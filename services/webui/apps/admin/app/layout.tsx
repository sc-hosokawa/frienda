import "@ui/styles/globals.css";
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { ThemeProvider } from "@ui/components/theme-provider";
import { Toaster } from "@ui/components/ui/toaster";
import { ApollClientProvider } from "../provider/apollo-client";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "管理システム",
  description: "Admin System",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}): JSX.Element {
  return (
    <html lang="en" suppressHydrationWarning>
      <body
        className={`${inter.className} bg-white text-black dark:bg-black dark:text-white`}
      >
        <ThemeProvider
          attribute="class"
          defaultTheme="system"
          enableSystem
          disableTransitionOnChange
        >
          <ApollClientProvider>
            {children}
            <Toaster />
          </ApollClientProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
