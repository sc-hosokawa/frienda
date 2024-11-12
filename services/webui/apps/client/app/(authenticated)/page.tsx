"use client";

import Image from "next/image";
import useUserStore from "../../store/user";
import { useQuery, gql } from "@apollo/client";
import { QuestData } from "../../generated/graphql";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@ui/components/ui/carousel";
import { RequestForViewDialog } from "./reqest-for-view";
import { Overview } from "./dashboard/overview";
import { Trending } from "./dashboard/trending";

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
  const acceptedArtists = user?.belongsToArtists.filter(
    (artist) => artist.status === "Accept",
  );
  const pendingArtists = user?.belongsToArtists.filter(
    (artist) => artist.status === "Check",
  );
  const timestamp = Date.now();
  const artistsLength = acceptedArtists?.length || 1;
  const randomIndex = timestamp % artistsLength;
  const randomArtist = acceptedArtists?.[randomIndex];

  console.log(user?.belongsToArtists);
  console.log(acceptedArtists);
  console.log(pendingArtists);

  return (
    <div className="h-full bg-black text-white p-6 space-y-8 overflow-x-hidden">
      <div className="flex items-center gap-2">
        <Image
          src="/home.svg"
          alt="logo"
          className="mr-2"
          width={40}
          height={40}
        />
        <h1 className="text-6xl font-light tracking-tight">HOME</h1>
      </div>
      <Actions />
      {randomArtist ? (
        randomArtist.status === "Accept" ? (
          <>
            <div className="flex items-center gap-2">
              <Image
                src={randomArtist.imageUrl || ""}
                alt={randomArtist.name}
                width={40}
                height={40}
              />
              <div>{randomArtist.name}</div>
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
                <div>に閲覧許可を申請中です</div>
              </>
            ) : (
              <div>閲覧許可申請中です</div>
            )}
          </div>
        )
      ) : (
        <div className="p-6 rounded-xl bg-white/5 text-center text-gray-400 space-y-4">
          <p>アーティスト閲覧権限を申請してください。</p>
          <p>
            すでに行った方はログアウトして再度ログインするか、しばらく時間をあけてからアクセスしてください。
          </p>
          <RequestForViewDialog />
        </div>
      )}
    </div>
  );
}

function Actions() {
  const { user } = useUserStore();

  const { data } = useQuery<QuestsResData>(GET_QUESTS_BY_USER, {
    variables: { userId: user?.id },
  });

  return (
    <section className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl">Quests ({data?.getQuestByUserId?.length})</h2>
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
                  <div className="p-6 rounded-xl bg-white/5 space-y-4 hover:bg-white/10 transition-colors">
                    <div className="inline-block px-3 py-1 rounded-full text-xs bg-white/10">
                      {quest.category}
                    </div>
                    <h3 className="font-medium">{quest.name}</h3>
                    <p className="text-sm text-gray-400">{quest.description}</p>
                    <button className="p-2 hover:bg-white/10 rounded-full">
                      <svg
                        className="w-5 h-5"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M17 8l4 4m0 0l-4 4m4-4H3"
                        />
                      </svg>
                    </button>
                  </div>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious />
            <CarouselNext />
          </Carousel>
        ) : (
          <div className="p-6 rounded-xl bg-white/5 text-center text-gray-400">
            利用可能なクエストはありません
          </div>
        )}
      </div>
    </section>
  );
}
