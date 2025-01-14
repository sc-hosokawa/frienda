"use client";

import Link from "next/link";
import Image from "next/image";
import { MoreHorizontal } from "lucide-react";
import { Button } from "@ui/components/ui/button";
import { HistoricalByUPC } from "./histrical-chart";
import { GenderGenViewByUPC } from "./gender-gen-data";
import { CreditDialog } from "../../../credit-dialog";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../../../store/user";
import { TrendingByUpcData } from "../../../../../generated/graphql";
import { DiscographyInfo } from "./DiscographyInfo";
import * as Popover from "@radix-ui/react-popover";

const GET_OVERVIEW_BY_UPC = gql`
  query GetOverviewByUpc($artistId: String!, $userId: String!, $upc: String!) {
    getOverviewByUpc(artistId: $artistId, userId: $userId, upc: $upc) {
      totalPlaybacks
      weeklyPlaybacks
    }
  }
`;

const GET_TRENDING_BY_UPC = gql`
  query GetTrendingByUpc($upc: String!, $userId: String!) {
    getTrendingByUpc(upc: $upc, userId: $userId) {
      artistName
      productImgUrl
      productTitle
      trendingTracks {
        isrc
        trackTitle
        upcTitle
        imageUrl
        totalPlayCount
        weeklyPlayCount
        totalPlayCountDetails {
          spotify
          apple
          line
          amazon
          youtube
        }
        weeklyPlayCountDetails {
          spotify
          apple
          line
          amazon
          youtube
        }
      }
    }
  }
`;

type Props = {
  params: {
    upc: string;
  };
};

export default function DiscographyAlbumPage({ params }: Props) {
  const { user } = useUserStore();
  const { data } = useQuery(GET_OVERVIEW_BY_UPC, {
    variables: { artistId: "", userId: user?.id, upc: params.upc },
  });
  const { data: trendingData } = useQuery(GET_TRENDING_BY_UPC, {
    variables: { upc: params.upc, userId: user?.id },
  });

  return (
    <>
      <div className="w-[60px]">
        <Link href="/dashboard/discography" className="ml-6">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6"
          />
        </Link>
      </div>
      <div className="max-w-7xl mx-auto bg-black text-white min-h-screen p-6">
        <hr className="my-8 border-[#303030]" />
        <div className="space-y-6 mb-16">
          <div className="flex gap-6">
            <div className="flex-shrink-0">
              <img
                src={trendingData?.getTrendingByUpc.productImgUrl || ""}
                alt="Album artwork showing an orange circular design"
                className="w-48 h-48 rounded-sm"
              />
            </div>
            <div className="flex-grow space-y-6">
              <div className="space-y-4 mb-16">
                <div className="flex items-center justify-between">
                  <h1 className="text-2xl font-semibold relative">
                    {trendingData?.getTrendingByUpc.productTitle}
                    <DiscographyInfo />
                  </h1>
                  {/* TODO: add info dialog 
                  <div className="flex gap-2">
                    <Button variant="ghost" size="icon">
                      <MoreHorizontal className="w-5 h-5" />
                    </Button>
                  </div>
                  */}
                </div>
                <p className="text-sm text-gray-400">
                  {trendingData?.getTrendingByUpc.artistName}
                </p>
                <div className="flex gap-8">
                  <div>
                    <div className="text-2xl">
                      {data?.getOverviewByUpc.totalPlaybacks.toLocaleString()}
                    </div>
                    <div className="text-xs text-gray-400">
                      Song Played (Total)
                    </div>
                  </div>
                  <div>
                    <div className="text-2xl">
                      {data?.getOverviewByUpc.weeklyPlaybacks.toLocaleString()}
                    </div>
                    <div className="text-xs text-gray-400">
                      Song Played (Week)
                    </div>
                  </div>
                </div>
              </div>

              <div className="space-y-2">
                {trendingData?.getTrendingByUpc.trendingTracks.map(
                  (track: any, i: number) => (
                    <div
                      key={i}
                      className="flex items-center justify-between py-2 hover:bg-gray-800 rounded-lg px-4 group w-full"
                    >
                      <div className="flex items-center gap-4">
                        <span className="text-gray-400 w-6">
                          {String(i + 1).padStart(2, "0")}
                        </span>
                        <Popover.Root>
                          <Popover.Trigger asChild>
                            <div className="cursor-pointer hover:opacity-80">
                              <div className="font-medium">
                                {track.trackTitle}
                              </div>
                              <div className="text-sm text-gray-400 flex gap-4">
                                <span>
                                  Total/ {track.totalPlayCount.toLocaleString()}
                                </span>
                                <span>
                                  Weekly/{" "}
                                  {track.weeklyPlayCount.toLocaleString()}
                                </span>
                              </div>
                            </div>
                          </Popover.Trigger>
                          <Popover.Portal>
                            <Popover.Content
                              className="bg-[#23231f] rounded-lg p-4 shadow-lg outline-none"
                              sideOffset={5}
                              side="right"
                            >
                              <div className="flex gap-12">
                                <div>
                                  <h4 className="text-sm text-white mb-2">
                                    Total Details
                                  </h4>
                                  <div className="space-y-1">
                                    <p>
                                      <span className="text-gray-400">
                                        Spotify:
                                      </span>{" "}
                                      {track.totalPlayCountDetails.spotify.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        Apple:
                                      </span>{" "}
                                      {track.totalPlayCountDetails.apple.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        Line:
                                      </span>{" "}
                                      {track.totalPlayCountDetails.line.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        Amazon:
                                      </span>{" "}
                                      {track.totalPlayCountDetails.amazon.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        YouTube:
                                      </span>{" "}
                                      {track.totalPlayCountDetails.youtube.toLocaleString()}
                                    </p>
                                  </div>
                                </div>
                                <div>
                                  <h4 className="text-sm text-white mb-2">
                                    Weekly Details
                                  </h4>
                                  <div className="space-y-1">
                                    <p>
                                      <span className="text-gray-400">
                                        Spotify:
                                      </span>{" "}
                                      {track.weeklyPlayCountDetails.spotify.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        Apple:
                                      </span>{" "}
                                      {track.weeklyPlayCountDetails.apple.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        Line:
                                      </span>{" "}
                                      {track.weeklyPlayCountDetails.line.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        Amazon:
                                      </span>{" "}
                                      {track.weeklyPlayCountDetails.amazon.toLocaleString()}
                                    </p>
                                    <p>
                                      <span className="text-gray-400">
                                        YouTube:
                                      </span>{" "}
                                      {track.weeklyPlayCountDetails.youtube.toLocaleString()}
                                    </p>
                                  </div>
                                </div>
                              </div>
                              <Popover.Arrow className="fill-[#23231f]" />
                            </Popover.Content>
                          </Popover.Portal>
                        </Popover.Root>
                      </div>
                      <div className="flex gap-2 group-hover:opacity-100 transition-opacity rounded-md p-1">
                        <CreditDialog
                          isrc={track.isrc}
                          trackName={track.trackTitle ?? ""}
                          artistId={""}
                        />
                      </div>
                    </div>
                  ),
                )}
              </div>
            </div>
          </div>
        </div>
        <HistoricalByUPC upc={params.upc} />
        <GenderGenViewByUPC upc={params.upc} />
      </div>
    </>
  );
}
