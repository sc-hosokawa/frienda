"use client";

import { gql, useQuery, useMutation } from "@apollo/client";
import { useRouter } from "next/navigation";
import useUserStore from "~/store/user";
import Image from "next/image";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { useState } from "react";
import { useTranslation } from "~/i18n/client";

const GET_USERS_IN_OFFER = gql`
  query GetUsersInOffer($offerId: Int!, $userId: String!) {
    getUsersInOffer(offerId: $offerId, userId: $userId) {
      users {
        userId
        username
        imgUrl
        email
        category
        statusInOffer
      }
    }
  }
`;

const CREATE_MESSAGE_ROOM = gql`
  mutation CreateNewMessageRoom($input: CreateNewMessageRoomInput!) {
    createNewMessageRoom(input: $input) {
      id
    }
  }
`;

const UPDATE_OFFER_STATUS = gql`
  mutation UpdateOfferStatus($input: UpdateOfferStatusInput!) {
    updateOfferStatus(input: $input) {
      id
      offerId
    }
  }
`;

interface UsersInOfferData {
  getUsersInOffer: {
    users: Array<{
      userId: string;
      username: string;
      imgUrl: string;
      email: string;
      category: string;
      statusInOffer: string;
    }>;
  };
}

interface ApplicantsListProps {
  offerId: number;
  userId: string;
}

