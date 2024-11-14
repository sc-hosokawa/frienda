import { Card } from "@ui/components/ui/card";
import Image from "next/image";
import { getEntries } from "../contentful";
import { Asset } from "contentful";
import Link from "next/link";
import { differenceInDays } from "date-fns";

// 型ガードの関数を追加
function isAsset(obj: any): obj is Asset {
  return obj && typeof obj === "object" && "fields" in obj && "sys" in obj;
}

export default async function NewsPage() {
  const entries = await getEntries("information", {
    order: "-sys.createdAt",
    limit: 10,
  });

  return (
    <div className="container max-w-7xl mx-auto">
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
      </header>{" "}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-12">
        {entries.items.map((entry) => {
          const isNew = entry.fields.date
            ? differenceInDays(
                new Date(),
                new Date(entry.fields.date.toString()),
              ) <= 5
            : false;

          return (
            <Link key={entry.sys.id} href={`/news/${entry.sys.id}`}>
              <Card className="overflow-hidden hover:shadow-lg transition-all hover:bg-white/50 relative">
                {isNew && (
                  <span className="absolute top-2 right-2 z-10 bg-yellow-400 text-yellow-900 px-2 py-1 rounded text-xs font-semibold">
                    New
                  </span>
                )}
                <div className="relative h-48 w-full">
                  <Image
                    src={
                      isAsset(entry.fields.thumbnail)
                        ? `https:${entry.fields.thumbnail.fields.file?.url}`
                        : "/placeholder.jpg"
                    }
                    alt={entry.fields.title?.toString() ?? ""}
                    fill
                    className="object-cover"
                  />
                </div>
                <div className="p-4">
                  <div className="flex items-center justify-between mb-2">
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
                  <h2 className="text-lg mb-2 line-clamp-2">
                    {entry.fields.title?.toString()}
                  </h2>
                </div>
              </Card>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
