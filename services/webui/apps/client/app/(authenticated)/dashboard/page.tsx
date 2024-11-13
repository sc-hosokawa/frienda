"use client";

import { useState } from "react";
import Image from "next/image";
import { Overview } from "./overview";
import { Trending } from "./trending";
import { Historical } from "./histrical";
import { GenderGenView } from "./gender-gen-data";
import useUserStore from "../../../store/user";
import { RequestForViewDialog } from "../reqest-for-view";

export default function Dashboard() {
  const { user } = useUserStore();
  const artists = user?.belongsToArtists;
  const acceptedArtists = artists?.filter(
    (artist) => artist.status === "Accept",
  );
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    acceptedArtists?.[0]?.artistId || null,
  );

  console.log(artists);
  console.log(acceptedArtists);

  return (
    <div className="bg-black text-white min-h-screen p-8">
      <div className="max-w-7xl mx-auto">
        <header className="flex items-center justify-between mb-8">
          <div className="flex items-center space-x-2">
            <Image
              src="/dashboard.svg"
              alt="Logo"
              className="mr-2"
              width={40}
              height={40}
            />

            <h1 className="text-6xl font-light">DASHBOARD</h1>
          </div>
          <RequestForViewDialog />
        </header>
        <div className="flex space-x-4 mb-8">
          {acceptedArtists && acceptedArtists.length > 0 ? (
            acceptedArtists.map((artist) => {
              const isSelected = artist.artistId === selectedArtist;
              return (
                <button
                  key={artist.artistId}
                  onClick={() => setSelectedArtist(artist.artistId)}
                  className={`flex items-center space-x-2 p-2 rounded-lg transition-colors ${
                    isSelected ? "bg-gray-800" : "hover:bg-gray-900"
                  }`}
                >
                  <span
                    className={`text-sm ${isSelected ? "text-white" : "text-gray-400"}`}
                  >
                    {artist.name}
                  </span>
                </button>
              );
            })
          ) : (
            <div className="w-full flex flex-col justify-center items-center py-8 space-y-4 text-gray-400">
              <p>アーティスト閲覧権限を申請してください。</p>
              <p>
                すでに行った方はログアウトして再度ログインするか、しばらく時間をあけてからアクセスしてください。
              </p>
              <RequestForViewDialog />
            </div>
          )}
        </div>
        <main className="space-y-16">
          {selectedArtist && (
            <>
              <Overview selectedArtistId={selectedArtist} />
              <Trending selectedArtistId={selectedArtist} />
              <Historical selectedArtistId={selectedArtist} />
              <GenderGenView selectedArtistId={selectedArtist} />
            </>
          )}
        </main>
      </div>
    </div>
  );
}
