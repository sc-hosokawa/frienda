import React, { useState } from "react";
import Image from "next/image";
// import Link from "next/link";
import {
  Upload,
  MoreHorizontal,
  Pencil,
  Trash2,
  Check,
  Copy,
  MessageSquare,
} from "lucide-react";
import heart from "~/public/heart.svg";
import { TableCell, TableRow } from "@ui/components/ui/table";
import { getBgClassByType, category } from "~/utils";
import { formatDistanceToNow } from "date-fns";
import { ja } from "date-fns/locale";
import { gql, useMutation } from "@apollo/client";
import useUserStore from "~/store/user";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@ui/components/ui/popover";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { useRouter } from "next/navigation";
import { useTranslation } from "~/i18n/client";

export interface CommunityListsRowProps {
  id: string;
  name: string;
  imageUrl: string;
  category: string;
  favoriteId: string;
  shortNoteId: string;
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
    return dateString;
  }
};

const isOnline = (dateString: string) => {
  try {
    const date = new Date(dateString);
    const now = new Date();
    const diffInMinutes = (now.getTime() - date.getTime()) / (1000 * 60);
    return diffInMinutes <= 15;
  } catch (error) {
    return false;
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

const ADD_SHORTNOTE = gql`
  mutation AddShortnote($writer: String!, $toUser: String!, $comment: String!) {
    addShortnote(writer: $writer, toUser: $toUser, comment: $comment) {
      id
    }
  }
`;

const DELETE_SHORTNOTE = gql`
  mutation DeleteShortnote($shortnoteId: String!) {
    deleteShortnote(shortnoteId: $shortnoteId) {
      id
    }
  }
`;

const EDIT_SHORTNOTE = gql`
  mutation EditShortnote($shortnoteId: String!, $comment: String!) {
    editShortnote(shortnoteId: $shortnoteId, comment: $comment) {
      id
    }
  }
`;

const CREATE_MESSAGE_ROOM = gql`
  mutation CreateNewMessageRoom($input: CreateNewMessageRoomInput!) {
    createNewMessageRoom(input: $input) {
      id
    }
  }
`;

// 接続タイプの定義
type ConnectionType = "FSP Transaction" | "Offer" | "Artist";

// 重複を除去して接続タイプを整理する関数
const getUniqueConnections = (connections: string[]): ConnectionType[] => {
  const uniqueSet = new Set(connections);
  return Array.from(uniqueSet) as ConnectionType[];
};

export default function CommunityListsRow({
  id,
  name,
  imageUrl,
  category,
  favoriteId,
  shortNoteId,
  shortNote,
  lastLoggedIn,
  connections,
  weight,
  refetch,
}: CommunityListsRowProps) {
  const router = useRouter();
  const { user } = useUserStore();
  const [markFavorite] = useMutation(MARK_FAVORITE);
  const [unmarkFavorite] = useMutation(UNMARK_FAVORITE);
  const [addShortnote] = useMutation(ADD_SHORTNOTE);
  const [deleteShortnote] = useMutation(DELETE_SHORTNOTE);
  const [editShortnote] = useMutation(EDIT_SHORTNOTE);
  const [createRoom] = useMutation(CREATE_MESSAGE_ROOM);
  const isLiked = favoriteId !== null;
  const [comment, setComment] = useState(shortNote || "");
  const [showCopied, setShowCopied] = useState(false);
  const { t } = useTranslation();

  const handleFavoriteClick = async (e: React.MouseEvent) => {
    e.preventDefault();

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

  const handleSaveShortnote = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (shortNoteId) {
        await editShortnote({
          variables: {
            shortnoteId: shortNoteId,
            comment: comment,
          },
        });
      } else {
        await addShortnote({
          variables: {
            writer: user?.id,
            toUser: id,
            comment: comment,
          },
        });
      }
      refetch();
    } catch (error) {
      console.error("Failed to save shortnote:", error);
    }
  };

  const handleDeleteShortnote = async (e: React.MouseEvent) => {
    e.stopPropagation();

    try {
      await deleteShortnote({
        variables: {
          shortnoteId: id,
        },
      });
      refetch();
    } catch (error) {
      console.error("Failed to delete shortnote:", error);
    }
  };

  const handleCopyUrl = async (e: React.MouseEvent) => {
    e.stopPropagation();
    const url = `${window.location.origin}/community/${id}`;
    await navigator.clipboard.writeText(url);
    setShowCopied(true);
    setTimeout(() => setShowCopied(false), 2000);
  };

  const handleMessageClick = async (e: React.MouseEvent) => {
    e.stopPropagation();
    try {
      const result = await createRoom({
        variables: {
          input: {
            createdBy: user?.id,
            userList: [user?.id, id],
            category: "dm",
          },
        },
      });

      if (result.data?.createNewMessageRoom?.id) {
        router.push(`/message/${result.data.createNewMessageRoom.id}`);
      }
    } catch (err) {
      console.error("Failed to create message room:", err);
    }
  };

  return (
    <TableRow
      className="group hover:bg-[#E4DBC0] transition-colors hover:cursor-pointer border-none"
      onClick={() => (window.location.href = `/community/${id}`)}
    >
      <TableCell>
        <button
          onClick={(e) => {
            e.stopPropagation();
            handleFavoriteClick(e);
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
            {/*
            <span className="text-[12px] font-light leading-[16px] text-left text-[#777777] group-hover:text-black/70">
              {`${weight}`}
            </span>
            */}
          </div>
        </div>
      </TableCell>
      <TableCell className="text-[15px] font-semibold leading-[16px] text-left group-hover:text-black">
        {category}
      </TableCell>

      <TableCell className="text-[15px] font-semibold leading-[16px] text-left group-hover:text-black">
        <div className="flex items-center justify-between gap-2">
          <span className="flex-1 truncate">{shortNote}</span>
          <Popover>
            <PopoverTrigger asChild>
              <button
                className="p-1 hover:bg-black/10 rounded shrink-0"
                onClick={(e) => {
                  e.stopPropagation();
                }}
              >
                <Pencil className="w-4 h-4 text-gray-500 group-hover:text-black" />
              </button>
            </PopoverTrigger>
            <PopoverContent
              className="w-80"
              onClick={(e) => {
                e.stopPropagation();
              }}
            >
              <form
                onSubmit={(e) => {
                  e.stopPropagation();
                  handleSaveShortnote(e);
                }}
                className="flex gap-2"
              >
                <Input
                  value={comment}
                  onChange={(e) => setComment(e.target.value)}
                  placeholder={t("common.enter-comment")}
                  className="flex-1"
                />
                <div className="flex gap-2">
                  <Button type="submit" size="sm">
                    {t("common.save")}
                  </Button>
                </div>
              </form>
            </PopoverContent>
          </Popover>
        </div>
      </TableCell>
      <TableCell className="text-[15px] font-semibold leading-[16px] text-left group-hover:text-black">
        <div className="flex flex-col">
          {getUniqueConnections(connections).map((connection, index) => (
            <span key={index} className="leading-5">
              {connection}
            </span>
          ))}
        </div>
      </TableCell>
      <TableCell>
        <div className="flex flex-col items-start">
          <span className="text-[15px] font-semibold leading-[16px] text-left group-hover:text-black">
            {lastLoggedIn ? (
              isOnline(lastLoggedIn) ? (
                <span className="text-green-500">Online</span>
              ) : (
                formatRelativeTime(lastLoggedIn)
              )
            ) : (
              ""
            )}
          </span>
        </div>
      </TableCell>

      <TableCell>
        <div className="flex items-center gap-2">
          <Popover>
            <PopoverTrigger asChild>
              <button
                className="w-12 h-12 rounded-full flex items-center justify-center relative"
                onClick={(e) => e.stopPropagation()}
              >
                <div className="absolute inset-0 rounded-full border border-dashed border-white group-hover:border-black" />
                <Upload className="w-[18px] h-[18px] text-white group-hover:text-black" />
              </button>
            </PopoverTrigger>
            <PopoverContent
              className="p-1"
              onClick={(e) => e.stopPropagation()}
            >
              <button
                onClick={handleCopyUrl}
                className="w-full px-3 py-2 text-sm text-left hover:bg-gray-100 hover:text-black rounded flex items-center gap-2"
              >
                {showCopied ? (
                  <>
                    <Check className="w-4 h-4 text-green-500" />
                    <span>{t("common.copied")}</span>
                  </>
                ) : (
                  <>
                    <Copy className="w-4 h-4" />
                    <span>{t("common.copy-url")}</span>
                  </>
                )}
              </button>
            </PopoverContent>
          </Popover>
          <Popover>
            <PopoverTrigger asChild>
              <button
                className="w-12 h-12 rounded-full flex items-center justify-center relative"
                onClick={(e) => e.stopPropagation()}
              >
                <div className="absolute inset-0 rounded-full border border-dashed border-white group-hover:border-black" />
                <MoreHorizontal className="w-[18px] h-[18px] text-white group-hover:text-black" />
              </button>
            </PopoverTrigger>
            <PopoverContent
              className="p-1"
              onClick={(e) => e.stopPropagation()}
            >
              <button
                onClick={handleMessageClick}
                className="w-full px-3 py-2 text-sm text-left hover:bg-gray-100 hover:text-black rounded flex items-center gap-2"
              >
                <MessageSquare className="w-4 h-4" />
                <span>{t("message.send-message")}</span>
              </button>
            </PopoverContent>
          </Popover>
        </div>
      </TableCell>
    </TableRow>
  );
}
