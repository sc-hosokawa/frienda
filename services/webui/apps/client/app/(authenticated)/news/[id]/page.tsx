import { getEntries } from "../../contentful";
import { Asset } from "contentful";
import Image from "next/image";
import Link from "next/link";
import { ArrowLeft } from "lucide-react";
import { documentToReactComponents } from "@contentful/rich-text-react-renderer";
import { getEntry } from "../../contentful";
import { Document, BLOCKS, MARKS, INLINES } from "@contentful/rich-text-types";

// 型ガードの関数
function isAsset(obj: any): obj is Asset {
  return obj && typeof obj === "object" && "fields" in obj && "sys" in obj;
}

// Document型かどうかをチェックする型ガード関数を追加
function isDocument(obj: any): obj is Document {
  return (
    obj && typeof obj === "object" && "nodeType" in obj && "content" in obj
  );
}

// ページコンポーネントのProps型定義
type Props = {
  params: {
    id: string;
  };
};

export default async function NewsDetailPage({ params }: Props) {
  const entry = await getEntry("information", params.id);

  if (!entry) {
    return <div>記事が見つかりませんでした。</div>;
  }

  // リッチテキストのレンダリングオプションを定義
  const options = {
    renderNode: {
      [BLOCKS.PARAGRAPH]: (node: any, children: any) => (
        <p className="mb-4">{children}</p>
      ),
      [BLOCKS.HEADING_1]: (node: any, children: any) => (
        <h1 className="text-3xl font-bold mb-4">{children}</h1>
      ),
      [BLOCKS.HEADING_2]: (node: any, children: any) => (
        <h2 className="text-2xl font-bold mb-3">{children}</h2>
      ),
      [BLOCKS.HEADING_3]: (node: any, children: any) => (
        <h3 className="text-xl font-bold mb-2">{children}</h3>
      ),
      [BLOCKS.UL_LIST]: (node: any, children: any) => (
        <ul className="list-disc pl-6 mb-4">{children}</ul>
      ),
      [BLOCKS.OL_LIST]: (node: any, children: any) => (
        <ol className="list-decimal pl-6 mb-4">{children}</ol>
      ),
      [INLINES.ENTRY_HYPERLINK]: (node: any, children: any) => (
        <Link href={`/news/${node.data.target.sys.id}`}>{children}</Link>
      ),
    },
    renderMark: {
      [MARKS.BOLD]: (text: any) => <span className="font-bold">{text}</span>,
      [MARKS.ITALIC]: (text: any) => <span className="italic">{text}</span>,
    },
  };

  return (
    <div className="container max-w-4xl mx-auto py-8">
      <header className="flex items-center justify-between mb-8">
        <div className="flex items-center space-x-2">
          <Image
            src="/news.svg"
            alt="Logo"
            className="mr-2"
            width={40}
            height={40}
          />

          <h1 className="text-6xl font-light">News</h1>
        </div>
      </header>
      <Link
        href="/news"
        className="flex items-center text-primary hover:underline mb-8"
      >
        <ArrowLeft className="w-4 h-4 mr-2" />
        ニュース一覧に戻る
      </Link>

      {/* サムネイル画像 */}
      {isAsset(entry.fields.thumbnail) && (
        <div className="relative h-[400px] w-full mb-8">
          <Image
            src={`https:${entry.fields.thumbnail.fields.file?.url}`}
            alt={entry.fields.title?.toString() ?? ""}
            fill
            className="object-cover rounded-xl"
          />
        </div>
      )}

      {/* メタ情報 */}
      <div className="flex items-center gap-4 mb-6">
        <span className="text-sm text-muted-foreground">
          {entry.fields.date
            ? new Date(entry.fields.date.toString())
                .toLocaleDateString("ja-JP", {
                  year: "numeric",
                  month: "2-digit",
                  day: "2-digit",
                })
                .replace(/\//g, "-")
            : ""}
        </span>
        <span className="text-sm bg-primary/10 text-primary px-2 py-1 rounded">
          {entry.fields.category?.toString()}
        </span>
      </div>

      {/* タイトル */}
      <h1 className="text-3xl font-bold mb-8">
        {entry.fields.title?.toString()}
      </h1>

      {/* 本文 */}
      <div className="prose prose-lg max-w-none">
        {isDocument(entry.fields.body) ? (
          documentToReactComponents(entry.fields.body, options)
        ) : (
          <p>コンテンツを表示できません</p>
        )}
      </div>
    </div>
  );
}
