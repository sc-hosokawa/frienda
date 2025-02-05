"use client";

import { useState } from "react";
import Image from "next/image";
import { gql, useQuery } from "@apollo/client";
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
import { OfferCardSkeleton } from "~/components/offer/offer-card-skeleton";
import { Offer, OfferCard } from "~/components/offer/offer-card";

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

export default function OfferList() {
  const { t } = useTranslation();

  /**
   * default: "", this means sort by created date in ascending order
   * fee_asc: sort by fee in ascending order
   * fee_desc: sort by fee in descending order
   */
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
                    <DropdownMenuRadioItem value="" className="cursor-pointer">
                      {t("offer.sort-newest")}
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="fee_asc"
                      className="cursor-pointer"
                    >
                      {t("offer.sort-fee-asc")}
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      value="fee_desc"
                      className="cursor-pointer"
                    >
                      {t("offer.sort-fee-desc")}
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
