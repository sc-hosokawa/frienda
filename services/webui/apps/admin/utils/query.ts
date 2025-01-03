import { gql } from "graphql-request";
export const endpoint = process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT!;

export const GET_HISTORICAL = gql`
  query GetHistorical($artistId: String!, $userId: String!, $period: Int!) {
    getPlayCountHistory(artistId: $artistId, userId: $userId, period: $period) {
      lineChartData {
        date
        spotify
        apple
        line
        youtube
        amazon
      }
    }
  }
`;

export const GET_ALL_ARTISTS = gql`
  query GetAllArtists {
    getAllArtists {
      artistList {
        id
        artistId
        name
        imageUrl
        fsp
      }
    }
  }
`;

export const GET_ARTIST_BY_ID = gql`
  query GetArtistById($artistId: String!) {
    getArtistById(artistId: $artistId) {
      id
      artistId
      name
      fsp
      imgUrl
    }
  }
`;
export const GET_GENDER_GEN_RATE = gql`
  query GetGenderGenRate($artistId: String!, $userId: String!) {
    getGenderGenRateByArtist(artistId: $artistId, userId: $userId) {
      genderRate {
        maleCount
        femaleCount
      }
      genRate {
        under14
        gen1519
        gen2024
        gen2529
        gen3034
        gen3539
        gen4044
        gen4549
        gen50Over
      }
    }
  }
`;

export const GET_TRENDING = gql`
  query GetTrending($artistId: String!, $userId: String!) {
    getTrending(artistId: $artistId, userId: $userId) {
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

export const GET_SYSTEM_OVERVIEW = gql`
  query GetSystemOverview {
    getSystemOverview {
      totalUsers
      totalArtists
      totalFsp
      totalRevenue
      totalPlayCount
    }
  }
`;

export const GET_FSP_HISTORY = gql`
  query GetFspHistoryForAdmin($count: Int!) {
    getFspHistoryForAdmin(count: $count) {
      date
      from
      to
      amount
      notes
    }
  }
`;

export const GET_TRACK_CREDITS_HISTORY = gql`
  query GetTrackCreditsHistoryForAdmin($count: Int!) {
    getTrackCreditsHistoryForAdmin(count: $count) {
      date
      title
      isrc
      user
      role
      name
      email
    }
  }
`;
