import "@ui/styles/globals.css";
import type { Metadata } from "next";
import { ThemeProvider } from "@ui/components/theme-provider";
import { SidebarProvider, SidebarTrigger } from "@ui/components/ui/sidebar";
import { ClientSidebar } from "./client-sidebar";
import Header from "./header";

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
    <html lang="en" suppressHydrationWarning>
      <body className={`bg-white text-black dark:bg-black dark:text-white`}>
        <ThemeProvider
          attribute="class"
          defaultTheme="system"
          enableSystem
          disableTransitionOnChange
        >
          <SidebarProvider>
            <div className="flex w-full pt-12">
              <ClientSidebar />
              <main className="flex-1 min-w-0 w-full">
                <Header />
                {children}
              </main>
            </div>
          </SidebarProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
