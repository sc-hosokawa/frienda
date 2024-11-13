"use client";

import { ArrowDownRight, ArrowUpRight } from "lucide-react";
import Image from "next/image";
import { format } from "date-fns";

import { Card } from "@ui/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../../store/user";

interface Transaction {
  id: string;
  amount: number;
  direction: string;
  counterParty: { name: string };
  txAt: string;
}

const GET_FSP_HISTORY = gql`
  query GetFspHistory($userId: String!, $count: Int!) {
    getFspHistoryByUser(userId: $userId, count: $count) {
      transactionList {
        id
        amount
        direction
        counterParty {
          name
        }
        txAt
      }
    }
  }
`;

export default function HistoryPage() {
  const { user } = useUserStore();
  const { data, loading, error } = useQuery(GET_FSP_HISTORY, {
    variables: { userId: user?.id, count: 100 },
  });

  if (loading) {
    return (
      <div className="min-h-screen bg-black text-white p-6 flex items-center justify-center">
        <div className="animate-spin">Loading...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-black text-white p-6 flex items-center justify-center">
        エラーが発生しました
      </div>
    );
  }

  const transactions = data?.getFspHistoryByUser?.transactionList ?? [];

  return (
    <div className="min-h-screen bg-black text-white p-6">
      <div className="max-w-7xl mx-auto">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl">History</h1>
        </div>

        <Card className="w-full bg-black text-white">
          <Table>
            <TableHeader>
              <TableRow className="border-b border-gray-800 hover:bg-transparent">
                <TableHead className="text-gray-400 font-normal">
                  日時
                </TableHead>
                <TableHead className="text-gray-400 font-normal">
                  種類
                </TableHead>
                <TableHead className="text-gray-400 font-normal">
                  取引相手
                </TableHead>
                <TableHead className="text-gray-400 font-normal text-right">
                  ポイント
                </TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {!transactions || transactions.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={4} className="text-center text-gray-500">
                    取引履歴がありません
                  </TableCell>
                </TableRow>
              ) : (
                transactions.map((transaction: Transaction) => (
                  <TableRow
                    key={transaction.id}
                    className="border-b border-gray-800 hover:bg-transparent"
                  >
                    <TableCell className="font-medium text-gray-200">
                      {format(new Date(transaction.txAt), "yyyy/MM/dd HH:mm")}
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div
                          className={`rounded-full p-1.5 ${
                            transaction.direction === "IN"
                              ? "bg-emerald-500/20 text-emerald-500"
                              : "bg-yellow-500/20 text-yellow-500"
                          }`}
                        >
                          {transaction.direction === "IN" ? (
                            <ArrowUpRight className="h-4 w-4" />
                          ) : (
                            <ArrowDownRight className="h-4 w-4" />
                          )}
                        </div>
                        <span className="text-gray-200">
                          ポイント
                          {transaction.direction === "IN" ? "獲得" : "利用"}
                        </span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <span className="text-gray-200">
                          {transaction.counterParty.name}
                        </span>
                      </div>
                    </TableCell>
                    <TableCell
                      className={`text-right ${
                        transaction.direction === "IN"
                          ? "text-emerald-500"
                          : "text-red-500"
                      }`}
                    >
                      {transaction.direction === "IN" ? "+" : "-"}
                      {transaction.amount.toLocaleString()} FSP
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </Card>
      </div>
    </div>
  );
}
