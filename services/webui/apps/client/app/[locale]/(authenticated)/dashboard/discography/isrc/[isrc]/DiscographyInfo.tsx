"use client";

import { InfoDialog } from "~/components/dialog/page-info";

export function DiscographyInfo() {
  return (
    <InfoDialog
      position="top-1"
      size={20}
      title="DISCOGRAPHYについて"
      content={
        <>
          <p className="leading-relaxed text-gray-300">
            このページでは、特定の作品についての再生数や傾向を確認できます。
          </p>
          <p className="mt-4 font-semibold text-lg border-t border-gray-800 pt-4">
            Overviewについて
          </p>
          <p className="mt-4">
            ページ上部では、該当する作品に収録されている楽曲の合計再生数などの情報が確認できます。
            <br />
            集計ルールは以下の通りです
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>データ集計開始は2021年3月1日です</li>
            <li>
              Song Played
              (Total)では作品に収録されているすべての楽曲の全期間にわたる合計再生数を表示
            </li>
            <li>
              Song Played
              (Weekly)では作品に収録されているすべての楽曲の過去１週間の合計再生数を表示
            </li>
            <li>
              楽曲リストでは、それぞれの楽曲の全期間にわたる合計再生数と週間再生数が表示
            </li>
          </ul>

          <p className="mt-16 font-semibold text-lg">クレジットについて</p>
          <p className="mt-4">
            クレジットでは、作品に収録されている楽曲のクレジット情報を追加したり確認したりできます。
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>
              クレジットは、楽曲の作曲者、作詞者、編曲者などの情報を追加したり確認したりできます
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
