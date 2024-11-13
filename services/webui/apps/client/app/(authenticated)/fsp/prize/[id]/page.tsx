"use client";

import Image from "next/image";
import Link from "next/link";
import { ArrowLeft } from "lucide-react";
import { Button } from "@ui/components/ui/button";
import { Card } from "@ui/components/ui/card";
import { useQuery, gql, useMutation } from "@apollo/client";
import useUserStore from "../../../../../store/user";
import { useRouter } from "next/navigation";

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

export default function PrizeDetailPage({
  params,
}: {
  params: { id: string };
}) {
  const router = useRouter();
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

  return (
    <div className="min-h-screen bg-black text-white p-6">
      <div className="max-w-6xl mx-auto space-y-8">
        {/* Header */}
        <div className="flex items-center gap-2">
          <Link href="/fsp" className="hover:opacity-80">
            <ArrowLeft className="w-6 h-6" />
          </Link>
          <h1 className="text-2xl font-light">Product Details</h1>
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
            <Button
              className="w-full bg-white text-black hover:bg-white/80"
              onClick={async () => {
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
                    router.push("/fsp");
                  } catch (error) {
                    console.error("Prize exchange failed:", error);
                  }
                }
              }}
            >
              この商品をポイントと交換する
              <span className="ml-2">
                {data?.getPrizeDetail?.point.toLocaleString()} fsp
              </span>
            </Button>
            <p className="leading-relaxed">
              {data?.getPrizeDetail?.description}
            </p>
            <div className="flex items-center gap-2">
              <span className="text-gray-400">条件</span>
              <span className="text-sm text-gray-300">
                {data?.getPrizeDetail?.condition}
              </span>
            </div>
          </div>
        </div>

        {/* Similar Products 
        <div className="space-y-6">
          <h2 className="text-2xl">Similar Products</h2>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {[1, 2, 3].map((i) => (
              <Card key={i} className="bg-black border border-gray-800">
                <Image
                  src="/placeholder.svg?height=200&width=400"
                  alt={`Similar Product ${i}`}
                  width={400}
                  height={200}
                  className="w-full h-48 object-cover"
                />
                <div className="p-4 space-y-4">
                  <h3 className="text-lg">SNS広告代行（1ヶ月）商品名が入ります。</h3>
                  <p className="text-sm text-gray-400">
                    2行目でテキストが長い場合はこのようになります...
                  </p>
                  <p className="text-sm text-gray-300">
                    あなたのアーティスト活動を多くの人に知ってもらうチャンスです。SNSの広告代行では、あなたの選択する...
                  </p>
                  <div className="flex items-center gap-2">
                    <span className="text-sm text-gray-400">必要ポイント</span>
                    <span>1,000 Pt</span>
                  </div>
                </div>
              </Card>
            ))}
          </div>
        </div>
*/}
      </div>
    </div>
  );
}
