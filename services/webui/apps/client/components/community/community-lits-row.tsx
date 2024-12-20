import React from "react";
import Image from "next/image";
import Link from "next/link";
import { Upload, MoreHorizontal } from "lucide-react";
import heart from "../../public/heart.svg";
import {
  TableCell,
  TableRow,
} from "../../../../packages/ui/components/ui/table";
import { getBgClassByType, UserType } from "../../utils";

export interface CommunityListsRowProps {
  id: string;
  name: string;
  imageUrl: string;
  category: string;
  favoriteId: string;
  shortNote: string;
  lastLoggedIn: string;
  connections: string[];
  weight: number;
}

export default function CommunityListsRow({
  id,
  name,
  imageUrl,
  category,
  favoriteId,
  shortNote,
  lastLoggedIn,
  connections,
  weight,
}: CommunityListsRowProps) {
  // TODO: this should be handled by the backend
  const isLiked = favoriteId !== null;
  return (
    <TableRow className="group hover:bg-[#E4DBC0] transition-colors hover:cursor-pointer border-none">
      <TableCell>
        <button className="w-12 h-12 relative flex items-center justify-center">
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
      <Link href={`/community/${id}`} className="contents">
        <TableCell>
          <div className="flex items-center gap-3">
            <Image
              src={imageUrl || "/logo_visualonly.jpg"}
              alt={name}
              className={`p-1 rounded-full object-cover ${getBgClassByType(category as UserType)}`}
              width={48}
              height={48}
            />
            <div className="flex flex-col">
              <span className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
                {name}
              </span>
              <span className="text-[12px] font-light leading-[16px] text-left text-[#777777] group-hover:text-black/70">
                {`${connections.length} common friends`}
              </span>
            </div>
          </div>
        </TableCell>

        <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
          {weight}
        </TableCell>
        <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
          {shortNote}
        </TableCell>
        <TableCell>{lastLoggedIn}</TableCell>
        <TableCell>
          <div className="flex flex-col items-start">
            <span className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
              {connections.join(", ")}
            </span>
            <span className="text-[12px] font-light leading-[16px] text-left text-[#777777] group-hover:text-black">
              {lastLoggedIn}
            </span>
          </div>
        </TableCell>
      </Link>

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
