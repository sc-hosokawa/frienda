"use client";

import { Suspense } from "react";
import Image from "next/image";
import OfferList from "./offer-list";
import OfferListSkeleton from "./offer-list-skeleton";
import OfferStats from "./stats";
import OfferAllList, { OfferAllListSkeleton } from "./offer-all-list";
import Link from "next/link";
import useUserStore from "../../../store/user";
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@ui/components/ui/tooltip";

export default function OfferPage() {
  const { user } = useUserStore();
  console.log(user?.fspBalance);

  return (
    <div className="p-4 min-h-screen">
      <div className="flex items-center gap-2 pt-[103px] justify-between mb-8">
        <div className="flex items-center gap-2">
          <Image
            src="/offer.svg"
            alt="logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col space-y-0">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              OFFERS
            </h1>
            <p className="text-sm -mt-2">オファー</p>
          </div>{" "}
        </div>
        <div className="flex items-center gap-2">
          <Link
            href="/offer/list"
            className="p-2 rounded-full hover:bg-gray-700 transition-colors border border-white border-dashed w-[60px] h-[60px] flex items-center justify-center"
          >
            <Image src="/search.svg" alt="list" width={24} height={24} />
          </Link>
          {user?.fspBalance !== undefined && user.fspBalance >= 20 ? (
            <Link
              href="/offer/create"
              className="p-2 rounded-full hover:bg-gray-700 transition-colors border border-white border-dashed w-[60px] h-[60px] flex items-center justify-center"
            >
              <Image src="/plus.svg" alt="plus" width={24} height={24} />
            </Link>
          ) : (
            <TooltipProvider>
              <Tooltip delayDuration={0}>
                <TooltipTrigger asChild>
                  <div className="p-2 rounded-full border border-white border-dashed w-[60px] h-[60px] flex items-center justify-center opacity-50 cursor-not-allowed">
                    <Image src="/plus.svg" alt="plus" width={24} height={24} />
                  </div>
                </TooltipTrigger>
                <TooltipContent>
                  <p>20 FSP以上を保有するユーザーがOfferを作成できます</p>
                </TooltipContent>
              </Tooltip>
            </TooltipProvider>
          )}
        </div>
      </div>
      <div className="">
        <hr className="mb-8 mt-24 border-[#303030]" />
        <OfferStats />
        <div className="flex flex-col space-y-0 mt-16 mb-8">
          <h1 className="text-6xl font-light">My Offers</h1>
          <p className="text-sm">マイオファー</p>
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
