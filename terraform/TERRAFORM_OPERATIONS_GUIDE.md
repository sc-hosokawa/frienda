# Terraform 運用手順書

**プロジェクト**: FRIENDA
**最終更新日**: 2026-05-01

---

## 目次

1. [概要](#1-概要)
2. [前提条件](#2-前提条件)
3. [プロジェクト構成](#3-プロジェクト構成)
4. [環境情報](#4-環境情報)
5. [日常運用（インフラ更新）](#5-日常運用インフラ更新)
6. [トラブルシューティング](#6-トラブルシューティング)
7. [運用ルール・注意事項](#7-運用ルール注意事項)

---

## 1. 概要

本手順書は、FRIENDAプロジェクトにおけるGoogle CloudインフラストラクチャをTerraformで管理・運用するための詳細手順を記載する。

## 2. 前提条件

### 2.1 必要なソフトウェア
- Terraform CLI (>= 1.5.0)
- Google Cloud SDK (gcloud)

### 2.2 アカウント・権限
- HCP Terraform (旧 Terraform Cloud) のアカウントおよび対象Workspaceへのアクセス権限
- 対象GCPプロジェクトに対する編集権限
- `terraform login` による認証済み環境
- `gcloud auth application-default login` による認証済み環境

## 3. プロジェクト構成

```
terraform/
├── environments/
│   ├── dev/
│   ├── test/
│   └── prod/
└── modules/
    ├── compute/
    ├── network/
    └── storage/
```

## 4. 環境情報

詳細な情報は [Google Cloud プロジェクト一覧](../docs/google-cloud-projects.md) を参照。

### 4.1 GCP プロジェクト & HCP Terraform Workspace 一覧 (Org: `scratch-jp`)

| 環境 | GCPプロジェクトID | HCP Terraform Workspace名 |
|---|---|---|
| test | `strategic-atom-315309` | `frienda-test` |
| dev | `frienda-test` | `frienda-dev` |
| prod | `frienda-prd` | `frienda-prod` |

## 5. 日常運用（インフラ更新）

### 5.1 作業の流れ
1. **ブランチ作成**: `feature/<機能名>`
2. **コード修正**: `terraform/environments/<環境名>/` 配下を編集
3. **バリデーション**: `terraform fmt`, `terraform validate`
4. **差分確認**: `terraform plan`
5. **適用**: `terraform apply`

### 5.2 適用順序
1. **test環境**: 実験・動作確認用
2. **dev環境**: 開発用
3. **prod環境**: 本番用

## 6. トラブルシューティング

- **`terraform init` が失敗する場合**: `.terraform` ディレクトリを削除して再試行してください。
- **権限エラー**: `gcloud auth application-default login` を再実行して権限を更新してください。
- **リソース競合**: GCPコンソールで直接作成されたリソースと競合している可能性があります。`terraform state list` で現状を確認してください。

## 7. 運用ルール・注意事項

1. **本番環境への直接変更禁止**: 必ずTerraformコード経由で変更すること。
2. **planの徹底**: `terraform apply` 前には必ず `terraform plan` で差分を確認すること。
3. **変数管理**: `.tfvars` ファイルにはシークレットを含めず、環境変数やシークレット管理サービスを利用すること。
4. **Git管理**: `.gitignore` に含まれるファイル（`*.tfstate`, `*.tfvars` 等）は絶対にGitにコミットしないこと。
