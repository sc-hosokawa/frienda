import "@ui/styles/globals.css";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "FRIENDSHIP. DAO",
  description: "Community-driven dashboard",
};

export default function AuthLayout({
  children,
  params: { locale },
}: {
  children: React.ReactNode;
  params: { locale: string };
}) {
  return (
    <div className="container min-h-screen flex items-center justify-center">
      {children}
    </div>
  );
}
