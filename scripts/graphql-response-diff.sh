#!/usr/bin/env bash

set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
QUERY_DIR="${GRAPHQL_DIFF_QUERY_DIR:-"${ROOT_DIR}/scripts/graphql-response-diff/queries"}"
RUN_ID="${GRAPHQL_DIFF_RUN_ID:-$(date +%Y%m%d-%H%M%S)}"
OUT_DIR="${GRAPHQL_DIFF_OUTPUT_DIR:-"${ROOT_DIR}/.graphql-response-diff/${RUN_ID}"}"
BASELINE_DIR="${GRAPHQL_DIFF_BASELINE_DIR:-"${ROOT_DIR}/.graphql-response-diff/baselines/${RUN_ID}"}"
MODE="${GRAPHQL_DIFF_MODE:-compare}"
PERIOD="${PERIOD:-30}"

usage() {
  cat <<'USAGE'
Usage:
  # Capture a baseline before merge from the staging endpoint.
  GRAPHQL_URL=https://staging.example.com/graphql \
  GRAPHQL_DIFF_TOKEN=xxxxx \
  ARTIST_ID=artist_xxx \
  USER_ID=user_xxx \
  UPC=upc_xxx \
  PERIOD=30 \
  GRAPHQL_DIFF_BASELINE_DIR=.graphql-response-diff/baselines/before-merge \
  make graphql-response-capture

  # Compare the saved baseline with the same staging endpoint after merge.
  CANDIDATE_GRAPHQL_URL=https://staging.example.com/graphql \
  GRAPHQL_DIFF_TOKEN=xxxxx \
  ARTIST_ID=artist_xxx \
  USER_ID=user_xxx \
  UPC=upc_xxx \
  PERIOD=30 \
  GRAPHQL_DIFF_BASELINE_DIR=.graphql-response-diff/baselines/before-merge \
  make graphql-response-diff

  # Compare two live endpoints directly.
  BASE_GRAPHQL_URL=https://current-staging.example.com/graphql \
  CANDIDATE_GRAPHQL_URL=https://candidate-staging.example.com/graphql \
  GRAPHQL_DIFF_TOKEN=xxxxx \
  ARTIST_ID=artist_xxx \
  USER_ID=user_xxx \
  UPC=upc_xxx \
  PERIOD=30 \
  make graphql-response-diff

Required environment variables:
  ARTIST_ID              Artist id used by dashboard queries
  USER_ID                User id used by dashboard/offer queries
  UPC                    UPC used by UPC dashboard queries

Endpoint requirements:
  capture mode:
    GRAPHQL_URL or BASE_GRAPHQL_URL
  compare mode:
    CANDIDATE_GRAPHQL_URL
    and either BASE_GRAPHQL_URL for live-vs-live comparison
    or GRAPHQL_DIFF_BASELINE_DIR for saved-baseline comparison

Optional environment variables:
  GRAPHQL_DIFF_TOKEN       Bearer token used for both endpoints
  GRAPHQL_TOKEN            Bearer token for GRAPHQL_URL in capture mode
  BASE_GRAPHQL_TOKEN       Bearer token for BASE_GRAPHQL_URL; overrides GRAPHQL_DIFF_TOKEN
  CANDIDATE_GRAPHQL_TOKEN  Bearer token for CANDIDATE_GRAPHQL_URL; overrides GRAPHQL_DIFF_TOKEN
  PERIOD                   Play count history period; defaults to 30
  GRAPHQL_DIFF_MODE        compare or capture; make targets set this automatically
  GRAPHQL_DIFF_QUERY_DIR   Directory containing query JSON fixtures
  GRAPHQL_DIFF_OUTPUT_DIR  Directory for response/diff artifacts
  GRAPHQL_DIFF_BASELINE_DIR Directory for captured baseline responses
  GRAPHQL_DIFF_RUN_ID      Artifact run id; defaults to timestamp
USAGE
}

die() {
  echo "error: $*" >&2
  exit 1
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "$1 is required"
}

require_env() {
  local name="$1"
  if [[ -z "${!name:-}" ]]; then
    usage >&2
    die "${name} is required"
  fi
}

validate_period() {
  if [[ ! "${PERIOD}" =~ ^[0-9]+$ ]]; then
    die "PERIOD must be a non-negative integer"
  fi
}

