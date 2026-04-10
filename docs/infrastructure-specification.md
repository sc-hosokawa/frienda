# FRIENDA インフラ構成仕様書

## 1. 概要

本ドキュメントは、FRIENDAプロジェクトの開発環境（Local Development）、ステージング環境（Staging）、本番環境（Production）のインフラ構成を定義する。

### 1.1 クラウドプロバイダー

- **Google Cloud Platform (GCP)**
- リージョン: `asia-northeast1`（東京）

### 1.2 主要サービス構成

| サービス | 技術スタック | デプロイ先 |
|----------|-------------|-----------|
| Backend API | Rust (Actix-web, Sea-ORM, async-graphql) | Google Cloud Run |
| WebUI Client | Next.js (React, TypeScript) | - |
| WebUI Admin | Next.js (React, TypeScript) | - |
| Mobile Client | Flutter (Dart) | App Store / Google Play |
| Mobile Admin | Flutter (Dart) | App Store / Google Play |
| Database | PostgreSQL 15 | Cloud SQL |
| Smart Contracts | Solidity (Foundry, Hardhat) | Ethereum (Sepolia / Mainnet) |

---

## 2. 環境一覧

| 項目 | 開発環境 (Local) | ステージング環境 (Staging) | 本番環境 (Prod) |
|------|-----------------|--------------------------|----------------|
| デプロイトリガー | ローカル実行 | `main` ブランチへのpush | `release` ブランチへのpush |
| Cloud Run サービス名 | — | `frienda-server` | `frienda-server-core` |
| Cloud SQL インスタンス名 | — (Docker PostgreSQL) | `frienda-dev-pg` | `frienda-pg` |
| VPC ネットワーク | — | `dev-network` | `frienda-network` |
| Terraform State | — | ローカル | `prd-frienda-terraform-state` (GCS) |

---

## 3. 開発環境 (Local Development)

#### コンテナ構成（docker-compose）

```
┌─────────────────────────────┐
│  docker-compose              │
│  ┌────────────────────────┐  │
│  │ postgres (PostgreSQL 16)│  │
│  │ Port: 5432              │  │
│  │ User: postgres           │  │
│  │ DB: postgres             │  │
│  └────────────────────────┘  │
└─────────────────────────────┘
```

| 項目 | 設定値 |
|------|--------|
| PostgreSQL バージョン | 16 |
| ホスト | 127.0.0.1 |
| ポート | 5432（カスタマイズ可） |
| ユーザー | postgres |
| パスワード | postgres |
| データベース名 | postgres |
| 初期化 | seeds/ 配下のSQLスクリプトを自動実行 |

#### シードデータ実行順序

| 順序 | ファイル | 内容 |
|------|---------|------|
| 1 | `01_init.sql` | 既存テーブル/型の削除 |
| 2 | `02_create_tables.sql` | テーブル作成 |
| 3 | `03_create_functions.sql` | トリガー関数作成（再生数集計） |
| 4 | `04_create_admin_user.sql` | 管理者ユーザー作成 |
| 5 | `05_create_artists.sql` | アーティストデータ |
| 6 | `06_create_upc.sql` | UPC/製品データ |
| 7 | `07_create_tracks.sql` | トラックデータ |
| 8 | `08_create_upctrack.sql` | UPC-トラック関連データ |
| 9 | `09_create_genesis_quests.sql` | ジェネシスクエストデータ |
| 10 | `10_create_prizes.sql` | 賞品データ |

#### ローカルサービス起動

| サービス | コマンド | ポート |
|----------|---------|-------|
| Backend API | `make api-dev` | 8080 |
| WebUI Client | `make webui-client-dev` | 3000 |
| WebUI Admin | `make webui-admin-dev` | 3001 |
| PostgreSQL | `make run-pg` | 5432 |

---

## 4. ステージング環境 (Staging)

### 4.1 ネットワーク構成

