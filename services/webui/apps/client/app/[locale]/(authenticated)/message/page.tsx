"use client";

import Image from "next/image";
import React, { Suspense } from "react";
import { Avatar, AvatarImage } from "@ui/components/ui/avatar";
import { Skeleton } from "@ui/components/ui/skeleton";
import NewMessageDialog from "~/components/dialog/new-message-dialog";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "~/store/user";
import { format } from "date-fns";
import { ja } from "date-fns/locale";
import { MessageRoomsByUserData } from "~/generated/graphql";
import { useRouter } from "next/navigation";
import { ConciergeDialog } from "~/components/dialog/concierge-dialog";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Form, FormControl, FormField, FormItem } from "@ui/components/ui/form";
import { useApolloClient } from "@apollo/client";
import { useTranslation } from "~/i18n/client";

const conciergeSchema = z.object({
  question: z.string(),
});

const ASK_LLM = gql`
  query AskLLM($userId: String!, $question: String!) {
    askLlm(userId: $userId, question: $question)
  }
`;

const GET_MESSAGE_ROOMS = gql`
  query GetMessageRooms($userId: String!) {
    getMessageRooms(userId: $userId) {
      messageRoomList {
        id
        category
        latestMessage
        latestMessageId
        latestSentAt
        isRead
        users {
          id
          name
          imageUrl
        }
      }
      countOfMessageRooms
    }
  }
`;

interface ResData {
  getMessageRooms: MessageRoomsByUserData;
}

const MessageSkeleton = () => (
  <div className="flex items-start gap-4 p-4 w-full">
    <Skeleton className="w-12 h-12 rounded-full" />
    <div className="flex-1">
      <Skeleton className="h-4 w-24 mb-2" />
      <Skeleton className="h-4 w-full" />
    </div>
  </div>
);

const MessageList = () => {
  const router = useRouter();
  const { user } = useUserStore();
  const { loading, error, data, refetch } = useQuery<ResData>(
    GET_MESSAGE_ROOMS,
    {
      variables: { userId: user?.id || "" },
      skip: !user?.id,
    },
  );

  const formatDateTime = (dateTimeStr: string | null | undefined) => {
    if (!dateTimeStr) return "";

    try {
      const date = new Date(dateTimeStr);
      const now = new Date();
      const isThisYear = date.getFullYear() === now.getFullYear();

      return format(date, isThisYear ? "M/d HH:mm" : "yyyy/M/d HH:mm", {
        locale: ja,
      });
    } catch (error) {
      console.error("Date formatting error:", error);
      return "";
    }
  };

  if (loading) return <MessageSkeleton />;
  if (error)
    return <div className="p-4 text-red-500">Error: {error.message}</div>;

  const messageRooms = data?.getMessageRooms.messageRoomList || [];
  const sortedRooms = [...messageRooms].sort((a, b) => {
    const bDate = b.latestSentAt ? new Date(b.latestSentAt).getTime() : 0;
    const aDate = a.latestSentAt ? new Date(a.latestSentAt).getTime() : 0;
    return bDate - aDate;
  });

  if (sortedRooms.length === 0) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-400 text-lg font-light">No messages yet</p>
      </div>
    );
  }

  return (
    <div className="divide-y divide-gray-800">
      {sortedRooms.map((room) => {
        const otherUser = room.users.find((u: any) => u.id !== user?.id);
        const isUnread = !room.isRead;

        return (
          <div
            key={room.id}
            className={`flex items-center gap-4 p-4 cursor-pointer hover:bg-[#E4DBC0] transition-colors group ${
              isUnread ? "" : ""
            }`}
            onClick={() => {
              router.push(`/message/${room.id}`);
            }}
          >
            <Avatar className="w-12 h-12 flex-shrink-0">
              <AvatarImage
                src={otherUser?.imageUrl || "/message.svg"}
                alt={otherUser?.name}
              />
            </Avatar>
            <span className="font-medium w-48 flex-shrink-0 group-hover:text-black">
              {otherUser?.name || "Unknown User"}
            </span>
            <p className="text-sm text-white flex-1 truncate group-hover:text-black">
              {room.latestMessage || "No messages"}
            </p>
            <span className="text-sm text-gray-400 flex-shrink-0 group-hover:text-black">
              {formatDateTime(room.latestSentAt || "")}
            </span>
          </div>
        );
      })}
    </div>
  );
};

export default function MessagePage() {
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
    <div className="bg-black text-white flex-1">
      <div className="flex items-center justify-between pt-[115px] border-gray-800">
        <div className="flex items-center gap-2">
          <Image
            src="/message.svg"
            alt="logo"
            className="mr-2"
            width={105}
            height={105}
          />
          <div className="flex flex-col">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              MESSAGE
            </h1>
            <p className="text-sm">メッセージ</p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <ConciergeDialog>
            <div className="flex flex-col space-y-4 overflow-auto h-[500px] w-[960px]">
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
          <NewMessageDialog />
        </div>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />

      <Suspense
        fallback={
          <>
            <MessageSkeleton />
            <MessageSkeleton />
            <MessageSkeleton />
          </>
        }
      >
        <MessageList />
      </Suspense>
    </div>
  );
}
