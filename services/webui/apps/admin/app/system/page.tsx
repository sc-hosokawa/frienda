"use client";

import React from "react";
import { StatsCard } from "../../components/stats-card";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_ALL_ARTISTS } from "../../utils/query";
import { Activity, Disc, JapaneseYen, Users, MoreVertical } from "lucide-react";
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
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";

export default function SettingPage() {
  const { data: artistData, isLoading: isLoadingArtist } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_ARTISTS).then(
        (data: any) => data.getAllArtists.artistList,
      );
    },
  });

  const downloadCreditHistoryCSV = () => {
    const headers = ["date", "isrc", "user", "role", "name", "email"];
    const csvContent = [
      headers.join(","),
      ...mockCreditHistory.map((history) =>
        [
          history.date,
          history.isrc,
          history.user,
          history.role,
          history.name,
          history.email,
        ].join(","),
      ),
    ].join("\n");

    const blob = new Blob([csvContent], { type: "text/csv" });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "credit-history.csv";
    a.click();
    window.URL.revokeObjectURL(url);
  };

  const downloadPointHistoryCSV = () => {
    const headers = ["date", "from", "to", "amount"];
    const csvContent = [
      headers.join(","),
      ...mockPointHistory.map((history) =>
        [history.date, history.from, history.to, history.amount].join(","),
      ),
    ].join("\n");

    const blob = new Blob([csvContent], { type: "text/csv" });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "point-history.csv";
    a.click();
    window.URL.revokeObjectURL(url);
  };

  return (
    <main>
      <div className="flex flex-col min-h-screen">
        {/* Cards */}
        <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-4 p-6">
          <StatsCard
            title="総アーティスト数"
            amount={artistData?.length}
            isLoading={isLoadingArtist}
            image={<Users />}
            unit="users"
          />
          <StatsCard
            title="総再生回数"
            amount={0}
            image={<Activity />}
            unit="回"
          />
          <StatsCard
            title="総配布ポイント数"
            amount={5218}
            image={<Disc />}
            unit="fsp"
          />
          <StatsCard
            title="総登録者"
            amount={23}
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
          <Card className="dark:border dark:border-white dark:border-opacity-10">
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle>{`クレジット登録`}</CardTitle>
              <DropdownMenu>
                <DropdownMenuTrigger>
                  <MoreVertical className="h-5 w-5" />
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  <DropdownMenuItem onClick={downloadCreditHistoryCSV}>
                    CSVダウンロード
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </CardHeader>
            <CardContent>
              <Table className="border-collapse">
                <TableHeader>
                  <TableRow className="border-b border-[#FFFFFF73]">
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      date
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      isrc
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      user
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      role
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      name
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
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
          <Card className="dark:border dark:border-white dark:border-opacity-10">
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle>ポイント履歴</CardTitle>
              <DropdownMenu>
                <DropdownMenuTrigger>
                  <MoreVertical className="h-5 w-5" />
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  <DropdownMenuItem onClick={downloadPointHistoryCSV}>
                    CSVダウンロード
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </CardHeader>
            <CardContent>
              <Table className="border-collapse">
                <TableHeader>
                  <TableRow className="border-b border-[#FFFFFF73]">
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      date
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      from
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      to
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
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
