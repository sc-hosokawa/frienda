import Image from "next/image";
import Link from "next/link";

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
import SuperAdminDialog from "./superadmin-dialog";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
} from "@ui/components/ui/dropdown-menu";
import { Settings } from "lucide-react";
import { Button } from "@ui/components/ui/button";

const items = [
  {
    title: "Home",
    url: "/",
    icon: <Image src="/home.svg" alt="Home" width={24} height={24} />,
  },
  {
    title: "Dashboard",
    url: "/dashboard",
    icon: <Image src="/dashboard.svg" alt="Dashboard" width={24} height={24} />,
  },
  {
    title: "News",
    url: "/news",
    icon: <Image src="/news.svg" alt="News" width={24} height={24} />,
  },
  {
    title: "Offers",
    url: "/offer",
    icon: <Image src="/offer.svg" alt="Offer" width={24} height={24} />,
  },
  {
    title: "Messages",
    url: "/message",
    icon: <Image src="/message.svg" alt="Messages" width={24} height={24} />,
  },
];

export function ClientSidebar() {
  return (
    <div className="dark">
      <Sidebar>
        <SidebarHeader>
          <Image
            src="/logo_visualonly_dark.jpg"
            alt="Logo"
            width={50}
            height={50}
          />
        </SidebarHeader>
        <SidebarContent>
          <SidebarGroup>
            <SidebarGroupContent>
              <SidebarMenu>
                {items.map((item) => (
                  <SidebarMenuItem key={item.title}>
                    <SidebarMenuButton asChild>
                      <a href={item.url} className="py-8">
                        {item.icon}
                        <span className="font-light">{item.title}</span>
                      </a>
                    </SidebarMenuButton>
                  </SidebarMenuItem>
                ))}
              </SidebarMenu>
            </SidebarGroupContent>
          </SidebarGroup>
        </SidebarContent>
        <SidebarFooter>
          <Link
            className="text-center w-full"
            href="https://forms.gle/1ZGguxTLQeNseW877"
            target="_blank"
            rel="noopener noreferrer"
          >
            Feedback
          </Link>
          <SuperAdminDialog />
          <AccessControlDialog />
          <div className="relative w-full">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" size="sm" className="w-full">
                  <Settings className="mr-11 h-4 w-4" />
                  Settings
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent side="right" align="start">
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
        </SidebarFooter>
      </Sidebar>
    </div>
  );
}