export function ApplicantsList({ offerId, userId }: ApplicantsListProps) {
  const router = useRouter();
  const { user } = useUserStore();
  const { t } = useTranslation();
  const [createRoom] = useMutation(CREATE_MESSAGE_ROOM);
  const [updateStatus] = useMutation(UPDATE_OFFER_STATUS);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<string | null>(null);
  const [modalType, setModalType] = useState<"ongoing" | "finished">("ongoing");

  const {
    data: usersData,
    loading: usersLoading,
    refetch,
  } = useQuery<UsersInOfferData>(GET_USERS_IN_OFFER, {
    variables: {
      offerId,
      userId,
    },
    skip: !userId,
  });

  console.log(usersData);

  if (usersLoading) {
    return <p>Loading users...</p>;
  }

  if (!usersData?.getUsersInOffer.users || usersData.getUsersInOffer.users.length === 0) {
    return (
      <div className="my-12">
        <h2 className="mb-4">Offer Management</h2>
        <div className="p-6 bg-zinc-900 rounded-lg text-center">
          <p className="text-md">{t("offer.no-applicant")}</p>
        </div>
      </div>
    );
  }

  const ongoingUser = usersData?.getUsersInOffer.users.find(
    (user) => user.statusInOffer === "Ongoing",
  );

  const finishedUser = usersData?.getUsersInOffer.users.find(
    (user) => user.statusInOffer === "Finished",
  );

  if (finishedUser) {
    return (
      <div className="my-12">
        <h2 className="mb-4">Offer Management</h2>
        <div className="p-6 bg-zinc-900 rounded-lg text-center">
          <p className="text-lg">このOfferは終了しました</p>
          <p className="text-sm text-gray-400 mt-2">貢献したユーザー</p>
          <div className="flex items-center justify-center gap-2 mt-4">
            <Image
              src={finishedUser.imgUrl || "/logo_visualonly.jpg"}
              alt={finishedUser.username}
              width={40}
              height={40}
              className="rounded-full"
            />
            <span>{finishedUser.username}</span>
          </div>
        </div>
      </div>
    );
  }

  const handleMessageClick = async (targetUserId: string) => {
    try {
      const result = await createRoom({
        variables: {
          input: {
            createdBy: user?.id,
            userList: [user?.id, targetUserId],
            category: "dm",
          },
        },
      });

      if (result.data?.createNewMessageRoom?.id) {
        router.push(`/message/${result.data.createNewMessageRoom.id}`);
      }
    } catch (err) {
      console.error("Failed to create message room:", err);
    }
  };

  const handleRequestClick = async (targetUserId: string) => {
    setSelectedUserId(targetUserId);
    setModalType("ongoing");
    setIsModalOpen(true);
  };

  const handleFinishClick = async (targetUserId: string) => {
    setSelectedUserId(targetUserId);
    setModalType("finished");
    setIsModalOpen(true);
  };

  const handleConfirmRequest = async () => {
    if (!selectedUserId) return;

    try {
      const status = modalType === "ongoing" ? "Ongoing" : "Finished";
      const result = await updateStatus({
        variables: {
          input: {
            id: offerId,
            userId: selectedUserId,
            status,
          },
        },
      });

      if (result.data?.updateOfferStatus?.id) {
        refetch();
        setIsModalOpen(false);
      }
    } catch (err) {
      console.error("Error updating offer status:", err);
    }
  };

  const getModalContent = () => {
    if (modalType === "ongoing") {
      return {
        title: "依頼の確認",
        message: "このユーザーに依頼を送信しますか？",
        description:
          "依頼を送信すると、このユーザーとのみ作業を進めることになります。",
        buttonText: "依頼する",
      };
    }
    return {
      title: "完了の確認",
      message: "この依頼を完了としてよろしいですか？",
      description: "完了すると、この依頼は終了となります。",
      buttonText: "完了する",
    };
  };

  return (
    <div className="my-12">
      <h2 className="mb-4">Offer Management</h2>
      <div className="grid gap-4">
        {ongoingUser ? (
          <div
            key={ongoingUser.userId}
            className="flex items-center gap-4 p-4 bg-black rounded-lg border border-blue-500"
          >
            <Image
              src={ongoingUser.imgUrl || "/logo_visualonly.jpg"}
              alt={ongoingUser.username}
              width={40}
              height={40}
              className="rounded-full"
            />
            <div>
              <p className="font-medium">{ongoingUser.username}</p>
              <p className="text-sm text-gray-400">{ongoingUser.category}</p>
            </div>
            <div className="ml-auto flex items-center gap-2">
              <button
                className="px-4 py-2 text-sm rounded-md bg-zinc-800 hover:bg-zinc-700 transition-colors"
                onClick={() => handleMessageClick(ongoingUser.userId)}
              >
                メッセージ
              </button>
              <button
                className="px-4 py-2 text-sm rounded-md bg-[#E4DBC0] hover:bg-[#E4DBC0]/70 transition-colors text-black"
                onClick={() => handleFinishClick(ongoingUser.userId)}
              >
                完了する
              </button>
              <span className="ml-4 text-sm px-3 py-1 rounded-full bg-blue-800">
                {ongoingUser.statusInOffer}
              </span>
            </div>
          </div>
        ) : (
          usersData?.getUsersInOffer.users.map((user) => (
            <div
              key={user.userId}
              className="flex items-center gap-4 p-4 bg-zinc-900 rounded-lg"
            >
              <Image
                src={user.imgUrl || "/logo_visualonly.jpg"}
                alt={user.username}
                width={40}
                height={40}
                className="rounded-full"
              />
              <div>
                <p className="font-medium">{user.username}</p>
                <p className="text-sm text-gray-400">{user.category}</p>
              </div>
              <div className="ml-auto flex items-center gap-2">
                <button
                  className="px-4 py-2 text-sm rounded-md bg-zinc-800 hover:bg-zinc-700 transition-colors"
                  onClick={() => handleMessageClick(user.userId)}
                >
                  メッセージ
                </button>
                <button
                  className="px-4 py-2 text-sm rounded-md bg-[#E4DBC0] hover:bg-[#E4DBC0]/70 transition-colors text-black"
                  onClick={() => handleRequestClick(user.userId)}
                >
                  依頼する
                </button>
                <span className="ml-4 text-sm px-3 py-1 rounded-full bg-zinc-800">
                  {user.statusInOffer}
                </span>
              </div>
            </div>
          ))
        )}
      </div>
      <Dialog open={isModalOpen} onOpenChange={setIsModalOpen}>
        <DialogContent className="sm:max-w-[425px] bg-zinc-900 border-zinc-800">
          <DialogHeader>
            <DialogTitle className="text-xl font-semibold">
              {getModalContent().title}
            </DialogTitle>
          </DialogHeader>
          <div className="py-4">
            <p className="text-sm text-gray-300">{getModalContent().message}</p>
            <p className="mt-2 text-xs text-gray-400">
              {getModalContent().description}
            </p>
          </div>
          <div className="flex justify-end gap-3 mt-4">
            <Button
              variant="outline"
              onClick={() => setIsModalOpen(false)}
              className="bg-transparent border-gray-600 hover:bg-gray-800"
            >
              キャンセル
            </Button>
            <Button
              onClick={handleConfirmRequest}
              className="bg-[#E4DBC0] hover:bg-[#E4DBC0]/70 text-black"
            >
              {getModalContent().buttonText}
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
