"use client";

import { Button } from "@ui/components/ui/button";
import { Card } from "@ui/components/ui/card";
import { Download } from "lucide-react";
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
          <Image
            src={offer?.imageUrl || "/placeholder.svg"}
            alt={offer?.title || "offer image"}
            width={300}
            height={300}
            className="w-full h-auto object-cover rounded-md"
          />

          <div className="space-y-6 overflow-hidden">
            <div className="space-y-2 w-full">
              <p className="text-lg mb-2 text-white">{offer?.title}</p>
              <p className="text-gray-400 whitespace-pre-wrap break-words">
                {offer?.description}
              </p>
            </div>

            <div className="flex items-center gap-4">
              <span className="px-3 py-1 rounded bg-zinc-800 text-sm text-white">
                {offer?.category}
              </span>
            </div>

            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Image
                  src={offer?.owner?.imageUrl || "/placeholder.svg"}
                  alt="Profile"
                  width={32}
                  height={32}
                  className="rounded-full"
                />
                <span className="text-sm">{offer?.owner?.name}</span>
              </div>
            </div>

            <div className="flex gap-8 text-sm">
              <div>
                <div>開催日</div>
                <div>{offer?.place}</div>
              </div>
              <div>
                <div>場所</div>
                <div>{offer?.place}</div>
              </div>
              <div>
                <div>参加対象</div>
                <div>{offer?.targetRole}</div>
              </div>
              <div>
                <div>報酬ポイント</div>
                <div>{offer?.fee} FSP</div>
              </div>
            </div>

            <p className="text-gray-400 text-sm">{offer?.attention}</p>
          </div>
        </div>

        <div className="mt-12">
          <h2 className="text-xl font-bold mb-4">Attachments</h2>
          <div className="grid grid-cols-4 gap-4 mb-4">
            {offer?.attachedImgs?.map((img, i) => (
              <Image
                key={i}
                src={img}
                alt="Offer attachment"
                width={240}
                height={240}
                className="aspect-square bg-zinc-800 rounded-lg flex items-center justify-center"
              />
            ))}
          </div>

          {offer?.attachedFiles?.map((file, i) => (
            <Button
              key={i}
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
          ))}
        </div>

        <div className="mt-4 text-right text-gray-400 text-sm">
          Last Updated: {new Date(offer?.updatedAt || "").toLocaleDateString()}
        </div>
      </div>
    </div>
  );
}
