# Claude Codeセッション記録

**保存日時**: 2026-05-01 

---

## ユーザー
ステージング環境（dev)にCloud SQLにpsqlを実行できるCompute Engineをgcloudコマンドで作成。できる限りコストが火からに方法。ディスク容量は10G.

## Claude Code
ステージング環境（dev）のCloud SQLに接続するための、コストを抑えたCompute Engineインスタンスの作成コマンドをご提案します。

### コストを最小化する構成
*   **マシンタイプ**: `e2-micro` (月額約$7程度の低価格インスタンス)
*   **プロビジョニングモデル**: `SPOT` (スポットインスタンス。通常価格より60-91%安価)
*   **ディスク**: 10GB `pd-standard` (標準HDD)
*   **OS**: Debian 12 (軽量なLinux)
*   **ネットワーク**: `dev-network` (既存のVPC)

### 実行コマンド

以下のコマンドをターミナルで実行してください。`[PROJECT_ID]` はご自身のプロジェクトIDに置き換えてください。

```bash
# プロジェクトIDとゾーンの指定
PROJECT_ID="[PROJECT_ID]"
ZONE="asia-northeast1-a"

gcloud compute instances create dev-psql-client \
    --project=$PROJECT_ID \
    --zone=$ZONE \
    --machine-type=e2-micro \
    --provisioning-model=SPOT \
    --network=dev-network \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --scopes=cloud-platform \
    --metadata=startup-script="apt-get update && apt-get install -y postgresql-client" \
    --description="Cloud SQL(dev)接続用クライアント"
```

### 補足事項

1.  **インターネット接続**: `postgresql-client` をインストールするために一時的に外部IPを付与しています（デフォルト設定）。インストール完了後、さらにコストを削る場合は外部IPを削除できますが、その場合は接続にIAP（Identity-Aware Proxy）等の設定が必要になります。
2.  **Cloud SQLへの接続**:
    *   インスタンス作成後、`gcloud compute ssh dev-psql-client --zone=asia-northeast1-a` でログインしてください。
    *   Cloud SQLのプライベートIPを確認し、以下のコマンドで接続できます。
        ```bash
        psql -h [DB_PRIVATE_IP] -U frienda-pg -d frienda-pg
        ```
    *   パスワードはTerraformで設定された `db_password` を使用してください。
3.  **FWルール**: もし `dev-network` にSSHを許可するファイアウォールルールがない場合は、別途以下のコマンドで許可設定（IAP経由）が必要です。
    ```bash
    gcloud compute firewall-rules create allow-ssh-ingress-from-iap \
        --project=$PROJECT_ID \
        --network=dev-network \
        --allow=tcp:22 \
        --source-ranges=35.235.240.0/20
    ```

作業が終わったらインスタンスを停止または削除することで、コストを最小限に抑えることができます。
