import "@ui/styles/globals.css";
import type { Metadata } from "next";
import { Jost } from "next/font/google";
import { ThemeProvider } from "@ui/components/theme-provider";
import { Toaster } from "@ui/components/ui/toaster";
import { Header } from "../components/header";
import Providers from "./providers";

const JostFont = Jost({
  subsets: ["latin"],
  weight: ["100", "200", "300", "400", "500", "600", "700", "800", "900"],
  display: "swap",
  variable: "--font-jost",
});

export const metadata: Metadata = {
  title: "Admin | FRIENDSHIP. DAO",
  description: "Admin dashboard for FRIENDSHIP. DAO",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}): JSX.Element {
  return (
    <html lang="en" suppressHydrationWarning>
      <body
        className={`${JostFont.className} bg-white text-black dark:bg-black dark:text-white dark`}
      >
        <ThemeProvider
          attribute="class"
          defaultTheme="system"
          enableSystem
          disableTransitionOnChange
        >
          <Providers>
            <Header />
            {children}
            <Toaster />
          </Providers>
        </ThemeProvider>
      </body>
    </html>
  );
}
