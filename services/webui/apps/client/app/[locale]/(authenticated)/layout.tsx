import "@ui/styles/globals.css";
import { SidebarProvider, SidebarTrigger } from "@ui/components/ui/sidebar";
import { ClientSidebar } from "~/components/client-sidebar";
import Header from "~/components/header";

import { Toaster } from "react-hot-toast";

export default function AuthenticatedLayout({
  children,
  params: { locale },
}: {
  children: React.ReactNode;
  params: { locale: string };
}): JSX.Element {
  return (
    <SidebarProvider>
      <div className="flex w-full pt-12 dark">
        <SidebarTrigger />
        <ClientSidebar locale={locale} />
        <Header />
        <main className="flex-1 min-w-0 w-full">
          <div className="max-w-6xl mx-auto">{children}</div>
          <Toaster />
        </main>
      </div>
    </SidebarProvider>
  );
}