payload_for_fixture() {
  local fixture="$1"
  local name
  name="$(basename "${fixture}" .json)"

  case "${name}" in
    get-overview)
      jq --arg artistId "${ARTIST_ID}" --arg userId "${USER_ID}" \
        'del(.requiredVariables, .description) | .variables = { artistId: $artistId, userId: $userId }' "${fixture}"
      ;;
    get-overview-by-upc)
      jq --arg artistId "${ARTIST_ID}" --arg userId "${USER_ID}" --arg upc "${UPC}" \
        'del(.requiredVariables, .description) | .variables = { artistId: $artistId, userId: $userId, upc: $upc }' "${fixture}"
      ;;
    get-trending)
      jq --arg artistId "${ARTIST_ID}" --arg userId "${USER_ID}" \
        'del(.requiredVariables, .description) | .variables = { artistId: $artistId, userId: $userId }' "${fixture}"
      ;;
    get-trending-by-upc)
      jq --arg upc "${UPC}" --arg userId "${USER_ID}" \
        'del(.requiredVariables, .description) | .variables = { upc: $upc, userId: $userId }' "${fixture}"
      ;;
    get-play-count-history)
      jq --arg artistId "${ARTIST_ID}" --arg userId "${USER_ID}" --argjson period "${PERIOD}" \
        'del(.requiredVariables, .description) | .variables = { artistId: $artistId, userId: $userId, period: $period }' "${fixture}"
      ;;
    get-playcount-history-by-upc)
      jq --arg upc "${UPC}" --argjson period "${PERIOD}" \
        'del(.requiredVariables, .description) | .variables = { upc: $upc, period: $period }' "${fixture}"
      ;;
    get-offer-stats)
      jq --arg userId "${USER_ID}" \
        'del(.requiredVariables, .description) | .variables = { userId: $userId }' "${fixture}"
      ;;
    *)
      die "no variable mapping is defined for query fixture: ${name}"
      ;;
  esac
}

post_graphql() {
  local endpoint="$1"
  local token="$2"
  local payload="$3"
  local output="$4"
  local raw_output="${output}.raw"
  local http_status
  local curl_args

  curl_args=(-sS -X POST "${endpoint}" -H "content-type: application/json" --data-binary "@${payload}" -o "${raw_output}" -w "%{http_code}")
  if [[ -n "${token}" ]]; then
    curl_args+=(-H "authorization: Bearer ${token}")
  fi

  if ! http_status="$(curl "${curl_args[@]}")"; then
    return 1
  fi

  if [[ ! "${http_status}" =~ ^2[0-9][0-9]$ ]]; then
    echo "HTTP ${http_status}" > "${output}.error"
    return 1
  fi

  if ! jq -S . "${raw_output}" > "${output}"; then
    echo "response is not valid JSON" > "${output}.error"
    return 1
  fi

  if jq -e '(.errors // []) | length > 0' "${output}" >/dev/null; then
    echo "GraphQL errors are present" > "${output}.error"
    return 1
  fi
}

