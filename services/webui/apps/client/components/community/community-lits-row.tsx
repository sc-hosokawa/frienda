import React, { useState } from "react";
import Image from "next/image";
import { Upload, MoreHorizontal } from "lucide-react";
import heart from "../../public/heart.svg";

interface CommunityListsRowProps {
  id: string;
  name: string;
  avatar: string;
  friendCount: string;
  rate: string;
  type: string;
  comment?: string | null;
  connection: {
    offer: string;
    date: string;
  };
  isOnline?: boolean;
  lastLogin?: string;
}

export default function CommunityListsRow({
  name,
  avatar,
  friendCount,
  rate,
  type,
  comment,
  connection,
  isOnline,
  lastLogin,
}: CommunityListsRowProps) {
  const [isLiked, setIsLiked] = useState(false);

  return (
    <div className="group flex items-center justify-between w-full h-16 px-4 hover:bg-[#E4DBC0] transition-colors hover:cursor-pointer">
      <div className="flex items-center gap-4">
        <button
          onClick={(e) => {
            e.stopPropagation();
            setIsLiked(!isLiked);
          }}
          className="w-[48px] h-[48px] relative flex items-center justify-center"
        >
          <div
            className={`absolute inset-0 rounded-full border border-dashed ${isLiked ? "border-transparent" : "border-white"}`}
          />
          <div
            className={`w-[48px] h-[48px] rounded-full flex items-center justify-center ${isLiked ? "bg-white" : "group-hover:bg-black"}`}
          >
            <div>
              <Image
                src={heart}
                alt="heart"
                width={18}
                height={18}
                className={`${isLiked ? "text-black" : "text-gray-400 group-hover:text-black"}`}
              />
            </div>
          </div>
        </button>

        <div className="flex items-center gap-3">
          <Image
            src={avatar}
            alt={name}
            className="w-10 h-10 rounded-full object-cover"
            width={40}
            height={40}
          />
          <div className="flex flex-col">
            <span className="text-sm text-white font-medium group-hover:text-black">
              {name}
            </span>
            <span className="text-xs text-[#777777] group-hover:text-black">
              {friendCount}
            </span>
          </div>
        </div>
      </div>

      <div className="flex items-center gap-8">
        <span className="text-base text-white group-hover:text-black">
          {rate}
        </span>
        <span className="text-base text-white group-hover:text-black">
          {type}
        </span>
        {comment && (
          <span className="px-3 py-1 bg-purple-500/20 text-purple-300 group-hover:bg-purple-600/30 group-hover:text-purple-900 rounded-full text-sm transition-colors">
            {comment}
          </span>
        )}
      </div>

      <div className="flex items-center gap-4">
        <div className="flex flex-col items-end">
          <span className="text-sm text-white group-hover:text-black">
            {connection?.offer}
          </span>
          <span className="text-xs text-[#777777] group-hover:text-black">
            {connection?.date}
          </span>
        </div>

        <div className="flex items-center gap-2">
          <div className="flex items-center gap-1">
            {isOnline ? (
              <>
                <div className="w-2 h-2 rounded-full bg-[#00B496]"></div>
                <span className="text-sm group-hover:text-black">Online</span>
              </>
            ) : (
              <>
                <span className="text-sm group-hover:text-black">
                  {lastLogin}
                </span>
              </>
            )}
          </div>
        </div>

        <div className="flex items-center gap-2">
          <button className="w-[48px] h-[48px] rounded-full flex items-center justify-center relative group">
            <div className="absolute inset-0 rounded-full border border-dashed border-white" />
            <div className="w-[48px] h-[48px] rounded-full flex items-center justify-center ">
              <Upload
                className="w-[18px] h-[18px] text-white group-hover:text-black"
                strokeWidth={2}
              />
            </div>
          </button>
          <button className="w-[48px] h-[48px] rounded-full flex items-center justify-center relative group">
            <div className="absolute inset-0 rounded-full border border-dashed border-white" />
            <div className="w-[48px] h-[48px] rounded-full flex items-center justify-center ">
              <MoreHorizontal
                className="w-[18px] h-[18px] text-white group-hover:text-black"
                strokeWidth={2}
              />
            </div>
          </button>
        </div>
      </div>
    </div>
  );
}
