"use client";

import { useState } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Info, Image as ImageIcon, Send } from "lucide-react";

export default function Component() {
  const [message, setMessage] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Handle message submission
    setMessage("");
  };

  return (
    <div className="flex flex-col h-screen bg-black text-white">
      {/* Header */}
      <header className="flex items-center justify-between p-4 border-b border-gray-800">
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 bg-purple-500 rounded-lg" />
          <div className="flex items-center gap-2">
            <span className="text-2xl font-bold tracking-wide">MESSAGE</span>
            <Button variant="ghost" size="icon" className="rounded-full">
              <Info className="w-4 h-4" />
            </Button>
          </div>
        </div>
      </header>

      {/* Message Area */}
      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        {/* Welcome Message */}
        <div className="space-y-1">
          <h1 className="text-2xl font-light">This is your first message to</h1>
          <h2 className="text-2xl font-light">hajime_takahashi.</h2>
          <p className="text-2xl font-light">Say Hello!</p>
        </div>

        {/* Message */}
        <div className="flex items-start gap-3">
          <Avatar className="w-10 h-10">
            <AvatarImage
              src="/placeholder.svg?height=40&width=40"
              alt="taro_yoshida"
            />
          </Avatar>
          <div className="space-y-1">
            <p className="text-sm font-medium">taro_yoshida</p>
            <p className="text-sm text-gray-400">
              hajime_takahashiさん、初めてメッセージにセットアップ。
              <br />
              生配信視聴からお待ちできました！
            </p>
          </div>
        </div>
      </div>

      {/* Message Input */}
      <div className="p-4 border-t border-gray-800">
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
