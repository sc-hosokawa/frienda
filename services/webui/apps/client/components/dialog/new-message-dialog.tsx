"use client";

import Image from "next/image";
import { useState } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Button } from "@ui/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useQuery, useMutation, gql } from "@apollo/client";
import useUserStore from "~/store/user";
import { UserSimpleData } from "~/generated/graphql";
import { useRouter } from "next/navigation";
import { useTranslation } from "~/i18n/client";

const SEARCH_USERS = gql`
  query SearchUsers($username: String!) {
    searchUsers(username: $username) {
      id
      name
      imageUrl
      realname
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

export default function NewMessageDialog() {
  const { user } = useUserStore();
  const { t } = useTranslation();
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");

  const { data, loading } = useQuery<{ searchUsers: UserSimpleData[] }>(
    SEARCH_USERS,
    {
      variables: { username: searchTerm },
      skip: searchTerm.length === 0,
    },
  );

  const [createRoom] = useMutation(CREATE_MESSAGE_ROOM);

  const handleUserSelect = async (userId: string) => {
    try {
      const result = await createRoom({
        variables: {
          input: {
            createdBy: user?.id,
            userList: [user?.id, userId],
            category: "dm",
          },
        },
      });

      if (result.data?.createNewMessageRoom?.id) {
        router.push(`/message/${result.data.createNewMessageRoom.id}`);
        setOpen(false);
      }
    } catch (err) {
      console.error("Failed to create room:", err);
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button
          variant="ghost"
          size="icon"
          className="rounded-full border border-dashed border-white w-[60px] h-[60px] flex items-center justify-center"
        >
          <Image src="/plus.svg" alt="plus" width={24} height={24} />
        </Button>
      </DialogTrigger>
      <DialogContent className="max-w-[80%] h-[80vh] bg-black border-gray-800">
        <DialogHeader className="relative">
          <DialogTitle className="text-6xl font-light">
            Who are you sending
            <br />
            message to?
          </DialogTitle>
          <p className="text-sm text-white mt-2">
            {t("message.select-user-to-send")}
          </p>
        </DialogHeader>

        <div className="mt-6 h-[90px] w-[555px]">
          <Label htmlFor="search" className="text-sm text-gray-400">
            {t("message.recipient")}
          </Label>
          <Input
            id="search"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            placeholder={t("message.enter-user-name")}
            className="mt-1.5 bg-transparent h-[60px] rounded-xl border border-white"
          />
        </div>

        <div className="mt-6 grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 overflow-y-auto">
          {loading ? (
            <div className="text-gray-400">{t("common.searching...")}</div>
          ) : data?.searchUsers && data.searchUsers.length > 0 ? (
            data.searchUsers.map((user) => (
              <button
                key={user.id}
                className="flex items-center gap-3 p-2 rounded-lg hover:bg-gray-800/50 transition-colors text-left"
                onClick={() => handleUserSelect(user.id)}
              >
                <Avatar className="h-10 w-10">
                  <AvatarImage
                    src={user.imageUrl || "/logo_visualonly.jpg"}
                    alt={user.name}
                  />
                </Avatar>
                <div>
                  <p className="text-sm font-medium">{user.name}</p>
                </div>
              </button>
            ))
          ) : searchTerm.length > 0 ? (
            <div className="text-gray-400">{t("common.no-user-found")}</div>
          ) : (
            <div className="text-gray-400">
              {t("message.search-user-by-name")}
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
