import Image from "next/image";
import { Play } from "lucide-react";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../store/user";

const GET_OVERVIEW = gql`
  query GetOverview($artistId: String!, $userId: String!) {
    getOverview(artistId: $artistId, userId: $userId) {
      totalPlaybacks
      weeklyPlaybacks
    }
  }
`;

export function Overview({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const { user } = useUserStore();
  const { data } = useQuery(GET_OVERVIEW, {
    variables: { artistId: selectedArtistId, userId: user?.id },
  });

  return (
    <div className="mb-8">
      <h2 className="text-2xl font-light mb-4">Overview</h2>
      <div className="space-y-4">
        <div className="flex items-center">
          <Image
            src="/song_played_total.svg"
            alt="play"
            width={24}
            height={24}
            className="mr-2"
          />
          <span className="text-gray-400 mr-4">Song Played (Total) /</span>
          <span className="text-4xl font-light">
            {data?.getOverview.totalPlaybacks.toLocaleString()}
          </span>
        </div>
        <div className="flex items-center">
          <Image
            src="/song_played_week.svg"
            alt="play"
            width={24}
            height={24}
            className="mr-2"
          />
          <span className="text-gray-400 mr-4">Song Played (Week) /</span>
          <span className="text-4xl font-light">
            {data?.getOverview.weeklyPlaybacks.toLocaleString()}
          </span>
        </div>
      </div>
    </div>
  );
}