```
┌──────────────────────────────────────────┐
│  GCP Project (Staging)                    │
│                                           │
│  ┌─────────────────────────────────────┐  │
│  │ VPC: dev-network                      │  │
│  │                                      │  │
│  │  ┌──────────────┐  ┌──────────────┐  │  │
│  │  │ Cloud Run    │  │ Cloud SQL    │  │  │
│  │  │ frienda-     │──│ frienda-dev- │  │  │
│  │  │ server       │  │ pg           │  │  │
│  │  │ (Public)     │  │ (Private IP) │  │  │
│  │  └──────────────┘  └──────────────┘  │  │
│  │        │                              │  │
│  │  ┌──────────────┐                     │  │
│  │  │ VPC Access   │                     │  │
│  │  │ Connector    │                     │  │
│  │  │ 10.20.0.0/28 │                     │  │
│  │  └──────────────┘                     │  │
│  └─────────────────────────────────────┘  │
│                                           │
│  ┌─────────────────────────────────────┐  │
│  │ Cloud Storage                        │  │
│  │  ├ frienda-photo-storage             │  │
│  │  │  (STANDARD → NEARLINE 365日)      │  │
│  │  └ frienda-general-files             │  │
│  │     (STANDARD → COLDLINE 30日)       │  │
│  │     (バージョニング有効)               │  │
│  └─────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

### 4.2 Cloud Run 設定

| 項目 | 設定値 |
|------|--------|
| サービス名 | `frienda-server` |
| リージョン | `asia-northeast1` |
| イングレス | `INGRESS_TRAFFIC_ALL`（公開） |
| IAM | `allUsers` に `run.invoker` 付与（未認証アクセス許可） |
| VPC接続 | VPC Access Connector 経由 |
| スケーリング | デフォルト（未設定） |

### 4.3 Cloud SQL 設定

| 項目 | 設定値 |
|------|--------|
| インスタンス名 | `frienda-dev-pg` |
| バージョン | PostgreSQL 15 |
| マシンタイプ | `db-custom-1-3840` |
| IP | プライベートIPのみ（`10.10.0.0/16`） |
| 削除保護 | 無効 |
| バックアップ | 未設定 |
| パスワード管理 | Terraform変数から指定 |

### 4.4 Cloud Storage 設定

| バケット名 | 用途 | ストレージクラス | ライフサイクル |
|-----------|------|----------------|--------------|
| `frienda-photo-storage` | 写真保存 | STANDARD | 365日後にNEARLINEへ遷移 |
| `frienda-general-files` | 汎用ファイル | STANDARD | 30日後にCOLDLINEへ遷移、バージョニング有効 |

### 4.5 本番環境との差異

| 項目 | ステージング | 本番 |
|------|-------------|------|
| Cloud Run サービス名 | `frienda-server` | `frienda-server-core` |
| Cloud Run 最小インスタンス | 0（デフォルト） | 1 |
| Cloud Run 最大インスタンス | デフォルト | 10 |
| Cloud SQL インスタンス名 | `frienda-dev-pg` | `frienda-pg` |
| Cloud SQL バックアップ | なし | あり (PITR, 02:00 UTC) |
| Cloud SQL 削除保護 | なし | あり |
| Cloud SQL パスワード | 変数指定 | 自動生成 |
| VPC ネットワーク | `dev-network` | `frienda-network` |
| ストレージバケット | 2個（photo, general） | 1個（general） |
| Terraform State | ローカル | GCS（リモート） |
| デプロイブランチ | `main` | `release` |

---

## 5. 本番環境 (Production)

### 5.1 ネットワーク構成

```
┌──────────────────────────────────────────┐
│  GCP Project (Prod)                       │
│                                           │
│  ┌─────────────────────────────────────┐  │
│  │ VPC: frienda-network                  │  │
│  │                                      │  │
│  │  ┌──────────────┐  ┌──────────────┐  │  │
│  │  │ Cloud Run    │  │ Cloud SQL    │  │  │
│  │  │ frienda-     │──│ frienda-pg   │  │  │
│  │  │ server-core  │  │              │  │  │
│  │  │ (Public)     │  │ (Private IP) │  │  │
│  │  │ min:1 max:10 │  │ Backup ON    │  │  │
│  │  └──────────────┘  └──────────────┘  │  │
│  │        │                              │  │
│  │  ┌──────────────┐                     │  │
│  │  │ VPC Access   │                     │  │
│  │  │ Connector    │                     │  │
│  │  │ prod-        │                     │  │
│  │  │ connector    │                     │  │
│  │  └──────────────┘                     │  │
│  └─────────────────────────────────────┘  │
│                                           │
│  ┌─────────────────────────────────────┐  │
│  │ Cloud Storage                        │  │
│  │  └ prd-frienda-general-files         │  │
│  │     (STANDARD → COLDLINE 30日)       │  │
│  └─────────────────────────────────────┘  │
│                                           │
│  ┌─────────────────────────────────────┐  │
│  │ Terraform State                      │  │
│  │  prd-frienda-terraform-state (GCS)   │  │
│  │  バージョニング: 5世代保持            │  │
│  └─────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

