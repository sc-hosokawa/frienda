"use client";

import { useState } from "react";
import Image from "next/image";
import { Overview } from "./overview";
import { Trending } from "./trending";
import { Historical } from "./histrical";
import { GenderGenView } from "./gender-gen-data";
import useUserStore from "../../../store/user";

export default function Dashboard() {
  const { user } = useUserStore();
  const artists = user?.belongsToArtists;
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    artists?.[0]?.artistId || null,
  );

  return (
    <div className="bg-black text-white min-h-screen p-8">
      <header className="flex items-center mb-8">
        <div className="flex items-center space-x-2">
          <Image
            src="/dashboard.svg"
            alt="Logo"
            className="mr-2"
            width={40}
            height={40}
          />

          <h1 className="text-6xl">DASHBOARD</h1>
        </div>
      </header>
      <div className="flex space-x-4 mb-8">
        {artists && artists.length > 0 ? (
          artists.map((artist) => {
            const isSelected = artist.artistId === selectedArtist;
            return (
              <button
                key={artist.artistId}
                onClick={() => setSelectedArtist(artist.artistId)}
                className={`flex items-center space-x-2 p-2 rounded-lg transition-colors ${
                  isSelected ? "bg-gray-800" : "hover:bg-gray-900"
                }`}
              >
                <Image
                  src={artist.imageUrl || "/placeholder.svg"}
                  alt={`${artist.name} Avatar`}
                  width={40}
                  height={40}
                  className="rounded-full"
                />
                <span
                  className={`text-sm ${isSelected ? "text-white" : "text-gray-400"}`}
                >
                  {artist.name}
                </span>
              </button>
            );
          })
        ) : (
          <div className="w-full flex justify-center items-center py-8">
            <p className="text-lg text-gray-400">
              アーティストへのアクセス権限を申請しましょう
            </p>
          </div>
        )}
      </div>
      <main className="space-y-16">
        <Overview selectedArtistId={selectedArtist} />
        <Trending selectedArtistId={selectedArtist} />
        <Historical selectedArtistId={selectedArtist} />
        <GenderGenView selectedArtistId={selectedArtist} />
      </main>
    </div>
  );
}
