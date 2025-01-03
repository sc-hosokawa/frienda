import Image from "next/image";
import { TrendingData } from "../../generated/graphql";
import { Skeleton } from "@ui/components/ui/skeleton";

interface TrendingProps {
  data: TrendingData;
  isLoading: boolean;
}

export function Trending({ data, isLoading }: TrendingProps) {
  return (
    <>
      <div className="flex justify-between items-center mb-4">
        <div className="flex flex-col space-y-0">
          <h2 className="text-2xl font-light">ランキング</h2>
        </div>

        {/* <Link href={`/dashboard/discography`}>
          <button className="text-white px-8 py-4 rounded-full text-sm border border-dashed border-white">
            全ての曲を見る
          </button>
        </Link> */}
      </div>
      {isLoading ? (
        <Skeleton className="h-[100px] w-full" />
      ) : (
        <div className="space-y-4">
          {[...(data?.trendingTracks ?? [])]
            .sort((a, b) => b.totalPlayCount - a.totalPlayCount)
            .map((song, index) => (
              <div key={index} className="flex items-center p-4 rounded-lg">
                <div className="flex items-center space-x-4">
                  <span className="text-2xl w-8">{index + 1}</span>
                  <Image
                    src={song.imageUrl || "/placeholder.svg"}
                    alt="Album cover"
                    width={64}
                    height={64}
                    className="rounded-lg"
                  />
                  <div className="flex flex-col space-y-1">
                    <h3 className="font-medium">{song.trackTitle}</h3>
                    <p className="text-gray-400 text-sm">{song.upcTitle}</p>
                    <div className="flex flex-col gap-2">
                      <div className="flex items-center gap-4">
                        <span className="text-sm text-gray-400">Total</span>
                        <span className="text-lg">
                          {song.totalPlayCount.toLocaleString()}
                        </span>
                      </div>
                      <div className="flex items-center gap-4">
                        <span className="text-sm text-gray-400">Weekly</span>
                        <span className="text-lg">
                          {song.weeklyPlayCount.toLocaleString()}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
        </div>
      )}
    </>
  );
}
