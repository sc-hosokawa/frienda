"use client";

import { useState } from "react";
import Image from "next/image";
import { Overview } from "./overview";
import { Trending } from "./trending";
import { Historical } from "./histrical";
import { GenderGenView } from "./gender-gen-data";
import useUserStore from "../../../../store/user";
import { RequestForViewDialog } from "../reqest-for-view";
import { DashboardInfo } from "./DashboardInfo";

export default function Dashboard() {
  const { user } = useUserStore();
  const artists = user?.belongsToArtists;
  const acceptedArtists = artists?.filter(
    (artist) => artist.status === "Accept"
  );
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    acceptedArtists?.[0]?.artistId || null
  );

  return (
    <div className="bg-black text-white min-h-screen">
      <div className="max-w-6xl mx-auto">
        <header className="flex items-center justify-between mb-8 w-full">
          <div className="flex items-center gap-2 pt-[120px]">
            <Image
              src="/dashboard.svg"
              alt="Logo"
              className="mr-2"
              width={105}
              height={105}
            />
            <div className="flex flex-col space-y-0">
              <h1 className="text-[90px] font-light tracking-tight leading-none relative">
                DASHBOARD
                <DashboardInfo />
              </h1>
              <p className="text-sm -mt-2">ダッシュボード</p>
            </div>
          </div>
          <div className="pt-[120px]">
            <RequestForViewDialog />
          </div>
        </header>
        <div className="flex space-x-4 mb-8 overflow-x-auto">
          {acceptedArtists && acceptedArtists.length > 0 ? (
            acceptedArtists.map((artist) => {
              const isSelected = artist.artistId === selectedArtist;
              return (
                <button
                  key={artist.artistId}
                  onClick={() => setSelectedArtist(artist.artistId)}
                  className={`flex items-center space-x-2 p-2 transition-colors shrink-0 ${
                    isSelected
                      ? "border-b border-white border-dashed"
                      : "hover:bg-gray-900"
                  }`}
                >
                  <span
                    className={`text-sm ${isSelected ? "text-white" : "text-white/90"}`}
                  >
                    {artist.name}
                  </span>
                </button>
              );
            })
          ) : (
            <div className="w-full flex flex-col justify-center items-center py-8 text-gray-400">
              <p>アーティスト閲覧権限を申請してください。</p>
              <p className="mb-8">
                すでに行った方はログアウトして再度ログインするか、しばらく時間をあけてからアクセスしてください。
              </p>
              <RequestForViewDialog />
            </div>
          )}
        </div>
        <main className="space-y-16">
          {selectedArtist && (
            <>
              <hr className="mt-2 mb-4 border-t border-gray-800" />
              <Overview selectedArtistId={selectedArtist} />
              <hr className="mt-2 mb-8 border-t border-gray-800" />
              <Trending selectedArtistId={selectedArtist} />
              <hr className="mt-2 mb-8 border-t border-gray-800" />
              <Historical selectedArtistId={selectedArtist} />
              <hr className="mt-2 mb-8 border-t border-gray-800" />
              <GenderGenView selectedArtistId={selectedArtist} />
            </>
          )}
        </main>
      </div>
    </div>
  );
}
