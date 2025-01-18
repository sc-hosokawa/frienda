import "@ui/styles/globals.css";

import { ThemeProvider } from "@ui/components/theme-provider";
import { Toaster } from "react-hot-toast";
import { AuthProvider } from "~/provider/auth-provider";
import { ApollClientProvider } from "~/provider/apollo-client";
import { JostFont } from "../utils/fonts";

export default function RootLayout({
  children,
  params: { locale },
}: {
  children: React.ReactNode;
  params: { locale: string };
}) {
  return (
    <html lang={locale} suppressHydrationWarning className="dark">
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
              {children}
              <Toaster />
            </ApollClientProvider>
          </AuthProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
