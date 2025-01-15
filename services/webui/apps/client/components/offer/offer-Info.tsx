import { InfoDialog } from "../dialog/page-info";

export function OfferInfo() {
  return (
    <InfoDialog
      position="top-3"
      size={24}
      title="OFFERについて"
      content={
        <>
          <p className="text-lg leading-relaxed">
            OFFERSでは、アーティストの音楽活動において、それをサポートできるタスクを見つけたり募集したりすることができます。
          </p>
          <p className="mt-4 font-semibold text-lg border-t border-gray-800 pt-4">
            Offerを見つける
          </p>
          <p className="mt-4">
            画面右上にある虫眼鏡アイコンをクリックすることで募集中のOfferを見つけることができます。
          </p>

          <p className="mt-16 font-semibold text-lg">新規Offerを作成する</p>
          <p className="mt-4">
            保有FSPが20以上のユーザーのみが新規Offerを作成できます。画面右上にあるプラスアイコンをクリックすることで新規Offerを作成できます。新規Offerを作成するには、以下の情報を入力する必要があります。
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>カテゴリー（Creation, Event, Promotion, Other）</li>
            <li>オファー名（タイトル）*</li>
            <li>概要（オファーの詳細な説明）*</li>
            <li>期日（オファーの締切日）</li>
            <li>場所（活動場所）*</li>
            <li>Fee（報酬額）*</li>
            <li>オファー対象（Musician, Curator, Creator, Supporter等）*</li>
            <li>オファー詳細についての補足項目</li>
            <li>対象となるスキル</li>
            <li>カバー画像*</li>
            <li>添付画像（最大4枚まで）</li>
            <li>添付メディア（PDFファイルやMP4動画）</li>
          </ul>
          <p className="mt-4 text-sm text-gray-400">* は必須項目です</p>
        </>
      }
    />
  );
}
