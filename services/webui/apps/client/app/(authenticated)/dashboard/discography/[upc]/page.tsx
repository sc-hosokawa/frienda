"use client";

import { MoreHorizontal } from "lucide-react";
import { Button } from "@ui/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { HistoricalByUPC } from "./histrical-chart";
import { GenderGenViewByUPC } from "./gender-gen-data";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../../../store/user";

const GET_OVERVIEW_BY_UPC = gql`
  query GetOverviewByUpc($artistId: String!, $userId: String!, $upc: String!) {
    getOverviewByUpc(artistId: $artistId, userId: $userId, upc: $upc) {
      totalPlaybacks
      weeklyPlaybacks
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
    variables: { artistId: '', userId: user?.id, upc: params.upc },
  });

  console.log(data);

  return (
    <div className="bg-black text-white min-h-screen p-6">
      <div className="max-w-4xl mx-auto space-y-6 mb-16">
        {/* UPC display */}
        <div className="text-sm text-gray-400">UPC: {params.upc}</div>

        <div className="flex gap-6">
          <div className="flex-shrink-0">
            <img
              src="/placeholder.svg?height=200&width=200"
              alt="Album artwork showing an orange circular design"
              className="w-48 h-48 rounded-sm"
            />
          </div>
          <div className="flex-grow space-y-6">
            <div className="space-y-4 mb-16">
              <div className="flex items-center justify-between">
                <h1 className="text-2xl font-semibold">
                  This is awesome Album
                </h1>
                <div className="flex gap-2">
                  <Button variant="ghost" size="icon">
                    <MoreHorizontal className="w-5 h-5" />
                  </Button>
                </div>
              </div>
              <p className="text-sm text-gray-400">The Awesome Band</p>
              <div className="flex gap-8">
                <div>
                  <div className="text-2xl">{data?.getOverviewByUpc.totalPlaybacks.toLocaleString()}</div>
                  <div className="text-xs text-gray-400">
                    Song Played (Total)
                  </div>
                </div>
                <div>
                  <div className="text-2xl">{data?.getOverviewByUpc.weeklyPlaybacks.toLocaleString()}</div>
                  <div className="text-xs text-gray-400">
                    Song Played (Week)
                  </div>
                </div>
              </div>
            </div>

            {/* 曲リスト */}
            <div className="space-y-2">
              {Array.from({ length: 7 }).map((_, i) => (
                <div
                  key={i}
                  className="flex items-center justify-between py-2 hover:bg-gray-800 rounded-lg px-4 group w-full"
                >
                  <div className="flex items-center gap-4">
                    <span className="text-gray-400 w-6">
                      {String(i + 1).padStart(2, "0")}
                    </span>
                    <div>
                      <div className="font-medium">Song name goes here</div>
                      <div className="text-sm text-gray-400">
                        The Awesome Band
                      </div>
                    </div>
                  </div>
                  <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity text-white rounded-md p-1">
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon">
                          <MoreHorizontal className="w-4 h-4 text-white" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent>
                        <DropdownMenuItem>クレジットを編集</DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
      <HistoricalByUPC selectedArtistId={params.upc} />
      <GenderGenViewByUPC selectedArtistId={params.upc} />
    </div>
  );
}
