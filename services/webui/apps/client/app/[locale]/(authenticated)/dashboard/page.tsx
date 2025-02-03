"use client";

import { useState } from "react";
import Image from "next/image";
import { Overview } from "~/components/dashboard/overview";
import { Trending } from "~/components/dashboard/trending";
import { Historical } from "~/components/dashboard/histrical";
import GenderGenView from "~/components/dashboard/gender-gen-data";
import useUserStore from "~/store/user";
import { RequestForViewDialog } from "~/components/reqest-for-view";
import { DashboardInfo } from "~/components/dashboard/DashboardInfo";
import { SearchArtist } from "~/components/dashboard/search-artist";
import getAllArtists from "~/store/artist";
import { gql, useQuery } from "@apollo/client";

const GET_GENDER_GEN_RATE = gql`
  query GetGenderGenRate($artistId: String!, $userId: String!) {
    getGenderGenRateByArtist(artistId: $artistId, userId: $userId) {
      genderRate {
        maleCount
        femaleCount
      }
      genRate {
        under17
        gen1822
        gen2327
        gen2834
        gen3544
        gen4559
        gen60150
      }
    }
  }
`;

export default function Dashboard() {
  const { user } = useUserStore();
  const isSuperAdmin = user?.isSuperAdmin;
  const artists = user?.belongsToArtists;
  const acceptedArtists = artists?.filter(
    (artist) => artist.status === "Accept",
  );
  const [selectedArtist, setSelectedArtist] = useState<string | null>(
    !isSuperAdmin
      ? acceptedArtists?.[0]?.artistId || null
      : "artist_00_000000000000000445",
  );
  const [open, setOpen] = useState(false);

  const { data, loading, error } = getAllArtists();

  const { data: genderGenRateData, loading: LoadingGenderGenRateData } =
    useQuery(GET_GENDER_GEN_RATE, {
      variables: {
        artistId: selectedArtist,
        userId: user?.id,
      },
    });

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
        {isSuperAdmin ? (
          <div className="flex space-x-4 mb-8">
            <SearchArtist
              value={selectedArtist}
              setValue={setSelectedArtist}
              artists={data?.getAllArtists.artistList}
              open={open}
              setOpen={setOpen}
              isLoading={loading}
              isError={error}
            />
          </div>
        ) : (
          <>
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
                    すでに行った方はログアウトして再度ログインするか、しばらく時間をあけてからログインしてください。
                  </p>
                  <RequestForViewDialog />
                </div>
              )}
            </div>
          </>
        )}
        <main className="space-y-16">
          {selectedArtist && (
            <>
              <hr className="mt-2 mb-4 border-t border-[#303030]" />
              <Overview selectedArtistId={selectedArtist} />
              <hr className="mt-2 mb-8 border-t border-[#303030]" />
              <Trending selectedArtistId={selectedArtist} />
              <hr className="mt-2 mb-8 border-t border-[#303030]" />
              <Historical selectedArtistId={selectedArtist} />
              <hr className="mt-2 mb-8 border-t border-[#303030]" />
              <GenderGenView
                data={genderGenRateData?.getGenderGenRateByArtist!}
                isLoading={LoadingGenderGenRateData}
              />
            </>
          )}
        </main>
      </div>
    </div>
  );
}
