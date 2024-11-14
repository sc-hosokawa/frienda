export default function TermOfService() {
  return (
    <div className="max-w-4xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">利用規約</h1>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">1. はじめに</h2>
        <p className="mb-4">
          本利用規約（以下「本規約」）は、当社が提供するサービス（以下「本サービス」）の利用条件を定めるものです。
          ユーザーの皆様は、本規約に同意の上、本サービスをご利用ください。
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">2. サービスの利用</h2>
        <p className="mb-4">
          本サービスを利用するにあたり、以下の事項を遵守してください：
        </p>
        <ul className="list-disc pl-6 mb-4">
          <li>法令及び本規約を遵守すること</li>
          <li>他のユーザーの権利を侵害しないこと</li>
          <li>虚偽の情報を提供しないこと</li>
          <li>不正アクセスを行わないこと</li>
        </ul>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">3. 禁止事項</h2>
        <p className="mb-4">
          本サービスの利用にあたり、以下の行為を禁止します：
        </p>
        <ul className="list-disc pl-6 mb-4">
          <li>法令違反行為</li>
          <li>当社または第三者の知的財産権を侵害する行為</li>
          <li>本サービスの運営を妨害する行為</li>
          <li>その他、当社が不適切と判断する行為</li>
        </ul>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">4. サービスの変更・中断</h2>
        <p className="mb-4">
          当社は、事前の通知なく本サービスの内容を変更、または提供を中断・終了することがあります。
          これによりユーザーに生じた損害について、当社は一切の責任を負いません。
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">5. 免責事項</h2>
        <p className="mb-4">
          当社は、本サービスに関して、その完全性、正確性、確実性、有用性等について、いかなる保証も行いません。
          本サービスの利用により生じた損害について、当社は一切の責任を負いません。
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">6. 規約の変更</h2>
        <p className="mb-4">
          当社は、必要に応じて本規約を変更することがあります。
          変更後の規約は、本サービス上で告知した時点から効力を生じるものとします。
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">7. お問い合わせ</h2>
        <p className="mb-4">
          本規約に関するお問い合わせは、以下の連絡先までご連絡ください：
        </p>
        <p>メール：support@example.com</p>
      </section>
    </div>
  );
}
