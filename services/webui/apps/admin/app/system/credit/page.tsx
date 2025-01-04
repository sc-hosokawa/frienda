"use client";

import React from "react";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_TRACK_CREDITS_HISTORY } from "../../../utils/query";
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
import { CreditHistoryTable } from "../../../components/system/credit-history-table";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { MoreVertical } from "lucide-react";

export default function CreditHistoryPage() {
  const { data: trackCreditsHistory, isLoading } = useQuery({
    queryKey: ["trackCreditsHistory"],
    queryFn: async () => {
      return await request(endpoint, GET_TRACK_CREDITS_HISTORY, {
        count: 100,
      }).then((data: any) => data.getTrackCreditsHistoryForAdmin);
    },
  });

  const downloadCreditHistoryCSV = () => {
    if (!trackCreditsHistory) return;

    const headers = ["date", "isrc", "user", "role", "name", "email"];
    const csvContent = [
      headers.join(","),
      ...trackCreditsHistory.map((history: any) =>
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

  return (
    <main className="p-6">
      <Card className="dark:border dark:border-white dark:border-opacity-10">
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle>クレジット登録履歴</CardTitle>
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
              {isLoading ? (
                <TableRow>
                  <td colSpan={6} className="text-center py-4">
                    Loading...
                  </td>
                </TableRow>
              ) : (
                trackCreditsHistory?.map((history: any) => (
                  <CreditHistoryTable key={history.id} {...history} />
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </main>
  );
}
