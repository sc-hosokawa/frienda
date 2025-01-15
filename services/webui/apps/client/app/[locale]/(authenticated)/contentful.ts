import { createClient } from "contentful";

export const contentfulConfig = {
  space: process.env.NEXT_PUBLIC_CTF_SPACE_ID!,
  accessToken: process.env.NEXT_PUBLIC_CTF_CDA_ACCESS_TOKEN!,
  previewAccessToken: process.env.NEXT_PUBLIC_CONTENTFUL_PREVIEW_ACCESS_TOKEN!,
  environment: process.env.NEXT_PUBLIC_CONTENTFUL_ENVIRONMENT || "master",
};

export const contentfulClient = createClient({
  space: contentfulConfig.space,
  accessToken: contentfulConfig.accessToken,
});

/* プレビューモード用のクライアント
export const previewClient = createClient({
  space: contentfulConfig.space,
  accessToken: contentfulConfig.previewAccessToken,
  environment: contentfulConfig.environment,
  host: "preview.contentful.com",
});
*/

// 記事を取得する関数の例
export async function getEntries(contentType: string, options = {}) {
  const client = contentfulClient;
  return client.getEntries({
    content_type: "information",
    ...options,
  });
}

export async function getEntry(contentType: string, id: string) {
  const client = contentfulClient;
  return client.getEntry(id);
}
