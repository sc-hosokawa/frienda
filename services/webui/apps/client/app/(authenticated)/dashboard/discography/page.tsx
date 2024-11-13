"use client";

import { Plus } from "lucide-react";
import { useState } from "react";
import Image from "next/image";
import Link from "next/link";

import { Button } from "@ui/components/ui/button";
import { Card, CardContent, CardHeader } from "@ui/components/ui/card";

import { ScrollArea } from "@ui/components/ui/scroll-area";
import { Separator } from "@ui/components/ui/separator";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../../store/user";
import { ProductsData, ProductWithTracks } from "../../../../generated/graphql";

interface ResData {
  getProducts: ProductsData;
}

export default function DiscographyPage() {
  const { user } = useUserStore();
  const artists = user?.belongsToArtists;
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    artists?.[0]?.artistId || null,
  );
  const { data } = useQuery<ResData>(GET_PRODUCTS, {
    variables: {
      artistId: selectedArtist || "",
    },
  });

  console.log(data);

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
            <div className="text-sm">{artist.name}</div>
          </button>
        ))}
      </div>

      <section className="mb-8">
        <h2 className="text-xl font-semibold mb-4">
          Albums ({data?.getProducts.album.length})
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {data?.getProducts.album.map((album) => (
            <AlbumCard key={album.product.upc} album={album} category="album" />
          ))}
        </div>
      </section>

      <section>
        <h2 className="text-xl font-semibold mb-4">
          Singles ({data?.getProducts.single.length})
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {data?.getProducts.single.map((single) => (
            <AlbumCard
              key={single.product.upc}
              album={single}
              category="single"
            />
          ))}
        </div>
      </section>
    </div>
  );
}

function AlbumCard({
  album,
  category,
}: {
  album: ProductWithTracks;
  category: "album" | "single" | "ep";
}) {
  return (
    <Link href={`/dashboard/discography/${album.product.upc}`}>
      <Card className="bg-zinc-900 border-zinc-800 text-gray-200 hover:bg-zinc-800 transition-colors">
        <CardHeader className="flex-row items-start gap-4 space-y-0">
          <Image
            src={
              album.product.imgUrl || "/placeholder.svg?height=100&width=100"
            }
            alt={album.product.title}
            width={100}
            height={100}
            className="rounded-md"
          />
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-2">
              <span className="text-xs px-2 py-0.5 rounded bg-zinc-800">
                {category}
              </span>
            </div>
            <h3 className="font-semibold">{album.product.title}</h3>
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

const GET_PRODUCTS = gql`
  query GetProducts($artistId: String!) {
    getProducts(artistId: $artistId) {
      album {
        product {
          artistId
          imgUrl
          title
          type
          upc
        }
        tracks {
          imgUrl
          isrc
          title
        }
      }
      ep {
        product {
          artistId
          imgUrl
          title
          type
          upc
        }
        tracks {
          imgUrl
          isrc
          title
        }
      }
      single {
        product {
          artistId
          imgUrl
          title
          type
          upc
        }
        tracks {
          imgUrl
          isrc
          title
        }
      }
    }
  }
`;
