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
  friendCount: number;
  rate: string;
  type: {
    title: string;
    role?: string;
  };
  comment?: string;
  connection: {
    offer: string;
    date: string;
  };
  isOnline: boolean;
  description: string;
  connectedSince: string;
  avatar: string;
  skill: string;
  members: { title: string; role?: string }[];
  lastLogin: string;
  offers?: string[] | undefined;
  connections?: UserType[] | undefined;
}

export default function CommunityListsRow({
  id,
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
  // TODO: this should be handled by the backend
  const isLiked = false;
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
              src={avatar || "/logo_visualonly.jpg"}
              alt={name}
              className={`p-1 rounded-full object-cover ${getBgClassByType(type.title as UserType)}`}
              width={48}
              height={48}
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
          {type.title}
        </TableCell>
        <TableCell>
          {comment && (
            <span
              className={`px-3 py-1 ${getBgClassByType(
                type.title as UserType,
              )} text-black group-hover:bg-white rounded-full text-sm transition-colors`}
            >
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
