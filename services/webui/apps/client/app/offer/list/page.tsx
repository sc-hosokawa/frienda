import { useState, useEffect } from "react";
import { Button } from "@ui/components/ui/button";
import { Card } from "@ui/components/ui/card";
import { Skeleton } from "@ui/components/ui/skeleton";
import {
  Diamond,
  Filter,
  Heart,
  MessageSquare,
  Share2,
  Star,
} from "lucide-react";
import Image from "next/image";

// インターフェースを定義
interface Offer {
  title: string;
  description: string;
  lastUpdated: string;
  points: number;
  match: number;
  date: string;
  location: string;
  participants: string;
  user: {
    name: string;
    connections: number;
    rating: number;
  };
}

export default function OfferList() {
  const [isLoading, setIsLoading] = useState(true);
  // 型を指定して useState を使用
  const [offers, setOffers] = useState<Offer[]>([]);

  useEffect(() => {
    // Simulate API call
    const fetchOffers = async () => {
      await new Promise((resolve) => setTimeout(resolve, 2000)); // 2 second delay
      setOffers(
        Array(6).fill({
          title: "イベントに参加してくれるアーティスト募集中！",
          description: "2行目の場合こう見えます。長いと途中でこう...",
          lastUpdated: "2024/10/10",
          points: 100,
          match: 75,
          date: "2024/10/31",
          location: "東京都",
          participants: "2 Artists, 1 Promoter, 1 Other",
          user: {
            name: "brady_nakayama",
            connections: 4,
            rating: 4.5,
          },
        }),
      );
      setIsLoading(false);
    };

    fetchOffers();
  }, []);

  const categories = [
    { name: "All", count: 48 },
    { name: "Category A", count: 16 },
    { name: "Category B", count: 16 },
    { name: "Category C", count: 16 },
  ];

  return (
    <div className="min-h-screen bg-black text-white p-6">
      <div className="max-w-7xl mx-auto">
        <header className="flex justify-between items-center mb-8">
          <h1 className="text-4xl font-bold">Offer List</h1>
          <div className="flex gap-4">
            <Button variant="outline" className="text-white">
              <Filter className="w-4 h-4 mr-2" />
              絞り込み
            </Button>
            <Button variant="outline" className="text-white">
              並び替え
            </Button>
          </div>
        </header>

        <nav className="mb-8 border-b border-zinc-800">
          <ul className="flex gap-8">
            {categories.map((category, index) => (
              <li key={index}>
                <button
                  className={`pb-2 ${
                    index === 0 ? "border-b-2 border-blue-500" : "text-gray-400"
                  }`}
                >
                  {category.name} ({category.count})
                </button>
              </li>
            ))}
          </ul>
        </nav>

        <div className="grid md:grid-cols-2 gap-6">
          {isLoading
            ? Array(6)
                .fill(0)
                .map((_, index) => <OfferCardSkeleton key={index} />)
            : offers.map((offer, index) => (
                <OfferCard key={index} offer={offer} />
              ))}
        </div>
      </div>
    </div>
  );
}

function OfferCard({ offer }: { offer: Offer }) {
  return (
    <Card className="bg-zinc-900 border-none p-4">
      <div className="flex gap-4">
        <Image
          src="/placeholder.svg"
          alt="Offer thumbnail"
          width={150}
          height={150}
          className="rounded-lg"
        />
        <div className="flex-1">
          <div className="flex justify-between items-start mb-2">
            <span className="px-2 py-1 rounded text-xs bg-blue-500/20 text-blue-400">
              Category
            </span>
            <div className="flex gap-2">
              <Share2 className="w-4 h-4" />
              <Heart className="w-4 h-4" />
            </div>
          </div>

          <h3 className="font-medium mb-1">{offer.title}</h3>
          <p className="text-sm text-gray-400 mb-2">{offer.description}</p>
          <p className="text-xs text-gray-500 mb-4">
            Last Updated: {offer.lastUpdated}
          </p>

          <div className="flex justify-between items-center mb-4">
            <div className="flex items-center gap-2 text-sm">
              <span className="px-2 py-1 rounded bg-zinc-800">
                報酬ポイント {offer.points} P
              </span>
            </div>
            <div className="flex items-center gap-1 text-sm">
              <Diamond className="w-4 h-4" />
              <span>{offer.match}% Match!</span>
            </div>
          </div>

          <div className="grid grid-cols-3 gap-4 text-sm mb-4">
            <div>
              <div className="text-gray-400">開催日</div>
              <div>{offer.date}</div>
            </div>
            <div>
              <div className="text-gray-400">場所</div>
              <div>{offer.location}</div>
            </div>
            <div>
              <div className="text-gray-400">対象</div>
              <div className="truncate">{offer.participants}</div>
            </div>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <div className="w-6 h-6 rounded-full bg-zinc-800" />
                <div className="text-sm">
                  <div>{offer.user.name}</div>
                  <div className="text-gray-400 text-xs">
                    {offer.user.connections} connections
                  </div>
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Star className="w-4 h-4" />
                <span className="text-sm">{offer.user.rating}</span>
              </div>
            </div>
            <div className="flex gap-2">
              <MessageSquare className="w-4 h-4" />
              <button className="text-sm">→</button>
            </div>
          </div>
        </div>
      </div>
    </Card>
  );
}

function OfferCardSkeleton() {
  return (
    <Card className="bg-zinc-900 border-none p-4">
      <div className="flex gap-4">
        <Skeleton className="w-[150px] h-[150px] rounded-lg" />
        <div className="flex-1">
          <div className="flex justify-between items-start mb-2">
            <Skeleton className="w-20 h-6" />
            <div className="flex gap-2">
              <Skeleton className="w-4 h-4" />
              <Skeleton className="w-4 h-4" />
            </div>
          </div>

          <Skeleton className="w-3/4 h-6 mb-1" />
          <Skeleton className="w-full h-4 mb-2" />
          <Skeleton className="w-1/2 h-4 mb-4" />

          <div className="flex justify-between items-center mb-4">
            <Skeleton className="w-32 h-8" />
            <Skeleton className="w-24 h-6" />
          </div>

          <div className="grid grid-cols-3 gap-4 mb-4">
            {[0, 1, 2].map((i) => (
              <div key={i}>
                <Skeleton className="w-full h-4 mb-1" />
                <Skeleton className="w-3/4 h-4" />
              </div>
            ))}
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Skeleton className="w-6 h-6 rounded-full" />
                <div>
                  <Skeleton className="w-24 h-4 mb-1" />
                  <Skeleton className="w-20 h-3" />
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Skeleton className="w-4 h-4" />
                <Skeleton className="w-8 h-4" />
              </div>
            </div>
            <div className="flex gap-2">
              <Skeleton className="w-4 h-4" />
              <Skeleton className="w-4 h-4" />
            </div>
          </div>
        </div>
      </div>
    </Card>
  );
}
