import Image from "next/image";
import { Suspense } from "react";
import { use } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { Skeleton } from "@ui/components/ui/skeleton";
import { Info, MoreVertical } from "lucide-react";
import NewMessageDialog from "./new-message-dialog";

interface Message {
  id: number;
  avatar: string;
  username: string;
  message: string;
  timestamp: string;
  highlighted: boolean;
}

// Simulating data fetching
const fetchMessages = (): Promise<Message[]> => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve([
        {
          id: 1,
          avatar: "/placeholder.svg?height=40&width=40",
          username: "taro_yoshida",
          message:
            "The Bandのjohn_johnです！よろしくお願いします！レコーディングやイベントのお誘い、またはお仕事やサポートページストのお誘いまでお待ちしております！",
          timestamp: "2024/10/23 12:23",
          highlighted: false,
        },
        {
          id: 2,
          avatar: "/placeholder.svg?height=40&width=40",
          username: "sayaka_kyoda",
          message:
            "The Bandのjohn_johnです！よろしくお願いします！レコーディングやイベントのお誘い、またはお仕事やサポートページストのお誘いまでお待ちしております！",
          timestamp: "2024/10/23 12:23",
          highlighted: true,
        },
        {
          id: 3,
          avatar: "/placeholder.svg?height=40&width=40",
          username: "minoru_kou",
          message:
            "The Bandのjohn_johnです！よろしくお願いします！レコーディングやイベントのお誘い、またはお仕事やサポートページストのお誘いまでお待ちしております！",
          timestamp: "2024/10/23 12:23",
          highlighted: false,
        },
        {
          id: 4,
          avatar: "/placeholder.svg?height=40&width=40",
          username: "chris_hayashi",
          message:
            "The Bandのjohn_johnです！よろしくお願いします！レコーディングやイベントのお誘い、またはお仕事やサポートページストのお誘いまでお待ちしております！",
          timestamp: "2024/10/23 12:23",
          highlighted: false,
        },
        {
          id: 5,
          avatar: "/placeholder.svg?height=40&width=40",
          username: "brady_johnson",
          message:
            "The Bandのjohn_johnです！よろしくお願いします！レコーディングやイベントのお誘い、またはお仕事やサポートページストのお誘いまでお待ちしております！",
          timestamp: "2024/10/23 12:23",
          highlighted: false,
        },
      ]);
    }, 2000); // Simulate a 2-second delay
  });
};

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
  const messages = use(fetchMessages());

  const truncateText = (text: string, maxLength: number) => {
    return text.length > maxLength ? text.slice(0, maxLength) + "..." : text;
  };

  return (
    <div className="divide-y divide-gray-800">
      {messages.map((message) => (
        <div
          key={message.id}
          className={`flex items-start gap-4 p-4 ${
            message.highlighted ? "bg-[#DBD0BA] text-black" : ""
          }`}
        >
          <div className="relative">
            <Avatar className="w-12 h-12 border-2 border-red-500 rounded-full">
              <AvatarImage src={message.avatar} alt={message.username} />
            </Avatar>
            <div className="absolute bottom-0 right-0 w-3 h-3 bg-red-500 rounded-full border-2 border-black" />
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between gap-2">
              <span className="font-medium">{message.username}</span>
              <div className="flex items-center gap-2 text-sm text-gray-400">
                <span>{message.timestamp}</span>
                {/* TODO: メニューを追加 
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="rounded-full h-8 w-8"
                    >
                      <MoreVertical className="w-4 h-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent
                    align="end"
                    className="bg-zinc-900 text-white border-gray-800"
                  >
                    <DropdownMenuItem>削除する</DropdownMenuItem>
                    <DropdownMenuItem>ブロックする</DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
                */}
              </div>
            </div>
            <p className="text-sm text-gray-400">
              {truncateText(message.message, 50)}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
};

export default function MessagePage() {
  return (
    <div className="bg-black text-white flex-1">
      <div className="flex items-center justify-between p-4 border-b border-gray-800">
        <div className="flex items-center gap-2">
          <Image
            src="/message.svg"
            alt="logo"
            className="mr-2"
            width={40}
            height={40}
          />
          <div className="flex items-center gap-2">
            <span className="text-6xl tracking-wide mb-2">MESSAGE</span>
            <Button variant="ghost" size="icon" className="rounded-full">
              <Info className="w-4 h-4" />
            </Button>
          </div>
        </div>
        <NewMessageDialog />
      </div>

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
