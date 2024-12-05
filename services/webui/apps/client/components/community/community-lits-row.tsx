import React, { useState } from "react";
import Image from "next/image";
import { Upload, MoreHorizontal } from "lucide-react";
import heart from "../../public/heart.svg";
import {
  TableCell,
  TableRow,
} from "../../../../packages/ui/components/ui/table";

interface CommunityListsRowProps {
  id: string;
  name: string;
  avatar?: string;
  friendCount: number;
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
    <TableRow className="group hover:bg-[#E4DBC0] transition-colors hover:cursor-pointer border-none">
      <TableCell>
        <button
          onClick={(e) => {
            e.stopPropagation();
            setIsLiked(!isLiked);
          }}
          className="w-12 h-12 relative flex items-center justify-center"
        >
          <div
            className={`absolute inset-0 rounded-full border border-dashed ${isLiked ? "border-transparent" : "border-white"}`}
          />
          <div
            className={`w-12 h-12 rounded-full flex items-center justify-center ${isLiked ? "bg-white" : "group-hover:bg-black"}`}
          >
            <Image
              src={heart}
              alt="heart"
              width={18}
              height={18}
              className={`${isLiked ? "text-black" : "text-gray-400 group-hover:text-black"}`}
            />
          </div>
        </button>
      </TableCell>
      <TableCell>
        <div className="flex items-center gap-3">
          <Image
            src={avatar || "/logo_visualonly.jpg"}
            alt={name}
            className="w-10 h-10 rounded-full object-cover"
            width={40}
            height={40}
          />
          <div className="flex flex-col">
            <span className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
              {name}
            </span>
            <span className="text-[12px] font-light leading-[16px] text-left text-[#777777] group-hover:text-black/70">
              {`${friendCount} common friends`}
            </span>
          </div>
        </div>
      </TableCell>

      <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
        {rate}
      </TableCell>
      <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
        {type}
      </TableCell>
      <TableCell>
        {comment && (
          <span className="px-3 py-1 bg-purple-500/20 text-purple-300 group-hover:bg-purple-600/30 group-hover:text-purple-900 rounded-full text-sm transition-colors">
            {comment}
          </span>
        )}
      </TableCell>
      <TableCell>
        <div className="flex flex-col items-start">
          <span className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
            {connection?.offer}
          </span>
          <span className="text-[12px] font-light leading-[16px] text-left text-[#777777] group-hover:text-black">
            {connection?.date}
          </span>
        </div>
      </TableCell>
      <TableCell>
        {isOnline ? (
          <div className="flex items-center gap-1">
            <div className="w-3 h-3 rounded-full bg-[#00B496]"></div>
            <span className="text-[12px] font-light leading-[16px] text-left group-hover:text-black">
              Online
            </span>
          </div>
        ) : (
          <span className="text-[12px] font-light leading-[16px] text-left group-hover:text-black">
            {lastLogin}
          </span>
        )}
      </TableCell>
      <TableCell>
        <div className="flex items-center gap-2">
          <button className="w-12 h-12 rounded-full flex items-center justify-center relative">
            <div className="absolute inset-0 rounded-full border border-dashed border-white group-hover:border-black" />
            <Upload className="w-[18px] h-[18px] text-white group-hover:text-black" />
          </button>
          <button className="w-12 h-12 rounded-full flex items-center justify-center relative">
            <div className="absolute inset-0 rounded-full border border-dashed border-white group-hover:border-black" />
            <MoreHorizontal className="w-[18px] h-[18px] text-white group-hover:text-black" />
          </button>
        </div>
      </TableCell>
    </TableRow>
  );
}
