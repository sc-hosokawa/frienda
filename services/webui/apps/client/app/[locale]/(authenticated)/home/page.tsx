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
  const timestamp = Date.now();
  const artistsLength = acceptedArtists?.length || 0;
  const randomIndex = artistsLength ? timestamp % artistsLength : 0;
  const randomArtist = artistsLength ? acceptedArtists?.[randomIndex] : null;

  console.log({
    belongsToArtists: user?.belongsToArtists,
    acceptedArtists,
    pendingArtists,
    artistsLength,
    randomIndex,
    randomArtist,
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
      {randomArtist ? (
        randomArtist.status === "Accept" ? (
          <>
            <div className="flex items-center gap-2">
              <div>
                <span className="text-xl mr-2">{randomArtist.name}</span>
                のサマリー
                <p className="text-sm text-gray-400">
                  {t("home.showing-random-artist")}
                </p>
              </div>
            </div>
            <Overview selectedArtistId={randomArtist.artistId} />
            <Trending selectedArtistId={randomArtist.artistId} />
          </>
        ) : (
          <div className="p-6 rounded-xl bg-white/5 text-center text-gray-400 space-y-4">
            {pendingArtists?.length ? (
              <>
                <div>
                  {pendingArtists?.map((artist) => artist.name).join(", ")}
                </div>
                <div>{t("home.asking-permission-to-view-1")}</div>
              </>
            ) : (
              <div>{t("home.asking-permission-to-view")}</div>
            )}
          </div>
        )
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
