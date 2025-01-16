"use client";

import React from "react";
import { StatsCard } from "../../components/stats-card";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import {
  endpoint,
  GET_ALL_ARTISTS,
  GET_SYSTEM_OVERVIEW,
  GET_FSP_HISTORY,
  GET_TRACK_CREDITS_HISTORY,
  GET_ALL_USERS,
} from "../../utils/query";
import { Activity, Disc, JapaneseYen, Users, Smartphone } from "lucide-react";
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
import Link from "next/link";
import { UserListTable } from "../../components/system/user-list-table";

export default function SettingPage() {
  const { data: artistData, isLoading: isLoadingArtist } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_ARTISTS).then(
        (data: any) => data.getAllArtists.artistList,
      );
    },
  });

  const { data: systemOverview, isLoading: isLoadingSystemOverview } = useQuery(
    {
      queryKey: ["systemOverview"],
      queryFn: async () => {
        return await request(endpoint, GET_SYSTEM_OVERVIEW).then(
          (data: any) => data.getSystemOverview,
        );
      },
    },
  );

  const {
    data: fspHistory,
    isLoading: isLoadingFspHistory,
    isError: isErrorFspHistory,
  } = useQuery({
    queryKey: ["fspHistory"],
    queryFn: async () => {
      return await request(endpoint, GET_FSP_HISTORY, { count: 10 }).then(
        (data: any) => data.getFspHistoryForAdmin,
      );
    },
  });

  const { data: trackCreditsHistory, isLoading: isLoadingTrackCreditsHistory } =
    useQuery({
      queryKey: ["trackCreditsHistory"],
      queryFn: async () => {
        return await request(endpoint, GET_TRACK_CREDITS_HISTORY, {
          count: 10,
        }).then((data: any) => data.getTrackCreditsHistoryForAdmin);
      },
    });

  const {
    data: userTable,
    isLoading: isLoadingUserTable,
    isError: isErrorUserTable,
  } = useQuery({
    queryKey: ["userTable"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_USERS, { count: 10 }).then(
        (data: any) => data.getAllUsersForAdmin,
      );
    },
  });

  return (
    <main>
      <div className="flex flex-col min-h-screen">
        {/* Cards */}
        <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-4 px-6 pt-6">
          <StatsCard
            title="総登録者"
            amount={systemOverview?.totalUsers}
            isLoading={isLoadingSystemOverview}
            image={<Users />}
            unit="users"
          />
          <StatsCard
            title="モバイルユーザー率"
            amount={
              (systemOverview?.mobileAppUsersCount /
                systemOverview?.totalUsers) *
              100
            }
            isLoading={isLoadingSystemOverview}
            image={<Smartphone />}
            unit="%"
          />
          <StatsCard
            title="総売上"
            amount={systemOverview?.totalRevenue}
            isLoading={isLoadingSystemOverview}
            image={<JapaneseYen />}
            unit="円"
          />
          <StatsCard
            title="総配布ポイント数"
            amount={systemOverview?.totalFsp}
            isLoading={isLoadingSystemOverview}
            image={<Disc />}
            unit="fsp"
          />
          <StatsCard
            title="総アーティスト数"
            amount={systemOverview?.totalArtists}
            isLoading={isLoadingSystemOverview}
            image={<Users />}
            unit="users"
          />
          <StatsCard
            title="総再生回数"
            amount={systemOverview?.totalPlayCount}
            isLoading={isLoadingSystemOverview}
            image={<Activity />}
            unit="回"
          />
        </div>
        {/* Tables */}
        <div className="grid grid-cols-1 gap-6 p-6">
          <Card className="dark:border dark:border-white dark:border-opacity-10">
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle>{`ユーザー一覧`}</CardTitle>
              <Link
                href="/system/user"
                className="text-sm text-muted-foreground hover:underline"
              >
                詳細を見る
              </Link>
            </CardHeader>
            <CardContent>
              <Table className="border-collapse">
                <TableHeader>
                  <TableRow className="border-b border-[#FFFFFF73]">
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      realname
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      username
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      email
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      role
                    </TableHead>
                    <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                      createdAt
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {isLoadingUserTable ? (
                    <TableRow>
                      <td colSpan={5} className="text-center py-4">
                        Loading...
                      </td>
                    </TableRow>
                  ) : (
                    userTable
                      ?.sort(
                        (a: any, b: any) =>
                          new Date(b.createdAt).getTime() -
                          new Date(a.createdAt).getTime(),
                      )
                      .slice(0, 5)
                      .map((user: any) => (
                        <UserListTable
                          key={user.id}
                          realname={user.realname}
                          username={user.username}
                          email={user.email}
                          role={user.role}
                          createdAt={user.createdAt}
                        />
                      ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
          <Card className="dark:border dark:border-white dark:border-opacity-10">
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle>{`クレジット登録`}</CardTitle>
              <Link
                href="/system/credit"
                className="text-sm text-muted-foreground hover:underline"
              >
                詳細を見る
              </Link>
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
                  {isLoadingTrackCreditsHistory ? (
                    <TableRow>
                      <td colSpan={6} className="text-center py-4">
                        Loading...
                      </td>
                    </TableRow>
                  ) : (
                    trackCreditsHistory
                      ?.slice(0, 5)
                      .map((history: any) => (
                        <CreditHistoryTable
                          key={`${history.date}-${history.isrc}-${history.user}`}
                          {...history}
                        />
                      ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
          <Card className="dark:border dark:border-white dark:border-opacity-10">
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle>ポイント履歴</CardTitle>
              <Link
                href="/system/fsp"
                className="text-sm text-muted-foreground hover:underline"
              >
                詳細を見る
              </Link>
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
                  {isLoadingFspHistory ? (
                    <TableRow>
                      <td colSpan={4} className="text-center py-4">
                        Loading...
                      </td>
                    </TableRow>
                  ) : (
                    fspHistory
                      ?.slice(0, 5)
                      .map((history: any) => (
                        <PointHistoryTable
                          key={`${history.date}-${history.from}-${history.to}`}
                          {...history}
                        />
                      ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </div>
      </div>
    </main>
  );
}
