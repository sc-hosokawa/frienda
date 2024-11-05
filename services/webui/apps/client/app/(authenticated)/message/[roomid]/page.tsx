"use client";

import { useState } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Info, Image as ImageIcon, Send } from "lucide-react";
import useUserStore from "../../../../store/user";
import { useQuery, useMutation, gql } from "@apollo/client";
import { MessagesByRoomIdByUserData } from "../../../../generated/graphql";
import { useParams } from "next/navigation";

const GET_MESSAGES = gql`
  query GetMessages($userId: String!, $messageRoomId: String!) {
    getMessagesByMessageRoomId(userId: $userId, messageRoomId: $messageRoomId) {
      messageList {
        id
        content
        sentAt
        sentBy
        attachedFile
        attachedImg
      }
      to {
        id
        name
        imageUrl
      }
    }
  }
`;

interface ResData {
  getMessagesByMessageRoomId: MessagesByRoomIdByUserData;
}

export default function Component() {
  const { user } = useUserStore();
  const params = useParams();
  const [message, setMessage] = useState("");

  const { loading, error, data, refetch } = useQuery<ResData>(GET_MESSAGES, {
    variables: {
      userId: user?.id,
      messageRoomId: params.roomid,
    },
    pollInterval: 3000, // 3秒ごとにポーリング
  });

  console.log(data);

  const messages = data?.getMessagesByMessageRoomId?.messageList ?? [];
  const recipient = data?.getMessagesByMessageRoomId?.to;

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  // メッセージを日付順に並び替え（古い順）
  const sortedMessages = [...messages].sort(
    (a, b) => new Date(a.sentAt).getTime() - new Date(b.sentAt).getTime(),
  );

  function handleSubmit(): void {
    throw new Error("Function not implemented.");
  }

  return (
    <div className="flex flex-col h-screen bg-black text-white">
      {/* Header - Update with recipient data */}
      <header className="flex-none items-center justify-between p-4 border-b border-gray-800">
        <div className="flex items-center gap-2">
          <Avatar className="w-10 h-10">
            <AvatarImage
              src={recipient?.imageUrl || "/logo_visualonly.jpg"}
              alt={recipient?.name || "Unknown User"}
            />
          </Avatar>
          <div className="flex items-center gap-2">
            <span className="text-2xl font-bold tracking-wide">
              {recipient?.name || "Unknown User"}
            </span>
            <Button variant="ghost" size="icon" className="rounded-full">
              <Info className="w-4 h-4" />
            </Button>
          </div>
        </div>
      </header>

      {/* Message Area */}
      <div className="flex-1 overflow-y-auto p-4 space-y-6 flex flex-col justify-end">
        {messages.length === 0 ? (
          <div className="space-y-1">
            <h1 className="text-2xl font-light">メッセージがありません</h1>
          </div>
        ) : (
          <div className="space-y-6">
            {sortedMessages.map((message) => (
              <div
                key={message.id}
                className={`flex items-start gap-3 ${
                  message.sentBy === user?.id ? "flex-row-reverse" : ""
                }`}
              >
                <Avatar className="w-10 h-10">
                  <AvatarImage
                    src={
                      message.sentBy === user?.id
                        ? user?.imageUrl || "/logo_visualonly.jpg"
                        : recipient?.imageUrl || "/logo_visualonly.jpg"
                    }
                    alt={
                      message.sentBy === user?.id ? user?.name : recipient?.name
                    }
                  />
                </Avatar>
                <div
                  className={`space-y-1 ${
                    message.sentBy === user?.id ? "text-right" : ""
                  }`}
                >
                  <p className="text-sm font-medium">
                    {message.sentBy === user?.id ? user?.name : recipient?.name}
                  </p>

                  {/* メッセージコンテンツの条件分岐 */}
                  {message.content && (
                    <p className="text-sm text-gray-400">{message.content}</p>
                  )}

                  {/* 添付画像の表示 */}
                  {message.attachedImg && (
                    <div className="max-w-[300px]">
                      <img
                        src={message.attachedImg}
                        alt="Attached image"
                        className="rounded-lg"
                      />
                    </div>
                  )}

                  {/* 添付ファイルの表示 */}
                  {message.attachedFile && (
                    <a
                      href={message.attachedFile}
                      download
                      className="flex items-center gap-2 text-blue-400 hover:text-blue-300"
                    >
                      <svg
                        className="w-4 h-4"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                        />
                      </svg>
                      <span>添付ファイルをダウンロード</span>
                    </a>
                  )}

                  <p className="text-xs text-gray-600">
                    {new Date(message.sentAt).toLocaleString()}
                  </p>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Message Input */}
      <div className="flex-none p-4 border-t border-gray-800">
        <form onSubmit={handleSubmit} className="flex items-center gap-2">
          <Input
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            placeholder="ここにメッセージを入力してください"
            className="flex-1 bg-gray-900 border-gray-800 text-white placeholder:text-gray-500"
          />
          <Button
            type="button"
            variant="ghost"
            size="icon"
            className="shrink-0"
          >
            <ImageIcon className="w-5 h-5" />
            <span className="sr-only">Upload image</span>
          </Button>
          <Button type="submit" size="icon" className="shrink-0">
            <Send className="w-5 h-5" />
            <span className="sr-only">Send message</span>
          </Button>
        </form>
      </div>
    </div>
  );
}
