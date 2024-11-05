import { Bell } from "lucide-react";
import { Card } from "@ui/components/ui/card";
import { Badge } from "@ui/components/ui/badge";
import { Button } from "@ui/components/ui/button";

export default function NotificationList() {
  const notifications = [
    {
      category: "NEWS",
      color: "bg-[#e8ff26]",
      textColor: "text-black",
      highlighted: true,
    },
    {
      category: "OFFERS",
      color: "bg-[#ff6b4d]",
      textColor: "text-white",
    },
    {
      category: "DASHBOARD",
      color: "bg-[#c084fc]",
      textColor: "text-white",
    },
    {
      category: "FRIENDS",
      color: "bg-[#4d8eff]",
      textColor: "text-white",
    },
    {
      category: "NEWS",
      color: "bg-[#e8ff26]",
      textColor: "text-black",
    },
    {
      category: "MESSAGE",
      color: "bg-[#ff4d4d]",
      textColor: "text-white",
    },
  ];

  return (
    <div className="min-h-screen bg-black text-white p-8">
      <header className="flex items-center gap-4 mb-16">
        <div className="relative">
          <Bell className="w-12 h-12 text-[#4d8eff]" />
          <div className="absolute top-0 right-0 w-3 h-3 bg-[#e8ff26] rounded-full" />
        </div>
        <div>
          <h1 className="text-4xl font-light tracking-wider">NOTIFICATIONS</h1>
          <p className="text-sm">通知</p>
        </div>
      </header>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {notifications.map((notification, index) => (
          <Card
            key={index}
            className={`relative overflow-hidden ${
              notification.highlighted
                ? notification.color
                : "bg-[#1a1a1a] hover:bg-[#252525]"
            } rounded-3xl p-6 transition-colors`}
          >
            <Badge
              className={`${notification.color} ${notification.textColor} rounded-full font-medium px-4 py-1`}
            >
              {notification.category}
            </Badge>

            <div
              className={`mt-6 ${notification.highlighted ? "text-black" : "text-white"}`}
            >
              <h2 className="text-lg font-medium mb-1">
                ここに通知のタイトルが入ります
              </h2>
              <h2 className="text-lg font-medium mb-4">
                ここに通知のタイトルが入ります
              </h2>

              <p className="text-sm opacity-80 mb-2">
                ここに通知の内容が入ります。ここに通知の内容が入ります。ここに通知の内容が入ります。ここに通知の内容が入ります。ここに通知の内容が入ります。
              </p>
              <p className="text-sm opacity-80">
                ここに通知の内容が入ります。ここに通知の内容が入ります。ここに通知の内容が入ります。ここに通知の内容が入ります。ここに通知の内容が入ります。
              </p>
            </div>

            <div className="flex justify-between items-center mt-8">
              <time className="text-sm opacity-60">2024/12/12 12:23</time>
              <Button
                size="icon"
                variant="ghost"
                className={`rounded-full ${
                  notification.highlighted
                    ? "text-black hover:bg-black/10"
                    : "text-white hover:bg-white/10"
                }`}
              >
                <ArrowIcon className="w-5 h-5" />
              </Button>
            </div>
          </Card>
        ))}
      </div>
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
