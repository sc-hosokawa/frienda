import { Card } from "@ui/components/ui/card";
import Image from "next/image";
import { getEntries } from "../contentful";
import { Asset } from "contentful";
import Link from "next/link";
import { differenceInDays } from "date-fns";

function isAsset(obj: any): obj is Asset {
  return obj && typeof obj === "object" && "fields" in obj && "sys" in obj;
}

const categoryStyles = {
  "FRIENDSHIP.": "bg-[#2D78FF]",
  "FRIENDSHIP. DAO": "bg-[#00B496]",
  Info: "bg-[#B487FF]",
} as const;

export default async function NewsPage() {
  const entries = await getEntries("information", {
    order: "-sys.createdAt",
    limit: 10,
  });

  return (
    <div className="container max-w-7xl mx-auto">
      <div className="flex items-center justify-between mb-8">
        <div className="flex items-center gap-2 pt-[125px] space-x-2">
          <Image
            src="/news.svg"
            alt="Logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col space-y-0">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              NEWS
            </h1>
            <p className="text-sm -mt-2">ニュース</p>
          </div>
        </div>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {entries.items.map((entry) => {
          const isNew = entry.fields.date
            ? differenceInDays(
                new Date(),
                new Date(entry.fields.date.toString()),
              ) <= 5
            : false;

          return (
            <Link key={entry.sys.id} href={`/news/${entry.sys.id}`}>
              <Card className="h-full overflow-hidden hover:shadow-lg transition-all hover:bg-white/50 relative border rounded-3xl border-white/30">
                {isNew && (
                  <span className="absolute top-0 left-0 z-10 bg-[#E1F000] text-black py-4 px-6 rounded-3xl text-xs font-light">
                    NEW
                  </span>
                )}
                <div className="relative h-48 w-full p-2">
                  <div className="relative h-full w-full rounded-lg overflow-hidden">
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
                </div>
                <div className="p-4 flex flex-col h-[240px]">
                  <div className="flex items-center justify-between mb-2">
                    <span
                      className={`text-sm my-2 px-4 py-2 rounded-full text-black font-light ${
                        categoryStyles[
                          entry.fields.category?.toString() as keyof typeof categoryStyles
                        ] ?? "bg-primary/10 text-primary"
                      }`}
                    >
                      {entry.fields.category?.toString()}
                    </span>
                  </div>
                  <h2 className="text-lg mb-2 line-clamp-3 flex-grow">
                    {entry.fields.title?.toString()}
                  </h2>
                  <span className="text-xs mt-4 text-muted-foreground">
                    {entry.fields.date
                      ? new Date(entry.fields.date.toString())
                          .toLocaleDateString("ja-JP", {
                            year: "numeric",
                            month: "2-digit",
                            day: "2-digit",
                            hour: "2-digit",
                            minute: "2-digit",
                          })
                          .replace(/\//g, "-")
                      : ""}
                  </span>
                </div>
              </Card>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
