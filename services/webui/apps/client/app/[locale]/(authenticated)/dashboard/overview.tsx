import Image from "next/image";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../../store/user";

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
      <h2 className="text-6xl font-light">Overview</h2>
      <p className="text-sm mb-14">再生数概要</p>
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center">
            <Image
              src="/song_played_total.svg"
              alt="play"
              width={60}
              height={60}
              className="mr-2"
            />
            <span className="mr-4 text-4xl font-light">
              Song Played (Total) /
            </span>
          </div>
          <span className="text-7xl font-light">
            {data?.getOverview.totalPlaybacks.toLocaleString()}
          </span>
        </div>
        <hr
          className="mt-2 mb-8 border-0 border-t-[1px] h-0"
          style={{
            borderStyle: "dashed",
            borderWidth: "1px 0 0 0",
            borderSpacing: "4rem",
            borderColor: "#FFFFFF",
          }}
        />
        <div className="flex items-center justify-between">
          <div className="flex items-center">
            <Image
              src="/song_played_week.svg"
              alt="play"
              width={60}
              height={60}
              className="mr-2"
            />
            <span className="mr-4 text-4xl font-light">
              Song Played (Week) /
            </span>
          </div>
          <span className="text-7xl font-light">
            {data?.getOverview.weeklyPlaybacks.toLocaleString()}
          </span>
        </div>
        <hr
          className="mt-2 mb-8 border-0 border-t-[1px] h-0"
          style={{
            borderStyle: "dashed",
            borderWidth: "1px 0 0 0",
            borderSpacing: "4rem",
            borderColor: "#FFFFFF",
          }}
        />
      </div>
    </div>
  );
}
