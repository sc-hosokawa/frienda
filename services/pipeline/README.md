# Pipeline

## Pipeline structures

| パイプライン名 | パイプラインの説明 | 技術スタック |
|------------|------------|------------|
| Layer1-1   | 各DSPからの視聴データの収集と加工し、データベースに登録   | Cloud Run jobs  |
| Layer1-2   | 作品メタデータを加工し、データベースに登録   | Cloud Run jobs  |
| Layer2     | データソースからデータ取得し、分析など高度な処理をして、データベースに登録   | Prefect   |