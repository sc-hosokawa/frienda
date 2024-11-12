"use client";

import Link from "next/link";
import Image from "next/image";
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
import useUserStore from "../../../store/user";
import { useQuery, gql } from "@apollo/client";
import dayjs from "dayjs";
import "dayjs/locale/ja";
import timezone from "dayjs/plugin/timezone";
import utc from "dayjs/plugin/utc";

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.locale("ja");
dayjs.tz.setDefault("Asia/Tokyo");

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

const GET_POPULAR_PRIZES = gql`
  query GetPopularPrizes {
    getPopularPrizes {
      id
      name
      point
      imgUrl
    }
  }
`;

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

export default function FspPage() {
  const { user } = useUserStore();
  const { data: fspHistoryData } = useQuery(GET_FSP_HISTORY, {
    variables: { userId: user?.id, count: 5 },
  });
  const { data: popularPrizesData } = useQuery(GET_POPULAR_PRIZES);

  console.log(fspHistoryData);

  const handleImageError = (e: React.SyntheticEvent<HTMLImageElement>) => {
    e.currentTarget.src = "/logo_visualonly.jpg";
  };

  return (
    <div className="container mx-auto p-4">
      <Card className="mb-6">
        <CardHeader>
          <CardTitle className="font-light">ポイント残高</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-4xl font-light">{user?.fspBalance} FSP</p>
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
        {!popularPrizesData?.getPopularPrizes ||
        popularPrizesData.getPopularPrizes.length === 0 ? (
          <div className="col-span-full flex justify-center items-center h-40 text-gray-500">
            No available prizes
          </div>
        ) : (
          popularPrizesData.getPopularPrizes.map((product: any) => (
            <Card key={product.id}>
              <CardContent className="flex flex-col items-center p-4">
                <Image
                  src={product.imageUrl || "/logo_visualonly.jpg"}
                  alt={product.name}
                  width={128}
                  height={128}
                  className="object-cover mb-2"
                  onError={handleImageError}
                />
                <h3 className="font-bold">{product.name}</h3>
                <p>{product.points} pt</p>
                <Link href={`/fsp/prize/${product.id}`}>
                  <Button className="mt-2">詳細を見る</Button>
                </Link>
              </CardContent>
            </Card>
          ))
        )}
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
                {fspHistoryData?.getFspHistoryByUser.transactionList.map(
                  (transaction: any) => (
                    <TableRow key={transaction.id}>
                      <TableCell>
                        {dayjs(transaction.txAt)
                          .tz()
                          .format("YYYY/MM/DD HH:mm:ss")}
                      </TableCell>
                      <TableCell>{transaction.direction}</TableCell>
                      <TableCell>{transaction.amount} fsp</TableCell>
                      <TableCell>{transaction.counterParty.name}</TableCell>
                    </TableRow>
                  ),
                )}
              </TableBody>
            </Table>
          </ScrollArea>
        </CardContent>
      </Card>
    </div>
  );
}
