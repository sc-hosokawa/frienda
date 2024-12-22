"use client";
import React from "react";
import { StatsCard } from "../../components/stats-card";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_ALL_ARTISTS } from "../../utils/query";
import { Activity, Disc, JapaneseYen, Users } from "lucide-react";
import {
  Table,
  TableBody,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import {
  CreditHistoryTable,
  CreditHistoryTableProps,
} from "../../components/system/credit-history-table";
import {
  PointHistoryTable,
  PointHistoryTableProps,
} from "../../components/system/point-history-table";

export default function SettingPage() {
  const { data: artistData, isLoading: isLoadingArtist } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_ARTISTS).then(
        (data: any) => data.getAllArtists.artistList
      );
    },
  });
  return (
    <main>
      <div className="flex flex-col min-h-screen gap-10">
        {/* Cards */}
        <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-4 mx-auto">
          <StatsCard
            title="総アーティスト数"
            amount={artistData?.length}
            isLoading={isLoadingArtist}
            image={<Users />}
            unit="users"
          />
          <StatsCard title="総再生回数" amount={0} image={<Activity />} />
          <StatsCard
            title="総配布ポイント数"
            amount={0}
            image={<Disc />}
            unit="fsp"
          />
          <StatsCard
            title="総登録者"
            amount={0}
            image={<Users />}
            unit="users"
          />
          <StatsCard
            title="総売上"
            amount={0}
            image={<JapaneseYen />}
            unit="円"
          />
        </div>
        {/* Tables */}
        <div className="grid grid-cols-1 gap-4 p-6">
          <Card className="bg-[#1E1E1E]">
            <CardHeader>
              <CardTitle>{`クレジット登録0件`}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table className="border-collapse">
                <TableHeader>
                  <TableRow className="border-b border-[#FFFFFF73]">
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      date
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      isrc
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      user
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      role
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      name
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      email
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {mockCreditHistory.map((history) => (
                    <CreditHistoryTable {...history} />
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
          <Card className="bg-[#1E1E1E]">
            <CardHeader>
              <CardTitle>ポイント履歴</CardTitle>
            </CardHeader>
            <CardContent>
              <Table className="border-collapse">
                <TableHeader>
                  <TableRow className="border-b border-[#FFFFFF73]">
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      date
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      from
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      to
                    </TableHead>
                    <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                      amount
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {mockPointHistory.map((history) => (
                    <PointHistoryTable {...history} />
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </div>
      </div>
    </main>
  );
}

const mockCreditHistory: CreditHistoryTableProps[] = [
  {
    date: "12/18/2024",
    isrc: "username",
    user: "username",
    role: "artist",
    name: "username",
    email: "example@gmail.com",
  },
  {
    date: "12/18/2024",
    isrc: "username",
    user: "username",
    role: "artist",
    name: "username",
    email: "example@gmail.com",
  },
  {
    date: "12/18/2024",
    isrc: "username",
    user: "username",
    role: "artist",
    name: "username",
    email: "example@gmail.com",
  },
  {
    date: "12/18/2024",
    isrc: "username",
    user: "username",
    role: "artist",
    name: "username",
    email: "example@gmail.com",
  },
  {
    date: "12/18/2024",
    isrc: "username",
    user: "username",
    role: "artist",
    name: "username",
    email: "example@gmail.com",
  },
  {
    date: "12/18/2024",
    isrc: "username",
    user: "username",
    role: "artist",
    name: "username",
    email: "example@gmail.com",
  },
];

const mockPointHistory: PointHistoryTableProps[] = [
  {
    date: "12/18/2024",
    from: "username",
    to: "username",
    amount: "100",
  },
  {
    date: "12/18/2024",
    from: "username",
    to: "username",
    amount: "100",
  },
  {
    date: "12/18/2024",
    from: "username",
    to: "username",
    amount: "100",
  },
  {
    date: "12/18/2024",
    from: "username",
    to: "username",
    amount: "100",
  },
  {
    date: "12/18/2024",
    from: "username",
    to: "username",
    amount: "100",
  },
  {
    date: "12/18/2024",
    from: "username",
    to: "username",
    amount: "100",
  },
];
