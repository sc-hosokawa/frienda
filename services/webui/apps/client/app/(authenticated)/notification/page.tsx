'use client'

import { Bell } from "lucide-react";
import { Card } from "@ui/components/ui/card";
import { Badge } from "@ui/components/ui/badge";
import { Button } from "@ui/components/ui/button";
import Image from "next/image";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "../../../store/user";

const GET_NOTIFICATIONS = gql`
  query GetNotifications($userId: String!) {
    getNotifications(userId: $userId) {
      id
      title
      content
      isRead
      createdAt
    }
  }
`;

export default function NotificationList() {
  const { user } = useUserStore();
  const { loading, error, data } = useQuery(GET_NOTIFICATIONS, {
    variables: {
      userId: user?.id
    }
  });

  console.log(data);  

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const notifications = data?.getNotifications.map((notification: any) => ({
    id: notification.id,
    category: "Notification",
    color: "bg-[#e8ff26]",
    textColor: "text-black",
    highlighted: !notification.isRead,
    title: notification.title,
    content: notification.content,
    createdAt: notification.createdAt,
  })) || [];

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
          <p className="text-xl text-gray-400">通知はありません</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {notifications.map((notification: any) => (
            <Card
              key={notification.id}
              className="h-full overflow-hidden hover:shadow-lg transition-all hover:bg-white/30 relative border rounded-3xl border-white/30"
            >
              {notification.highlighted && (
                <span className="absolute top-0 left-0 z-10 bg-[#E1F000] text-black py-4 px-6 rounded-3xl text-xs font-light">
                  NEW
                </span>
              )}
              <div className="p-4 flex flex-col h-[240px]">
                <div className="flex items-center justify-between mb-2">
                  <span
                    className={`text-sm my-2 px-4 py-2 rounded-full ${
                      notification.color
                    } ${notification.textColor}`}
                  >
                    {notification.category}
                  </span>
                </div>
                <h2 className="text-lg mb-2 line-clamp-3 flex-grow">
                  {notification.title}
                </h2>
                <p className="text-sm text-white line-clamp-2">
                  {notification.content}
                </p>
                <span className="text-xs mt-4 text-muted-foreground">
                  {(() => {
                    const date = new Date(notification.createdAt);
                    const jstDate = new Date(date.getTime() + (9 * 60 * 60 * 1000));
                    return jstDate.toLocaleString('ja-JP', {
                      year: 'numeric',
                      month: '2-digit',
                      day: '2-digit',
                      hour: '2-digit',
                      minute: '2-digit',
                    });
                  })()}
                </span>
              </div>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}

function ArrowIcon(props: React.SVGProps<SVGSVGElement>) {
  return (
    <svg
      {...props}
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M5 12h14" />
      <path d="m12 5 7 7-7 7" />
    </svg>
  );
}
