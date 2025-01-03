import Image from "next/image";
import Link from "next/link";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../store/user";
import { TrendingData } from "../../../generated/graphql";
import { CreditDialog } from "../credit-dialog";

const GET_TRENDING = gql`
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
interface ResData {
  getTrending: TrendingData;
}

export function Trending({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const { user } = useUserStore();
  const { data } = useQuery<ResData>(GET_TRENDING, {
    variables: { artistId: selectedArtistId, userId: user?.id },
  });

  return (
    <div className="mb-8">
      <div className="flex justify-between items-center mb-4">
        <div className="flex flex-col space-y-0">
          <h2 className="text-2xl font-light">( Trending )</h2>
        </div>

        <Link href={`/dashboard/discography`}>
          <button className="text-white px-8 py-4 rounded-full text-sm border border-dashed border-white">
            全ての曲を見る
          </button>
        </Link>
      </div>
      <div className="space-y-4">
        {[...(data?.getTrending.trendingTracks ?? [])]
          .sort((a, b) => b.totalPlayCount - a.totalPlayCount)
          .map((song, index) => (
            <div
              key={index}
              className={`flex items-center justify-between p-4 rounded-lg ${index % 2 === 1 ? "bg-[#23231f]" : ""}`}
            >
              <div className="flex items-center space-x-4">
                <span className="text-2xl w-8">{index + 1}</span>
                <Image
                  src={song.imageUrl || "/placeholder.svg"}
                  alt="Album cover"
                  width={64}
                  height={64}
                  className="rounded-lg"
                />
                <div>
                  <h3 className="font-medium">{song.trackTitle}</h3>
                  <p className="text-gray-400 text-sm">{song.upcTitle}</p>
                </div>
              </div>
              <div className="flex items-center space-x-64">
                <div className="flex flex-col items-end">
                  <p className="flex items-baseline gap-2">
                    <span className="text-sm text-gray-400">Total /</span>
                    <span className="text-2xl">
                      {song.totalPlayCount.toLocaleString()}
                    </span>
                  </p>
                  <p className="flex items-baseline gap-2">
                    <span className="text-sm text-gray-400">Weekly /</span>
                    <span className="text-2xl">
                      {song.weeklyPlayCount.toLocaleString()}
                    </span>
                  </p>
                </div>
                <CreditDialog
                  isrc={song.isrc}
                  trackName={song.trackTitle ?? ""}
                  artistId={selectedArtistId || ""}
                />
              </div>
            </div>
          ))}
      </div>
    </div>
  );
}
