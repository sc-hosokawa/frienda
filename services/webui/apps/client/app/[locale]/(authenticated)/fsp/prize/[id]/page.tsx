"use client";

import Image from "next/image";
import Link from "next/link";
import { ArrowLeft } from "lucide-react";
import { Button } from "@ui/components/ui/button";
import { Card } from "@ui/components/ui/card";
import { useQuery, gql, useMutation } from "@apollo/client";
import useUserStore from "~/store/user";
import { useRouter } from "next/navigation";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@ui/components/ui/tabs";
import { useTranslation } from "~/i18n/client";

const GET_PRIZE_DETAIL = gql`
  query GetPrizeDetail($prizeId: Int!) {
    getPrizeDetail(prizeId: $prizeId) {
      id
      imgUrl
      name
      point
      description
      representation
      condition
    }
  }
`;

const GET_USER_POINT_BALANCE = gql`
  query GetUserPointBalance($userId: String!) {
    getUserPointBalance(userId: $userId) {
      fspBalance
    }
  }
`;

const GET_PRIZES_BY_USER = gql`
  query GetPrizesByUser($userId: String!) {
    getPrizeByUserId(userId: $userId) {
      usedPrizeList {
        id
        name
        point
        description
        representation
      }
      unusedPrizeList {
        id
        name
        point
        description
        representation
      }
      requestedPrizeList {
        id
        name
        point
        description
      }
    }
  }
`;

const REQUEST_PRIZE = gql`
  mutation RequestPrize($input: RequestPrizeInput!) {
    requestPrize(input: $input) {
      id
    }
  }
`;

const USE_PRIZE = gql`
  mutation UsePrize($input: UsePrizeInput!) {
    usePrize(input: $input) {
      id
    }
  }
`;

const GET_PRIZE_HISTORY_BY_USER = gql`
  query GetPrizeHistoryByUser($userId: String!, $prizeId: Int!) {
    getPrizeHistoryByUserId(userId: $userId, prizeId: $prizeId) {
      unusedHistory {
        id
        prizeId
        userId
        imgUrl
        username
        realname
        email
        pointUsed
        amount
        exchangedAt
      }
      requestedHistory {
        id
        prizeId
        userId
        imgUrl
        username
        realname
        email
        pointUsed
        amount
        exchangedAt
        requestedAt
      }
      usedHistory {
        id
        prizeId
        userId
        imgUrl
        username
        realname
        email
        pointUsed
        amount
        exchangedAt
        usedAt
      }
    }
  }
`;

