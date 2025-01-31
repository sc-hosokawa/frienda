"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";

export default function TokusyoPage() {
  const router = useRouter();

  return (
    <div className="max-w-4xl mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">特定商取引法に基づく表記</h1>

      <div className="space-y-8">
        <section>
          <h2 className="text-xl font-semibold mb-3">販売業者</h2>
          <p>株式会社ヒップランドミュージックコーポレーション</p>
          <Link
            href="https://www.hipland.co.jp/"
            target="_blank"
            className="text-blue-500"
          >
            https://www.hipland.co.jp/
          </Link>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">運営統括責任者</h2>
          <p>代表取締役社長 野村達矢</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">所在地</h2>
          <p>東京都港区北青山2-11-3　A-PLACE 青山 1F</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">連絡先</h2>
          <p>メールアドレス: info@friendshipdao.xyz</p>
          <p>電話番号: 03-5411-4800</p>
          <p>受付時間: 10:00-18:00（土日祝を除く）</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">販売価格</h2>
          <div className="space-y-2">
            <p>FSP価格表（消費税込み）：</p>
            <ul className="list-disc pl-6">
              <li>100 FSP：150円</li>
              <li>300 FSP：450円</li>
              <li>500 FSP：750円</li>
              <li>1,000 FSP：1,500円</li>
              <li>5,000 FSP：7,500円</li>
            </ul>
            <p className="mt-4 text-sm">※表示価格はすべて消費税（10%）を含んだ金額です。</p>
            <p className="mt-4 text-sm">※FSPは、当サービスでのみ利用可能なコミュニティ内ポイントの名称です。</p>
          </div>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">
            商品代金以外の追加手数料等の追加料金{" "}
          </h2>
          <p>商品代金以外の料金は発生いたしません。</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">引渡し時期</h2>
          <p>注文後すぐにアカウントに反映され、ご利用になれます。</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">返品・交換について</h2>
          <div className="space-y-4">
            <p>
              当サービスで購入されるポイントは、デジタルコンテンツの性質上、購入後の返品・キャンセル・返金はお受けできません。
              ただし、システム障害等により正常にポイントが付与されなかった場合は、以下の連絡先までご連絡ください。
            </p>
            <ul className="list-disc pl-6">
              <li>メールアドレス: info@friendshipdao.xyz</li>
              <li>電話番号: 03-5411-4800</li>
              <li>受付時間: 10:00-18:00（土日祝を除く）</li>
            </ul>
          </div>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">受け付け可能な決済手段</h2>
          <p>クレジットカード</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">決済期間</h2>
          <p>クレジットカード決済の場合はただちに処理されます。</p>
        </section>
      </div>
      <footer className="text-sm text-gray-400 mt-12 pt-4 border-t border-gray-200">
        <p>公開日：2025年1月18日</p>
        <p>最終更新日：2025年1月31日</p>
      </footer>
      <button
        onClick={() => router.back()}
        className="mb-6 px-4 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-200 hover:text-black mt-12"
      >
        ← 戻る
      </button>
    </div>
  );
}
