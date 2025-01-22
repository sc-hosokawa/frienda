"only server";
import { gql, useQuery } from "@apollo/client";

const GET_ALL_ARTISTS = gql`
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

const getAllArtists = () => {
  const { data, loading, error } = useQuery(GET_ALL_ARTISTS);
  return { data, loading, error };
};

export default getAllArtists;
