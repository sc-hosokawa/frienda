"use client";

import Image from "next/image";
import useUserStore from "~/store/user";
import { useQuery, gql } from "@apollo/client";
import { QuestData } from "~/generated/graphql";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselPrevious,
  CarouselNext,
} from "@ui/components/ui/carousel";
import { RequestForViewDialog } from "~/components/reqest-for-view";
import { Overview } from "~/components/dashboard/overview";
import { Trending } from "~/components/dashboard/trending";
import { useTranslation } from "~/i18n/client";
import { useState, useEffect } from "react";

const GET_QUESTS_BY_USER = gql`
  query GetQuestsByUser($userId: String!) {
    getQuestByUserId(userId: $userId) {
      id
      name
      description
      category
    }
  }
`;
interface QuestsResData {
  getQuestByUserId: QuestData[];
}

export default function Home() {
  const { user } = useUserStore();
  const { t } = useTranslation();
  const acceptedArtists = user?.belongsToArtists.filter(
    (artist) => artist.status === "Accept",
  );
  const pendingArtists = user?.belongsToArtists.filter(
    (artist) => artist.status === "Check",
  );

  // ローカルストレージから選択されたアーティストIDを取得するロジック
  const [selectedArtistId, setSelectedArtistId] = useState<string | null>(null);

  useEffect(() => {
    // コンポーネントマウント時にローカルストレージから選択済みアーティストIDを取得
    const storedArtistId = localStorage.getItem("selectedHomeArtistId");

    // ローカルストレージに保存されたIDがあり、そのIDを持つアーティストにアクセス権がある場合はそれを使用
    const artistExists = acceptedArtists?.some(
      (artist) => artist.artistId === storedArtistId,
    );

    if (storedArtistId && artistExists) {
      setSelectedArtistId(storedArtistId);
    } else if (acceptedArtists && acceptedArtists.length > 0) {
      // なければ最初のアーティストを選択
      setSelectedArtistId(acceptedArtists[0]?.artistId || null);
    }
  }, [acceptedArtists]);

  // アーティスト選択を処理する関数
  const handleArtistSelect = (artistId: string) => {
    setSelectedArtistId(artistId);
    localStorage.setItem("selectedHomeArtistId", artistId);
  };

  // 選択されたアーティストオブジェクトを取得
  const selectedArtist =
    acceptedArtists?.find((artist) => artist.artistId === selectedArtistId) ||
    null;

  console.log({
    belongsToArtists: user?.belongsToArtists,
    acceptedArtists,
    pendingArtists,
    selectedArtistId,
    selectedArtist,
  });

  const { data } = useQuery<QuestsResData>(GET_QUESTS_BY_USER, {
    variables: { userId: user?.id },
  });
  const Actions = () => {
    return (
      <section className="space-y-4">
        <div className="flex flex-col">
          <h2 className="text-6xl font-light">
            Actions ({data?.getQuestByUserId?.length})
          </h2>
          <p className="text-sm">アクション</p>
        </div>

        <div className="relative">
          {data?.getQuestByUserId?.length ? (
            <Carousel
              opts={{
                align: "start",
              }}
              className="w-full"
            >
              <CarouselContent className="-ml-2 md:-ml-4">
                {data?.getQuestByUserId?.map((quest) => (
                  <CarouselItem
                    key={quest.id}
                    className="pl-2 md:pl-4 md:basis-1/2 lg:basis-1/3"
                  >
                    <div className="h-full">
                      <div className="border border-[#707070] p-6 rounded-2xl bg-white/5 space-y-4 transition-colors h-full">
                        <div className="inline-block px-3 py-1 rounded-full text-xs border border-white">
                          {quest.category}
                        </div>
                        <h3 className="font-medium">{quest.name}</h3>
                        <p className="text-sm text-gray-400">
                          {quest.description}
                        </p>
                      </div>
                    </div>
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious />
              <CarouselNext />
            </Carousel>
          ) : (
            <div className="p-6 rounded-xl bg-white/5 text-center text-gray-400">
              {t("home.no-request-available")}
            </div>
          )}
        </div>
      </section>
    );
  };

  return (
    <div className="h-full bg-black text-white p-6 space-y-8 overflow-x-hidden">
      <div className="flex items-center gap-2 pt-[100px]">
        <Image
          src="/home.svg"
          alt="logo"
          className="mr-2"
          width={105}
          height={105}
        />
        <div className="flex flex-col space-y-0">
          <h1 className="text-[90px] font-light tracking-tight leading-none">
            HOME
          </h1>
          <p className="text-sm -mt-2">{t("common.Home")}</p>
        </div>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />
      <Actions />
      <hr className="mb-8 mt-48 border-[#303030]" />
      {acceptedArtists && acceptedArtists.length > 0 ? (
        <>
          <div className="flex flex-col gap-4">
            <div className="flex items-center gap-2">
              <div>
                <span className="text-xl mr-2">{selectedArtist?.name}</span>
                のサマリー
                <p className="text-sm text-gray-400">
                  {t("home.showing-selected-artist")}
                </p>
              </div>
            </div>

            {/* アーティスト選択UI - 改善版 */}
            <div className="flex space-x-4 overflow-x-auto pb-4 max-w-full">
              {acceptedArtists.map((artist) => (
                <button
                  key={artist.artistId}
                  onClick={() => handleArtistSelect(artist.artistId)}
                  className={`px-4 py-2 rounded-full text-sm transition-colors whitespace-nowrap flex-shrink-0 ${
                    selectedArtistId === artist.artistId
                      ? "bg-white/20 text-white"
                      : "bg-transparent text-gray-400 hover:bg-white/10"
                  }`}
                >
                  {artist.name}
                </button>
              ))}
            </div>

            <Overview selectedArtistId={selectedArtistId || ""} />
            <Trending
              selectedArtistId={selectedArtistId || ""}
              isHomePage={true}
            />
          </div>
        </>
      ) : (
        <div className="p-6 rounded-xl bg-white/5 text-center text-gray-400">
          <p className="text-sm">{t("home.plz-ask-permission-to-view")}</p>
          <p className="text-sm">{t("home.alert-for-user")}</p>
          <p className="text-sm mb-8">{t("home.alert-for-permissions")}</p>
          <RequestForViewDialog />
        </div>
      )}
    </div>
  );
}
