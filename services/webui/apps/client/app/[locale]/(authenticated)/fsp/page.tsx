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
import { useTranslation } from "~/i18n/client";

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
  const { t } = useTranslation();
  const { user } = useUserStore();
  const { data: fspHistoryData } = useQuery(GET_FSP_HISTORY, {
    variables: { userId: user?.id, count: 5 },
  });
  const { data: popularPrizesData } = useQuery(GET_POPULAR_PRIZES);
  const sortedPrizes = popularPrizesData?.getPopularPrizes
    ? [...popularPrizesData.getPopularPrizes].sort(
        (a: any, b: any) => a.point - b.point,
      )
    : [];

  const handleImageError = (e: React.SyntheticEvent<HTMLImageElement>) => {
    e.currentTarget.src = "/logo_visualonly.jpg";
  };

  const { data: userPointBalanceData } = useQuery(GET_USER_POINT_BALANCE, {
    variables: { userId: user?.id },
  });

  return (
    <>
      <div className="w-[60px]">
        <Link href="/dashboard" className="ml-6">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6"
          />
        </Link>
      </div>
      <div className="container mx-auto p-4">
        <hr className="my-8 border-[#303030]" />
        <header className="flex items-center justify-between mb-8">
          <h1 className="text-6xl font-light">{t("fsp.title")}</h1>
        </header>
        <div className="flex gap-6 mb-6">
          <Card className="flex-1">
            <CardHeader>
              <CardTitle className="font-light">
                {t("fsp.point-balance")}
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-2">
              <p className="text-4xl font-light">
                {user?.fspBalance.toLocaleString()}{" "}
                <span className="text-sm">FSP</span>
              </p>
              <p className="font-light">
                <span className="mr-2 text-gray-400">
                  {t("fsp.credential")}
                  <Popover>
                    <PopoverTrigger>
                      <InfoIcon className="inline-block ml-2 mb-1 h-4 w-4 cursor-pointer text-gray-400 hover:text-gray-600" />
                    </PopoverTrigger>
                    <PopoverContent className="w-80">
                      <div className="space-y-2">
                        <h4 className="font-medium">
                          {t("fsp.credential-info")}
                        </h4>
                        <p className="text-sm text-gray-300">
                          {t("fsp.credential-description")}
                        </p>
                      </div>
                    </PopoverContent>
                  </Popover>
                  ：
                </span>
                {userPointBalanceData?.getUserPointBalance
                  .isCredentialAvailable ? (
                  userPointBalanceData?.getUserPointBalance.credentialBalance.toLocaleString()
                ) : (
                  <Link href="/profile">
                    <Button>{t("fsp.unregistered")}</Button>
                  </Link>
                )}
              </p>
            </CardContent>
          </Card>

          <div className="flex-[2] grid grid-cols-2 gap-4 p-6">
            <TransferDialog />
            <PurchaseDialog />
            <AllocationDialog />
          </div>
        </div>

        <hr className="mb-8 mt-24 border-[#303030]" />

        <div className="flex justify-between items-center mb-4">
          <h2 className="text-2xl font-light">{t("fsp.exchangeable-items")}</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-8">
          {!popularPrizesData?.getPopularPrizes ||
          popularPrizesData.getPopularPrizes.length === 0 ? (
            <div className="col-span-full flex justify-center items-center h-40 text-gray-500">
              {t("fsp.no-available-prizes")}
            </div>
          ) : (
            sortedPrizes.map((product: any) => (
              <Card
                key={product.id}
                className="bg-zinc-900 border-zinc-800 text-gray-200 hover:bg-zinc-800 transition-colors"
              >
                <CardContent className="flex items-center gap-4 p-4">
                  <div className="flex-shrink-0">
                    <Image
                      src={product.imageUrl || "/logo_visualonly.jpg"}
                      alt={product.name}
                      width={128}
                      height={128}
                      className="object-cover rounded-lg"
                      onError={handleImageError}
                    />
                  </div>
                  <div className="flex flex-col flex-grow">
                    <h3 className="text-lg font-medium">{product.name}</h3>
                    <p className="text-gray-400">
                      {product.point.toLocaleString()} fsp
                    </p>
                    <div className="flex justify-end mt-auto">
                      <Link href={`/fsp/prize/${product.id}`}>
                        <Button>{t("fsp.details")}</Button>
                      </Link>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </div>

        <hr className="mb-12" />

        <div className="flex justify-between items-center mb-8">
          <h2 className="text-2xl font-light">
            {t("fsp.transaction-history")}
          </h2>
          <Link href="/fsp/history">
            <Button
              variant="link"
              className="text-white px-8 py-4 rounded-full text-sm border border-dashed border-white"
            >
              {t("fsp.view-more")}
            </Button>
          </Link>
        </div>
        <Card>
          <CardContent>
            <ScrollArea className="h-[300px]">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("fsp.transaction.date")}</TableHead>
                    <TableHead>{t("fsp.transaction.type")}</TableHead>
                    <TableHead>{t("fsp.transaction.amount")}</TableHead>
                    <TableHead>{t("fsp.transaction.counterparty")}</TableHead>
                    <TableHead>{t("fsp.transaction.note")}</TableHead>
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
                        {t("fsp.no-transaction-history")}
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
                      ),
                    )
                  )}
                </TableBody>
              </Table>
            </ScrollArea>
          </CardContent>
        </Card>
      </div>
    </>
  );
}
