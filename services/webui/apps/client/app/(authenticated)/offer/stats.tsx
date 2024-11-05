"use client";

import Image from "next/image";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "../../../store/user";
import { OfferStatsByUserData } from "../../../generated/graphql";

const GET_OFFER_STATS = gql`
  query GetOfferStats($userId: String!) {
    getOfferStatsByUser(userId: $userId) {
      totalOffers
      ongoingOffers
      appliedOffers
      completedOffers
      totalEarnings
    }
  }
`;

export default function OfferStats() {
  const { user } = useUserStore();

  const { loading, error, data } = useQuery(GET_OFFER_STATS, {
    variables: { userId: user?.id || "" },
    skip: !user?.id,
  });

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const stats = data?.getOfferStatsByUser || {
    totalOffers: 0,
    ongoingOffers: 0,
    appliedOffers: 0,
    completedOffers: 0,
    totalEarnings: 0,
  };

  return (
    <div className="p-6 bg-black text-white mb-6">
      <h1 className="text-2xl mb-6">Overview</h1>
      <div className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center space-x-3">
            <Image
              src="/total.svg"
              alt="logo"
              className="mr-2"
              width={40}
              height={40}
            />
            <div>
              <p className="text-xs text-gray-400">Total</p>
              <p className="text-4xl font-bold">{stats.totalOffers}</p>
            </div>
          </div>
          <div className="flex items-center space-x-3">
            <Image
              src="/current.svg"
              alt="logo"
              className="mr-2"
              width={40}
              height={40}
            />
            <div>
              <p className="text-xs text-gray-400">Current</p>
              <p className="text-4xl font-bold">{stats.ongoingOffers}</p>
            </div>
          </div>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center space-x-3">
            <Image
              src="/apply.svg"
              alt="logo"
              className="mr-2"
              width={40}
              height={40}
            />
            <div>
              <p className="text-xs text-gray-400">Applying</p>
              <p className="text-4xl font-bold">{stats.appliedOffers}</p>
            </div>
          </div>
          <div className="flex items-center space-x-3">
            <Image
              src="/complete.svg"
              alt="logo"
              className="mr-2"
              width={40}
              height={40}
            />
            <div>
              <p className="text-xs text-gray-400">Completed</p>
              <p className="text-4xl font-bold">{stats.completedOffers}</p>
            </div>
          </div>
        </div>
        <div className="flex items-center space-x-3">
          <Image
            src="/total_point_earn.svg"
            alt="logo"
            className="mr-2"
            width={40}
            height={40}
          />
          <div>
            <p className="text-xs text-gray-400">Total Point Earned</p>
            <p className="text-4xl font-bold">{stats.totalEarnings}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
