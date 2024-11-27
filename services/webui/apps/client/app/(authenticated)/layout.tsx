import "@ui/styles/globals.css";
import type { Metadata } from "next";
import { ThemeProvider } from "@ui/components/theme-provider";
import { SidebarProvider, SidebarTrigger } from "@ui/components/ui/sidebar";
import { ClientSidebar } from "./client-sidebar";
import Header from "./header";
import { AuthProvider } from "../../provider/auth-provider";
import { ApollClientProvider } from "../../provider/apollo-client";
import { Jost } from "next/font/google";

const JostFont = Jost({
  subsets: ["latin"],
  weight: ["100", "200", "300", "400", "500", "600", "700", "800", "900"],
  display: "swap",
  variable: "--font-jost",
});

export const metadata: Metadata = {
  title: "FRIENDSHIP. DAO",
  description: "Community-driven dashboard",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}): JSX.Element {
  return (
    <html lang="en" suppressHydrationWarning className="dark">
      <body
        className={`${JostFont.className} bg-white text-black dark:bg-black dark:text-white dark`}
      >
        <ThemeProvider
          attribute="class"
          defaultTheme="dark"
          enableSystem={false}
          disableTransitionOnChange
        >
          <AuthProvider>
            <ApollClientProvider>
              <SidebarProvider>
                <div className="flex w-full pt-12">
                  <ClientSidebar />
                  <Header />
                  <main className="flex-1 min-w-0 w-full">
                    <div className="max-w-6xl mx-auto">{children}</div>
                  </main>
                </div>
              </SidebarProvider>
            </ApollClientProvider>
          </AuthProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
