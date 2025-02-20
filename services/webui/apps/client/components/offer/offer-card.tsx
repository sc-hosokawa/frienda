"use client";

import Image from "next/image";
import { Card } from "@ui/components/ui/card";
import { useRouter } from "next/navigation";

// カテゴリーに応じた背景色を返す関数を定義
const getCategoryBackgroundColor = (category: string | undefined | null) => {
  switch (category) {
    case "Creation":
      return "bg-orange-500";
    case "Event":
      return "bg-green-500";
    case "Promotion":
      return "bg-yellow-500";
    case "Other":
      return "bg-gray-400";
    default:
      return "bg-blue-500";
  }
};

export interface Offer {
  id: string;
  title: string;
  description: string;
  imageUrl?: string;
  fee: number;
  category: string;
  place: string;
}

export function OfferCard({ offer }: { offer: Offer }) {
  const router = useRouter();

  const handleClick = () => {
    router.push(`/offer/${offer.id}`);
  };

  return (
    <Card
      className="bg-zinc-900 border-none p-4 cursor-pointer hover:bg-zinc-800 transition-colors"
      onClick={handleClick}
    >
      <div className="flex gap-4">
        {offer.imageUrl ? (
          <Image
            src={offer.imageUrl}
            alt="Offer thumbnail"
            width={150}
            height={150}
            className="rounded-lg"
          />
        ) : (
          <Image
            src="/offer.svg"
            alt="Default thumbnail"
            width={150}
            height={150}
            className="rounded-lg"
          />
        )}

        <div className="flex-1 min-w-0">
          <div className="flex justify-between items-start mb-2">
            <span
              className={`px-2 py-1 rounded-full text-black text-xs ${getCategoryBackgroundColor(offer.category)}`}
            >
              {offer.category}
            </span>
            {/*
            <div className="flex gap-2">
              <Share2 className="w-4 h-4" />
              <Heart className="w-4 h-4" />
            </div>
            */}
          </div>

          <h3 className="font-medium mb-1 truncate">{offer.title}</h3>
          <p className="text-sm text-gray-400 mb-2 line-clamp-2 break-words">
            {offer.description}
          </p>

          {offer.place && (
            <div className="flex items-center gap-2 text-sm mb-2">
              <span className="px-2 py-1">場所: {offer.place}</span>
            </div>
          )}
          <div className="flex items-center gap-2 text-sm">
            <span className="px-2 py-1 rounded bg-zinc-800">
              報酬: {offer.fee.toLocaleString()} FSP
            </span>
          </div>

          {/*

          <div className="grid grid-cols-3 gap-4 text-sm mb-4">
            <div>
              <div className="text-gray-400">開催日</div>
              <div>{offer.fee}</div>
            </div>
            <div>
              <div className="text-gray-400">場所</div>
              <div>{offer.fee}</div>
            </div>
            <div>
              <div className="text-gray-400">対象</div>
              <div className="truncate">{offer.fee}</div>
            </div>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <div className="w-6 h-6 rounded-full bg-zinc-800" />
                <div className="text-sm">
                  <div>{offer.fee}</div>
                  <div className="text-gray-400 text-xs">
                    {offer.fee} connections
                  </div>
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Star className="w-4 h-4" />
                <span className="text-sm">{offer.fee}</span>
              </div>
            </div>
            <div className="flex gap-2">
              <MessageSquare className="w-4 h-4" />
              <button className="text-sm">→</button>
            </div>
          </div>
          */}
        </div>
      </div>
    </Card>
  );
}
