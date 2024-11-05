"use client";

import { useState, useEffect } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { Share2, User } from "lucide-react";
import { Input } from "@ui/components/ui/input";
import { Avatar, AvatarImage, AvatarFallback } from "@ui/components/ui/avatar";

// 型定義
interface Artist {
  artistId: string;
  name: string;
  imageUrl?: string;
  fsp: number;
}

interface Member {
  id: string;
  name: string;
  imageUrl?: string;
  fsp: number;
}

// ダミーデータ
const dummyArtists: Artist[] = [
  { artistId: "1", name: "乃木坂46", imageUrl: "/nogizaka.jpg", fsp: 1000 },
  { artistId: "2", name: "櫻坂46", imageUrl: "/sakurazaka.jpg", fsp: 800 },
  { artistId: "3", name: "日向坂46", imageUrl: "/hinatazaka.jpg", fsp: 600 },
];

const dummyMembers: { [key: string]: Member[] } = {
  "1": [
    { id: "101", name: "齋藤飛鳥", imageUrl: "/asuka.jpg", fsp: 0 },
    { id: "102", name: "遠藤さくら", imageUrl: "/sakura.jpg", fsp: 0 },
    { id: "103", name: "山下美月", imageUrl: "/mizuki.jpg", fsp: 0 },
  ],
  "2": [
    { id: "201", name: "森田ひかる", imageUrl: "/hikaru.jpg", fsp: 0 },
    { id: "202", name: "菅井友香", imageUrl: "/yuka.jpg", fsp: 0 },
  ],
  "3": [
    { id: "301", name: "加藤史帆", imageUrl: "/shiho.jpg", fsp: 0 },
    { id: "302", name: "金村美玖", imageUrl: "/miku.jpg", fsp: 0 },
  ],
};

export function AllocationDialog() {
  const [selectedArtist, setSelectedArtist] = useState<Artist | null>(null);
  const [members, setMembers] = useState<Member[]>([]);
  const [allocatedPoints, setAllocatedPoints] = useState<{
    [key: string]: number;
  }>({});
  const [showConfirmation, setShowConfirmation] = useState(false);

  // アーティスト選択時にメンバーリストを更新
  useEffect(() => {
    if (selectedArtist) {
      setMembers(dummyMembers[selectedArtist.artistId] || []);
    }
  }, [selectedArtist]);

  const handlePointsChange = (memberId: string, points: number) => {
    const currentPoints = allocatedPoints[memberId] || 0;
    const totalAllocated =
      Object.values(allocatedPoints).reduce((a, b) => a + b, 0) -
      currentPoints +
      points;

    if (selectedArtist && totalAllocated <= selectedArtist.fsp) {
      setAllocatedPoints((prev) => ({
        ...prev,
        [memberId]: points,
      }));
    }
  };

  const handleConfirm = async () => {
    try {
      console.log("ポイント分配完了:", allocatedPoints);
      setShowConfirmation(false);
      setAllocatedPoints({});
      setSelectedArtist(null);
    } catch (error) {
      console.error("Failed to allocate points:", error);
    }
  };

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button className="w-full">
          <Share2 className="mr-2 h-4 w-4" />
          分配
        </Button>
      </DialogTrigger>
      <DialogContent className="w-4/5 h-4/5 max-w-none">
        <DialogHeader>
          <DialogTitle>
            {showConfirmation
              ? "確認"
              : selectedArtist
                ? `${selectedArtist.name}のメンバー`
                : "アーティスト選択"}
          </DialogTitle>
        </DialogHeader>

        <div className="flex-1 overflow-auto p-4">
          {!showConfirmation ? (
            !selectedArtist ? (
              // アーティスト選択画面
              <div className="space-y-2">
                {dummyArtists.map((artist) => (
                  <div
                    key={artist.artistId}
                    className="flex items-center justify-between p-2 hover:bg-gray-100 cursor-pointer"
                    onClick={() => setSelectedArtist(artist)}
                  >
                    <div className="flex items-center gap-3">
                      <Avatar>
                        <AvatarImage src={artist.imageUrl} />
                        <AvatarFallback>
                          <User />
                        </AvatarFallback>
                      </Avatar>
                      <span>{artist.name}</span>
                    </div>
                    <span>{artist.fsp} ポイント</span>
                  </div>
                ))}
              </div>
            ) : (
              // メンバー一覧と分配画面
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span>分配可能なFSP: {selectedArtist.fsp}</span>
                  <Button onClick={() => setShowConfirmation(true)}>
                    送付
                  </Button>
                </div>
                <div className="space-y-2">
                  {members.map((member) => (
                    <div
                      key={member.id}
                      className="flex items-center justify-between p-2"
                    >
                      <span>{member.name}</span>
                      <Input
                        type="number"
                        className="w-24"
                        value={allocatedPoints[member.id] || 0}
                        onChange={(e) =>
                          handlePointsChange(
                            member.id,
                            parseInt(e.target.value) || 0,
                          )
                        }
                      />
                    </div>
                  ))}
                </div>
                <div className="text-right">
                  残りポイント:{" "}
                  {selectedArtist.fsp -
                    Object.values(allocatedPoints).reduce((a, b) => a + b, 0)}
                </div>
              </div>
            )
          ) : (
            // 確認画面
            <div className="space-y-4">
              {members.map((member) => (
                <div key={member.id} className="flex justify-between p-2">
                  <span>{member.name}</span>
                  <span>{allocatedPoints[member.id] || 0} ポイント</span>
                </div>
              ))}
              <Button className="w-full" onClick={handleConfirm}>
                確定する
              </Button>
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
