"use client";

import { InfoDialog } from "../../../../components/dialog/page-info";

export function DashboardInfo() {
  return (
    <InfoDialog
      position="top-3"
      size={24}
      title="DASHBOARDについて"
      content={
        <>
          <p className="leading-relaxed text-gray-300">
            ダッシュボードでは、ダッシュボードはアーティストが発表した楽曲の再生数などのデータをDSPを横断して確認できます。
          </p>
          <p className="mt-4 font-semibold text-lg border-t border-gray-800 pt-4">
            Overviewについて
          </p>
          <p className="mt-4">
            Overviewでは、アーティストがこれまでに発表してきた全ての楽曲の合計再生数を表示します。
            <br />
            集計ルールは以下の通りです
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>データ集計開始は2021年3月1日です</li>
            <li>これまでに発表された楽曲の全期間にわたる合計再生数を表示</li>
          </ul>

          <p className="mt-16 font-semibold text-lg">Trendingについて</p>
          <p className="mt-4">
            Trendingでは、アーティストがこれまでに発表してきた楽曲のうち、再生数が上位５位の楽曲の情報を表示します。
            <br />
            集計ルールは以下の通りです
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>データ集計開始は2021年3月1日です</li>
            <li>
              これまでに発表された楽曲のうち、全期間の合計再生数が上位５位の楽曲を表示
            </li>
          </ul>

          <p className="mt-16 font-semibold text-lg">チャートについて</p>
          <p className="mt-4">
            再生数の傾向を把握できるように、複数のチャートを表示します。
            <br />
            チャートの種類は以下の通りです
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>再生数の推移（Stacked Chart）</li>
            <li>世代別割合（Generation）</li>
            <li>性別割合（Gender）</li>
          </ul>
        </>
      }
    />
  );
}
