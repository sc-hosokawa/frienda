import { Card } from "@ui/components/ui/card";
import Image from "next/image";
import { Share2 } from "lucide-react";

export default function Component() {
  const news = [
    {
      id: 1,
      image: "/placeholder.svg?height=400&width=600",
      category: "FRIENDSHIP",
      title: "ここに追加のタイトルが入りますここに追加のタイトルが入ります",
      description:
        "ここに説明の内容が入ります。ここに説明の内容が入ります。ここに説明の内容が入ります。ここに説明の内容が入ります。",
      date: "2024/12/12 12:23",
      isNew: true,
    },
    // Repeat similar items for other cards
  ];

  return (
    <div className="min-h-screen bg-black text-white">
      <header className="p-4 border-b border-gray-800">
        <div className="flex items-center gap-2 mb-6">
          <Image
            src="/news.svg"
            alt="logo"
            className="mr-2"
            width={40}
            height={40}
          />
          <span className="text-6xl tracking-wide mb-2">NEWS</span>
        </div>
        <nav>
          <ul className="flex gap-6 text-sm text-gray-400">
            <li className="text-white">All</li>
            <li>FRIENDSHIP</li>
            <li>FRIENDSHIP Q&Q</li>
            <li>Other</li>
          </ul>
        </nav>
      </header>

      <main className="p-4">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {news.map((item) => (
            <Card
              key={item.id}
              className="bg-gray-900 border-gray-800 overflow-hidden group"
            >
              <div className="relative">
                <Image
                  src={item.image}
                  alt=""
                  width={600}
                  height={400}
                  className="w-full h-48 object-cover"
                />
                <div className="absolute top-2 left-2 flex gap-2">
                  {item.isNew && (
                    <span className="bg-yellow-400 text-black text-xs px-2 py-1 rounded-full">
                      new
                    </span>
                  )}
                  <span className="bg-cyan-500 text-white text-xs px-2 py-1 rounded-full">
                    {item.category}
                  </span>
                </div>
                <button className="absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-black/50 rounded-full opacity-0 group-hover:opacity-100 transition-opacity">
                  <Share2 className="w-4 h-4" />
                </button>
              </div>
              <div className="p-4 space-y-2">
                <h2 className="font-medium line-clamp-2">{item.title}</h2>
                <p className="text-sm text-gray-400 line-clamp-2">
                  {item.description}
                </p>
                <time className="text-xs text-gray-500">{item.date}</time>
              </div>
            </Card>
          ))}
        </div>
      </main>
    </div>
  );
}
