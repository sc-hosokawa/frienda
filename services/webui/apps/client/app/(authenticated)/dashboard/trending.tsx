import Image from "next/image";
import Link from "next/link";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../store/user";
import { CreditDialog } from "../credit-dialog";
import * as Popover from "@radix-ui/react-popover";

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
        totalPlayCountDetails {
          spotify
          apple
          line
          amazon
          youtube
        }
        weeklyPlayCountDetails {
          spotify
          apple
          line
          amazon
          youtube
        }
      }
    }
  }
`;

export function Trending({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const { user } = useUserStore();
  const { data } = useQuery(GET_TRENDING, {
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
                <Popover.Root>
                  <Popover.Trigger asChild>
                    <div className="flex flex-col items-end cursor-pointer hover:opacity-80">
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
                  </Popover.Trigger>
                  <Popover.Portal>
                    <Popover.Content
                      className="bg-[#23231f] rounded-lg p-4 shadow-lg outline-none"
                      sideOffset={5}
                    >
                      <div className="flex gap-12">
                        <div>
                          <h4 className="text-sm text-white mb-2">
                            Total Details
                          </h4>
                          <div className="space-y-1">
                            <p>
                              <span className="text-gray-400">Spotify:</span>{" "}
                              {song.totalPlayCountDetails.spotify.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">Apple:</span>{" "}
                              {song.totalPlayCountDetails.apple.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">Line:</span>{" "}
                              {song.totalPlayCountDetails.line.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">Amazon:</span>{" "}
                              {song.totalPlayCountDetails.amazon.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">YouTube:</span>{" "}
                              {song.totalPlayCountDetails.youtube.toLocaleString()}
                            </p>
                          </div>
                        </div>
                        <div>
                          <h4 className="text-sm text-white mb-2">
                            Weekly Details
                          </h4>
                          <div className="space-y-1">
                            <p>
                              <span className="text-gray-400">Spotify:</span>{" "}
                              {song.weeklyPlayCountDetails.spotify.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">Apple:</span>{" "}
                              {song.weeklyPlayCountDetails.apple.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">Line:</span>{" "}
                              {song.weeklyPlayCountDetails.line.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">Amazon:</span>{" "}
                              {song.weeklyPlayCountDetails.amazon.toLocaleString()}
                            </p>
                            <p>
                              <span className="text-gray-400">YouTube:</span>{" "}
                              {song.weeklyPlayCountDetails.youtube.toLocaleString()}
                            </p>
                          </div>
                        </div>
                      </div>
                      <Popover.Arrow className="fill-[#23231f]" />
                    </Popover.Content>
                  </Popover.Portal>
                </Popover.Root>
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