export default function PrizeDetailPage({
  params,
}: {
  params: { id: string };
}) {
  const router = useRouter();
  const { t } = useTranslation();
  const prizeId = parseInt(params.id);
  const { loading, error, data } = useQuery(GET_PRIZE_DETAIL, {
    variables: { prizeId },
  });
  const { user, updateBalance } = useUserStore();

  const [exchangePrize] = useMutation(gql`
    mutation ExchangePrize($input: ExchangePrizeInput!) {
      exchangePrize(input: $input) {
        id
        txId
      }
    }
  `);

  // クエリフックを追加
  const { refetch } = useQuery(GET_USER_POINT_BALANCE, {
    variables: { userId: user?.id },
    skip: !user?.id,
    onCompleted: (data) => {
      updateBalance(data.getUserPointBalance.fspBalance);
    },
  });

  // Add query for prize history
  const { data: prizeHistory, refetch: refetchPrizeHistory } = useQuery(
    GET_PRIZES_BY_USER,
    {
      variables: { userId: user?.id },
      skip: !user?.id,
    },
  );

  const [requestPrize] = useMutation(REQUEST_PRIZE);
  const [usePrize] = useMutation(USE_PRIZE);

  // 管理者かどうかのチェック
  const isAdmin = user?.id === data?.getPrizeDetail?.representation;

  // Add query for prize history inside the component
  const { data: prizeHistoryData, refetch: refetchPrizeHistoryByUserId } =
    useQuery(GET_PRIZE_HISTORY_BY_USER, {
      variables: { userId: user?.id, prizeId: prizeId },
      skip: !user?.id || !isAdmin,
      fetchPolicy: "network-only",
    });

  console.log("isAdmin", isAdmin);
  console.log("userid", user?.id);

  console.log(
    "unusedHistory",
    prizeHistoryData?.getPrizeHistoryByUserId.unusedHistory,
  );
  console.log(
    "requestedHistory",
    prizeHistoryData?.getPrizeHistoryByUserId.requestedHistory,
  );
  console.log(
    "usedHistory",
    prizeHistoryData?.getPrizeHistoryByUserId.usedHistory,
  );

  // Add this function at the component level
  const handleImageError = (
    e: React.SyntheticEvent<HTMLImageElement, Event>,
  ) => {
    e.currentTarget.src = "/logo_visualonly.jpg";
  };

  // Add these helper functions at the component level
  const groupHistoryByUser = (histories: any[]) => {
    return histories.reduce((acc: any, curr: any) => {
      const key = curr.userId;
      if (!acc[key]) {
        acc[key] = {
          ...curr,
          amount: 0,
        };
      }
      acc[key].amount += curr.amount;
      return acc;
    }, {});
  };

  return (
    <div className="min-h-screen bg-black text-white p-6">
      <div className="max-w-6xl mx-auto space-y-8">
        {/* Header */}
        <div className="flex items-center gap-2">
          <Link href="/fsp" className="hover:opacity-80">
            <ArrowLeft className="w-6 h-6" />
          </Link>
          <h1 className="text-2xl font-light">{t("prize.product-details")}</h1>
        </div>

        {/* Main Content */}
        <div className="grid lg:grid-cols-2 gap-8">
          {/* Product Image */}
          <Card className="bg-white rounded-lg overflow-hidden">
            <Image
              src={data?.getPrizeDetail?.imgUrl || "/logo_visualonly.jpg"}
              alt="Product"
              width={600}
              height={400}
              className="w-full h-full object-cover"
            />
          </Card>

          {/* Product Info */}
          <div className="space-y-6">
            <h2 className="text-xl">{data?.getPrizeDetail?.name}</h2>
            <div className="flex items-center gap-2">
              <span className="text-gray-400">必要ポイント</span>
              <span className="text-xl">
                {data?.getPrizeDetail?.point.toLocaleString()} fsp
              </span>
            </div>
            {!isAdmin ? (
              <Button
                className="w-full bg-white text-black hover:bg-white/80 disabled:opacity-50 disabled:cursor-not-allowed"
                disabled={(user?.fspBalance ?? 0) < data?.getPrizeDetail?.point}
                onClick={async () => {
                  if ((user?.fspBalance ?? 0) < data?.getPrizeDetail?.point) {
                    alert("ポイント残高が不足しています。");
                    return;
                  }
                  if (
                    confirm(
                      `${data?.getPrizeDetail?.name}を${data?.getPrizeDetail?.point.toLocaleString()} fspで交換しますか？`,
                    )
                  ) {
                    try {
                      const response = await exchangePrize({
                        variables: {
                          input: {
                            userId: user?.id,
                            prizeId: parseInt(params.id),
                            amount: 1,
                          },
                        },
                      });
                      console.log(response);
                      console.log("refetch");
                      const { data: newBalance } = await refetch();
                      console.log("newBalance", newBalance);
                      updateBalance(newBalance.getUserPointBalance.fspBalance);

                      alert(
                        "交換が完了しました。\n" +
                          "交換ID: " +
                          response.data.exchangePrize.txId,
                      );
                      refetchPrizeHistory();
                    } catch (error) {
                      console.error("Prize exchange failed:", error);
                    }
                  }
                }}
              >
                この景品をポイントと交換する
                <span className="ml-2">
                  {data?.getPrizeDetail?.point.toLocaleString()} fsp
                </span>
              </Button>
            ) : (
              <Dialog>
                <DialogTrigger asChild>
                  <Button className="w-full bg-white text-black hover:bg-white/80 relative">
                    管理者メニュー
                    {prizeHistoryData?.getPrizeHistoryByUserId?.requestedHistory?.filter(
                      (history: any) => history.prizeId === prizeId,
                    ).length > 0 && (
                      <span className="absolute -top-1 -right-1 w-3 h-3 bg-red-500 rounded-full" />
                    )}
                  </Button>
                </DialogTrigger>
                <DialogContent className="max-w-4xl bg-black text-white border border-white/20">
                  <DialogHeader>
                    <DialogTitle>管理者メニュー</DialogTitle>
                  </DialogHeader>
                  <Tabs defaultValue="exchanged" className="w-full">
                    <TabsList className="bg-black border border-white/20">
                      <TabsTrigger value="exchanged">
                        {t("prize.exchanged-users")}
                      </TabsTrigger>
                      <TabsTrigger value="requested">
                        {t("prize.requested-users")}
                      </TabsTrigger>
                      <TabsTrigger value="used">
                        {t("prize.used-history")}
                      </TabsTrigger>
                    </TabsList>
                    <TabsContent value="exchanged" className="mt-4">
                      <Card className="bg-black border border-white/20 p-6">
                        <div className="space-y-4 max-h-[60vh] overflow-y-auto">
                          {(() => {
                            const filteredHistory =
                              prizeHistoryData?.getPrizeHistoryByUserId?.unusedHistory?.filter(
                                (history: any) => history.prizeId === prizeId,
                              );
                            const groupedHistory = groupHistoryByUser(
                              filteredHistory || [],
                            );

                            return Object.values(groupedHistory).length ===
                              0 ? (
                              <div className="text-center text-gray-400 py-4">
                                {t("prize.no-users")}
                              </div>
                            ) : (
                              Object.values(groupedHistory).map(
                                (history: any, index: number) => (
                                  <div
                                    key={index}
                                    className="flex justify-between items-center p-4 border-b border-white/10"
                                  >
                                    <div className="flex items-center gap-4">
                                      <div className="w-10 h-10 rounded-full overflow-hidden">
                                        <Image
                                          src={
                                            history.imgUrl ||
                                            "/logo_visualonly.jpg"
                                          }
                                          alt={history.username}
                                          width={40}
                                          height={40}
                                          className="w-full h-full object-cover"
                                          onError={handleImageError}
                                          priority={false}
                                        />
                                      </div>
                                      <div className="flex flex-col">
                                        <span className="font-medium">
                                          {history.username}
                                        </span>
                                        <span className="text-sm text-gray-400">
                                          {history.realname}
                                        </span>
                                        <span className="text-sm text-gray-400">
                                          {history.email}
                                        </span>
                                      </div>
                                    </div>
                                    <div className="flex items-center gap-4">
                                      <span className="text-sm text-gray-400">
                                        {t("prize.last-exchange")}:{" "}
                                        {new Date(
                                          history.exchangedAt,
                                        ).toLocaleDateString()}
                                      </span>
                                      <span className="text-sm font-medium">
                                        {t("prize.total")}: {history.amount}
                                        {t("prize.items")}
                                      </span>
                                    </div>
                                  </div>
                                ),
                              )
                            );
                          })()}
                        </div>
                      </Card>
                    </TabsContent>
                    <TabsContent value="requested" className="mt-4">
                      <Card className="bg-black border border-white/20 p-6">
                        <div className="space-y-4 max-h-[60vh] overflow-y-auto">
                          {/* Requested Users List content */}
                          {prizeHistoryData?.getPrizeHistoryByUserId?.requestedHistory?.filter(
                            (history: any) => history.prizeId === prizeId,
                          ).length === 0 ? (
                            <div className="text-center text-gray-400 py-4">
                              {t("prize.no-users")}
                            </div>
                          ) : (
                            prizeHistoryData?.getPrizeHistoryByUserId?.requestedHistory
                              ?.filter(
                                (history: any) => history.prizeId === prizeId,
                              )
                              .map((history: any, index: number) => (
                                <div
                                  key={index}
                                  className="flex justify-between items-center p-4 border-b border-white/10"
                                >
                                  <div className="flex items-center gap-4">
                                    <div className="w-10 h-10 rounded-full overflow-hidden">
                                      <Image
                                        src={
                                          history.imgUrl ||
                                          "/logo_visualonly.jpg"
                                        }
                                        alt={history.username}
                                        width={40}
                                        height={40}
                                        className="w-full h-full object-cover"
                                        onError={handleImageError}
                                        priority={false}
                                      />
                                    </div>
                                    <div className="flex flex-col">
                                      <span className="font-medium">
                                        {history.username}
                                      </span>
                                      <span className="text-sm text-gray-400">
                                        {history.realname}
                                      </span>
                                      <span className="text-sm text-gray-400">
                                        {history.email}
                                      </span>
                                    </div>
                                  </div>
                                  <div className="flex items-center gap-4">
                                    <span className="text-sm text-gray-400">
                                      {t("prize.request-date")}:{" "}
                                      {new Date(
                                        history.requestedAt,
                                      ).toLocaleDateString()}
                                    </span>
                                    <Button
                                      className="bg-white text-black hover:bg-white/80"
                                      onClick={async () => {
                                        if (
                                          confirm(
                                            t("prize.approve-confirmation"),
                                          )
                                        ) {
                                          try {
                                            await usePrize({
                                              variables: {
                                                input: {
                                                  representationUserId:
                                                    user?.id,
                                                  userId: history.userId,
                                                  prizeId: prizeId,
                                                },
                                              },
                                            });
                                            alert(t("prize.approve-success"));
                                            refetchPrizeHistoryByUserId();
                                          } catch (error) {
                                            console.error(
                                              "Prize use approval failed:",
                                              error,
                                            );
                                            alert(t("prize.approve-error"));
                                          }
                                        }
                                      }}
                                    >
                                      {t("prize.approve-button")}
                                    </Button>
                                  </div>
                                </div>
                              ))
                          )}
                        </div>
                      </Card>
                    </TabsContent>
                    <TabsContent value="used" className="mt-4">
                      <Card className="bg-black border border-white/20 p-6">
                        <div className="space-y-4 max-h-[60vh] overflow-y-auto">
                          {(() => {
                            const filteredHistory =
                              prizeHistoryData?.getPrizeHistoryByUserId?.usedHistory?.filter(
                                (history: any) => history.prizeId === prizeId,
                              );
                            const groupedHistory = groupHistoryByUser(
                              filteredHistory || [],
                            );

                            return Object.values(groupedHistory).length ===
                              0 ? (
                              <div className="text-center text-gray-400 py-4">
                                {t("prize.no-users")}
                              </div>
                            ) : (
                              Object.values(groupedHistory).map(
                                (history: any, index: number) => (
                                  <div
                                    key={index}
                                    className="flex justify-between items-center p-4 border-b border-white/10"
                                  >
                                    <div className="flex items-center gap-4">
                                      <div className="w-10 h-10 rounded-full overflow-hidden">
                                        <Image
                                          src={
                                            history.imgUrl ||
                                            "/logo_visualonly.jpg"
                                          }
                                          alt={history.username}
                                          width={40}
                                          height={40}
                                          className="w-full h-full object-cover"
                                          onError={handleImageError}
                                          priority={false}
                                        />
                                      </div>
                                      <div className="flex flex-col">
                                        <span className="font-medium">
                                          {history.username}
                                        </span>
                                        <span className="text-sm text-gray-400">
                                          {history.realname}
                                        </span>
                                        <span className="text-sm text-gray-400">
                                          {history.email}
                                        </span>
                                      </div>
                                    </div>
                                    <div className="flex items-center gap-4">
                                      <span className="text-sm text-gray-400">
                                        {t("prize.last-use")}:{" "}
                                        {new Date(
                                          history.usedAt,
                                        ).toLocaleDateString()}
                                      </span>
                                      <span className="text-sm font-medium">
                                        {t("prize.total")}: {history.amount}
                                        {t("prize.items")}
                                      </span>
                                    </div>
                                  </div>
                                ),
                              )
                            );
                          })()}
                        </div>
                      </Card>
                    </TabsContent>
                  </Tabs>
                </DialogContent>
              </Dialog>
            )}
            <p className="leading-relaxed">
              {data?.getPrizeDetail?.description}
            </p>
            <div className="flex items-center gap-2">
              <span className="text-gray-400">{t("prize.condition")}</span>
              <span className="text-sm text-gray-300">
                {data?.getPrizeDetail?.condition}
              </span>
            </div>
          </div>
        </div>

        {/* Add Prize History section after the main content */}
        <div className="mt-12">
          {/* Prize History for current prize - Only show if not admin */}
          {!isAdmin && (
            <div className="mb-8">
              <div className="grid gap-4">
                <Card className="bg-black border border-white/20 p-6">
                  <div className="flex flex-col space-y-4">
                    <div className="flex justify-between items-center">
                      <div className="flex space-x-8 text-sm text-gray-400">
                        <div>
                          <span>{t("prize.exchanged-count")}: </span>
                          <span className="text-white">
                            {prizeHistory?.getPrizeByUserId?.unusedPrizeList?.filter(
                              (prize: any) => prize.id === prizeId,
                            ).length || 0}
                          </span>
                        </div>
                        <div>
                          <span>{t("prize.requested-count")}: </span>
                          <span className="text-white">
                            {prizeHistory?.getPrizeByUserId?.requestedPrizeList?.filter(
                              (prize: any) => prize.id === prizeId,
                            ).length || 0}
                          </span>
                        </div>
                        <div>
                          <span>{t("prize.used-count")}: </span>
                          <span className="text-white">
                            {prizeHistory?.getPrizeByUserId?.usedPrizeList?.filter(
                              (prize: any) => prize.id === prizeId,
                            ).length || 0}
                          </span>
                        </div>
                      </div>

                      {prizeHistory?.getPrizeByUserId?.unusedPrizeList?.filter(
                        (prize: any) => prize.id === prizeId,
                      ).length > 0 && (
                        <Button
                          className="bg-white text-black hover:bg-white/80 px-6"
                          onClick={async () => {
                            console.log(
                              prizeHistory?.getPrizeByUserId?.unusedPrizeList[0]
                                .representation,
                            );
                            if (confirm(t("prize.request-use-confirmation"))) {
                              try {
                                const response = await requestPrize({
                                  variables: {
                                    input: {
                                      userId: user?.id,
                                      prizeId: prizeId,
                                    },
                                  },
                                });
                                console.log(response);
                                alert(t("prize.request-use-success"));
                                refetchPrizeHistory();
                              } catch (error) {
                                console.error("Prize use failed:", error);
                                alert(t("prize.request-use-error"));
                              }
                            }
                          }}
                        >
                          {t("prize.request-use")}
                        </Button>
                      )}
                    </div>
                  </div>
                </Card>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
