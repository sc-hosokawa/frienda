"use client";

import Image from "next/image";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "~/store/user";

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
    <div className="bg-black text-white mb-6">
      <h2 className="text-6xl font-light">Overview</h2>
      <p className="text-sm mb-8">オファー概要</p>
      <div className="space-y-4 bg-[#1C1C1C] p-8 rounded-2xl">
        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center justify-between w-full border-b border-dotted border-white/30 pb-4">
            <div className="flex items-center">
              <Image src="/total.svg" alt="logo" width={60} height={60} />
              <p className="text-4xl font-light ml-3">Total</p>
            </div>
            <p className="text-7xl font-extralight">
              {stats.totalOffers.toLocaleString()}
            </p>
          </div>
          <div className="flex items-center justify-between w-full border-b border-dotted border-white/30 pb-4">
            <div className="flex items-center">
              <Image src="/current.svg" alt="logo" width={60} height={60} />
              <p className="text-4xl font-light ml-3">Current</p>
            </div>
            <p className="text-7xl font-extralight">
              {stats.ongoingOffers.toLocaleString()}
            </p>
          </div>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center justify-between w-full border-b border-dotted border-white/30 pb-4">
            <div className="flex items-center">
              <Image src="/apply.svg" alt="logo" width={60} height={60} />
              <p className="text-4xl font-light ml-3">Applying</p>
            </div>
            <p className="text-7xl font-extralight">
              {stats.appliedOffers.toLocaleString()}
            </p>
          </div>
          <div className="flex items-center justify-between w-full border-b border-dotted border-white/30 pb-4">
            <div className="flex items-center">
              <Image src="/complete.svg" alt="logo" width={60} height={60} />
              <p className="text-4xl font-light ml-3">Completed</p>
            </div>
            <p className="text-7xl font-extralight">
              {stats.completedOffers.toLocaleString()}
            </p>
          </div>
        </div>
        <div className="flex items-center justify-between border-b border-dotted border-white/30 pt-4">
          <div className="flex items-center">
            <Image
              src="/total_point_earn.svg"
              alt="logo"
              width={60}
              height={60}
            />
            <p className="text-4xl font-light ml-3">Total Point Earned</p>
          </div>
          <p className="text-7xl font-extralight">
            {stats.totalEarnings.toLocaleString()}
          </p>
        </div>
      </div>
    </div>
  );
}
