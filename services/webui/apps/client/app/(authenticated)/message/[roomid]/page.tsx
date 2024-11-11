"use client";

import { useState, useRef, useEffect } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Info, Image as ImageIcon, Send, Loader2 } from "lucide-react";
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

interface Message {
  id: string;
  content: string;
  sentAt: string;
  sentBy: string;
  // ... other fields
}

export default function Component() {
  const { user } = useUserStore();
  const params = useParams();
  const [message, setMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [pendingMessage, setPendingMessage] = useState<Message | null>(null);

  const { loading, error, data, refetch } = useQuery<ResData>(GET_MESSAGES, {
    variables: {
      userId: user?.id,
      messageRoomId: params.roomid,
    },
    pollInterval: 3000,
  });

  const messages = data?.getMessagesByMessageRoomId?.messageList ?? [];
  const recipient = data?.getMessagesByMessageRoomId?.to;
  console.log(messages);

  // メッセージエリアの最下部を参照するref
  const messageEndRef = useRef<HTMLDivElement>(null);
  // メッセージエリア全体を参照するref
  const messageAreaRef = useRef<HTMLDivElement>(null);
  // ユーザーが手動でスクロールしているかを追跡
  const [isUserScrolling, setIsUserScrolling] = useState(false);

  const textareaRef = useRef<HTMLTextAreaElement>(null);

  // テキストエリアの高さを自動調整
  const adjustTextareaHeight = () => {
    const textarea = textareaRef.current;
    if (textarea) {
      textarea.style.height = "auto";
      textarea.style.height = `${Math.min(textarea.scrollHeight, 200)}px`;
    }
  };

  // メッセージ内容が変更されたときの処理
  const handleMessageChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setMessage(e.target.value);
    adjustTextareaHeight();
  };

  // コンポーネントのマウント時に初期化
  useEffect(() => {
    adjustTextareaHeight();
  }, []);

  // スクロール位置を監視
  const handleScroll = () => {
    if (messageAreaRef.current) {
      const { scrollTop, scrollHeight, clientHeight } = messageAreaRef.current;
      // 下から100px以上スクロールされたら、ユーザーがスクロール中と判断
      const isScrolledUp = scrollHeight - (scrollTop + clientHeight) > 100;
      setIsUserScrolling(isScrolledUp);
    }
  };

  // 新しいメッセージが来たときのスクロール処理
  useEffect(() => {
    // ユーザーが手動でスクロールしていない場合のみ自動スクロール
    if (!isUserScrolling) {
      messageEndRef.current?.scrollIntoView({ behavior: "smooth" });
    }
  }, [messages]); // messagesが更新されたときに実行

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const sortedMessages = [...messages].sort(
    (a, b) => new Date(a.sentAt).getTime() - new Date(b.sentAt).getTime(),
  );

  const handleSubmit = async (e?: React.FormEvent) => {
    e?.preventDefault();

    if (!message.trim() || isSubmitting) return;

    // 送信中メッセージを作成
    const tempMessage: Message = {
      id: `temp-${Date.now()}`,
      content: message,
      sentAt: new Date().toISOString(),
      sentBy: user?.id || "",
      // ... other required fields
    };

    try {
      setIsSubmitting(true);
      setPendingMessage(tempMessage);

      // TODO: 実際のメッセージ送信処理
      // await sendMessage({ content: message });

      setMessage("");
    } catch (error) {
      console.error("Failed to send message:", error);
    } finally {
      setIsSubmitting(false);
      setPendingMessage(null);
    }
  };

  // キー入力のハンドリング
  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    // IMEの変換確定時は処理をスキップ
    if (e.nativeEvent.isComposing || e.keyCode === 229) {
      return;
    }

    if (e.key === "Enter") {
      if (e.shiftKey) {
        // Shift + Enter の場合は改行を許可
        return;
      } else {
        // Enter のみの場合は送信
        e.preventDefault();
        handleSubmit();
      }
    }
  };

  return (
    <div className="flex flex-col h-screen bg-black text-white">
      {/* Header - Update with recipient data */}
      <header className="flex-none items-center justify-between p-4 border-b border-gray-800 sticky top-0">
        <div className="flex items-center gap-2">
          <Avatar className="w-10 h-10">
            <AvatarImage
              src={recipient?.imageUrl || "/logo_visualonly.jpg"}
              alt={recipient?.name || "Unknown User"}
            />
          </Avatar>
          <div className="flex items-center gap-2">
            <span className="text-2xl tracking-wide">
              {recipient?.name || "Unknown User"}
            </span>
            <Button variant="ghost" size="icon" className="rounded-full">
              <Info className="w-4 h-4" />
            </Button>
          </div>
        </div>
      </header>

      {/* Message Area */}
      <div
        ref={messageAreaRef}
        onScroll={handleScroll}
        className="flex-1 overflow-y-auto p-4 space-y-6"
      >
        <div className="min-h-full flex flex-col justify-end">
          {messages.length === 0 ? (
            <div className="text-center space-y-2">
              <h1 className="text-2xl font-light">メッセージがありません</h1>
              <p className="text-gray-500">
                最初のメッセージを送信してみましょう
              </p>
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
                        message.sentBy === user?.id
                          ? user?.name
                          : recipient?.name
                      }
                    />
                  </Avatar>
                  <div
                    className={`space-y-1 ${
                      message.sentBy === user?.id ? "text-right" : ""
                    }`}
                  >
                    <p className="text-sm font-medium">
                      {message.sentBy === user?.id
                        ? user?.name
                        : recipient?.name}
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
          {/* 送信中のメッセージ */}
          {pendingMessage && (
            <div className="flex items-start gap-3 flex-row-reverse opacity-50">
              <Avatar className="w-10 h-10">
                <AvatarImage
                  src={user?.imageUrl || "/logo_visualonly.jpg"}
                  alt={user?.name}
                />
              </Avatar>
              <div className="space-y-1 text-right">
                <p className="text-sm font-medium flex items-center gap-2 justify-end">
                  {user?.name}
                  <Loader2 className="w-3 h-3 animate-spin" />
                </p>
                <p className="text-sm text-gray-400">
                  {pendingMessage.content}
                </p>
                <p className="text-xs text-gray-600">送信中...</p>
              </div>
            </div>
          )}
          <div ref={messageEndRef} />
        </div>
      </div>

      {/* Message Input */}
      <div className="flex-none p-4 border-t border-gray-800 sticky bottom-0">
        <form onSubmit={handleSubmit} className="flex items-center gap-2">
          <textarea
            ref={textareaRef}
            value={message}
            onChange={handleMessageChange}
            onKeyDown={handleKeyDown}
            disabled={isSubmitting}
            placeholder={
              isSubmitting ? "送信中..." : "ここにメッセージを入力してください"
            }
            rows={1}
            className={`
              flex-1 bg-gray-900 border-gray-800 text-white 
              placeholder:text-gray-500 resize-none min-h-[40px] 
              max-h-[200px] py-2 px-3 rounded-md
              ${isSubmitting ? "opacity-50" : ""}
            `}
            style={{
              overflow: "hidden",
              lineHeight: "1.5",
            }}
          />
          <Button
            type="submit"
            size="icon"
            className="shrink-0"
            disabled={isSubmitting || !message.trim()}
          >
            {isSubmitting ? (
              <Loader2 className="w-5 h-5 animate-spin" />
            ) : (
              <Send className="w-5 h-5" />
            )}
            <span className="sr-only">
              {isSubmitting ? "送信中..." : "メッセージを送信"}
            </span>
          </Button>
        </form>
      </div>
    </div>
  );
}
