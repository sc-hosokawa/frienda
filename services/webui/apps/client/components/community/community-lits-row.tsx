import React from "react";
import Image from "next/image";
import Link from "next/link";
import { Upload, MoreHorizontal } from "lucide-react";
import heart from "../../public/heart.svg";
import {
  TableCell,
  TableRow,
} from "../../../../packages/ui/components/ui/table";
import { getBgClassByType, category } from "../../utils";
import { formatDistanceToNow } from "date-fns";
import { ja } from "date-fns/locale";
import { gql, useMutation } from "@apollo/client";
import useUserStore from "../../store/user";

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
  refetch: () => void;
}

const formatRelativeTime = (dateString: string) => {
  try {
    const date = new Date(dateString);
    return formatDistanceToNow(date, { addSuffix: true, locale: ja });
  } catch (error) {
    return dateString; // 日付のパースに失敗した場合は元の文字列を返す
  }
};

const MARK_FAVORITE = gql`
  mutation MarkFavorite($targetUserId: String!, $likedBy: String!) {
    markFavorite(targetUserId: $targetUserId, likedBy: $likedBy) {
      id
    }
  }
`;

const UNMARK_FAVORITE = gql`
  mutation UnmarkFavorite($favoriteId: String!) {
    unmarkFavorite(favoriteId: $favoriteId) {
      id
    }
  }
`;

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
  refetch,
}: CommunityListsRowProps) {
  const { user } = useUserStore();
  const [markFavorite] = useMutation(MARK_FAVORITE);
  const [unmarkFavorite] = useMutation(UNMARK_FAVORITE);
  const isLiked = favoriteId !== null;

  const handleFavoriteClick = async (e: React.MouseEvent) => {
    e.preventDefault(); // Link内部のボタンなのでイベントの伝播を止める

    try {
      if (isLiked) {
        await unmarkFavorite({
          variables: {
            favoriteId: favoriteId,
          },
        });
      } else {
        await markFavorite({
          variables: {
            targetUserId: id,
            likedBy: user?.id,
          },
        });
      }
      refetch();
    } catch (error) {
      console.error("Favorite operation failed:", error);
    }
  };

  return (
    <TableRow className="group hover:bg-[#E4DBC0] transition-colors hover:cursor-pointer border-none">
      <TableCell>
        <button
          onClick={handleFavoriteClick}
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
      <Link href={`/community/${id}`} className="contents">
        <TableCell>
          <div className="flex items-center gap-3">
            <div className="relative w-12 h-12">
              <Image
                src={imageUrl || "/logo_visualonly.jpg"}
                alt={name}
                className="p-1 rounded-full object-cover border-2"
                style={getBgClassByType(category as category)}
                fill
              />
            </div>
            <div className="flex flex-col">
              <span className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
                {name}
              </span>
              <span className="text-[12px] font-light leading-[16px] text-left text-[#777777] group-hover:text-black/70">
                {`${weight}`}
              </span>
            </div>
          </div>
        </TableCell>
        <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
          {category}
        </TableCell>

        <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
          {shortNote}
        </TableCell>
        <TableCell className="text-[15px] font-semibold leading-[16px] text-left  group-hover:text-black">
          {connections.join(", ")}
        </TableCell>
        <TableCell>
          <div className="flex flex-col items-start">
            <span className="text-[15px] font-semibold leading-[16px] text-left group-hover:text-black">
              {lastLoggedIn ? formatRelativeTime(lastLoggedIn) : ""}
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
