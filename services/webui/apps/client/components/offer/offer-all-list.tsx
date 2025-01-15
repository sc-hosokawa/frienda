"use client";

import Image from "next/image";
import { Suspense, useEffect } from "react";
import { Card, CardContent, CardFooter } from "@ui/components/ui/card";
import { Badge } from "@ui/components/ui/badge";
import { Skeleton } from "@ui/components/ui/skeleton";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "../../store/user";
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
      return "bg-zinc-800";
  }
};

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
            <Badge
              className={`text-black font-medium ${getCategoryBackgroundColor(offer.category)}`}
            >
              {offer.category}
            </Badge>
          </div>
          <p className="text-sm mb-3 line-clamp-2">{offer.title}</p>
          <div className="flex items-center gap-4 text-sm mb-3">
            <div>Fee: {offer.fee} FSP</div>
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
  const { data, loading, error, refetch } = useQuery<{
    getOffersByStatus: OffersByStatus;
  }>(GET_OFFERS_BY_STATUS, {
    variables: { userId: user?.id },
    skip: !user?.id,
  });

  useEffect(() => {
    refetch();
  }, [refetch]);

  if (loading) return null;
  if (error) return <div>Error: {error.message}</div>;
  if (!data) return null;

  const { inprogressOffers, appliedOffers } = data.getOffersByStatus;
  const allOffers = [...inprogressOffers, ...appliedOffers];

  return (
    <div className="space-y-6">
      <div>
        <div className="flex items-center mb-4">
          <Image
            src="/current.svg"
            alt="logo"
            className="mr-2"
            width={30}
            height={30}
          />
          <h2 className="text-xl">進行中のOffer</h2>
        </div>
        {inprogressOffers.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {inprogressOffers.map((offer) => (
              <OfferCard key={offer.id} offer={offer} />
            ))}
          </div>
        ) : (
          <div className="text-center py-8 text-zinc-500">
            進行中のオファーはまだありません
          </div>
        )}
      </div>

      <div>
        <div className="flex items-center mb-4">
          <Image
            src="/apply.svg"
            alt="logo"
            className="mr-2"
            width={30}
            height={30}
          />
          <h2 className="text-xl">応募中のOffer</h2>
        </div>
        {appliedOffers.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {appliedOffers.map((offer) => (
              <OfferCard key={offer.id} offer={offer} />
            ))}
          </div>
        ) : (
          <div className="text-center py-8 text-zinc-500">
            応募中のオファーはまだありません
          </div>
        )}
      </div>
    </div>
  );
};

export const OfferAllListSkeleton = () => (
  <div className="min-h-screen bg-black text-white py-6">
    <div className="">
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
      <div className="mt-8">
        <div className="flex flex-col space-y-0 mb-6">
          <h1 className="text-6xl font-light">Offer List</h1>
          <p className="text-sm -mt-2">オファー一覧</p>
        </div>

        <Suspense fallback={<OfferAllListSkeleton />}>
          <OfferListClient />
        </Suspense>
      </div>
    </div>
  );
}
