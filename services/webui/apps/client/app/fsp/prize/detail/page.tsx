import Image from "next/image";
import { Info } from "lucide-react";

import { Button } from "@ui/components/ui/button";
import { Card } from "@ui/components/ui/card";

export default function Component() {
  return (
    <div className="min-h-screen bg-black text-white p-6">
      <div className="max-w-6xl mx-auto space-y-8">
        {/* Header */}
        <div className="flex items-center gap-2">
          <h1 className="text-2xl">Product Details</h1>
          <Info className="w-5 h-5 text-gray-400" />
        </div>

        {/* Main Content */}
        <div className="grid lg:grid-cols-2 gap-8">
          {/* Product Image */}
          <Card className="bg-white rounded-lg overflow-hidden">
            <Image
              src="/placeholder.svg?height=400&width=600"
              alt="Product"
              width={600}
              height={400}
              className="w-full h-full object-cover"
            />
          </Card>

          {/* Product Info */}
          <div className="space-y-6">
            <h2 className="text-xl">商品名が入ります</h2>
            <div className="flex items-center gap-2">
              <span className="text-gray-400">必要ポイント</span>
              <span className="text-xl">1,000 Pt</span>
            </div>
            <Button className="w-full bg-[#E6DFD1] text-black hover:bg-[#D6CFB1]">
              この商品をポイントと交換する
              <span className="ml-2">1,000pt</span>
            </Button>
            <p className="text-gray-300 leading-relaxed">
              ここにオファーの概要が入ります。音楽シーンを盛り上げるための特別なイベントに参加してくれるアーティストを大募集しています！このイベントは、あなたの音楽を新しいリスナーに届ける絶好のチャンスです。才能あふれるアーティスト同士が集まり、共にクリエイティブなコラボレーションを楽しみながら、音楽の未来を切り開きましょう。
            </p>
            <p className="text-gray-300 leading-relaxed">
              参加者は、経験豊富なプロフェッショナルとネットワークを広げるだけでなく、音楽業界での知名度を高める貴重な機会を得ることができます。あなたの音楽が、多くのリスナーに響き渡る瞬間を一緒に作り上げませんか？是非、この素晴らしい機会をお見逃しなく！
            </p>
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
