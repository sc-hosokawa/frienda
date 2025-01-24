"use client";

import { Info } from "lucide-react";
import { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { Card, CardContent, CardHeader } from "@ui/components/ui/card";
import { ScrollArea } from "@ui/components/ui/scroll-area";
import { Separator } from "@ui/components/ui/separator";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "~/store/user";
import { ProductsData, ProductWithTracks } from "~/generated/graphql";
import getAllArtists from "~/store/artist";
import { SearchArtist } from "~/components/dashboard/search-artist";

interface ResData {
  getProducts: ProductsData;
}

export default function DiscographyPage() {
  const { user } = useUserStore();
  const isSuperAdmin = user?.isSuperAdmin;
  const artists = user?.belongsToArtists;
  const { data: allArtists, loading, error } = getAllArtists();
  const [open, setOpen] = useState(false);
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    !isSuperAdmin
      ? artists?.[0]?.artistId || null
      : "artist_00_000000000000000445"
  );
  const { data } = useQuery<ResData>(GET_PRODUCTS, {
    variables: {
      artistId: selectedArtist || "",
    },
  });

  if (!artists?.length && !isSuperAdmin) {
    return (
      <div className="min-h-screen bg-black text-gray-200 p-6 flex flex-col items-center justify-center">
        <h2 className="text-xl font-semibold mb-4">
          アーティスト情報の閲覧権限を申請しましょう
        </h2>
      </div>
    );
  }

  return (
    <>
      <div className="w-[60px]">
        <Link href="/dashboard" className="ml-6">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6"
          />
        </Link>
      </div>
      <div className="min-h-screen bg-black text-gray-200 px-6 pb-6">
        <hr className="my-8 border-[#303030]" />
        <header className="flex items-center justify-between mb-8">
          <h1 className="text-6xl font-light">Discography</h1>
        </header>
        <div className="flex flex-col gap-1 mb-8 text-sm text-gray-400">
          <div className="flex items-center gap-2">
            <Info className="w-4 h-4 mr-1 shrink-0" />
            作品が反映されるまで最大で3週間程度かかる場合があります。反映されていないと感じた場合やデータに不備がある場合は、左下のFeedbackからお知らせください。
          </div>
        </div>

        {isSuperAdmin ? (
          <div className="mb-4">
            <SearchArtist
              value={selectedArtist}
              setValue={setSelectedArtist}
              artists={allArtists?.getAllArtists.artistList}
              open={open}
              setOpen={setOpen}
              isLoading={loading}
              isError={error}
            />
          </div>
        ) : (
          <>
            <div className="flex gap-2 mb-8 overflow-x-auto">
              {artists?.map((artist) => (
                <button
                  key={artist.artistId}
                  onClick={() => setSelectedArtist(artist.artistId)}
                  className={`flex items-center gap-2 px-3 py-1.5 transition-colors shrink-0 ${
                    selectedArtist === artist.artistId
                      ? "border-b border-white border-dashed"
                      : "hover:bg-zinc-900"
                  }`}
                >
                  <div className="text-sm">{artist.name}</div>
                </button>
              ))}
            </div>
          </>
        )}

        <hr className="mb-8 mt-24 border-[#303030]" />

        <section className="mb-8">
          <h2 className="text-6xl font-light">
            Albums ({data?.getProducts.album.length})
          </h2>
          <p className="mb-8">アルバム</p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {data?.getProducts.album.map((album) => (
              <AlbumCard
                key={album.product.upc}
                album={album}
                category="album"
              />
            ))}
          </div>
        </section>

        <section className="mb-8 mt-24">
          <h2 className="text-6xl font-light">
            EPs ({data?.getProducts.ep.length})
          </h2>
          <p className="mb-8">eps</p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {data?.getProducts.ep.map((ep) => (
              <AlbumCard key={ep.product.upc} album={ep} category="ep" />
            ))}
          </div>
        </section>

        <section className="mb-8 mt-24">
          <h2 className="text-6xl font-light">
            Singles ({data?.getProducts.single.length})
          </h2>
          <p className="mb-8">シングル</p>
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
    </>
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
              <span className="text-xs px-4 py-2 rounded-full border border-white">
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
