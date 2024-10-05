# FRIENDA Terraform

## Dev

- Manual（ローカルから実行）
    - `terraform apply` を都度実行
- Unsafe
    - 全ての設定を緩めておく

## Stg

- Auto（ローカルからは実行しない）
    - GitHub Actionsで自動化
- Safer
    - 一部設定を緩めておく
- 高可用性、耐障害性はそこそこ

## Prd

- Auto（ローカルからは実行しない）
    - GitHub Actionsで自動化
- Safest
    - 全ての設定を厳密に行う
- 高可用性、耐障害性を高める
    - インスタンス数を増やす
    - データベースのバックアップ
    - データベースのスナップショット