"use client";

import { Button } from "@ui/components/ui/button";
import { Download, ArrowLeft } from "lucide-react";
import Image from "next/image";
import { useQuery, useMutation, gql } from "@apollo/client";
import { useState } from "react";
import useUserStore from "../../../../store/user";
import { OfferDetailData } from "../../../../generated/graphql";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";

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

const DELETE_OFFER_MUTATION = gql`
  mutation DeleteOffer($input: DeleteOfferInput!) {
    deleteOffer(input: $input) {
      id
    }
  }
`;

const getCategoryBackgroundColor = (category: string | undefined | null) => {
  switch (category) {
    case "Creation":
      return "bg-orange-500";
    case "Event":
      return "bg-green-500";
    case "Promotion":
      return "bg-yellow-500";
    case "Other":
      return "bg-gray-400";
    default:
      return "bg-zinc-800";
  }
};

export default function OfferDetailPage({
  params,
}: {
  params: { id: string };
}) {
  const [isApplied, setIsApplied] = useState(false);
  const { user } = useUserStore();
  const { data, loading, error, refetch } = useQuery<ResData>(GET_OFFER_QUERY, {
    variables: {
      offerId: parseInt(params.id),
      userId: user?.id,
    },
    skip: !user?.id,
  });

  const [updateStatus] = useMutation(UPDATE_OFFER_STATUS);

  const isOwner = user?.id === data?.getOffersById?.owner?.id;

  const router = useRouter();

  const [showCancelModal, setShowCancelModal] = useState(false);

  const [updateOfferStatus, { loading: isUpdating }] = useMutation(
    UPDATE_OFFER_STATUS,
    {
      onCompleted: () => {
        setShowCancelModal(false);
        router.push("/offer");
      },
      onError: (error) => {
        console.error("Update status error:", error);
      },
    },
  );

  const [deleteOffer, { loading: isDeleting }] = useMutation(
    DELETE_OFFER_MUTATION,
    {
      onCompleted: () => {
        setShowCancelModal(false);
        router.push("/offer");
      },
      onError: (error) => {
        console.error("Delete offer error:", error);
      },
    },
  );

  const handleCancel = async () => {
    try {
      await deleteOffer({
        variables: {
          input: {
            id: parseInt(params.id),
          },
        },
      });
    } catch (error) {
      console.error("Delete error:", error);
    }
  };

  if (loading)
    return (
      <div className="min-h-screen bg-black flex items-center justify-center">
        <div className="">Loading...</div>
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
      refetch();
    }
  };

  return (
    <div className="min-h-screen bg-black text-white">
      <div className="p-6">
        <div className="mb-8">
          <Link href="/offer" className="block mb-2">
            <div className="flex items-center gap-2">
              <Image
                src="/arrow-left.svg"
                alt="arrow-left"
                width={60}
                height={60}
              />
            </div>
          </Link>
          <div className="flex items-center justify-between">
            <h1 className="text-[42px] font-light">Offer Details</h1>
            {isOwner ? (
              <div className="flex gap-4">
                <Link href={`/offer/edit/${params.id}`}>
                  <Button className="">編集</Button>
                </Link>
                <Button
                  variant="outline"
                  className="bg-black text-red-500 border-red-500 hover:bg-red-950"
                  onClick={() => setShowCancelModal(true)}
                >
                  削除
                </Button>
              </div>
            ) : (
              <>
                {data?.getOffersById?.status === "Reject" ? null : (
                  <Button
                    className="bg-[#E4DBC0] hover:bg-white text-black rounded-full"
                    onClick={showConfirmationDialog}
                    disabled={[
                      "Applied",
                      "Ongoing",
                      "Suspend",
                      "Canceled",
                      "Finished",
                    ].includes(data?.getOffersById?.status ?? "")}
                  >
                    {(() => {
                      switch (data?.getOffersById?.status) {
                        case "Applied":
                          return "応募済";
                        case "Ongoing":
                          return "進行中";
                        case "Suspend":
                        case "Canceled":
                          return "停止中";
                        case "Finished":
                          return "完了";
                        default:
                          return "このオファーに応募する";
                      }
                    })()}
                  </Button>
                )}
              </>
            )}
          </div>
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
              <div className="flex items-center gap-4">
                <span
                  className={`px-3 py-1 rounded-full text-sm text-black ${getCategoryBackgroundColor(offer?.category)}`}
                >
                  {offer?.category}
                </span>
              </div>
              <p className="text-lg mb-2 text-white">{offer?.title}</p>
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

            <p className="text-gray-100 whitespace-pre-wrap break-words">
              {offer?.description}
            </p>
            <p className="text-gray-100 whitespace-pre-wrap break-words">
              {offer?.attention}
            </p>
          </div>
        </div>

        <div className="mt-12">
          <h2 className="mb-4">( Attachments )</h2>
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

      <Dialog open={showCancelModal} onOpenChange={setShowCancelModal}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>オファーの削除確認</DialogTitle>
          </DialogHeader>
          <div className="py-4">
            <p>このオファーを削除しますか？</p>
            <p className="text-sm text-gray-500 mt-2">
              削除されたオファーは元に戻すことができません。
            </p>
          </div>
          <DialogFooter className="flex gap-2">
            <Button variant="outline" onClick={() => setShowCancelModal(false)}>
              戻る
            </Button>
            <Button
              variant="destructive"
              className="bg-red-500 hover:bg-red-600"
              onClick={handleCancel}
              disabled={isDeleting}
            >
              {isDeleting ? "削除中..." : "削除する"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
