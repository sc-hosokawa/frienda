"use client";

import { Suspense } from "react";
import useSWR from "swr";
import { Button } from "@ui/components/ui/button";
import { Card, CardContent, CardFooter } from "@ui/components/ui/card";
import { Badge } from "@ui/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@ui/components/ui/avatar";
import { Send, MoreHorizontal, Download } from "lucide-react";
import { Skeleton } from "@ui/components/ui/skeleton";

// Offer type definition
type Offer = {
  image: string;
  categories: { name: string; color: string }[];
  title: string;
  points: string;
  match: string;
  date: string;
  status: string;
  details: string;
  user: {
    avatar: string;
    name: string;
    connections: string;
  };
};

// Simulated API fetch function
const fetchOffers = async (): Promise<Offer[]> => {
  await new Promise((resolve) => setTimeout(resolve, 5000)); // 5 second delay
  return Array(6).fill({
    image: "/placeholder.svg?height=200&width=400",
    categories: [
      { name: "Category A", color: "bg-cyan-500" },
      { name: "Category B", color: "bg-pink-500" },
    ],
    title: "イベントに参加してくれるアーティスト募集中！2万円で良い...",
    points: "1,000",
    match: "100% Match!",
    date: "2024/10/31",
    status: "審査中",
    details: "2 skills, 1 region, 1 other",
    user: {
      avatar: "/placeholder.svg?height=40&width=40",
      name: "kyoko_adagawa",
      connections: "3 connections",
    },
  });
};

// OfferCard component
const OfferCard = ({ offer }: { offer: Offer }) => (
  <Card className="bg-zinc-900 border-zinc-800">
    <CardContent className="p-0">
      <img src={offer.image} alt="" className="w-full h-48 object-cover" />
      <div className="p-4">
        <div className="flex gap-2 mb-3">
          {offer.categories.map((category, idx) => (
            <Badge key={idx} className={`${category.color} text-white`}>
              {category.name}
            </Badge>
          ))}
          <div className="ml-auto flex gap-1">
            <Download className="h-4 w-4" />
            <MoreHorizontal className="h-4 w-4" />
          </div>
        </div>
        <p className="text-sm mb-3">{offer.title}</p>
        <div className="flex items-center gap-4 text-sm mb-3">
          <div>獲得ポイント {offer.points} Pt</div>
          <div className="text-green-500">{offer.match}</div>
        </div>
        <div className="flex items-center gap-4 text-sm text-gray-400">
          <div>{offer.date}</div>
          <div>{offer.status}</div>
          <div>{offer.details}</div>
        </div>
      </div>
    </CardContent>
    <CardFooter className="p-4 pt-0">
      <div className="flex items-center gap-2">
        <Avatar className="h-8 w-8">
          <AvatarImage src={offer.user.avatar} />
          <AvatarFallback>UA</AvatarFallback>
        </Avatar>
        <div className="text-sm">
          <div>{offer.user.name}</div>
          <div className="text-gray-400">{offer.user.connections}</div>
        </div>
        <Button
          variant="outline"
          size="sm"
          className="ml-auto text-white border-white"
        >
          4.5
        </Button>
      </div>
    </CardFooter>
  </Card>
);

// SkeletonCard component
const SkeletonCard = () => (
  <Card className="bg-zinc-900 border-zinc-800">
    <CardContent className="p-0">
      <Skeleton className="w-full h-48" />
      <div className="p-4">
        <div className="flex gap-2 mb-3">
          <Skeleton className="h-6 w-20" />
          <Skeleton className="h-6 w-20" />
        </div>
        <Skeleton className="h-4 w-full mb-3" />
        <Skeleton className="h-4 w-3/4 mb-3" />
        <div className="flex items-center gap-4 mb-3">
          <Skeleton className="h-4 w-24" />
          <Skeleton className="h-4 w-24" />
        </div>
        <div className="flex items-center gap-4">
          <Skeleton className="h-4 w-20" />
          <Skeleton className="h-4 w-20" />
          <Skeleton className="h-4 w-20" />
        </div>
      </div>
    </CardContent>
    <CardFooter className="p-4 pt-0">
      <div className="flex items-center gap-2 w-full">
        <Skeleton className="h-8 w-8 rounded-full" />
        <div className="flex-grow">
          <Skeleton className="h-4 w-24 mb-1" />
          <Skeleton className="h-3 w-20" />
        </div>
        <Skeleton className="h-8 w-12" />
      </div>
    </CardFooter>
  </Card>
);

// OfferList component with SWR
const OfferListClient = () => {
  const { data: offers } = useSWR<Offer[]>("offers", fetchOffers, {
    suspense: true,
    fallbackData: Array(6).fill({
      image: "/placeholder.svg?height=200&width=400",
      categories: [
        { name: "Category A", color: "bg-cyan-500" },
        { name: "Category B", color: "bg-pink-500" },
      ],
      title: "イベントに参加してくれるアーティスト募集中！2万円で良い...",
      points: "1,000",
      match: "100% Match!",
      date: "2024/10/31",
      status: "審査中",
      details: "2 skills, 1 region, 1 other",
      user: {
        avatar: "/placeholder.svg?height=40&width=40",
        name: "kyoko_adagawa",
        connections: "3 connections",
      },
    }),
    revalidateOnMount: true,
  });

  if (!offers) return null;

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      {offers.map((offer, index) => (
        <OfferCard key={index} offer={offer} />
      ))}
    </div>
  );
};

// Rename OfferListFallback to OfferAllListSkeleton and export it
export const OfferAllListSkeleton = () => (
  <div className="min-h-screen bg-black text-white py-6">
    <div className="max-w-7xl mx-auto">
      <div className="flex justify-between items-center mb-6">
        <Skeleton className="h-8 w-32" /> {/* タイトルのスケルトン */}
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {Array(6)
          .fill(null)
          .map((_, index) => (
            <SkeletonCard key={index} />
          ))}
      </div>
    </div>
  </div>
);

export default function AllOfferList() {
  return (
    <div className="min-h-screen bg-black text-white py-6">
      <div className="max-w-7xl mx-auto">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl ml-6">Offer List</h1>
        </div>

        <Suspense fallback={<OfferAllListSkeleton />}>
          <OfferListClient />
        </Suspense>
      </div>
    </div>
  );
}
