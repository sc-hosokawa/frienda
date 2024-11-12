import { Suspense } from "react";
import Image from "next/image";
import OfferList from "./offer-list";
import OfferListSkeleton from "./offer-list-skeleton";
import OfferStats from "./stats";
import OfferAllList, { OfferAllListSkeleton } from "./offer-all-list";
import { Plus, List } from "lucide-react";
import Link from "next/link";

export default function OfferPage() {
  return (
    <div className="p-4 min-h-screen">
      <div className="flex items-center justify-between gap-2 mb-8">
        <div className="flex items-center gap-2">
          <Image
            src="/offer.svg"
            alt="logo"
            className="mr-2"
            width={40}
            height={40}
          />
          <h1 className="text-6xl font-light tracking-tight">OFFER</h1>
        </div>
        <div className="flex items-center gap-2">
          <Link
            href="/offer/list"
            className="p-2 rounded-full hover:bg-gray-700 transition-colors border-0 border-white"
          >
            <List className="h-8 w-8 text-white" />
          </Link>
          <Link
            href="/offer/create"
            className="p-2 rounded-full hover:bg-gray-700 transition-colors border-0 border-white"
          >
            <Plus className="h-8 w-8 text-white" />
          </Link>
        </div>
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
        <Suspense fallback={<OfferAllListSkeleton />}>
          <OfferAllList />
        </Suspense>
      </div>
    </div>
  );
}
