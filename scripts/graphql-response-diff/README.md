# GraphQL Response Diff

GraphQL endpoint に同じ query/variables を投げ、JSON レスポンスが一致するかを比較する軽量チェックです。Dashboard 系の refactor で UI 向けレスポンス値が変わっていないことを確認する目的で使います。

## Usage

### Same staging before/after merge

マージ前に staging の現在値を保存します。

```bash
GRAPHQL_URL=https://staging.example.com/graphql \
GRAPHQL_DIFF_TOKEN=xxxxx \
ARTIST_ID=artist_xxx \
USER_ID=user_xxx \
UPC=upc_xxx \
PERIOD=30 \
GRAPHQL_DIFF_BASELINE_DIR=.graphql-response-diff/baselines/before-merge \
make graphql-response-capture
```

マージ後に同じ staging endpoint の現在値と、保存済み baseline を比較します。

```bash
CANDIDATE_GRAPHQL_URL=https://staging.example.com/graphql \
GRAPHQL_DIFF_TOKEN=xxxxx \
ARTIST_ID=artist_xxx \
USER_ID=user_xxx \
UPC=upc_xxx \
PERIOD=30 \
GRAPHQL_DIFF_BASELINE_DIR=.graphql-response-diff/baselines/before-merge \
make graphql-response-diff
```

### Two live endpoints

```bash
BASE_GRAPHQL_URL=https://current-staging.example.com/graphql \
CANDIDATE_GRAPHQL_URL=https://candidate-staging.example.com/graphql \
GRAPHQL_DIFF_TOKEN=xxxxx \
ARTIST_ID=artist_xxx \
USER_ID=user_xxx \
UPC=upc_xxx \
PERIOD=30 \
make graphql-response-diff
```

`GRAPHQL_TOKEN` は capture mode の `GRAPHQL_URL` 用 token です。`BASE_GRAPHQL_TOKEN` / `CANDIDATE_GRAPHQL_TOKEN` を指定した場合は、それぞれの endpoint 用 token として `GRAPHQL_DIFF_TOKEN` より優先されます。token は environment variable からのみ読み取り、artifact には保存しません。

## Data Assumption

この差分テストは、比較対象の 2 endpoint、またはマージ前後の同じ staging が比較可能な DB snapshot を参照している前提です。JSON object の key order は正規化しますが、配列順は UI contract として比較対象にします。

## Artifacts

capture mode の結果は `GRAPHQL_DIFF_BASELINE_DIR`、diff mode の結果は `.graphql-response-diff/<timestamp>/` に保存されます。

- `request.json`: 実際に送信した GraphQL payload
- `base.json`: baseline endpoint の正規化済み response
- `candidate.json`: candidate endpoint の正規化済み response
- `diff.patch`: 差分がある場合のみ保存される unified diff

## Query Fixtures

`queries/*.json` には `requiredVariables` を記載しています。これは fixture を読む人向けの metadata で、送信前に script 側で取り除かれます。実際に送信される `variables` は `ARTIST_ID` / `USER_ID` / `UPC` / `PERIOD` から query ごとに組み立てます。
