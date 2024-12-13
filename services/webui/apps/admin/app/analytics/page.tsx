"use client";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";

import React from "react";
import {
  GET_ALL_ARTISTS,
  GET_ARTIST_BY_ID,
  GET_HISTORICAL,
} from "../../utils/query";
import { ChartCard } from "../../components/analytics/chart-card";
import { Input } from "@ui/components/ui/input";

const endpoint = process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT!;

export default function AnalyticsPage() {
  const [selectedPeriod, setSelectedPeriod] = React.useState(12);
  const [selectedArtistId, setSelectedArtistId] = React.useState<string | null>(
    "artist_00_000000000000000000"
  );

  const {
    data: artistData,
    isLoading: isLoadingArtist,
    isError: isErrorLoadingArtist,
  } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ARTIST_BY_ID, {
        artistId: selectedArtistId,
      }).then((data: any) => data.getArtistById);
    },
  });
  console.log(artistData);

  const {
    data: chartData,
    isLoading: isLoadingChart,
    isError: isErrorLoadingChart,
  } = useQuery({
    queryKey: ["analytics", selectedPeriod, selectedArtistId],
    queryFn: async () => {
      if (!selectedArtistId) return null;

      const response = await request(endpoint, GET_HISTORICAL, {
        artistId: selectedArtistId,
        userId: "admin_0000000000000000000000",
        period: selectedPeriod,
      });
      return response;
    },
    enabled: !!selectedArtistId,
  });
  return (
    <div className="flex flex-col mx-auto max-w-6xl gap-6">
      <div className="flex flex-row gap-4">
        <Input
          placeholder="Search"
          onChange={(e) => setSelectedArtistId(e.target.value)}
          value={selectedArtistId?.toString()}
        />
      </div>

      <ChartCard
        data={chartData}
        selectedPeriod={selectedPeriod}
        setSelectedPeriod={setSelectedPeriod}
        isLoading={isLoadingChart}
        isError={isErrorLoadingChart}
      />
    </div>
  );
}
