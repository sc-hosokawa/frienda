import "@ui/styles/globals.css";
import type { Metadata } from "next";
import { ThemeProvider } from "@ui/components/theme-provider";
import { AuthProvider } from "../../provider/auth-provider";
import { ApollClientProvider } from "../../provider/apollo-client";

export const metadata: Metadata = {
  title: "FRIENDSHIP. DAO",
  description: "Community-driven dashboard",
};

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className="bg-white text-black dark:bg-black dark:text-white">
        <ThemeProvider
          attribute="class"
          defaultTheme="system"
          enableSystem
          disableTransitionOnChange
        >
          <AuthProvider>
            <ApollClientProvider>
              <div className="container min-h-screen flex items-center justify-center">
                {children}
              </div>
            </ApollClientProvider>
          </AuthProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
