"use client";

import { useState } from "react";
import { Card } from "@ui/components/ui/card";
import { Skeleton } from "@ui/components/ui/skeleton";
import Image from "next/image";
import { gql, useQuery } from "@apollo/client";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useTranslation } from "~/i18n/client";
import { Input } from "@ui/components/ui/input";
import { ArrowDownUp } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuContent,
} from "@ui/components/ui/dropdown-menu";
import { Button } from "@ui/components/ui/button";
import {
  SearchOfferDialog,
  SearchOfferOptions,
} from "~/components/dialog/search-offer-dialog";

const SEARCH_OFFERS = gql`
  query searchOffers($query: String!, $options: SearchOptionsOffersInput!) {
    searchOffers(query: $query, options: $options) {
      offerList {
        id
        title
        description
        imageUrl
        fee
        category
      }
    }
  }
`;

// インターフェースを更新
interface Offer {
  id: string;
  title: string;
  description: string;
  imageUrl?: string;
  fee: number;
  category: string;
}

// カテゴリーに応じた背景色を返す関数を定義
const getCategoryBackgroundColor = (category: string | undefined | null) => {
  switch (category) {
    case "Creation":
      return "bg-orange-500";
    case "Event":
      return "bg-green-500";
    case "Promotion":
      return "bg-yellow-500";
    case "Other":
      return "bg-gray-400";
    default:
      return "bg-blue-500";
  }
};

export default function OfferList() {
  // TODO: add translation
  const { t } = useTranslation();
  const [sort, setSort] = useState<string>("");
  const [queryWord, setQueryWord] = useState<string>("");
  const [searchOptions, setSearchOptions] = useState<SearchOfferOptions>({});

  function handleSetOptions(options: SearchOfferOptions) {
    setSearchOptions({
      ...options,
      sortBy: sort,
    });
  }

  const { data, loading, error } = useQuery(SEARCH_OFFERS, {
    variables: {
      query: queryWord,
      options: {
        ...searchOptions,
        sortBy: sort,
      },
    },
  });

  const offers = data?.searchOffers?.offerList ?? [];

  if (error) {
    return (
      <div className="min-h-screen bg-black text-white p-6 flex items-center justify-center">
        <p>
          {t("common.error-occurred")}: {error.message}
        </p>
      </div>
    );
  }

  return (
    <>
      <div className="w-[60px]">
        <Link href="/offer" className="ml-6">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6"
          />
        </Link>
      </div>

      <div className="min-h-screen bg-black text-white p-6">
        <div className="max-w-7xl mx-auto">
          <header className="flex justify-between items-center mb-8">
            <div className="flex items-center gap-4">
              <h1 className="text-6xl font-light">Offer List</h1>
            </div>
            <div className="flex flex-row items-center gap-3">
              <Input
                type="text"
                placeholder={"Search Offer"}
                value={queryWord}
                onChange={(e) => setQueryWord(e.target.value)}
                className="w-96"
              />
              <SearchOfferDialog
                options={searchOptions}
                setOptions={setSearchOptions}
                handleOption={handleSetOptions}
              />
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button asChild variant="outline" size="icon" className="p-1">
                    <ArrowDownUp className="w-8 h-8 cursor-pointer" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent className="w-56">
                  <DropdownMenuRadioGroup value={sort} onValueChange={setSort}>
                    <DropdownMenuRadioItem
                      value="newest"
                      className="cursor-pointer"
                    >
                      新着順
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="matched"
                      className="cursor-pointer"
                    >
                      マッチ度（降順）
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="point"
                      className="cursor-pointer"
                    >
                      ポイント（降順）
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="date"
                      className="cursor-pointer"
                    >
                      期限までの日数（降順）
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="member"
                      className="cursor-pointer"
                    >
                      対象人数（降順）
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="rate"
                      className="cursor-pointer"
                    >
                      ユーザーレーティング（降順）
                    </DropdownMenuRadioItem>
                  </DropdownMenuRadioGroup>
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
          </header>

          <div className="grid md:grid-cols-2 gap-6">
            {loading ? (
              Array(6)
                .fill(0)
                .map((_, index) => <OfferCardSkeleton key={index} />)
            ) : offers.length === 0 ? (
              <div className="col-span-2 text-center py-10 text-gray-400">
                {t("offer.no-offer-registered")}
              </div>
            ) : (
              offers.map((offer: Offer) => (
                <OfferCard key={offer.id} offer={offer} />
              ))
            )}
          </div>
        </div>
      </div>
    </>
  );
}