load_fixtures() {
  [[ -d "${QUERY_DIR}" ]] || die "query fixture directory does not exist: ${QUERY_DIR}"

  shopt -s nullglob
  FIXTURES=("${QUERY_DIR}"/*.json)
  shopt -u nullglob
  [[ "${#FIXTURES[@]}" -gt 0 ]] || die "no query fixtures found in ${QUERY_DIR}"
}

require_common_inputs() {
  require_env ARTIST_ID
  require_env USER_ID
  require_env UPC
  validate_period
}

capture_baseline() {
  local endpoint="${GRAPHQL_URL:-${BASE_GRAPHQL_URL:-}}"
  local token="${GRAPHQL_TOKEN:-${BASE_GRAPHQL_TOKEN:-${GRAPHQL_DIFF_TOKEN:-}}}"
  local failed=0
  local checked=0

  [[ -n "${endpoint}" ]] || {
    usage >&2
    die "GRAPHQL_URL or BASE_GRAPHQL_URL is required in capture mode"
  }

  mkdir -p "${BASELINE_DIR}"
  echo "GraphQL response baseline: ${BASELINE_DIR}"

  for fixture in "${FIXTURES[@]}"; do
    local name
    local case_dir
    local request
    local response

    name="$(basename "${fixture}" .json)"
    case_dir="${BASELINE_DIR}/${name}"
    request="${case_dir}/request.json"
    response="${case_dir}/base.json"
    mkdir -p "${case_dir}"

    echo "==> ${name}"
    if ! payload_for_fixture "${fixture}" > "${request}"; then
      echo "FAIL ${name}: failed to build request"
      failed=$((failed + 1))
      continue
    fi

    if ! post_graphql "${endpoint}" "${token}" "${request}" "${response}"; then
      echo "FAIL ${name}: baseline endpoint request failed"
      failed=$((failed + 1))
      continue
    fi

    echo "CAPTURED ${name}"
    checked=$((checked + 1))
  done

  echo "Captured ${checked} query fixture(s); failures: ${failed}"
  if [[ "${failed}" -gt 0 ]]; then
    exit 1
  fi
}

compare_responses() {
  mkdir -p "${OUT_DIR}"
  echo "GraphQL response diff artifacts: ${OUT_DIR}"

  local base_token="${BASE_GRAPHQL_TOKEN:-${GRAPHQL_DIFF_TOKEN:-}}"
  local candidate_token="${CANDIDATE_GRAPHQL_TOKEN:-${GRAPHQL_DIFF_TOKEN:-}}"
  local use_saved_baseline=0
  local failed=0
  local checked=0

  require_env CANDIDATE_GRAPHQL_URL

  if [[ -n "${GRAPHQL_DIFF_BASELINE_DIR:-}" ]]; then
    use_saved_baseline=1
    [[ -d "${GRAPHQL_DIFF_BASELINE_DIR}" ]] || die "baseline directory does not exist: ${GRAPHQL_DIFF_BASELINE_DIR}"
    echo "Comparing saved baseline: ${GRAPHQL_DIFF_BASELINE_DIR}"
  else
    require_env BASE_GRAPHQL_URL
  fi

  for fixture in "${FIXTURES[@]}"; do
    local name
    local case_dir
    local request
    local base_response
    local candidate_response
    local diff_file

    name="$(basename "${fixture}" .json)"
    case_dir="${OUT_DIR}/${name}"
    request="${case_dir}/request.json"
    base_response="${case_dir}/base.json"
    candidate_response="${case_dir}/candidate.json"
    diff_file="${case_dir}/diff.patch"
    mkdir -p "${case_dir}"

    echo "==> ${name}"
    if ! payload_for_fixture "${fixture}" > "${request}"; then
      echo "FAIL ${name}: failed to build request"
      failed=$((failed + 1))
      continue
    fi

    if [[ "${use_saved_baseline}" -eq 1 ]]; then
      local saved_response="${GRAPHQL_DIFF_BASELINE_DIR}/${name}/base.json"
      if [[ ! -f "${saved_response}" ]]; then
        echo "FAIL ${name}: saved baseline response not found (${saved_response})"
        failed=$((failed + 1))
        continue
      fi
      cp "${saved_response}" "${base_response}"
    else
      if ! post_graphql "${BASE_GRAPHQL_URL}" "${base_token}" "${request}" "${base_response}"; then
        echo "FAIL ${name}: base endpoint request failed"
        failed=$((failed + 1))
        continue
      fi
    fi

    if ! post_graphql "${CANDIDATE_GRAPHQL_URL}" "${candidate_token}" "${request}" "${candidate_response}"; then
      echo "FAIL ${name}: candidate endpoint request failed"
      failed=$((failed + 1))
      continue
    fi

    if diff -u "${base_response}" "${candidate_response}" > "${diff_file}"; then
      echo "PASS ${name}"
      rm -f "${diff_file}"
    else
      echo "FAIL ${name}: response differs (${diff_file})"
      failed=$((failed + 1))
    fi
    checked=$((checked + 1))
  done

  echo "Checked ${checked} query fixture(s); failures: ${failed}"
  if [[ "${failed}" -gt 0 ]]; then
    exit 1
  fi
}

main() {
  require_cmd curl
  require_cmd jq
  require_common_inputs
  load_fixtures

  case "${MODE}" in
    capture)
      capture_baseline
      ;;
    compare)
      require_cmd diff
      compare_responses
      ;;
    *)
      usage >&2
      die "GRAPHQL_DIFF_MODE must be capture or compare"
      ;;
  esac
}

main "$@"