### 5.2 Cloud Run 設定

| 項目 | 設定値 |
|------|--------|
| サービス名 | `frienda-server-core` |
| リージョン | `asia-northeast1` |
| イングレス | `INGRESS_TRAFFIC_ALL`（公開） |
| IAM | `allUsers` に `run.invoker` 付与（未認証アクセス許可） |
| VPC接続 | VPC Access Connector (`prod-connector`) 経由 |
| 最小インスタンス数 | 1（コールドスタート回避） |
| 最大インスタンス数 | 10 |

### 5.3 Cloud SQL 設定

| 項目 | 設定値 |
|------|--------|
| インスタンス名 | `frienda-pg` |
| バージョン | PostgreSQL 15 |
| マシンタイプ | `db-custom-1-3840` |
| IP | プライベートIPのみ（`10.10.0.0/16`） |
| 削除保護 | **有効** |
| バックアップ | **有効**（毎日 02:00 UTC） |
| ポイントインタイムリカバリ | **有効** |
| パスワード管理 | `random_password` リソースで自動生成（16文字、特殊文字なし） |

### 5.4 Cloud Storage 設定

| バケット名 | 用途 | ストレージクラス | ライフサイクル |
|-----------|------|----------------|--------------|
| `prd-frienda-general-files` | 汎用ファイル | STANDARD | 30日後にCOLDLINEへ遷移 |

### 5.5 Terraform State 管理

| 項目 | 設定値 |
|------|--------|
| バケット名 | `prd-frienda-terraform-state` |
| リージョン | `us-west1` |
| バージョニング | 有効（5世代保持） |
| 公開アクセス | 禁止 |

---

## 6. CI/CD パイプライン

### 6.1 全体フロー

```
┌────────┐    push     ┌──────────┐    ┌──────────────┐
│ 開発者  │ ─────────→ │ GitHub   │ ──→│ GitHub       │
│        │            │          │    │ Actions (CI) │
└────────┘            └──────────┘    └──────┬───────┘
                                              │
                      ┌───────────────────────┼───────────────────┐
                      │                       │                   │
               ┌──────▼──────┐  ┌─────────────▼──┐  ┌──────────▼──────┐
               │ Backend     │  │ Client         │  │ Contract       │
               │ Test        │  │ Lint           │  │ Test           │
               │ cargo test  │  │ pnpm lint      │  │ forge test     │
               │ clippy      │  │                │  │                │
               │ fmt check   │  │                │  │                │
               └─────────────┘  └────────────────┘  └────────────────┘
```

### 6.2 CI ワークフロー (`ci.yaml`)

| トリガー | 条件 |
|---------|------|
| push | `main`, `develop` ブランチ |
| pull_request | `main`, `develop` ブランチ |

| ジョブ | 実行条件 | 内容 |
|--------|---------|------|
| Backend | コミットメッセージに "backend" | `cargo test`, `cargo clippy`, `cargo fmt --check` |
| Client | コミットメッセージに "client" | `pnpm install`, `pnpm lint` |
| Contract | コミットメッセージに "contract" | `forge install`, `forge test` |

### 6.3 デプロイワークフロー

#### ステージング環境デプロイ (`deploy_dev_server.yaml`)

