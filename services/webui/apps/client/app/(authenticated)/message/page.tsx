"use client";

import Image from "next/image";
import { Suspense } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import { Skeleton } from "@ui/components/ui/skeleton";
import { Info } from "lucide-react";
import NewMessageDialog from "./new-message-dialog";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../store/user";
import { format } from "date-fns";
import { ja } from "date-fns/locale";
import { MessageRoomsByUserData } from "../../../generated/graphql";
import { useRouter } from "next/navigation";

const GET_MESSAGE_ROOMS = gql`
  query GetMessageRooms($userId: String!) {
    getMessageRooms(userId: $userId) {
      messageRoomList {
        id
        category
        latestMessage
        latestMessageId
        latestSentAt
        isRead
        users {
          id
          name
          imageUrl
        }
      }
      countOfMessageRooms
    }
  }
`;

interface ResData {
  getMessageRooms: MessageRoomsByUserData;
}

const MessageSkeleton = () => (
  <div className="flex items-start gap-4 p-4 w-full">
    <Skeleton className="w-12 h-12 rounded-full" />
    <div className="flex-1">
      <Skeleton className="h-4 w-24 mb-2" />
      <Skeleton className="h-4 w-full" />
    </div>
  </div>
);

const MessageList = () => {
  const router = useRouter();
  const { user } = useUserStore();
  const { loading, error, data, refetch } = useQuery<ResData>(
    GET_MESSAGE_ROOMS,
    {
      variables: { userId: user?.id || "" },
      skip: !user?.id,
    },
  );

  const formatDateTime = (dateTimeStr: string | null | undefined) => {
    if (!dateTimeStr) return "";

    try {
      const date = new Date(dateTimeStr);
      const now = new Date();
      const isThisYear = date.getFullYear() === now.getFullYear();

      return format(date, isThisYear ? "M/d HH:mm" : "yyyy/M/d HH:mm", {
        locale: ja,
      });
    } catch (error) {
      console.error("Date formatting error:", error);
      return "";
    }
  };

  if (loading) return <MessageSkeleton />;
  if (error)
    return <div className="p-4 text-red-500">Error: {error.message}</div>;

  const messageRooms = data?.getMessageRooms.messageRoomList || [];
  const sortedRooms = [...messageRooms].sort((a, b) => {
    const bDate = b.latestSentAt ? new Date(b.latestSentAt).getTime() : 0;
    const aDate = a.latestSentAt ? new Date(a.latestSentAt).getTime() : 0;
    return bDate - aDate;
  });

  if (sortedRooms.length === 0) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-400 text-lg font-light">No messages yet</p>
      </div>
    );
  }

  return (
    <div className="divide-y divide-gray-800">
      {sortedRooms.map((room) => {
        const otherUser = room.users.find((u: any) => u.id !== user?.id);
        const isUnread = !room.isRead;

        return (
          <div
            key={room.id}
            className={`flex items-center gap-4 p-4 cursor-pointer hover:bg-[#E4DBC0] transition-colors group ${
              isUnread ? "" : ""
            }`}
            onClick={() => {
              router.push(`/message/${room.id}`);
            }}
          >
            <Avatar className="w-12 h-12 flex-shrink-0">
              <AvatarImage
                src={otherUser?.imageUrl || "/message.svg"}
                alt={otherUser?.name}
              />
            </Avatar>
            <span
              className="font-medium w-48 flex-shrink-0 group-hover:text-black"
            >
              {otherUser?.name || "Unknown User"}
            </span>
            <p
              className="text-sm text-white flex-1 truncate group-hover:text-black"
            >
              {room.latestMessage || "No messages"}
            </p>
            <span
              className="text-sm text-gray-400 flex-shrink-0 group-hover:text-black"
            >
              {formatDateTime(room.latestSentAt || "")}
            </span>
          </div>
        );
      })}
    </div>
  );
};

export default function MessagePage() {
  return (
    <div className="bg-black text-white flex-1">
      <div className="flex items-center justify-between pt-[115px] border-gray-800">
        <div className="flex items-center gap-2">
          <Image
            src="/message.svg"
            alt="logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              MESSAGE
            </h1>
            <p className="text-sm">メッセージ</p>
          </div>
        </div>
        <NewMessageDialog />
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />

      <Suspense
        fallback={
          <>
            <MessageSkeleton />
            <MessageSkeleton />
            <MessageSkeleton />
          </>
        }
      >
        <MessageList />
      </Suspense>
    </div>
  );
}
