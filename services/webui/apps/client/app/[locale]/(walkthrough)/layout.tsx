import "@ui/styles/globals.css";
import { ThemeProvider } from "@ui/components/theme-provider";
import { AuthProvider } from "../../../provider/auth-provider";
import { Jost, Noto_Sans_JP } from "next/font/google";

const JostFont = Jost({
  subsets: ["latin"],
  weight: ["100", "200", "300", "400", "500", "600", "700", "800", "900"],
  display: "swap",
  variable: "--font-jost",
});

const NotoSansJP = Noto_Sans_JP({
  subsets: ["latin"],
  weight: ["100", "300", "400", "500", "700", "900"],
  display: "swap",
  variable: "--font-noto-sans-jp",
});

export default function WalkthroughLayout({
  children,
}: {
  children: React.ReactNode;
}): JSX.Element {
  return (
    <ThemeProvider
      attribute="class"
      defaultTheme="dark"
      enableSystem={false}
      disableTransitionOnChange
    >
      <AuthProvider>
        <div
          className={`${JostFont.className} bg-white text-black dark:bg-black dark:text-white dark`}
        >
          <div className="flex w-full pt-12">
            <main className="flex-1 min-w-0 w-full">
              <div className="max-w-6xl mx-auto">{children}</div>
            </main>
          </div>
        </div>
      </AuthProvider>
    </ThemeProvider>
  );
}
