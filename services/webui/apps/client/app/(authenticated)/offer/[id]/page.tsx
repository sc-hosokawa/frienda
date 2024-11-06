"use client";

import { Button } from "@ui/components/ui/button";
import { Card } from "@ui/components/ui/card";
import {
  Download,
  Heart,
  MapPin,
  Pause,
  Play,
  Share2,
  Star,
} from "lucide-react";
import Image from "next/image";
import { useQuery, useMutation, gql } from "@apollo/client";
import { useState } from "react";
import useUserStore from "../../../../store/user";
import { OfferDetailData } from "../../../../generated/graphql";

const GET_OFFER_QUERY = gql`
  query GetOfferDetail($offerId: Int!, $userId: String!) {
    getOffersById(offerId: $offerId, userId: $userId) {
      id
      title
      status
      description
      imageUrl
      fee
      category
      place
      attention
      requiredSkill
      targetRole
      publicity
      attachedImgs
      attachedFiles
      createdAt
      updatedAt
      owner {
        id
        name
        imageUrl
      }
    }
  }
`;

interface ResData {
  getOffersById: OfferDetailData;
}

const UPDATE_OFFER_STATUS = gql`
  mutation UpdateOfferStatus($id: Int!, $userId: String!, $status: String!) {
    updateOfferStatus(input: { id: $id, userId: $userId, status: $status }) {
      id
      offerId
    }
  }
`;

