"use client";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import React from "react";
import {
  GET_ALL_ARTISTS,
  GET_GENDER_GEN_RATE,
  GET_HISTORICAL,
} from "../../utils/query";
import { ChartCard } from "../../components/analytics/chart-card";
import { SearchArtist } from "../../components/analytics/search-artist";
import GenderGenView from "../../components/analytics/gender-gen-chart";

const endpoint = process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT!;
const admin = "admin_0000000000000000000000";

export default function AnalyticsPage() {
  const [selectedPeriod, setSelectedPeriod] = React.useState(12);
  const [open, setOpen] = React.useState(false);
  const [selectedArtistId, setSelectedArtistId] = React.useState(
    "artist_00_000000000000000000"
  );
  const {
    data: artistData,
    isLoading: isLoadingArtist,
    isError: isErrorLoadingArtist,
  } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_ARTISTS).then(
        (data: any) => data.getAllArtists.artistList
      );
    },
  });

  const { data: genderGenData, isLoading: isLoadingGenderGenData } = useQuery({
    queryKey: ["genderGenData", selectedArtistId],
    queryFn: async () => {
      return await request(endpoint, GET_GENDER_GEN_RATE, {
        artistId: selectedArtistId,
        userId: admin,
      }).then((data: any) => data.getGenderGenRateByArtist);
    },
    enabled: !!selectedArtistId,
  });

  const {
    data: chartData,
    isLoading: isLoadingChart,
    isError: isErrorLoadingChart,
  } = useQuery({
    queryKey: ["analytics", selectedPeriod, selectedArtistId],
    queryFn: async () => {
      const response = await request(endpoint, GET_HISTORICAL, {
        artistId: selectedArtistId,
        userId: admin,
        period: selectedPeriod,
      });
      return response;
    },
    enabled: !!selectedArtistId,
  });

  return (
    <div className="flex flex-col mx-auto max-w-6xl gap-6">
      <SearchArtist
        value={selectedArtistId}
        setValue={setSelectedArtistId}
        artists={artistData}
        open={open}
        setOpen={setOpen}
        isLoading={isLoadingArtist}
        isError={isErrorLoadingArtist}
      />

      <ChartCard
        data={chartData}
        selectedPeriod={selectedPeriod}
        setSelectedPeriod={setSelectedPeriod}
        isLoading={isLoadingChart}
        isError={isErrorLoadingChart}
      />

      <GenderGenView data={genderGenData} isLoading={isLoadingGenderGenData} />
    </div>
  );
}
