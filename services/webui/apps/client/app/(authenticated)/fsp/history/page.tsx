"use client";

import { ArrowDownRight, ArrowUpRight } from "lucide-react";
import Image from "next/image";

import { Card } from "@ui/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";

export default function HistoryPage() {
  const transactions = [
    {
      date: "2024/7/15",
      type: "獲得",
      content: "オファー名が入ります。オファー名が入ります。一緒にイベント...",
      user: {
        name: "brady_nakayama",
        avatar: "/home.svg?height=32&width=32",
      },
      points: 200,
      isGain: true,
    },
    {
      date: "2024/7/15",
      type: "利用",
      content: "オファー名が入ります。オファー名が入ります。一緒にイベント...",
      user: {
        name: "brady_nakayama",
        avatar: "/home.svg?height=32&width=32",
      },
      points: 1000,
      isGain: false,
    },
    {
      date: "2024/7/15",
      type: "利用",
      content: "オファー名が入ります。オファー名が入ります。一緒にイベント...",
      user: {
        name: "brady_nakayama",
        avatar: "/home.svg?height=32&width=32",
      },
      points: 1000,
      isGain: false,
    },
    {
      date: "2024/7/15",
      type: "獲得",
      content: "オファー名が入ります。オファー名が入ります。一緒にイベント...",
      user: {
        name: "brady_nakayama",
        avatar: "/home.svg?height=32&width=32",
      },
      points: 200,
      isGain: true,
    },
  ];

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
                  内容
                </TableHead>
                <TableHead className="text-gray-400 font-normal">
                  取引
                </TableHead>
                <TableHead className="text-gray-400 font-normal text-right">
                  ポイント
                </TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {transactions.map((transaction, index) => (
                <TableRow
                  key={index}
                  className="border-b border-gray-800 hover:bg-transparent"
                >
                  <TableCell className="font-medium text-gray-200">
                    {transaction.date}
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center gap-2">
                      <div
                        className={`rounded-full p-1.5 ${
                          transaction.isGain
                            ? "bg-emerald-500/20 text-emerald-500"
                            : "bg-yellow-500/20 text-yellow-500"
                        }`}
                      >
                        {transaction.isGain ? (
                          <ArrowUpRight className="h-4 w-4" />
                        ) : (
                          <ArrowDownRight className="h-4 w-4" />
                        )}
                      </div>
                      <span className="text-gray-200">
                        ポイント{transaction.type}
                      </span>
                    </div>
                  </TableCell>
                  <TableCell className="text-gray-200">
                    {transaction.content}
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center gap-2">
                      <Image
                        src={transaction.user.avatar}
                        alt={`${transaction.user.name}'s avatar`}
                        className="rounded-full"
                        width={24}
                        height={24}
                      />
                      <span className="text-gray-200">
                        {transaction.user.name}
                      </span>
                    </div>
                  </TableCell>
                  <TableCell
                    className={`text-right ${transaction.isGain ? "text-emerald-500" : "text-red-500"}`}
                  >
                    {transaction.isGain ? "+" : "-"}
                    {transaction.points.toLocaleString()}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </Card>
      </div>
    </div>
  );
}
