import "@ui/styles/globals.css";
import type { Metadata } from "next";
import { ThemeProvider } from "@ui/components/theme-provider";
import { SidebarProvider, SidebarTrigger } from "@ui/components/ui/sidebar";
import { ClientSidebar } from "./client-sidebar";
import Header from "./header";
import { AuthProvider } from "../../../provider/auth-provider";
import { ApollClientProvider } from "../../../provider/apollo-client";
import { Jost, Noto_Sans_JP } from "next/font/google";
import { Toaster } from "react-hot-toast";

const JostFont = Jost({
  subsets: ["latin"],
  weight: ["100", "200", "300", "400", "500", "600", "700", "800", "900"],
  display: "swap",
  variable: "--font-jost",
});

export const NotoSansJP = Noto_Sans_JP({
  subsets: ["latin"],
  weight: ["100", "300", "400", "500", "700", "900"],
  display: "swap",
  variable: "--font-noto-sans-jp",
});

const metadata: Metadata = {
  title: "FRIENDSHIP. DAO",
  description: "Community-driven dashboard",
};

export default function RootLayout({
  children,
  params: { locale },
}: {
  children: React.ReactNode;
  params: { locale: string };
}): JSX.Element {
  return (
    <SidebarProvider>
      <div className="flex w-full pt-12">
        <SidebarTrigger />
        <ClientSidebar />
        <Header />
        <main className="flex-1 min-w-0 w-full">
          <div className="max-w-6xl mx-auto">{children}</div>
          <Toaster />
        </main>
      </div>
    </SidebarProvider>
  );
}
