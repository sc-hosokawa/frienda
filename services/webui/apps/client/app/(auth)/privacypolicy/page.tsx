"use client";
import { useRouter } from "next/navigation";

export default function PrivacyPolicy() {
  const router = useRouter();

  return (
    <div className="max-w-4xl mx-auto px-4 py-8">
      <button
        onClick={() => router.back()}
        className="mb-6 px-4 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-200"
      >
        ← 戻る
      </button>

      <h1 className="text-3xl font-bold mb-6">プライバシーポリシー</h1>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">
          1. 個人情報の収集について
        </h2>
        <p className="mb-4">
          当サービスは、以下の個人情報を収集する場合があります：
        </p>
        <ul className="list-disc pl-6 mb-4">
          <li>氏名</li>
          <li>メールアドレス</li>
          <li>利用履歴</li>
          <li>その他サービス提供に必要な情報</li>
        </ul>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">2. 個人情報の利用目的</h2>
        <p className="mb-4">収集した個人情報は、以下の目的で利用いたします：</p>
        <ul className="list-disc pl-6 mb-4">
          <li>サービスの提供・運営</li>
          <li>ユーザーサポート</li>
          <li>サービスの改善・新機能の開発</li>
          <li>お知らせやメールマガジンの配信</li>
        </ul>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">3. 個人情報の第三者提供</h2>
        <p className="mb-4">
          法令に基づく場合を除き、お客様の同意なく第三者に個人情報を提供することはありません。
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">4. お問い合わせ</h2>
        <p className="mb-4">
          プライバシーポリシーに関するお問い合わせは、以下の連絡先までご連絡ください：
        </p>
        <p>メール：info@friendshipdao.xyz</p>
      </section>

      <footer className="text-sm text-gray-400 mt-12 pt-4 border-t border-gray-200">
        <p>公開日：2024年11月15日</p>
        <p>最終更新日：2024年11月17日</p>
      </footer>
    </div>
  );
}
