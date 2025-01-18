import React from "react";
import Image from "next/image";
import Link from "next/link";
import { BorderDash } from "../border-dash";

interface OfferCardProps {
  id: number;
  title: string;
  description: string;
  imageUrl: string;
  fee: string;
  category: string;
}

export function OfferCard({
  id,
  title,
  description,
  imageUrl,
  fee,
  category,
}: OfferCardProps) {
  return (
    <div
      className={`p-6 rounded-2xl border-white border border-solid`}
      style={{}}
    >
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-2">
          <div className="w-6 h-6 rounded-full bg-[#2D78FF]" />
          <span className="text-white text-[12px]  leading-[15px]">
            {status}
          </span>
        </div>

        <Link href={`/offer/${id}`}>
          <BorderDash
            imageSrc={"/more-horizontal.svg"}
            alt="more"
            width={24}
            height={24}
            className="w-12 h-12"
          />
        </Link>
      </div>

      {/* Content */}
      <div className="space-y-4">
        <div>
          <h3 className="text-[15px]  leading-[18px]">Offer# {id}</h3>
          <p className="text-[18px]  leading-[22px] mt-2">{title}</p>
        </div>

        <div className="flex gap-4">
          <Image
            src={imageUrl || "/logo_visualonly.jpg"}
            alt={title}
            width={100}
            height={100}
            className="rounded-lg shrink-0"
          />

          <div className="h-[96px] overflow-hidden flex-1">
            {description.length > 200
              ? `${description.substring(0, 200)}...`
              : description}
          </div>
        </div>

        {/* Participants 
        <div className="flex -space-x-2">
          {participants.map((participant, index) => (
            <Image
              key={index}
              src={participant.avatar}
              alt={participant.name}
              width={32}
              height={32}
              className="rounded-full border-2 border-black"
            />
          ))}
        </div>
        */}

        {/* Details */}
        <div className="grid grid-cols-3 gap-4 pt-4">
          <div>
            <p className="text-[12px] font-[300] leading-[16px] text-[#777777] mb-2">
              カテゴリ
            </p>
            <p className="text-[12px] font-[400] leading-[15px]">{category}</p>
          </div>
          <div>
            <p className="text-[12px] font-[300] leading-[16px] text-[#777777] mb-2">
              Fee
            </p>
            <p className="text-[12px] font-[400] leading-[15px]">{fee} fsp</p>
          </div>
        </div>
      </div>
    </div>
  );
}