export default function OfferDetailPage({
  params,
}: {
  params: { id: string };
}) {
  const [isApplied, setIsApplied] = useState(false);
  const { user } = useUserStore();
  const { data, loading, error } = useQuery<ResData>(GET_OFFER_QUERY, {
    variables: {
      offerId: parseInt(params.id),
      userId: user?.id,
    },
    skip: !user?.id,
  });

  console.log(data?.getOffersById);

  const [updateStatus] = useMutation(UPDATE_OFFER_STATUS);

  const isOwner = user?.id === data?.getOffersById?.owner?.id;

  if (loading)
    return (
      <div className="min-h-screen bg-black flex items-center justify-center">
        <div className="animate-spin">Loading...</div>
      </div>
    );

  if (error)
    return (
      <div className="min-h-screen bg-black text-white flex items-center justify-center">
        Error: {error.message}
      </div>
    );

  const offer = data?.getOffersById;

  const handleApply = async () => {
    const result = await updateStatus({
      variables: {
        id: parseInt(params.id),
        userId: user?.id,
        status: "Applied",
      },
    });

    if (result.data) {
      setIsApplied(true);
    }
  };

  const showConfirmationDialog = () => {
    // TODO: Add dialog component
    if (window.confirm("本当に申し込みますか？")) {
      handleApply();
    }
  };

  return (
    <div className="min-h-screen bg-black text-white">
      <div className="max-w-4xl mx-auto p-6">
        <div className="flex items-center justify-between mb-8">
          <h1 className="text-6xl my-6">Offer Details</h1>
          {/* ここのハンドリングを丁寧に実装 */}
          {isOwner ? (
            <Button className="">編集する</Button>
          ) : (
            <Button
              className="bg-teal-500 hover:bg-teal-600 text-white"
              onClick={showConfirmationDialog}
              disabled={isApplied}
            >
              {isApplied ? "応募済み" : "このオファーに応募する"}
            </Button>
          )}
        </div>

        <div className="grid md:grid-cols-[300px,1fr] gap-8">
          <Card className="bg-zinc-900 border-none overflow-hidden">
            <Image
              src={offer?.imageUrl || "/placeholder.svg"}
              alt={offer?.title || "offer image"}
              width={300}
              height={300}
              className="w-full h-auto"
            />
          </Card>

          <div className="space-y-6">
            <div>
              <p className="text-lg mb-2 text-white">{offer?.title}</p>
              <p className="text-gray-400">{offer?.description}</p>
            </div>

            <div className="flex items-center gap-4">
              <span className="px-3 py-1 rounded bg-zinc-800 text-sm text-white">
                カテゴリー
              </span>
              <span className="px-3 py-1 rounded bg-zinc-800 text-sm text-white">
                サブカテゴリー
              </span>
            </div>

            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Image
                  src="/placeholder.svg"
                  alt="Profile"
                  width={32}
                  height={32}
                  className="rounded-full"
                />
                <span className="text-sm">teddy_nakayama</span>
              </div>
              <div className="flex items-center gap-1">
                <Star className="w-4 h-4" />
                <span className="text-sm">4.5</span>
              </div>
            </div>

            <div className="flex gap-8 text-sm">
              <div className="flex items-center gap-2">
                <MapPin className="w-4 h-4" />
                <span className="text-white">75% Match</span>
              </div>
              <div>
                <div>開催日</div>
                <div>2024/10/31</div>
              </div>
              <div>
                <div>参加人数</div>
                <div>2 Artists</div>
              </div>
              <div>
                <div>報酬ポイント</div>
                <div>100 P</div>
              </div>
            </div>

            <p className="text-gray-400 text-sm">
              ここにオファーの概要が入ります。ここにオファーの概要が入ります。ここにオファーの概要が入ります。
              ここにオファーの概要が入ります。ここにオファーの概要が入ります。ここにオファーの��要が入ります。
            </p>
          </div>
        </div>

        <div className="mt-12">
          <h2 className="text-xl font-bold mb-4">Attachments</h2>
          <div className="grid grid-cols-4 gap-4 mb-4">
            {[1, 2, 3, 4].map((i) => (
              <div
                key={i}
                className="aspect-square bg-zinc-800 rounded-lg flex items-center justify-center"
              >
                Image
              </div>
            ))}
          </div>

          <Button
            variant="outline"
            className="w-full justify-between text-left mb-6"
          >
            <div className="flex items-center gap-2">
              <span className="bg-zinc-800 px-2 py-1 rounded text-sm text-white">
                PDF
              </span>
              ファイルの入り方です。ファイルの入ります。
              <span className="text-sm text-gray-400">1.2MB</span>
            </div>
            <Download className="w-4 h-4" />
          </Button>

          <div className="space-y-3">
            <div className="bg-zinc-900 rounded-full p-3 flex items-center justify-between">
              <div className="flex items-center gap-3">
                <Play className="w-5 h-5" />
                <div>
                  <div className="text-sm">Song name goes here</div>
                  <div className="text-xs text-gray-400">The Awesome Band</div>
                </div>
              </div>
              <span className="text-sm">3:23</span>
            </div>

            <div className="bg-zinc-900 rounded-full p-3 flex items-center justify-between">
              <div className="flex items-center gap-3">
                <Pause className="w-5 h-5" />
                <div>
                  <div className="text-sm">Song name goes here</div>
                  <div className="text-xs text-gray-400">The Awesome Band</div>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm">1:26</span>
                <span className="text-sm text-gray-400">/</span>
                <span className="text-sm text-gray-400">3:23</span>
              </div>
            </div>
          </div>
        </div>

        <div className="mt-12">
          <h2 className="text-xl font-bold mb-4">Similar Offers</h2>
          <div className="grid md:grid-cols-2 gap-4">
            {[1, 2].map((i) => (
              <Card key={i} className="bg-zinc-900 border-none p-4 text-white">
                <div className="flex gap-4">
                  <Image
                    src="/placeholder.svg"
                    alt="Offer thumbnail"
                    width={100}
                    height={100}
                    className="rounded-lg"
                  />
                  <div className="flex-1">
                    <div className="flex justify-between mb-2">
                      <span className="px-2 py-1 rounded bg-zinc-800 text-xs text-white">
                        カテゴリー
                      </span>
                      <div className="flex gap-2">
                        <Share2 className="w-4 h-4" />
                        <Heart className="w-4 h-4" />
                      </div>
                    </div>
                    <p className="text-sm mb-2 text-white">
                      イベントに参加してくれるアーティスト募集中！
                    </p>
                    <p className="text-xs text-gray-400">
                      2行目の場合こう見えます。おもしろそう。
                    </p>
                  </div>
                </div>
              </Card>
            ))}
          </div>
        </div>

        <div className="mt-4 text-right text-gray-400 text-sm">
          Last Updated: {new Date(offer?.updatedAt || "").toLocaleDateString()}
        </div>
      </div>
    </div>
  );
}