function OfferCard({ offer }: { offer: Offer }) {
  const router = useRouter();

  const handleClick = () => {
    router.push(`/offer/${offer.id}`);
  };

  return (
    <Card
      className="bg-zinc-900 border-none p-4 cursor-pointer hover:bg-zinc-800 transition-colors"
      onClick={handleClick}
    >
      <div className="flex gap-4">
        {offer.imageUrl ? (
          <Image
            src={offer.imageUrl}
            alt="Offer thumbnail"
            width={150}
            height={150}
            className="rounded-lg"
          />
        ) : (
          <Image
            src="/offer.svg"
            alt="Default thumbnail"
            width={150}
            height={150}
            className="rounded-lg"
          />
        )}

        <div className="flex-1 min-w-0">
          <div className="flex justify-between items-start mb-2">
            <span
              className={`px-2 py-1 rounded-full text-black text-xs ${getCategoryBackgroundColor(offer.category)}`}
            >
              {offer.category}
            </span>
            {/*
            <div className="flex gap-2">
              <Share2 className="w-4 h-4" />
              <Heart className="w-4 h-4" />
            </div>
            */}
          </div>

          <h3 className="font-medium mb-1 truncate">{offer.title}</h3>
          <p className="text-sm text-gray-400 mb-2 line-clamp-2 break-words">
            {offer.description}
          </p>
          {/*
          <p className="text-xs text-gray-500 mb-4">
            Last Updated: {offer.fee} FSP
          </p>
          */}

          <div className="flex justify-between items-center mb-4">
            <div className="flex items-center gap-2 text-sm">
              <span className="px-2 py-1 rounded bg-zinc-800">
                報酬: {offer.fee} FSP
              </span>
            </div>
          </div>

          {/*

          <div className="grid grid-cols-3 gap-4 text-sm mb-4">
            <div>
              <div className="text-gray-400">開催日</div>
              <div>{offer.fee}</div>
            </div>
            <div>
              <div className="text-gray-400">場所</div>
              <div>{offer.fee}</div>
            </div>
            <div>
              <div className="text-gray-400">対象</div>
              <div className="truncate">{offer.fee}</div>
            </div>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <div className="w-6 h-6 rounded-full bg-zinc-800" />
                <div className="text-sm">
                  <div>{offer.fee}</div>
                  <div className="text-gray-400 text-xs">
                    {offer.fee} connections
                  </div>
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Star className="w-4 h-4" />
                <span className="text-sm">{offer.fee}</span>
              </div>
            </div>
            <div className="flex gap-2">
              <MessageSquare className="w-4 h-4" />
              <button className="text-sm">→</button>
            </div>
          </div>
          */}
        </div>
      </div>
    </Card>
  );
}

function OfferCardSkeleton() {
  return (
    <Card className="bg-zinc-900 border-none p-4">
      <div className="flex gap-4">
        <Skeleton className="w-[150px] h-[150px] rounded-lg" />
        <div className="flex-1">
          <div className="flex justify-between items-start mb-2">
            <Skeleton className="w-20 h-6" />
            <div className="flex gap-2">
              <Skeleton className="w-4 h-4" />
              <Skeleton className="w-4 h-4" />
            </div>
          </div>

          <Skeleton className="w-3/4 h-6 mb-1" />
          <Skeleton className="w-full h-4 mb-2" />
          <Skeleton className="w-1/2 h-4 mb-4" />

          <div className="flex justify-between items-center mb-4">
            <Skeleton className="w-32 h-8" />
            <Skeleton className="w-24 h-6" />
          </div>

          <div className="grid grid-cols-3 gap-4 mb-4">
            {[0, 1, 2].map((i) => (
              <div key={i}>
                <Skeleton className="w-full h-4 mb-1" />
                <Skeleton className="w-3/4 h-4" />
              </div>
            ))}
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Skeleton className="w-6 h-6 rounded-full" />
                <div>
                  <Skeleton className="w-24 h-4 mb-1" />
                  <Skeleton className="w-20 h-3" />
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Skeleton className="w-4 h-4" />
                <Skeleton className="w-8 h-4" />
              </div>
            </div>
            <div className="flex gap-2">
              <Skeleton className="w-4 h-4" />
              <Skeleton className="w-4 h-4" />
            </div>
          </div>
        </div>
      </div>
    </Card>
  );
}
