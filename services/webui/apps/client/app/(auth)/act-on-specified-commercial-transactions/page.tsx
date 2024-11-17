export default function TokusyoPage() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">特定商取引法に基づく表示</h1>

      <div className="space-y-8">
        <section>
          <h2 className="text-xl font-semibold mb-3">販売業者</h2>
          <p>株式会社ヒップランドミュージックコーポレーション</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">運営責任者</h2>
          <p>代表取締役 野村達矢</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">所在地</h2>
          <p>東京都港区北青山2-11-3　A-PLACE 青山 1F</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">連絡先</h2>
          <p>メールアドレス: info@friendshipdao.xyz</p>
          {/* <p>電話番号: 03-5411-4800</p> */}
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">商品代金以外の必要料金</h2>
          <p>送料、手数料等</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">引渡し時期</h2>
          <p>注文から1週間以内</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">返品・交換について</h2>
          <p>返品・交換はできません。</p>
        </section>
      </div>
    </div>
  );
}
