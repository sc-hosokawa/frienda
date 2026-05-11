"use client";

import { Bell } from "lucide-react";
import { Card } from "@ui/components/ui/card";
import Image from "next/image";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "~/store/user";
import { useTranslation } from "~/i18n/client";
import type { NotificationListData } from "~/generated/graphql";

const GET_NOTIFICATIONS = gql`
  query GetNotificationList($userId: String!, $limit: Int!, $offset: Int!) {
    getNotificationList(userId: $userId, limit: $limit, offset: $offset) {
      notifications {
        id
        title
        content
        isRead
        createdAt
      }
    }
  }
`;

function formatNotificationDate(createdAt: string) {
  const date = new Date(createdAt);
  const jstDate = new Date(date.getTime() + 9 * 60 * 60 * 1000);

  return jstDate.toLocaleString("ja-JP", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export default function NotificationList() {
  const { user } = useUserStore();
  const { t } = useTranslation();
  const { loading, error, data } = useQuery<{
    getNotificationList: NotificationListData;
  }>(GET_NOTIFICATIONS, {
    variables: {
      userId: user?.id ?? "",
      limit: 20,
      offset: 0,
    },
    skip: !user?.id,
  });

  if (!user?.id || loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const notifications = data?.getNotificationList.notifications ?? [];

  return (
    <div className="container max-w-6xl mx-auto">
      <div className="flex items-center justify-between mb-8">
        <div className="flex items-center gap-2 pt-[125px] space-x-2">
          <div className="relative">
            <Image
              src="/notification.svg"
              alt="Logo"
              className="w-[105px] h-[105px] text-[#4d8eff]"
              width={105}
              height={105}
            />
          </div>
          <div className="flex flex-col space-y-0">
            <h1 className="text-[90px] font-light tracking-tight leading-none">
              NOTIFICATIONS
            </h1>
            <p className="text-sm -mt-2">通知</p>
          </div>
        </div>
      </div>
      <hr className="mb-8 mt-24 border-[#303030]" />

      {notifications.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20">
          <Bell className="w-16 h-16 text-gray-400 mb-4" />
          <p className="text-xl text-gray-400">
            {t("notification.no-notification")}
          </p>
        </div>
      ) : (
        <ul className="space-y-4">
          {notifications.map((notification) => (
            <li key={notification.id}>
              <Card className="border rounded-3xl border-white/30 bg-transparent">
                <div className="flex flex-col gap-3 p-5 md:flex-row md:items-start md:justify-between">
                  <div className="min-w-0 flex-1">
                    <h2 className="text-lg font-light leading-snug">
                      {notification.title}
                    </h2>
                    <p className="mt-2 text-sm leading-6 text-white/80">
                      {notification.content}
                    </p>
                  </div>
                  <time
                    className="shrink-0 text-xs text-muted-foreground md:pt-1"
                    dateTime={notification.createdAt}
                  >
                    {formatNotificationDate(notification.createdAt)}
                  </time>
                </div>
              </Card>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
