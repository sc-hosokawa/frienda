"use client";

import Link from "next/link";
import Image from "next/image";
import { HistoricalByIsrc } from "~/components/dashboard/histrical-chart-isrc";
import GenderGenView from "~/components/dashboard/gender-gen-data";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "~/store/user";
import { DiscographyInfo } from "./DiscographyInfo";

const GET_GENDER_GEN_RATE_BY_ISRC = gql`
  query GetGenderGenRateByIsrc(
    $artistId: String!
    $userId: String!
    $isrc: String!
  ) {
    getGenderGenRateByIsrc(artistId: $artistId, userId: $userId, isrc: $isrc) {
      genderRate {
        maleCount
        femaleCount
        neutralCount
        unknownCount
      }
      genRate {
        under17
        gen1822
        gen2327
        gen2834
        gen3544
        gen4559
        gen60150
      }
    }
  }
`;

const GET_TRACK_INFO = gql`
  query GetTrackInfo($isrc: String!) {
    getTrackInfo(isrc: $isrc) {
      track {
        isrc
        title
        imgUrl
      }
      product {
        upc
        title
        imgUrl
        type
        artistId
      }
    }
  }
`;

type Props = {
  params: {
    isrc: string;
  };
};

export default function IsrcPage({ params }: Props) {
  const { user } = useUserStore();
  const { data: genderGenRateData, loading: loadingGenderGenRate } = useQuery(
    GET_GENDER_GEN_RATE_BY_ISRC,
    {
      variables: { isrc: params.isrc, artistId: "", userId: "" },
    },
  );

  const { data: trackInfoData, loading: loadingTrackInfo } = useQuery(
    GET_TRACK_INFO,
    {
      variables: { isrc: params.isrc },
    },
  );

  return (
    <>
      <div className="w-[60px]">
        <Link href="/dashboard/discography" className="ml-6">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6"
          />
        </Link>
      </div>
      <div className="max-w-7xl mx-auto bg-black text-white min-h-screen px-6 pb-6">
        <hr className="my-8 border-[#303030]" />

        {/* Track Info表示部分を追加 */}
        {loadingTrackInfo ? (
          <div>Loading...</div>
        ) : (
          <div>
            <h2 className="text-6xl font-light mb-4">
              {trackInfoData?.getTrackInfo.track.title}
            </h2>
            <p className="text-gray-400 text-sm py-4">収録作品</p>
            <div className="overflow-x-auto">
              <div className="flex flex-nowrap gap-6 px-4 pb-4">
                {trackInfoData?.getTrackInfo.product?.map((product: any) => (
                  <Link
                    key={product.upc}
                    href={`/dashboard/discography/upc/${product.upc}`}
                    className="block hover:opacity-80 transition-opacity"
                  >
                    <div className="flex items-center space-x-4 p-4 bg-zinc-800 rounded-lg shrink-0 w-[300px] h-28">
                      <Image
                        src={product.imgUrl || "/default-album.png"}
                        alt={product.title}
                        width={80}
                        height={80}
                        className="rounded-md"
                      />
                      <div className="flex-1 min-w-0">
                        <h3 className="font-medium truncate">
                          {product.title}
                        </h3>
                        <p className="text-gray-400">{product.type}</p>
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </div>
        )}
        <hr className="my-8 border-[#303030]" />

        <HistoricalByIsrc isrc={params.isrc} />
        <GenderGenView
          data={genderGenRateData?.getGenderGenRateByIsrc!}
          isLoading={loadingGenderGenRate}
        />
      </div>
    </>
  );
}
