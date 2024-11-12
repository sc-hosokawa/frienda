import Image from "next/image";

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

const items = [
  {
    title: "Home",
    url: "/",
    icon: <Image src="/home.svg" alt="Home" width={24} height={24} />,
  },
  {
    title: "Offers",
    url: "/offer",
    icon: <Image src="/offer.svg" alt="Offer" width={24} height={24} />,
  },
  {
    title: "Dashboard",
    url: "/dashboard",
    icon: <Image src="/dashboard.svg" alt="Dashboard" width={24} height={24} />,
  },
  {
    title: "Messages",
    url: "/message",
    icon: <Image src="/message.svg" alt="Messages" width={24} height={24} />,
  },
  {
    title: "News",
    url: "/news",
    icon: <Image src="/news.svg" alt="News" width={24} height={24} />,
  },
];

export function ClientSidebar() {
  return (
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
        <SuperAdminDialog />
        <AccessControlDialog />
      </SidebarFooter>
    </Sidebar>
  );
}
