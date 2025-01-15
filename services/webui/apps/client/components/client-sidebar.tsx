"use client";

import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState } from "react";
import { Send, Settings } from "lucide-react";

import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarFooter,
} from "@ui/components/ui/sidebar";
import AccessControlDialog from "./access-control";
import SuperAdminDialog from "./dialog/superadmin-dialog";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
} from "@ui/components/ui/dropdown-menu";
import { Button } from "@ui/components/ui/button";

const items = [
  {
    title: "Home",
    url: "/",
    icon: {
      default: "/home.svg",
      active: "/home_line.svg",
    },
  },
  {
    title: "Dashboard",
    url: "/dashboard",
    icon: {
      default: "/dashboard.svg",
      active: "/dashboard_line.svg",
    },
  },
  {
    title: "News",
    url: "/news",
    icon: {
      default: "/news.svg",
      active: "/news_line.svg",
    },
  },
  {
    title: "Offers",
    url: "/offer",
    icon: {
      default: "/offer.svg",
      active: "/offers_line.svg",
    },
  },
  {
    title: "Community",
    url: "/community",
    icon: {
      default: "/community.svg",
      active: "/community_line.svg",
    },
  },
  {
    title: "Message",
    url: "/message",
    icon: {
      default: "/message.svg",
      active: "/message_line.svg",
    },
  },
  {
    title: "Notification",
    url: "/notification",
    icon: {
      default: "/notification.svg",
      active: "/notification_line.svg",
    },
  },
];

export function ClientSidebar() {
  const pathname = usePathname();
  const [hoveredItem, setHoveredItem] = useState<string | null>(null);

  return (
    <div className="dark">
      <Sidebar variant="sidebar" collapsible="offcanvas">
        <SidebarHeader>
          <Image
            src="/logo_visualonly_dark.jpg"
            alt="Logo"
            width={50}
            height={50}
            className="mt-4 ml-2"
          />
        </SidebarHeader>
        <SidebarContent className="mt-24">
          <SidebarGroup>
            <SidebarGroupContent>
              <SidebarMenu>
                {items.map((item) => {
                  const isActive =
                    item.url === "/"
                      ? pathname === item.url
                      : pathname.startsWith(item.url);
                  const showActiveIcon = isActive || hoveredItem === item.url;

                  return (
                    <SidebarMenuItem key={item.title}>
                      <SidebarMenuButton asChild isActive={isActive}>
                        <a
                          href={item.url}
                          className="py-8 sidebar-item relative"
                          onMouseEnter={() => setHoveredItem(item.url)}
                          onMouseLeave={() => setHoveredItem(null)}
                          data-active={isActive}
                        >
                          <div className="flex items-center gap-2">
                            <Image
                              src={
                                showActiveIcon
                                  ? item.icon.active
                                  : item.icon.default
                              }
                              alt={item.title}
                              width={24}
                              height={24}
                            />
                            <span className="font-light text-[15px]">
                              {item.title}
                            </span>
                          </div>
                          {isActive && (
                            <div className="absolute right-4 top-1/2 -translate-y-1/2">
                              <svg
                                width="16"
                                height="16"
                                viewBox="0 0 16 16"
                                fill="none"
                                xmlns="http://www.w3.org/2000/svg"
                              >
                                <path
                                  d="M6 12L10 8L6 4"
                                  stroke="currentColor"
                                  strokeWidth="1"
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                />
                              </svg>
                            </div>
                          )}
                        </a>
                      </SidebarMenuButton>
                    </SidebarMenuItem>
                  );
                })}
                <div className="relative w-full mt-24">
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="w-full font-light justify-start hover:bg-white rounded-md transition-colors duration-200 hover:text-black"
                      >
                        <Settings className="w-4 h-4 mr-2" />
                        <span>Settings</span>
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent side="right" align="start">
                      <DropdownMenuItem asChild>
                        <Link href="/walkthrough">
                          <span>チュートリアル</span>
                        </Link>
                      </DropdownMenuItem>
                      <DropdownMenuItem asChild>
                        <Link href="/privacypolicy">
                          <span>プライバシーポリシー</span>
                        </Link>
                      </DropdownMenuItem>
                      <DropdownMenuItem asChild>
                        <Link href="/termofservice">
                          <span>利用規約</span>
                        </Link>
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
                <Link
                  className="w-full flex items-center gap-2 pl-3 py-2 font-light hover:bg-white rounded-md transition-colors duration-200 hover:text-black"
                  href="https://forms.gle/1ZGguxTLQeNseW877"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <Send className="w-4 h-4 mr-2" />
                  <span>Feedback</span>
                </Link>
              </SidebarMenu>
            </SidebarGroupContent>
          </SidebarGroup>
        </SidebarContent>
        <SidebarFooter>
          <SuperAdminDialog />
          <AccessControlDialog />
        </SidebarFooter>
      </Sidebar>
    </div>
  );
}
