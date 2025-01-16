"use client";

import React, { Suspense } from "react";
import Image from "next/image";
import OfferList from "~/components/offer/offer-list";
import OfferListSkeleton from "~/components/offer/offer-list-skeleton";
import OfferStats from "~/components/offer/stats";
import OfferAllList, {
  OfferAllListSkeleton,
} from "~/components/offer/offer-all-list";
import { OfferInfo } from "~/components/offer/offer-Info";
import Link from "next/link";
import useUserStore from "~/store/user";
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@ui/components/ui/tooltip";
import { ConciergeDialog } from "~/components/dialog/concierge-dialog";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Form, FormControl, FormField, FormItem } from "@ui/components/ui/form";
import { gql, useApolloClient } from "@apollo/client";
import { Skeleton } from "@ui/components/ui/skeleton";
import { useTranslation } from "~/i18n/client";

const conciergeSchema = z.object({
  question: z.string(),
});

const ASK_LLM = gql`
  query AskLLM($userId: String!, $question: String!) {
    askLlm(userId: $userId, question: $question)
  }
`;

export default function OfferPage() {
  const { user } = useUserStore();
  const client = useApolloClient();
  const { t } = useTranslation();
  const [userQuestion, setUserQuestion] = React.useState<string | null>(null);
  const [answer, setAnswer] = React.useState<string | null>(null);
  const [isLoading, setIsLoading] = React.useState(false);

  const form = useForm<z.infer<typeof conciergeSchema>>({
    resolver: zodResolver(conciergeSchema),
  });

  async function onSubmit(value: z.infer<typeof conciergeSchema>) {
    setUserQuestion(value.question);
    if (answer) setAnswer(null);
    try {
      setIsLoading(true);
      const { data } = await client.query({
        query: ASK_LLM,
        variables: {
          userId: user?.id,
          question: value.question,
        },
      });
      setAnswer(data.askLlm);
    } catch (e) {
      console.error(e);
    } finally {
      form.setValue("question", "");
      setIsLoading(false);
    }
  }

  return (
    <div className="p-4 min-h-screen">
      <div className="flex items-center gap-2 pt-[103px] justify-between mb-8">
        <div className="flex items-center gap-2">
          <Image
            src="/offer.svg"
            alt="logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col space-y-0">
            <h1 className="text-[90px] font-light tracking-tight leading-none relative">
              OFFERS
              <OfferInfo />
            </h1>
            <p className="text-sm -mt-2">オファー</p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <ConciergeDialog>
            <div className="flex flex-col space-y-4 overflow-auto w-[960px]">
              {userQuestion && (
                <div className="flex justify-end mb-6">
                  <div className="bg-[#E4DBC0] text-black w-[500px] p-4 rounded-md">
                    {userQuestion}
                  </div>
                </div>
              )}
              <div className="flex flex-row">
                <div>
                  <Image
                    src={"/logo_visualonly_dark.jpg"}
                    alt="avatar"
                    width={40}
                    height={40}
                    className={`p-1 rounded-full object-cover`}
                  />
                </div>
                {answer && (
                  <div className="bg-transparent text-white w-[960px]">
                    {answer.split("\n").map((line, index) => (
                      <React.Fragment key={index}>
                        {line.startsWith("**") && !line.startsWith("* **") ? (
                          <h3 className="text-lg mb-2">
                            {line.replace(/\*\*/g, "")}
                          </h3>
                        ) : line.startsWith("* **") ? (
                          <div className="flex gap-2 mb-2">
                            <span className="ml-4">•</span>
                            <p>
                              <span className="font-bold">
                                {line.match(/\*\*(.*?)\*\*/)?.[1]}:
                              </span>
                              {line.split(":**")[1]}
                            </p>
                          </div>
                        ) : line.startsWith("*") ? (
                          <div className="flex gap-2 mb-2">
                            <span className="ml-4">•</span>
                            <p>{line.substring(2)}</p>
                          </div>
                        ) : (
                          <p className="mb-2">{line}</p>
                        )}
                      </React.Fragment>
                    ))}
                  </div>
                )}
                {isLoading && <Skeleton className="w-[960px] h-[90px]" />}
                {!isLoading && !answer && (
                  <div className="bg-transparent text-white w-[960px] p-2">
                    <p>{t("concierge.welcome")}</p>
                    <p className="text-sm text-gray-400 mt-4">
                      {t("concierge.notion")}
                    </p>
                    <p className="text-sm text-gray-400 mt-4">
                      {t("concierge.hint")}
                    </p>
                  </div>
                )}
              </div>
            </div>

            <Form {...form}>
              <form
                onSubmit={form.handleSubmit(onSubmit)}
                className="flex flex-row items-center w-[960px] gap-2"
              >
                <FormField
                  control={form.control}
                  name="question"
                  render={({ field }) => (
                    <FormItem>
                      <FormControl>
                        <input
                          placeholder={t("concierge.ask-me-anything")}
                          className="flex w-[900px] border border-white bg-transparent text-white rounded-[30px] h-[90px] p-6"
                          {...field}
                        />
                      </FormControl>
                    </FormItem>
                  )}
                />

                <button type="submit">
                  <Image
                    src="/arrow-up-circle.svg"
                    alt="arrow-up"
                    width={36}
                    height={36}
                  />
                </button>
              </form>
            </Form>
          </ConciergeDialog>
          <Link
            href="/offer/list"
            className="p-2 rounded-full hover:bg-gray-700 transition-colors border border-white border-dashed w-[60px] h-[60px] flex items-center justify-center"
          >
            <Image src="/search.svg" alt="list" width={24} height={24} />
          </Link>
          {user?.fspBalance !== undefined && user.fspBalance >= 20 ? (
            <Link
              href="/offer/create"
              className="p-2 rounded-full hover:bg-gray-700 transition-colors border border-white border-dashed w-[60px] h-[60px] flex items-center justify-center"
            >
              <Image src="/plus.svg" alt="plus" width={24} height={24} />
            </Link>
          ) : (
            <TooltipProvider>
              <Tooltip delayDuration={0}>
                <TooltipTrigger asChild>
                  <div className="p-2 rounded-full border border-white border-dashed w-[60px] h-[60px] flex items-center justify-center opacity-50 cursor-not-allowed">
                    <Image src="/plus.svg" alt="plus" width={24} height={24} />
                  </div>
                </TooltipTrigger>
                <TooltipContent>
                  <p>{t("offer.offer-creation-notion")}</p>
                </TooltipContent>
              </Tooltip>
            </TooltipProvider>
          )}
        </div>
      </div>
      <div className="">
        <hr className="mb-8 mt-24 border-[#303030]" />
        <OfferStats />
        <div className="flex flex-col space-y-0 mt-16 mb-8">
          <h1 className="text-6xl font-light">My Offers</h1>
          <p className="text-sm">マイオファー</p>
        </div>
        <Suspense fallback={<OfferListSkeleton />}>
          <OfferList />
        </Suspense>
        <Suspense fallback={<OfferAllListSkeleton />}>
          <OfferAllList />
        </Suspense>
      </div>
    </div>
  );
}
