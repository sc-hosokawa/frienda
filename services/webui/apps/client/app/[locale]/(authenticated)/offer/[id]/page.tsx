"use client";

import { Button } from "@ui/components/ui/button";
import { Download, Play, Pause } from "lucide-react";
import Image from "next/image";
import { useQuery, useMutation, gql } from "@apollo/client";
import { useState } from "react";
import useUserStore from "~/store/user";
import { OfferDetailData } from "~/generated/graphql";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";
import { ApplicantsList } from "~/components/offer/applications-list";
import { useTranslation } from "~/i18n/client";

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
  const { t } = useTranslation();
  const { data, loading, error, refetch } = useQuery<ResData>(GET_OFFER_QUERY, {
    variables: {
      offerId: parseInt(params.id),
      userId: user?.id,
    },
    skip: !user?.id,
  });

  console.log(data?.getOffersById);

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

  const [playingAudio, setPlayingAudio] = useState<HTMLAudioElement | null>(
    null,
  );

  const handleFileClick = (file: string) => {
    const extension = file.split("?")[0]?.split(".").pop()?.toLowerCase();
    const isAudio = ["mp3", "wav", "m4a", "ogg"].includes(extension ?? "");

    if (isAudio) {
      if (playingAudio) {
        playingAudio.pause();
        setPlayingAudio(null);
      } else {
        const audio = new Audio(file);
        audio.play();
        setPlayingAudio(audio);
        audio.onended = () => setPlayingAudio(null);
      }
    } else {
      window.open(file, "_blank", "noopener,noreferrer");
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
    if (window.confirm(t("offer.apply.confirmation"))) {
      handleApply();
      refetch();
    }
  };

  return (
    <div className="min-h-screen bg-black text-white">
      <div className="p-6">
        <div className="mb-8">
          <div className="w-[60px]">
            <div
              className="block mb-2 cursor-pointer"
              onClick={() => router.back()}
            >
              <Image
                src="/arrow-left.svg"
                alt="arrow-left"
                width={60}
                height={60}
              />
            </div>
          </div>
          <div className="flex items-center justify-between">
            <h1 className="text-[42px] font-light">Offer Details</h1>
            {isOwner ? (
              <div className="flex gap-4">
                <Link href={`/offer/edit/${params.id}`}>
                  <Button className="">{t("common.edit")}</Button>
                </Link>
                <Button
                  variant="outline"
                  className="bg-black text-red-500 border-red-500 hover:bg-red-950"
                  onClick={() => setShowCancelModal(true)}
                >
                  {t("common.delete")}
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
                          return t("common.applied");
                        case "Ongoing":
                          return t("common.ongoing");
                        case "Suspend":
                        case "Canceled":
                          return t("offer.canceled-offer");
                        case "Finished":
                          return t("common.finished");
                        default:
                          return t("offer.apply-the-offer");
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
            src={offer?.imageUrl || "/offer.svg"}
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

            <div>
              <div className="grid grid-cols-4 gap-2 text-sm">
                {offer?.fee && (
                  <div>
                    <div className="text-gray-400">{t("offer.reward")}</div>
                    <div className="text-white">{offer?.fee} FSP</div>
                  </div>
                )}
                {offer?.place && (
                  <div>
                    <div className="text-gray-400">{t("offer.place")}</div>
                    <div className="text-white">{offer?.place}</div>
                  </div>
                )}
                {offer?.category && (
                  <div>
                    <div className="text-gray-400">{t("offer.category")}</div>
                    <div className="text-white">{offer?.category}</div>
                  </div>
                )}
                {offer?.targetRole && (
                  <div>
                    <div className="text-gray-400">{t("offer.target")}</div>
                    <div className="text-white">{offer?.targetRole}</div>
                  </div>
                )}
              </div>
            </div>

            {offer?.owner && (
              <div>
                <div className="flex items-center gap-2">
                  <Link href={`/community/${offer.owner.id}`}>
                    <div className="flex items-center gap-2 hover:opacity-80">
                      <Image
                        src={offer.owner.imageUrl || "/logo_visualonly.jpg"}
                        alt="Profile"
                        width={32}
                        height={32}
                        className="rounded-full w-8 h-8 object-cover"
                      />
                      <span className="text-white">{offer.owner.name}</span>
                    </div>
                  </Link>
                </div>
              </div>
            )}

            {offer?.description && (
              <div>
                <h3 className="text-sm text-gray-400 mb-2">説明</h3>
                <p className="text-white whitespace-pre-wrap break-words">
                  {offer.description}
                </p>
              </div>
            )}

            {offer?.attention && (
              <div>
                <h3 className="text-sm text-gray-400 mb-2">注意事項</h3>
                <p className="text-white whitespace-pre-wrap break-words">
                  {offer.attention}
                </p>
              </div>
            )}

            {offer?.requiredSkill && (
              <div>
                <h3 className="text-sm text-gray-400 mb-2">必要なスキル</h3>
                <p className="text-white whitespace-pre-wrap break-words">
                  {offer.requiredSkill}
                </p>
              </div>
            )}
          </div>
        </div>

        {((offer?.attachedImgs?.length ?? 0) > 0 ||
          (offer?.attachedFiles?.length ?? 0) > 0) && (
          <div className="mt-12">
            <h3 className="text-sm text-gray-400 mb-4">添付ファイル</h3>
            {offer?.attachedImgs && offer.attachedImgs.length > 0 && (
              <div className="grid grid-cols-4 gap-4 mb-4">
                {offer.attachedImgs.map((img, i) => (
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
            )}

            {offer?.attachedFiles?.map((file, i) => {
              const extension = file
                .split("?")[0]
                ?.split(".")
                .pop()
                ?.toLowerCase();
              const isAudio = ["mp3", "wav", "m4a", "ogg"].includes(
                extension ?? "",
              );
              const isPlaying = isAudio && playingAudio;

              return (
                <Button
                  key={i}
                  variant="outline"
                  className="w-full h-[90px] justify-between text-left mb-6 rounded-full border-white"
                  onClick={() => handleFileClick(file)}
                >
                  <div className="flex items-center gap-2">
                    <span className="w-[60px] h-[60px] rounded-full text-sm text-white font-light border-white border flex items-center justify-center">
                      {isAudio ? (
                        isPlaying ? (
                          <Pause className="w-4 h-4" />
                        ) : (
                          <Play className="w-4 h-4" />
                        )
                      ) : (
                        file.split("?")[0]?.split(".").pop()?.toUpperCase()
                      )}
                    </span>
                    {decodeURIComponent(
                      file
                        .split("/")
                        .pop()
                        ?.split("?")[0]
                        ?.split("_")
                        .slice(1)
                        .join("_")
                        .split(".")[0] ?? "",
                    )}
                  </div>
                  {!isAudio && <Download className="w-4 h-4" />}
                </Button>
              );
            })}
          </div>
        )}

        <div className="mt-4 text-right text-gray-400 text-sm">
          最終更新:{" "}
          {new Date(offer?.updatedAt || "").toLocaleDateString("ja-JP")}
        </div>

        {isOwner && (
          <>
            <hr className="mb-8 mt-12 border-[#303030]" />
            <ApplicantsList
              offerId={parseInt(params.id)}
              userId={user?.id || ""}
            />
          </>
        )}
      </div>

      <Dialog open={showCancelModal} onOpenChange={setShowCancelModal}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>{t("offer.delete-confirmation")}</DialogTitle>
          </DialogHeader>
          <div className="py-4">
            <p>{t("offer.delete-confirmation-description")}</p>
            <p className="text-sm text-gray-500 mt-2">
              {t("offer.delete-confirmation-description-1")}
            </p>
          </div>
          <DialogFooter className="flex gap-2">
            <Button variant="outline" onClick={() => setShowCancelModal(false)}>
              {t("common.back")}
            </Button>
            <Button
              variant="destructive"
              className="bg-red-500 hover:bg-red-600"
              onClick={handleCancel}
              disabled={isDeleting}
            >
              {isDeleting ? t("common.deleting...") : t("common.delete")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
