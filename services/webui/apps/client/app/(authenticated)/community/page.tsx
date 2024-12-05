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
import {
  Table,
  TableBody,
  TableHead,
  TableHeader,
  TableRow,
} from "../../../../../packages/ui/components/ui/table";
import { ChevronDown } from "lucide-react";

export default function CommunityPage() {
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
          className="rounded-full border border-dashed border-white w-[60px] h-[60px] flex items-center justify-center"
        >
          <Image src="/search.svg" alt="plus" width={24} height={24} />
        </Button>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />

      <Tabs defaultValue="list" className="w-full">
        <div className="flex justify-between mb-6">
          <h2 className="text-[18px] font-[360] leading-[18px] text-left">
            {/* TODO: this should be correct number */}
            My Connections (11)
          </h2>
          <TabsList className="bg-transparent border border-dashed border-white rounded-full p-1 w-[186px] h-[60px]">
            <TabsTrigger
              value="map"
              className="rounded-[60px] w-[90px] text-[15px] font-[360] leading-[18px] text-center h-[52.5px] text-white data-[state=active]:bg-white data-[state=active]:text-black"
            >
              Map View
            </TabsTrigger>
            <TabsTrigger
              value="list"
              className="rounded-[60px] w-[90px] text-[15px] font-[360] leading-[18px] text-center h-[52.5px] text-white data-[state=active]:bg-white data-[state=active]:text-black"
            >
              List View
            </TabsTrigger>
          </TabsList>
        </div>
        <TabsContent value="map">{/* TODO: add map view */}</TabsContent>
        <TabsContent value="list">
          <Table className="border-collapse">
            <TableHeader>
              <TableRow className="border-b border-[#FFFFFF73]">
                <TableHead></TableHead>
                <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                  <div className="flex items-center gap-1">
                    User
                    <ChevronDown className="w-4 h-4" />
                  </div>
                </TableHead>
                <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                  Rate
                </TableHead>
                <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                  Type
                </TableHead>
                <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                  Comment
                </TableHead>
                <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                  Connection
                </TableHead>
                <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                  Last Logged in
                </TableHead>
                <TableHead className="w-24"></TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {/* TODO: this should be actual data */}
              {mockData.map((data) => (
                <CommunityListsRow key={data.id} {...data} />
              ))}
            </TableBody>
          </Table>
        </TabsContent>
      </Tabs>
    </div>
  );
}
// TODO: remove this mock data
const mockData = [
  {
    id: "1",
    name: "taro_yoshida",
    friendCount: 4,
    rate: "4.5",
    type: "Curator",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "2",
    name: "sayaka_kyoda",
    friendCount: 4,
    rate: "4.5",
    type: "Curator",
    comment: "イベントいつも最高",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
    isOnline: true,
  },
  {
    id: "3",
    name: "photoone",
    friendCount: 4,
    rate: "4.5",
    type: "Curator",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "4",
    name: "lisa_fukuda",
    friendCount: 4,
    rate: "4.5",
    type: "Curator",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "5",
    name: "minoru_kou",
    friendCount: 4,
    rate: "4.5",
    type: "Curator",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    lastLogin: "20分前",
  },
  {
    id: "6",
    name: "john_john",
    friendCount: 4,
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
