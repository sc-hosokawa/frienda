import { gql } from "graphql-request";

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
