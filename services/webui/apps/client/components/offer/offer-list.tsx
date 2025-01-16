"use client";

import { useEffect } from "react";
import { Card, CardContent } from "@ui/components/ui/card";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "~/store/user";
import { OffersData } from "~/generated/graphql";
import { useRouter } from "next/navigation";
import { useTranslation } from "~/i18n/client";

const GET_OFFERS_BY_OWNER = gql`
  query GetOffersByOwner($userId: String!) {
    getOffersByOwner(userId: $userId) {
      offerList {
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

interface ResData {
  getOffersByOwner: OffersData;
}

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

export default function OfferList() {
  const { user } = useUserStore();
  const { t } = useTranslation();
  const router = useRouter();

  const { data, loading, error, refetch } = useQuery<ResData>(
    GET_OFFERS_BY_OWNER,
    {
      variables: { userId: user?.id },
      skip: !user?.id,
    }
  );

  useEffect(() => {
    refetch();
  }, [refetch]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const offers = data?.getOffersByOwner?.offerList || [];

  if (offers.length === 0) {
    return (
      <div className="text-center py-10">
        <p className="text-zinc-500">{t("offer.offer-list.no-offer-yet")}</p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {offers.map((offer) => (
        <Card
          key={offer.id}
          className="bg-zinc-900 border border-zinc-800 relative overflow-hidden cursor-pointer hover:bg-zinc-800 transition-colors"
          onClick={() => router.push(`/offer/${offer.id}`)}
        >
          <CardContent className="p-6">
            {offer.imageUrl && (
              <div className="mb-4">
                <img
                  src={offer.imageUrl}
                  alt={offer.title}
                  className="w-full h-40 object-cover rounded-md"
                />
              </div>
            )}

            <div className="flex justify-between items-start mb-2">
              <div>
                <div className="text-sm text-zinc-500 mb-1">
                  Offer# {offer.id}
                </div>
                <h3 className="text-base text-zinc-100 font-medium">
                  {offer.title}
                </h3>
              </div>
            </div>

            <div className="text-sm text-zinc-500 mb-4 line-clamp-2 min-h-[3em]">
              {offer.description}
            </div>

            <div className="flex justify-between items-center pt-4 border-t border-zinc-800">
              <div
                className={`text-sm text-black px-2 py-0.5 rounded-full inline-block ${getCategoryBackgroundColor(offer.category)}`}
              >
                {offer.category}
              </div>
              <div className="text-sm font-medium text-white">
                {offer.fee} FSP
              </div>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}
