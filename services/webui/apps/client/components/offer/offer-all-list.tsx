"use client";

import Image from "next/image";
import { Suspense, useEffect } from "react";
import { Card, CardContent } from "@ui/components/ui/card";
import { Badge } from "@ui/components/ui/badge";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "../../store/user";
import { useRouter } from "next/navigation";
import { useTranslation } from "~/i18n/client";
import { Input } from "@ui/components/ui/input";
import { ArrowDownUp, Settings2 } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { Button } from "@ui/components/ui/button";
import { OfferAllListSkeleton } from "./offer-all-list-skeleton";

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
      className="bg-zinc-900 border-zinc-800 cursor-pointer hover:bg-zinc-800 transition-colors overflow-hidden"
      onClick={handleClick}
    >
      <CardContent className="p-0">
        <div className="aspect-video relative">
          <img
            src={offer.imageUrl || "/offer.svg"}
            alt="offer image"
            className="w-full h-full object-contain bg-zinc-800"
          />
        </div>
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

// OfferList component with SWR
const OfferListClient = () => {
  const { t } = useTranslation();
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
          <h2 className="text-xl">{t("offer.offer-all-list.ongoing-offer")}</h2>
        </div>
        {inprogressOffers.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {inprogressOffers.map((offer) => (
              <OfferCard key={offer.id} offer={offer} />
            ))}
          </div>
        ) : (
          <div className="text-center py-8 text-zinc-500">
            {t("offer.offer-all-list.no-ongoing-offer")}
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
          <h2 className="text-xl">
            {t("offer.offer-all-list.applying-offer")}
          </h2>
        </div>
        {appliedOffers.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {appliedOffers.map((offer) => (
              <OfferCard key={offer.id} offer={offer} />
            ))}
          </div>
        ) : (
          <div className="text-center py-8 text-zinc-500">
            {t("offer.offer-all-list.no-applying-offer")}
          </div>
        )}
      </div>
    </div>
  );
};

export default function AllOfferList() {
  return (
    <div className="min-h-screen bg-black text-white py-6">
      <div className="mt-8">
        <div className="flex flex-row items-center justify-between">
          <div className="flex flex-col space-y-0 mb-6">
            <h1 className="text-6xl font-light">Offer List</h1>
            <p className="text-sm -mt-2">オファー一覧</p>
          </div>
          <div className="flex flex-row items-center gap-3">
            <Input placeholder="Search Offer" />
            <Settings2 className="w-8 h-8 text-white cursor-pointer" />
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <ArrowDownUp className="w-8 h-8 text-white cursor-pointer" />
              </DropdownMenuTrigger>
              <DropdownMenuContent className="w-56">
                <DropdownMenuLabel>Sort</DropdownMenuLabel>
                <DropdownMenuItem>GitHub</DropdownMenuItem>
                <DropdownMenuItem>Support</DropdownMenuItem>
                <DropdownMenuItem disabled>API</DropdownMenuItem>
                <DropdownMenuItem>Log out</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </div>
        <Suspense fallback={<OfferAllListSkeleton />}>
          <OfferListClient />
        </Suspense>
      </div>
    </div>
  );
}
