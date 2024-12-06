"use client";

import Image from "next/image";
import { Button } from "../../../../../packages/ui/components/ui/button";

export default function CommunityLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="bg-black text-white flex-1">
      <div className="flex items-center justify-between pt-[115px] border-gray-800">
        <div className="flex items-center gap-2">
          <Image
            src="/community.svg"
            alt="logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              Community
            </h1>
            <p className="text-sm">コミュニティ</p>
          </div>
        </div>
        <Button
          variant="ghost"
          size="icon"
          className="rounded-full border border-dashed border-white w-[60px] h-[60px] flex items-center justify-center"
        >
          <Image src="/search.svg" alt="plus" width={24} height={24} />
        </Button>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />
      {children}
    </div>
  );
}
