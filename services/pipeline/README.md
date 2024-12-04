# Pipeline

## Pipeline structures

| パイプライン名 | パイプラインの説明 | 技術スタック |
|------------|------------|------------|
| Layer1-1   | 各DSPからの視聴データの収集と加工し、データベースに登録   | Cloud Run Function  |
| Layer1-2   | オンチェーンのデータを取得して、データベースに登録   | Cloud Run Function  |
