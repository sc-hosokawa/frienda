import { Asset } from "contentful";
import Image from "next/image";
import Link from "next/link";
import { documentToReactComponents } from "@contentful/rich-text-react-renderer";
import { getEntry } from "../../contentful";
import { Document, BLOCKS, MARKS, INLINES } from "@contentful/rich-text-types";
import { getTranslation, setStaticParamsLocale } from "~/i18n/server";
import { SUPPORTED_LOCALES } from "~/i18n/settings";

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
    locale: string;
  };
};

// categoryStyles を追加
const categoryStyles = {
  "FRIENDSHIP.": "bg-[#2D78FF]",
  "FRIENDSHIP. DAO": "bg-[#00B496]",
  Info: "bg-[#B487FF]",
} as const;

export async function generateStaticParams() {
  return SUPPORTED_LOCALES.map((locale) => ({ locale }));
}

export default async function NewsDetailPage({ params }: Props) {
  const entry = await getEntry("information", params.id);
  setStaticParamsLocale(params.locale);

  const { t } = await getTranslation();

  if (!entry) {
    return <div>{t("news.no-article-found")}</div>;
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
      [INLINES.HYPERLINK]: (node: any) => {
        const uri = node.data.uri;
        const text = node.content.find(
          (child: any) => child.nodeType === "text",
        )?.value;
        return (
          <Link href={uri} className="text-blue-500" passHref>
            {text}
          </Link>
        );
      },
    },
    renderMark: {
      [MARKS.BOLD]: (text: any) => <span className="font-bold">{text}</span>,
      [MARKS.ITALIC]: (text: any) => <span className="italic">{text}</span>,
    },
  };

  return (
    <div className="container max-w-4xl mx-auto py-8">
      <Link href="/news">
        <div className="flex items-center gap-2">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="-mt-6"
          />
        </div>
      </Link>

      <div className="my-8"></div>

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
        <span
          className={`text-sm px-4 py-2 rounded-full text-black font-light ${
            categoryStyles[
              entry.fields.category?.toString() as keyof typeof categoryStyles
            ] ?? "bg-primary/10 text-primary"
          }`}
        >
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
          <p>{t("news.cannot-display-content")}</p>
        )}
      </div>
    </div>
  );
}