| 項目 | 設定 |
|------|------|
| トリガー | `main` ブランチへのpush（`services/backend/**` 変更時） |
| ビルド | `docker build --platform linux/amd64 -f Dockerfile.server` |
| レジストリ | `asia-northeast1-docker.pkg.dev/$PROJECT_ID/$SERVICE_NAME/$IMAGE:latest` |
| デプロイ先 | Cloud Run `frienda-server` |
| 環境変数 | 30以上のシークレットをCloud Runに設定 |

#### 本番環境デプロイ (`deploy_prd_server.yaml`)

| 項目 | 設定 |
|------|------|
| トリガー | `release` ブランチへのpush（`services/backend/**` 変更時） |
| ビルド | ステージング環境と同一プロセス |
| レジストリ | 本番用Artifact Registry |
| デプロイ先 | Cloud Run `frienda-server-core` |
| 環境変数 | 本番用シークレットを使用 |

#### 定期ジョブ (`credential_update.yaml`)

| 項目 | 設定 |
|------|------|
| スケジュール | 毎月15日 12:00 UTC |
| 処理内容 | DSP認証情報の更新 |
| 対象 | ステージング → 本番（順次実行） |

### 6.4 デプロイブランチ戦略

```
feature/* ──→ main (Staging Deploy) ──→ release (Prod Deploy)
```

---

## 7. Docker イメージ構成

### 7.1 Backend サーバー (`Dockerfile.server`)

| 項目 | 設定値 |
|------|--------|
| ビルドステージ | `rust:1.94.1-bookworm` |
| ランタイム | `gcr.io/distroless/cc-debian12` |
| ビルド対象 | `server-core` |
| ビルドモード | release |
| ポート | 8080 |
| 含まれるファイル | Firebase認証JSONファイル |

### 7.2 Backend エクステンション (`Dockerfile.extension`)

| 項目 | 設定値 |
|------|--------|
| ビルドステージ | `rust:1.83.0` |
| ランタイム | `gcr.io/distroless/cc-debian12` |
| ビルド対象 | `server-extension` |
| ポート | 8080 |

### 7.3 PostgreSQL (`services/postgres/Dockerfile`)

| 項目 | 設定値 |
|------|--------|
| ベースイメージ | `postgres:16` |
| 初期化 | `seeds/` をdocker-entrypoint-initdb.dにコピー |

---

## 8. 環境変数一覧

### 8.1 Backend API

| カテゴリ | 変数名 | 用途 |
|---------|--------|------|
| データベース | `DATABASE_URL` | PostgreSQL接続文字列 |
| サーバー | `HOST`, `PORT` | リッスンアドレス（0.0.0.0:8080） |
| 環境 | `ENV`, `ENVIRONMENT` | 環境識別（dev/prod） |
| 認証 | `JWK_URL`, `JWK_ISSUER` | Firebase JWT検証 |
| AI | `GEMINI_API_KEY` | Gemini API |
| メール | `SENDGRID_API_KEY` | SendGrid |
| ブロックチェーン | `ETH_RPC_URL`, `CREDENTIAL_CONTRACT_ADDRESS` | Ethereum連携 |
| DSP | `SERVICE_ACCOUNT_DSP`, `CLIENT_ID`, `CLIENT_SECRET` | DSPサービス認証 |
| DSP | `GENDER_GEN_*` | Gender Generation API関連 |
| セキュリティ | `HASH_SALT` | ハッシュソルト |

### 8.2 WebUI Client

| カテゴリ | 変数名 | 用途 |
|---------|--------|------|
| 環境 | `NEXT_PUBLIC_ENV` | 環境識別 |
| API | `NEXT_PUBLIC_GRAPHQL_ENDPOINT` | GraphQLエンドポイント |
| CMS | `CONTENTFUL_SPACE_ID`, アクセストークン | Contentful連携 |
| 認証 | Firebase設定（PROJECT_ID等） | Firebase認証 |
| 決済 | `STRIPE_SECRET_KEY` | Stripe連携 |

### 8.3 WebUI Admin

| カテゴリ | 変数名 | 用途 |
|---------|--------|------|
| 認証 | `BASIC_AUTH_USER`, `BASIC_AUTH_PASSWORD` | Basic認証 |
| API | `NEXT_PUBLIC_GRAPHQL_ENDPOINT` | GraphQLエンドポイント |
| 決済 | `STRIPE_SECRET_KEY` | Stripe連携 |

