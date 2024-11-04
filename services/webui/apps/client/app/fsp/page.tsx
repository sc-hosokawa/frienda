"use client";

import { useState } from "react";
import Link from "next/link";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import { Button } from "@ui/components/ui/button";
import { ScrollArea } from "@ui/components/ui/scroll-area";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { TransferDialog } from "./transfer-dialog";
import { AllocationDialog } from "./allocation-dialog";
import { PurchaseDialog } from "./purchase-dialog";

// 商品データの型定義
type Product = {
  id: number;
  name: string;
  points: number;
  imageUrl: string;
};

// 取引履歴の型定義
type Transaction = {
  id: number;
  type: "send" | "receive" | "exchange";
  amount: number;
  date: string;
  description: string;
};

// ダミーデータ
const products: Product[] = [
  {
    id: 1,
    name: "商品A",
    points: 500,
    imageUrl: "/placeholder.svg?height=100&width=100",
  },
  {
    id: 2,
    name: "商品B",
    points: 1000,
    imageUrl: "/placeholder.svg?height=100&width=100",
  },
  {
    id: 3,
    name: "商品C",
    points: 1500,
    imageUrl: "/placeholder.svg?height=100&width=100",
  },
];

const transactions: Transaction[] = [
  {
    id: 1,
    type: "receive",
    amount: 100,
    date: "2023-11-01",
    description: "ログインボーナス",
  },
  {
    id: 2,
    type: "send",
    amount: 50,
    date: "2023-11-02",
    description: "友達にポイント送信",
  },
  {
    id: 3,
    type: "exchange",
    amount: 500,
    date: "2023-11-03",
    description: "商品Aと交換",
  },
];

export default function Component() {
  const [balance, setBalance] = useState(2000);

  return (
    <div className="container mx-auto p-4">
      <Card className="mb-6">
        <CardHeader>
          <CardTitle>ポイント残高</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-4xl font-bold">{balance} pt</p>
        </CardContent>
      </Card>

      <div className="grid grid-cols-3 gap-4 mb-6">
        <TransferDialog />
        <PurchaseDialog />
        <AllocationDialog />
      </div>

      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl">交換可能な商品</h2>
        <Link href="/fsp/prize">
          <Button variant="link" className="text-primary">
            もっと見る
          </Button>
        </Link>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
        {products.map((product) => (
          <Card key={product.id}>
            <CardContent className="flex flex-col items-center p-4">
              <img
                src={product.imageUrl}
                alt={product.name}
                className="w-24 h-24 object-cover mb-2"
              />
              <h3 className="font-bold">{product.name}</h3>
              <p>{product.points} pt</p>
              <Link href={`/fsp/prize/${product.id}`}>
                <Button className="mt-2">詳細を見る</Button>
              </Link>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl">取引履歴</h2>
        <Link href="/fsp/history">
          <Button variant="link" className="text-primary">
            もっと見る
          </Button>
        </Link>
      </div>
      <Card>
        <CardContent>
          <ScrollArea className="h-[300px]">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>日付</TableHead>
                  <TableHead>種類</TableHead>
                  <TableHead>金額</TableHead>
                  <TableHead>説明</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {transactions.map((transaction) => (
                  <TableRow key={transaction.id}>
                    <TableCell>{transaction.date}</TableCell>
                    <TableCell>{transaction.type}</TableCell>
                    <TableCell>{transaction.amount} pt</TableCell>
                    <TableCell>{transaction.description}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </ScrollArea>
        </CardContent>
      </Card>
    </div>
  );
}
