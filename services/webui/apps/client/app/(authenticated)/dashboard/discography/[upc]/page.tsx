"use client";

import { MoreHorizontal } from "lucide-react";
import { Button } from "@ui/components/ui/button";
import { HistoricalByUPC } from "./histrical-chart";
import { GenderGenViewByUPC } from "./gender-gen-data";
import { CreditDialog } from "../../../credit-dialog";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../../../store/user";
import { TrendingByUpcData } from "../../../../../generated/graphql";

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
      }
    }
  }
`;

interface TrendingResData {
  getTrendingByUpc: TrendingByUpcData;
}

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
  const { data: trendingData } = useQuery<TrendingResData>(
    GET_TRENDING_BY_UPC,
    {
      variables: { upc: params.upc, userId: user?.id },
    },
  );
  console.log(trendingData?.getTrendingByUpc.trendingTracks[0]?.trackTitle);

  return (
    <div className="max-w-7xl mx-auto bg-black text-white min-h-screen p-6">
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
                <h1 className="text-2xl font-semibold">
                  {trendingData?.getTrendingByUpc.productTitle}
                </h1>
                <div className="flex gap-2">
                  <Button variant="ghost" size="icon">
                    <MoreHorizontal className="w-5 h-5" />
                  </Button>
                </div>
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
              {trendingData?.getTrendingByUpc.trendingTracks.map((track, i) => (
                <div
                  key={i}
                  className="flex items-center justify-between py-2 hover:bg-gray-800 rounded-lg px-4 group w-full"
                >
                  <div className="flex items-center gap-4">
                    <span className="text-gray-400 w-6">
                      {String(i + 1).padStart(2, "0")}
                    </span>
                    <div>
                      <div className="font-medium">{track.trackTitle}</div>
                      <div className="text-sm text-gray-400">{track.isrc}</div>
                    </div>
                  </div>
                  <div className="flex gap-2 group-hover:opacity-100 transition-opacity rounded-md p-1">
                    <CreditDialog
                      isrc={track.isrc}
                      trackName={track.trackTitle ?? ""}
                      artistId={""}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
      <HistoricalByUPC upc={params.upc} />
      <GenderGenViewByUPC upc={params.upc} />
    </div>
  );
}