### 8.4 Smart Contracts

| カテゴリ | 変数名 | 用途 |
|---------|--------|------|
| ガス | `GAS_REPORT` | ガスレポート出力 |
| ネットワーク | `INFURA_KEY` | Infuraノード接続 |
| デプロイ | `DEPLOYER_PRIVATE_KEY`, `MNEMONIC` | デプロイ用秘密鍵 |
| 検証 | `ETHERSCAN_KEY` | Etherscanコントラクト検証 |

---

## 9. 認証・セキュリティ

### 9.1 認証方式

| レイヤー | 方式 | 詳細 |
|---------|------|------|
| ユーザー認証 | Firebase Authentication | JWT トークンによる認証 |
| 管理画面 | Basic Authentication | ユーザー名/パスワード |
| API間通信 | サービスアカウント | GCPサービスアカウント |
| 決済 | Stripe Webhook | Webhook署名検証 |

### 9.2 ネットワークセキュリティ

| 項目 | 設定 |
|------|------|
| Cloud SQL | プライベートIPのみ（VPC経由でアクセス） |
| Cloud Run → Cloud SQL | VPC Access Connector 経由 |
| Cloud Run イングレス | 全トラフィック許可（将来的にロードバランサー + IAP 導入推奨） |

---

## 10. 環境間差異サマリー

| 項目 | 開発 (Local) | ステージング (Staging) | 本番 (Prod) |
|------|-------------|----------------------|-------------|
| **環境** | ローカル (Docker) | GCP | GCP |
| **Cloud Run サービス名** | — | `frienda-server` | `frienda-server-core` |
| **Cloud Run 最小インスタンス** | — | 0（デフォルト） | 1 |
| **Cloud Run 最大インスタンス** | — | デフォルト | 10 |
| **Cloud SQL インスタンス名** | — (Docker PostgreSQL 16) | `frienda-dev-pg` | `frienda-pg` |
| **Cloud SQL マシンタイプ** | — | `db-custom-1-3840` | `db-custom-1-3840` |
| **Cloud SQL バックアップ** | — | なし | あり (PITR, 02:00 UTC) |
| **Cloud SQL 削除保護** | — | なし | あり |
| **Cloud SQL パスワード** | `postgres` | 変数指定 | 自動生成 |
| **VPC ネットワーク** | — | `dev-network` | `frienda-network` |
| **ストレージバケット** | — | 2個（photo, general） | 1個（general） |
| **Terraform State** | — | ローカル | GCS（リモート） |
| **デプロイ方法** | ローカル実行 | `main` ブランチへのpush | `release` ブランチへのpush |
| **IAM** | — | allUsers許可 | allUsers許可 |

---

## 11. 今後の改善事項

### 11.1 ステージング環境の強化

- [ ] ステージング環境のリソース名を `dev-` プレフィクスから `stg-` プレフィクスへリネーム検討
- [ ] Cloud SQL バックアップの有効化
- [ ] Cloud SQL 削除保護の有効化
- [ ] Terraform State のリモート管理化（GCS）

### 11.2 セキュリティ強化

- [ ] Cloud Runへのロードバランサー + Cloud Armor導入
- [ ] Identity-Aware Proxy (IAP) による管理画面アクセス制限
- [ ] Cloud SQL への接続をCloud SQL Auth Proxyに統一
- [ ] シークレット管理をGitHub SecretsからGoogle Secret Managerへ移行検討

### 11.3 可用性・監視

- [ ] Cloud Monitoring アラートポリシーの設定
- [ ] Cloud Logging のログベースメトリクス設定
- [ ] アップタイムチェックの導入
- [ ] エラーレポート（Error Reporting）の有効化

### 11.4 コスト最適化

- [ ] ステージング環境のTerraform State をリモート管理化
- [ ] 不要リソースの定期棚卸しフロー整備
- [ ] Cloud RunのCPU割り当て最適化（request-based vs always-on）

---

## 改訂履歴

| 日付 | バージョン | 内容 |
|------|-----------|------|
| 2026-04-10 | 1.0 | 初版作成 |
