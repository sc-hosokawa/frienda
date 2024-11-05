import { Suspense } from "react";
import Image from "next/image";
import Link from "next/link";
import { Card, CardContent } from "@ui/components/ui/card";

// Simulated data fetch
async function getProducts() {
  await new Promise((resolve) => setTimeout(resolve, 2000)); // Simulate loading
  return Array(6).fill({
    title: "SNS広告代行（1ヶ月）商品名が入ります。",
    description:
      "あなたのアーティスト活動を多くの人に知ってもらうチャンスです。SNSの広告代行では、あなたの選択する音楽を...",
    points: 1000,
    image: "/placeholder.svg?height=400&width=600",
  });
}

function ProductSkeleton() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {Array(3)
        .fill(0)
        .map((_, i) => (
          <Card key={i} className="bg-gray-800 border-0">
            <CardContent className="p-0">
              <div className="aspect-[4/3] bg-gray-700 animate-pulse" />
              <div className="p-4 space-y-3">
                <div className="h-4 bg-gray-700 animate-pulse rounded" />
                <div className="space-y-2">
                  <div className="h-3 bg-gray-700 animate-pulse rounded w-[90%]" />
                  <div className="h-3 bg-gray-700 animate-pulse rounded w-[70%]" />
                </div>
                <div className="h-4 bg-gray-700 animate-pulse rounded w-24" />
              </div>
            </CardContent>
          </Card>
        ))}
    </div>
  );
}

async function ProductList() {
  const products = await getProducts();

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {products.map((product, i) => (
        <Card
          key={i}
          className="bg-gray-800 border-0 overflow-hidden hover:bg-gray-700 transition-colors"
        >
          <CardContent className="p-0">
            <Link href="#" className="block">
              <Image
                src={product.image}
                alt={product.title}
                width={600}
                height={400}
                className="aspect-[4/3] object-cover"
              />
              <div className="p-4 space-y-3">
                <h3 className="font-medium line-clamp-2 text-white">
                  {product.title}
                </h3>
                <p className="text-sm text-gray-300 line-clamp-2">
                  {product.description}
                </p>
                <div className="flex items-center gap-2 text-white">
                  <span className="text-sm">必要ポイント</span>
                  <span className="font-medium">
                    {product.points.toLocaleString()} Pt
                  </span>
                </div>
              </div>
            </Link>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}

export default function Component() {
  return (
    <div className="bg-black min-h-screen text-white p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        <h2 className="text-2xl font-medium">利用可能な商品</h2>
        <Suspense fallback={<ProductSkeleton />}>
          <ProductList />
        </Suspense>
      </div>
    </div>
  );
}
