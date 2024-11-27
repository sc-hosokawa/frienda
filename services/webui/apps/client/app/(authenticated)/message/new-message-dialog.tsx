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
import useUserStore from "../../../store/user";
import { AllUsersData } from "../../../generated/graphql";
import { useRouter } from "next/navigation";

const GET_ALL_USERS = gql`
  query GetAllUsers {
    getAllUsers {
      users {
        id
        name
        imageUrl
      }
    }
  }
`;
interface ResData {
  getAllUsers: AllUsersData;
}

const CREATE_MESSAGE_ROOM = gql`
  mutation CreateNewMessageRoom($input: CreateNewMessageRoomInput!) {
    createNewMessageRoom(input: $input) {
      id
    }
  }
`;

export default function NewMessageDialog() {
  const { user } = useUserStore();
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [search, setSearch] = useState("");
  const { data } = useQuery<ResData>(GET_ALL_USERS);
  const [createRoom] = useMutation(CREATE_MESSAGE_ROOM);

  const users = data?.getAllUsers.users || [];
  const filteredUsers = users.filter((user) =>
    user.name.toLowerCase().includes(search.toLowerCase()),
  );

  // Handle room creation
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
          className="rounded-full border border-dashed border-gray-600 w-[60px] h-[60px] flex items-center justify-center"
        >
          <Image src="/plus.svg" alt="plus" width={24} height={24} />
        </Button>
      </DialogTrigger>
      <DialogContent className="max-w-[80%] h-[80vh] bg-black border-gray-800">
        <DialogHeader className="relative">
          <DialogTitle className="text-2xl font-light">
            Who are you sending
            <br />
            message to?
          </DialogTitle>
          <p className="text-sm text-gray-400 mt-2">
            送信先のユーザーを選択してください。
          </p>
        </DialogHeader>
        {/* 送信先 
        <div className="mt-6">
          <Label htmlFor="search" className="text-sm text-gray-400">
            送信先
          </Label>
          <Input
            id="search"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="mt-1.5 bg-transparent border-gray-800"
          />
        </div>
        */}
        <div className="mt-6 grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 overflow-y-auto">
          {filteredUsers.map((user) => (
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
          ))}
        </div>
      </DialogContent>
    </Dialog>
  );
}
