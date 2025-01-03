"use client";

import React from "react";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_FSP_HISTORY } from "../../../utils/query";
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
import { PointHistoryTable } from "../../../components/system/point-history-table";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { MoreVertical } from "lucide-react";

export default function FspHistoryPage() {
  const { data: fspHistory, isLoading } = useQuery({
    queryKey: ["fspHistory"],
    queryFn: async () => {
      return await request(endpoint, GET_FSP_HISTORY, {
        count: 100,
      }).then((data: any) => data.getFspHistoryForAdmin);
    },
  });

  const downloadPointHistoryCSV = () => {
    if (!fspHistory) return;

    const headers = ["date", "from", "to", "amount"];
    const csvContent = [
      headers.join(","),
      ...fspHistory.map((history: any) =>
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
    <main className="p-6">
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
              {isLoading ? (
                <TableRow>
                  <td colSpan={4} className="text-center py-4">
                    Loading...
                  </td>
                </TableRow>
              ) : (
                fspHistory?.map((history: any) => (
                  <PointHistoryTable key={history.id} {...history} />
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </main>
  );
}
