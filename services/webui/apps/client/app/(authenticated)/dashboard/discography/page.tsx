"use client";

import { MoreHorizontal, Plus } from "lucide-react";
import { useState } from "react";
import Image from "next/image";
import Link from "next/link";

import { Button } from "@ui/components/ui/button";
import { Card, CardContent, CardHeader } from "@ui/components/ui/card";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { ScrollArea } from "@ui/components/ui/scroll-area";
import { Separator } from "@ui/components/ui/separator";
import { useQuery, gql } from "@apollo/client";

import useUserStore from "../../../../store/user";


const discographyData = {
  artists: [
    {
      id: 1,
      name: "The Awesome Band",
      subName: "The Awesome Band",
      image: "/placeholder.svg?height=40&width=40",
    },
    {
      id: 2,
      name: "The Another Band",
      subName: "The Another Band",
      image: "/placeholder.svg?height=40&width=40",
    },
  ],
  albums: [
    {
      id: 1,
      title: "This is awesome album",
      artwork: "/placeholder.svg?height=200&width=200",
      tracks: Array(10).fill({
        title: "Song name goes here",
      }),
    },
    {
      id: 2,
      title: "This is awesome album",
      artwork: "/placeholder.svg?height=200&width=200",
      tracks: Array(12).fill({
        title: "Song name goes here",
      }),
    },
  ],
  singles: [
    {
      id: 1,
      title: "This is awesome album",
      artwork: "/placeholder.svg?height=200&width=200",
      tracks: [
        {
          title: "Song name goes here",
        },
      ],
    },
  ],
};

export default function DiscographyPage() {
  const { user } = useUserStore();
  const artists = user?.belongsToArtists;
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    artists?.[0]?.artistId || null,
  );

  if (!artists?.length) {
    return (
      <div className="min-h-screen bg-black text-gray-200 p-6 flex flex-col items-center justify-center">
        <h2 className="text-xl font-semibold mb-4">
          アーティスト情報の閲覧権限を申請しましょう
        </h2>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-black text-gray-200 p-6">
      <header className="flex items-center justify-between mb-8">
        <div className="flex items-center gap-2">
          <h1 className="text-2xl font-semibold">Discography</h1>
          <Button size="icon" variant="ghost" className="rounded-full">
            <Plus className="h-4 w-4" />
          </Button>
        </div>
      </header>

      <div className="flex gap-2 mb-8">
        {artists?.map((artist) => (
          <button
            key={artist.artistId}
            onClick={() => setSelectedArtist(artist.artistId)}
            className={`flex items-center gap-2 px-3 py-1.5 rounded-full transition-colors ${
              selectedArtist === artist.artistId
                ? "bg-zinc-700 ring-2 ring-zinc-500"
                : "bg-zinc-900 hover:bg-zinc-800"
            }`}
          >
            <Image
              src={artist.imageUrl || "/placeholder.svg?height=24&width=24"}
              alt={artist.name}
              width={24}
              height={24}
              className="rounded-full"
            />
            <div className="text-sm">{artist.name}</div>
          </button>
        ))}
      </div>

      {selectedArtist}

      <section className="mb-8">
        <h2 className="text-xl font-semibold mb-4">Albums (4)</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {discographyData.albums.map((album) => (
            <AlbumCard key={album.id} album={album} />
          ))}
        </div>
      </section>

      <section>
        <h2 className="text-xl font-semibold mb-4">Singles (7)</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {discographyData.singles.map((single) => (
            <AlbumCard key={single.id} album={single} />
          ))}
        </div>
      </section>
    </div>
  );
}

function AlbumCard({
  album,
}: {
  album: {
    id: number;
    artwork: string;
    title: string;
    tracks: { title: string }[];
  };
}) {
  return (
    <Link href={`/dashboard/discography/${album.id}`}>
      <Card className="bg-zinc-900 border-zinc-800 text-gray-200 hover:bg-zinc-800 transition-colors">
        <CardHeader className="flex-row items-start gap-4 space-y-0">
          <Image
            src={album.artwork}
            alt={album.title}
            width={100}
            height={100}
            className="rounded-md"
          />
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-2">
              <span className="text-xs px-2 py-0.5 rounded bg-zinc-800">
                Album
              </span>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button size="icon" variant="ghost" className="h-8 w-8">
                    <MoreHorizontal className="h-4 w-4" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="w-40">
                  <DropdownMenuItem>Share</DropdownMenuItem>
                  <DropdownMenuItem>Download</DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
            <h3 className="font-semibold">{album.title}</h3>
          </div>
        </CardHeader>
        <CardContent>
          <ScrollArea className="h-[300px] pr-4">
            {album.tracks.map((track, index) => (
              <div key={index}>
                <div className="flex items-center justify-between py-2">
                  <div className="flex items-center gap-3">
                    <span className="text-sm text-gray-400">
                      {(index + 1).toString().padStart(2, "0")}
                    </span>
                    <span className="text-sm">{track.title}</span>
                  </div>
                  <Button size="icon" variant="ghost" className="h-8 w-8">
                    <MoreHorizontal className="h-4 w-4" />
                  </Button>
                </div>
                {index < album.tracks.length - 1 && (
                  <Separator className="bg-zinc-700" />
                )}
              </div>
            ))}
          </ScrollArea>
        </CardContent>
      </Card>
    </Link>
  );
}
