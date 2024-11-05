"use client";

import { Suspense } from "react";
import Image from "next/image";
import Link from "next/link";
import { Card, CardContent } from "@ui/components/ui/card";
import { useQuery, gql } from "@apollo/client";

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
  const { loading, error, data } = useQuery(GET_POPULAR_PRIZES);

  if (loading) return <ProductSkeleton />;
  if (error) return <div>Error loading products</div>;
  if (!data.getPopularPrizes || data.getPopularPrizes.length === 0) {
    return (
      <div className="h-40 flex items-center justify-center text-gray-400">
        No data
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {data.getPopularPrizes.map((product: any, i: number) => (
        <Card
          key={i}
          className="bg-gray-800 border-0 overflow-hidden hover:bg-gray-700 transition-colors"
        >
          <CardContent className="p-0">
            <Link href="#" className="block">
              <Image
                src={product.imgUrl}
                alt={product.name}
                width={600}
                height={400}
                className="aspect-[4/3] object-cover"
              />
              <div className="p-4 space-y-3">
                <h3 className="font-medium line-clamp-2 text-white">
                  {product.name}
                </h3>
                <p className="text-sm text-gray-300 line-clamp-2">
                  {product.name}
                </p>
                <div className="flex items-center gap-2 text-white">
                  <span className="text-sm">必要ポイント</span>
                  <span className="font-medium">
                    {product.point.toLocaleString()} Pt
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
