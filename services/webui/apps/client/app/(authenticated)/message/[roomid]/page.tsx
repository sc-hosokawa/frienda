"use client";

import { useState, useRef, useEffect } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import { Info, Image as ImageIcon, Send, Loader2, Plus, X } from "lucide-react";
import useUserStore from "../../../../store/user";
import { useQuery, useMutation, gql } from "@apollo/client";
import { MessagesByRoomIdByUserData } from "../../../../generated/graphql";
import { useParams } from "next/navigation";
import { storage } from "../../../../config";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";

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

const SEND_MESSAGE = gql`
  mutation SendMessage($input: SendMessageInput!) {
    sendMessage(input: $input) {
      id
      message
      sentAt
      attachedFile
      attachedImg
    }
  }
`;

interface ResData {
  getMessagesByMessageRoomId: MessagesByRoomIdByUserData;
}

interface Message {
  content: string;
  sentAt: string;
  sentBy: string;
}

export default function Component() {
  const { user } = useUserStore();
  const params = useParams();
  const [message, setMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [pendingMessage, setPendingMessage] = useState<Message | null>(null);
  const [attachedImage, setAttachedImage] = useState<string | null>(null);
  const [attachedFile, setAttachedFile] = useState<string | null>(null);
  const [isUserScrolling, setIsUserScrolling] = useState(false);

  const { loading, error, data, refetch } = useQuery<ResData>(GET_MESSAGES, {
    variables: {
      userId: user?.id,
      messageRoomId: params.roomid,
    },
    pollInterval: 3000,
  });

  const messages = data?.getMessagesByMessageRoomId?.messageList ?? [];
  const recipient = data?.getMessagesByMessageRoomId?.to;

  // メッセージエリアの最下部を参照するref
  const messageEndRef = useRef<HTMLDivElement>(null);
  // メッセージエリア全体を参照するref
  const messageAreaRef = useRef<HTMLDivElement>(null);

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

  const [sendMessage] = useMutation(SEND_MESSAGE, {
    onCompleted: () => {
      refetch(); // メッセージリストを更新
    },
  });

  // スクロール位置を監視
  const handleScroll = () => {
    if (messageAreaRef.current) {
      const { scrollTop, scrollHeight, clientHeight } = messageAreaRef.current;
      // 下から100px以上スクロールされたら、ユーザーがスクロール中と判断
      const isScrolledUp = scrollHeight - (scrollTop + clientHeight) > 100;
      setIsUserScrolling(isScrolledUp);
    }
  };

  // 画像の読み込みを待つ関数を追加
  const waitForImages = async () => {
    const images = messageAreaRef.current?.getElementsByTagName("img");
    if (!images?.length) return;

    const imageLoadPromises = Array.from(images).map((img) => {
      if (img.complete) return Promise.resolve();
      return new Promise((resolve) => {
        img.onload = resolve;
        img.onerror = resolve; // エラー時もスクロールするために解決する
      });
    });

    await Promise.all(imageLoadPromises);
  };

  // 初期表示時のスクロール処理を修正
  useEffect(() => {
    if (!loading && messages.length > 0 && messageAreaRef.current) {
      const scrollToBottom = async () => {
        await waitForImages();
        messageAreaRef.current?.scrollTo({
          top: messageAreaRef.current.scrollHeight,
          behavior: "auto",
        });
      };
      scrollToBottom();
    }
  }, [loading, messages.length]);

  // 新しいメッセージが来たときのスクロール処理も修正
  useEffect(() => {
    if (!isUserScrolling && messageAreaRef.current) {
      const scrollToBottom = async () => {
        await waitForImages();
        messageAreaRef.current?.scrollTo({
          top: messageAreaRef.current.scrollHeight,
          behavior: "smooth",
        });
      };
      scrollToBottom();
    }
  }, [messages, isUserScrolling]);

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
      content: message.trim(),
      sentAt: new Date().toISOString(),
      sentBy: user?.id || "",
    };

    try {
      setIsSubmitting(true);
      setPendingMessage(tempMessage);

      await sendMessage({
        variables: {
          input: {
            roomId: params.roomid as string,
            sentBy: user?.id,
            message: message.trim(),
            attachedFile: attachedFile ? [attachedFile] : [],
            attachedImg: attachedImage ? [attachedImage] : [],
          },
        },
      });

      setMessage("");
    } catch (error) {
      console.error("Failed to send message:", error);
    } finally {
      setIsSubmitting(false);
      setPendingMessage(null);
    }

    setAttachedImage(null);
    setAttachedFile(null);
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

  const handleFileUpload = async (file: File, type: "image" | "file") => {
    const path = type === "image" ? "msg/images" : "msg/files";
    const storageRef = ref(storage, `${path}/${Date.now()}_${file.name}`);

    if (file.size > 10 * 1024 * 1024) {
      throw new Error("ファイルサイズは10MB以下にしてください");
    }

    await uploadBytes(storageRef, file);
    return await getDownloadURL(storageRef);
  };

  const handleImageSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    if (!file.type.startsWith("image/")) {
      alert("画像ファイルを選択してください");
      return;
    }

    try {
      const imageUrl = await handleFileUpload(file, "image");
      setAttachedImage(imageUrl);
    } catch (error) {
      alert(
        error instanceof Error ? error.message : "アップロードに失敗しました",
      );
      console.error("Failed to upload image:", error);
    }
  };

  const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    try {
      const fileUrl = await handleFileUpload(file, "file");
      setAttachedFile(fileUrl);
    } catch (error) {
      console.error("Failed to upload file:", error);
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
                    className={`space-y-1 text-gray-400 ${
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
                      <p className="text-sm text-white">{message.content}</p>
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
      <div className="flex-none p-4 sticky bottom-0">
        {/* プレビューエリア */}
        {(attachedImage || attachedFile) && (
          <div className="mb-2 p-2 bg-gray-900 rounded-md">
            {attachedImage && (
              <div className="relative inline-block">
                <img
                  src={attachedImage}
                  alt="Preview"
                  className="max-h-32 rounded-md"
                />
                <Button
                  type="button"
                  variant="ghost"
                  size="icon"
                  className="absolute top-1 right-1 bg-black/50 hover:bg-black/70 rounded-full"
                  onClick={() => setAttachedImage(null)}
                >
                  <X className="w-4 h-4" />
                </Button>
              </div>
            )}
            {attachedFile && (
              <div className="flex items-center gap-2 p-2 bg-gray-800 rounded-md">
                <svg
                  className="w-4 h-4 shrink-0"
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
                <span className="text-sm truncate">添付ファイル</span>
                <Button
                  type="button"
                  variant="ghost"
                  size="icon"
                  className="ml-auto"
                  onClick={() => setAttachedFile(null)}
                >
                  <X className="w-4 h-4" />
                </Button>
              </div>
            )}
          </div>
        )}

        <form onSubmit={handleSubmit} className="flex items-center gap-2">
          {/* 非表示のファイル入力フィールド */}
          <input
            type="file"
            accept="image/*"
            onChange={handleImageSelect}
            className="hidden"
            id="image-upload"
            disabled={isSubmitting}
          />
          <input
            type="file"
            onChange={handleFileSelect}
            className="hidden"
            id="file-upload"
            disabled={isSubmitting}
          />

          {/* 添付ファイルドロップダウン */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                type="button"
                size="icon"
                variant="ghost"
                className="shrink-0"
                disabled={isSubmitting}
              >
                <Plus className="w-5 h-5" />
                <span className="sr-only">添付ファイルを追加</span>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="start">
              <DropdownMenuItem asChild>
                <label
                  htmlFor="image-upload"
                  className="flex items-center gap-2 cursor-pointer"
                >
                  <ImageIcon className="w-4 h-4" />
                  <span>画像を添付</span>
                </label>
              </DropdownMenuItem>
              <DropdownMenuItem asChild>
                <label
                  htmlFor="file-upload"
                  className="flex items-center gap-2 cursor-pointer"
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
                  <span>ファイルを添付</span>
                </label>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>

          {/* メッセージ入力欄 */}
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
              flex-1 text-white 
              placeholder:text-white placeholder:text-[10px] placeholder:py-1 resize-none min-h-[40px] 
              max-h-[200px] py-2 px-3 rounded-full border border-white
              ${isSubmitting ? "opacity-50" : ""}
            `}
            style={{
              overflow: "hidden",
              lineHeight: "1.5",
            }}
          />

          {/* 送信ボタン */}
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
