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
import { TransferDialog } from "~/components/dialog/transfer-dialog";
import { AllocationDialog } from "~/components/dialog/allocation-dialog";
import { PurchaseDialog } from "~/components/dialog/purchase-dialog";
import useUserStore from "~/store/user";
import { useQuery, gql } from "@apollo/client";
import dayjs from "dayjs";
import "dayjs/locale/ja";
import timezone from "dayjs/plugin/timezone";
import utc from "dayjs/plugin/utc";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@ui/components/ui/popover";
import { InfoIcon } from "lucide-react";

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.locale("ja");
dayjs.tz.setDefault("Asia/Tokyo");

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
        note
      }
    }
  }
`;

const GET_USER_POINT_BALANCE = gql`
  query GetUserPointBalance($userId: String!) {
    getUserPointBalance(userId: $userId) {
      fspBalanceTemp
      credentialBalance
      isCredentialAvailable
    }
  }
`;

export default function FspPage() {
  const { user } = useUserStore();
  const { data: fspHistoryData } = useQuery(GET_FSP_HISTORY, {
    variables: { userId: user?.id, count: 5 },
  });
  const { data: popularPrizesData } = useQuery(GET_POPULAR_PRIZES);
  const sortedPrizes = popularPrizesData?.getPopularPrizes
    ? [...popularPrizesData.getPopularPrizes].sort(
        (a: any, b: any) => a.point - b.point
      )
    : [];

  const handleImageError = (e: React.SyntheticEvent<HTMLImageElement>) => {
    e.currentTarget.src = "/logo_visualonly.jpg";
  };

  const { data: userPointBalanceData } = useQuery(GET_USER_POINT_BALANCE, {
    variables: { userId: user?.id },
  });

  console.log(userPointBalanceData);

  return (
    <div className="container mx-auto p-4">
      <Card className="mb-6">
        <CardHeader>
          <CardTitle className="font-light">ポイント残高</CardTitle>
        </CardHeader>
        <CardContent className="space-y-2">
          <p className="text-4xl font-light">
            {user?.fspBalance.toLocaleString()} FSP
          </p>
          <p className="font-light">
            <span className="mr-2 text-gray-400">
              クレデンシャル
              <Popover>
                <PopoverTrigger>
                  <InfoIcon className="inline-block ml-2 mb-1 h-4 w-4 cursor-pointer text-gray-400 hover:text-gray-600" />
                </PopoverTrigger>
                <PopoverContent className="w-80">
                  <div className="space-y-2">
                    <h4 className="font-medium">クレデンシャルとは</h4>
                    <p className="text-sm text-gray-300">
                      クレデンシャルは、ブロックチェーン上で発行・管理される貢献証明です。
                      特定の条件を満たすことで取得でき、さまざまな特典を受けることができます。
                      登録はプロフィールページからできます。
                    </p>
                  </div>
                </PopoverContent>
              </Popover>
              ：
            </span>
            {userPointBalanceData?.getUserPointBalance.isCredentialAvailable ? (
              userPointBalanceData?.getUserPointBalance.credentialBalance.toLocaleString()
            ) : (
              <Link href="/profile">
                <Button>未登録</Button>
              </Link>
            )}
          </p>
        </CardContent>
      </Card>

      <div className="grid grid-cols-3 gap-4 mb-6">
        <TransferDialog />
        <PurchaseDialog />
        <AllocationDialog />
      </div>

      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl">交換可能な商品</h2>
        {/* TODO: もっと見るを実装 
        <Link href="/fsp/prize">
          <Button variant="link" className="text-primary">
            もっと見る
          </Button>
        </Link>
        */}
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
        {!popularPrizesData?.getPopularPrizes ||
        popularPrizesData.getPopularPrizes.length === 0 ? (
          <div className="col-span-full flex justify-center items-center h-40 text-gray-500">
            No available prizes
          </div>
        ) : (
          sortedPrizes.map((product: any) => (
            <Card key={product.id}>
              <CardContent className="flex flex-col items-center p-4">
                <Image
                  src={product.imageUrl || "/logo_visualonly.jpg"}
                  alt={product.name}
                  width={128}
                  height={128}
                  className="object-cover mb-2 rounded-lg"
                  onError={handleImageError}
                />
                <h3 className="">{product.name}</h3>
                <p>{product.point.toLocaleString()} fsp</p>
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
                  <TableHead>相手</TableHead>
                  <TableHead>内容</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {!fspHistoryData?.getFspHistoryByUser.transactionList ||
                fspHistoryData.getFspHistoryByUser.transactionList.length ===
                  0 ? (
                  <TableRow>
                    <TableCell
                      colSpan={4}
                      className="text-center text-gray-500"
                    >
                      取引履歴がありません
                    </TableCell>
                  </TableRow>
                ) : (
                  fspHistoryData.getFspHistoryByUser.transactionList.map(
                    (transaction: any) => (
                      <TableRow key={transaction.id}>
                        <TableCell>
                          {dayjs
                            .utc(transaction.txAt)
                            .tz("Asia/Tokyo")
                            .format("YYYY/MM/DD HH:mm:ss")}
                        </TableCell>
                        <TableCell
                          className={
                            transaction.direction === "IN"
                              ? "text-green-600"
                              : "text-red-600"
                          }
                        >
                          {transaction.direction}
                        </TableCell>
                        <TableCell>
                          {transaction.amount.toLocaleString()} fsp
                        </TableCell>
                        <TableCell
                          className={
                            transaction.counterParty.name === "System"
                              ? "text-gray-600"
                              : ""
                          }
                        >
                          {transaction.counterParty.name}
                        </TableCell>
                        <TableCell>{transaction.note}</TableCell>
                      </TableRow>
                    )
                  )
                )}
              </TableBody>
            </Table>
          </ScrollArea>
        </CardContent>
      </Card>
    </div>
  );
}
