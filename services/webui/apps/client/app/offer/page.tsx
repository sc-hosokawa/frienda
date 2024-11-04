import { Suspense } from "react";
import Image from "next/image";
import OfferList from "../offer/offer-list";
import OfferListSkeleton from "../offer/offer-list-skeleton";
import OfferStats from "./stats";
import OfferAllList from "./offer-all-list";

export default function OfferPage() {
  return (
    <div className="p-4 min-h-screen">
      <div className="flex items-center gap-2 mb-8">
        <Image
          src="/offer.svg"
          alt="logo"
          className="mr-2"
          width={40}
          height={40}
        />
        <h1 className="text-6xl tracking-tight">OFFER</h1>
      </div>
      <div className="max-w-4xl mx-auto">
        <OfferStats />
        <div className="flex items-baseline gap-2 mb-4">
          <h1 className="text-2xl p-6">My Offers</h1>
          <p className="text-sm text-zinc-400">マイオファー</p>
        </div>
        <Suspense fallback={<OfferListSkeleton />}>
          <OfferList />
        </Suspense>
        <Suspense fallback={<div>Loading...</div>}>
          <OfferAllList />
        </Suspense>
      </div>
    </div>
  );
}
