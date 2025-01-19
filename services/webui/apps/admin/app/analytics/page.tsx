"use client";

import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import React from "react";
import {
  endpoint,
  GET_ALL_ARTISTS,
  GET_GENDER_GEN_RATE,
  GET_HISTORICAL,
  GET_TRENDING,
} from "../../utils/query";
import { ChartCard } from "../../components/analytics/chart-card";
import { SearchArtist } from "../../components/analytics/search-artist";
import GenderGenView from "../../components/analytics/gender-gen-chart";
import { Trending } from "../../components/analytics/trending";

const admin = "admin_0000000000000000000185";

interface ArtistsData {
  getAllArtists: {
    artistList: ArtistData[];
  };
}

interface ArtistData {
  id: string;
  artistId: string;
  name: string;
  imageUrl?: string;
  fsp: number;
}

export default function AnalyticsPage() {
  const [selectedPeriod, setSelectedPeriod] = React.useState(12);
  const [open, setOpen] = React.useState(false);
  const [selectedArtistId, setSelectedArtistId] = React.useState(
    "artist_00_000000000000000185",
  );
  const {
    data: artistData,
    isLoading: isLoadingArtist,
    isError: isErrorLoadingArtist,
  } = useQuery<ArtistData[]>({
    queryKey: ["artists"],
    queryFn: async () => {
      const response = await request<ArtistsData>(endpoint, GET_ALL_ARTISTS);
      return response.getAllArtists.artistList;
    },
    staleTime: 0,
  });

  console.log(artistData);

  const { data: trendingData, isLoading: isLoadingTrendingData } = useQuery({
    queryKey: ["trendingData", selectedArtistId],
    queryFn: async () => {
      return await request(endpoint, GET_TRENDING, {
        artistId: selectedArtistId,
        userId: admin,
      }).then((data: any) => data.getTrending);
    },
    enabled: !!selectedArtistId,
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
    <div className="flex flex-col lg:flex-row mx-auto max-w-2xl lg:max-w-max gap-6 p-8">
      <div className="flex flex-col gap-6 lg:w-1/3 w-full">
        <SearchArtist
          value={selectedArtistId}
          setValue={setSelectedArtistId}
          artists={artistData || []}
          open={open}
          setOpen={setOpen}
          isLoading={isLoadingArtist}
          isError={isErrorLoadingArtist}
        />

        <Trending data={trendingData} isLoading={isLoadingTrendingData} />
      </div>
      <div className="flex flex-col gap-6 lg:w-2/3 w-full">
        <ChartCard
          data={chartData}
          selectedPeriod={selectedPeriod}
          setSelectedPeriod={setSelectedPeriod}
          isLoading={isLoadingChart}
          isError={isErrorLoadingChart}
        />

        <GenderGenView
          data={genderGenData}
          isLoading={isLoadingGenderGenData}
        />
      </div>
    </div>
  );
}
