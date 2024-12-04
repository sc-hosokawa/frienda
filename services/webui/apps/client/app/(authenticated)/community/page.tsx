"use client";

import Image from "next/image";
import CommunityListsRow from "../../../components/community/community-lits-row";
import { Button } from "../../../../../packages/ui/components/ui/button";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "../../../../../packages/ui/components/ui/tabs";

export default function MessagePage() {
  return (
    <div className="bg-black text-white flex-1">
      <div className="flex items-center justify-between pt-[115px] border-gray-800">
        <div className="flex items-center gap-2">
          <Image
            src="/community.svg"
            alt="logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              Community
            </h1>
            <p className="text-sm">コミュニティ</p>
          </div>
        </div>
        <Button
          variant="ghost"
          size="icon"
          className="rounded-full border border-dashed border-gray-600 w-[60px] h-[60px] flex items-center justify-center"
        >
          <Image src="/search.svg" alt="plus" width={24} height={24} />
        </Button>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />

      <Tabs defaultValue="list" className="w-full">
        <div className="flex justify-end mb-6">
          <TabsList className="bg-transparent border border-dashed border-white rounded-full p-1 w-[186px] h-[60px]">
            <TabsTrigger
              value="map"
              className="rounded-[60px] w-[90px] text-base h-[52.5px] data-[state=active]:bg-white data-[state=active]:text-black"
            >
              Map View
            </TabsTrigger>
            <TabsTrigger
              value="list"
              className="rounded-[60px] w-[90px] text-base h-[52.5px] data-[state=active]:bg-white data-[state=active]:text-black"
            >
              List View
            </TabsTrigger>
          </TabsList>
        </div>
        <TabsContent value="map">
          Make changes to your account here.
        </TabsContent>
        <TabsContent value="list">
          {mockData.map((data) => (
            <CommunityListsRow key={data.id} {...data} />
          ))}
        </TabsContent>
      </Tabs>
    </div>
  );
}

const mockData = [
  {
    id: "1",
    name: "john_john",

    friendCount: "4 common friends",
    rate: "4.5",
    type: "Curator",
    comment: "次のMVの時きく！",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "2",
    name: "john_john",

    friendCount: "4 common friends",
    rate: "4.5",
    type: "Curator",
    comment: "次のMVの時きく！",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
    isOnline: true,
  },
  {
    id: "3",
    name: "john_john",

    friendCount: "4 common friends",
    rate: "4.5",
    type: "Curator",
    comment: "次のMVの時きく！",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "4",
    name: "Sayaka Yoshida",

    friendCount: "4 common friends",
    rate: "4.5",
    type: "Curator",
    comment: "次のMVの時きく！",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "5",
    name: "john_john",

    friendCount: "4 common friends",
    rate: "4.5",
    type: "Curator",
    comment: "次のMVの時きく！",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "6",
    name: "john_john",

    friendCount: "4 common friends",
    rate: "4.5",
    type: "Curator",
    comment: "次のMVの時きく！",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
];
