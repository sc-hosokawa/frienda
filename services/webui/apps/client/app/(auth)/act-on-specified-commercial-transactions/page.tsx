export default function TokusyoPage() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">特定商取引法に基づく表示</h1>

      <div className="space-y-8">
        <section>
          <h2 className="text-xl font-semibold mb-3">販売業者</h2>
          <p>[会社名を記載]</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">運営責任者</h2>
          <p>[責任者名を記載]</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">所在地</h2>
          <p>[所在地を記載]</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">連絡先</h2>
          <p>メールアドレス: [メールアドレスを記載]</p>
          <p>電話番号: [電話番号を記載]</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">商品代金以外の必要料金</h2>
          <p>送料、手数料等 [詳細を記載]</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">引渡し時期</h2>
          <p>[配送期間等を記載]</p>
        </section>

        <section>
          <h2 className="text-xl font-semibold mb-3">返品・交換について</h2>
          <p>[返品・交換ポリシーを記載]</p>
        </section>
      </div>
    </div>
  );
}
