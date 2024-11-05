"use client";

import { Suspense } from "react";
import { Card, CardContent, CardFooter } from "@ui/components/ui/card";
import { Badge } from "@ui/components/ui/badge";
import { MoreHorizontal } from "lucide-react";
import { Skeleton } from "@ui/components/ui/skeleton";
import { gql, useQuery } from "@apollo/client";
import { OffersData } from "../../../generated/graphql";
import useUserStore from "../../../store/user";
import { useRouter } from "next/navigation";

// Offer type definition
type Offer = {
  id: string;
  title: string;
  description: string;
  imageUrl: string;
  fee: number;
  category: string;
};

type OffersByStatus = {
  inprogressOffers: Offer[];
  appliedOffers: Offer[];
};

const GET_OFFERS_BY_STATUS = gql`
  query GetOffersData($userId: String!) {
    getOffersByStatus(userId: $userId) {
      inprogressOffers {
        id
        title
        description
        imageUrl
        fee
        category
      }
      appliedOffers {
        id
        title
        description
        imageUrl
        fee
        category
      }
    }
  }
`;

// OfferCard component
const OfferCard = ({ offer }: { offer: Offer }) => {
  const router = useRouter();

  const handleClick = () => {
    router.push(`/offer/${offer.id}`);
  };

  return (
    <Card
      className="bg-zinc-900 border-zinc-800 cursor-pointer hover:bg-zinc-800 transition-colors"
      onClick={handleClick}
    >
      <CardContent className="p-0">
        <img src={offer.imageUrl} alt="" className="w-full h-48 object-cover" />
        <div className="p-4">
          <div className="flex gap-2 mb-3">
            <Badge className="bg-cyan-500 text-white">{offer.category}</Badge>
            <div className="ml-auto flex gap-1">
              <MoreHorizontal className="h-4 w-4" />
            </div>
          </div>
          <p className="text-sm mb-3 line-clamp-2">{offer.title}</p>
          <div className="flex items-center gap-4 text-sm mb-3">
            <div>獲得ポイント {offer.fee} FSP</div>
          </div>
          <div className="flex items-center gap-4 text-sm text-gray-400 line-clamp-2">
            <div>{offer.description}</div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

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
  const user = useUserStore((state) => state.user);
  const { data, loading, error } = useQuery<{
    getOffersByStatus: OffersByStatus;
  }>(GET_OFFERS_BY_STATUS, {
    variables: { userId: user?.id },
    skip: !user?.id,
  });

  if (loading) return null;
  if (error) return <div>Error: {error.message}</div>;
  if (!data) return null;

  const { inprogressOffers, appliedOffers } = data.getOffersByStatus;
  const allOffers = [...inprogressOffers, ...appliedOffers];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-xl mb-4">進行中のOffer</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {inprogressOffers.map((offer) => (
            <OfferCard key={offer.id} offer={offer} />
          ))}
        </div>
      </div>

      <div>
        <h2 className="text-xl mb-4">応募中のOffer</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {appliedOffers.map((offer) => (
            <OfferCard key={offer.id} offer={offer} />
          ))}
        </div>
      </div>
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
