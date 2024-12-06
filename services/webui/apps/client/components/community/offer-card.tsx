import React from "react";
import Image from "next/image";
import { MoreHorizontal } from "lucide-react";
import { BorderDash } from "../border-dash";

interface OfferCardProps {
  status: "In-Progress" | "Offer Applied";
  offerId: string;
  title: string;
  lastUpdated: string;
  participants: {
    avatar: string;
    name: string;
  }[];
  deadline: string;
  location: string;
  target: string;
  borderColor?: string;
}

export function OfferCard({
  status,
  offerId,
  title,
  lastUpdated,
  participants,
  deadline,
  location,
  target,
  borderColor = "#2D78FF",
}: OfferCardProps) {
  return (
    <div
      className={`p-6 rounded-2xl border-2 border-solid`}
      style={{ borderColor }}
    >
      {/* Header */}
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-2">
          <div className="w-6 h-6 rounded-full bg-[#2D78FF]" />
          <span className="text-white text-[12px]  leading-[15px]">
            {status}
          </span>
        </div>

        <BorderDash
          imageSrc={"/more-horizontal.svg"}
          alt="more"
          width={24}
          height={24}
          className="w-12 h-12"
          link={"/"}
        />
      </div>

      {/* Content */}
      <div className="space-y-4">
        <div>
          <h3 className="text-[15px]  leading-[18px]">Offer# {offerId}</h3>
          <p className="text-[18px]  leading-[22px] mt-2">{title}</p>
        </div>

        <div>
          <p className="text-[12px] font-[300] leading-[16px] text-[#777777]">
            Last Updated: {lastUpdated}
          </p>
        </div>

        {/* Participants */}
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

        {/* Details */}
        <div className="grid grid-cols-3 gap-4 pt-4">
          <div>
            <p className="text-[12px] font-[300] leading-[16px] text-[#777777]">
              期限
            </p>
            <p className="text-[12px] font-[400] leading-[15px]">{deadline}</p>
          </div>
          <div>
            <p className="text-[12px] font-[300] leading-[16px] text-[#777777]">
              場所
            </p>
            <p className="text-[12px] font-[400] leading-[15px]">{location}</p>
          </div>
          <div>
            <p className="text-[12px] font-[300] leading-[16px] text-[#777777]">
              対象
            </p>
            <p className="text-[12px] font-[400] leading-[15px]">{target}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
