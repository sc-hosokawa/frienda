"use client";

import Image from "next/image";
import Link from "next/link";
import useUserStore from "../../store/user";
import { useRouter } from "next/navigation";
import { LogOut } from "lucide-react";
import { useUserBalance } from "../../store/user";

export default function Header() {
  const { user, clearUser } = useUserStore();
  const { loading } = useUserBalance();
  const router = useRouter();

  const handleLogout = async () => {
    try {
      await fetch("/api/auth/logout", { method: "POST" });
      clearUser();
      router.push("/login");
    } catch (error) {
      console.error("Logout failed:", error);
    }
  };

  return (
    <header className="dark bg-transparent fixed top-0 right-0 z-50 bg-black text-white flex justify-end h-[60px] md:left-[var(--sidebar-width)] transition-[left] duration-200 ease-linear peer-data-[collapsible=icon]:md:left-[var(--sidebar-width-icon)] peer-data-[collapsible=offcanvas]:md:left-0">
      <div className="flex items-center bg-[#E4DBC0] text-black rounded-l-full pl-4">
        <Link
          href="/profile"
          className="flex items-center gap-2 pl-1 pr-2 py-2 mr-2 hover:bg-black/10"
        >
          <Image
            src={user?.imageUrl || "/logo_visualonly.jpg"}
            alt="Profile picture"
            width={36}
            height={36}
            className="rounded-full"
          />
          <div className="flex flex-col px-2">
            <span className="text-sm">@{user?.name}</span>
            <span className="text-xs text-gray-600">{user?.realname}</span>
          </div>
        </Link>

        <Link
          href="/fsp"
          className="flex items-center gap-2 px-2 py-1 hover:bg-black/20 rounded-full border border-black"
        >
          <span className="text-xs flex gap-8 items-center">
            <Image src="/disc.svg" alt="header" width={24} height={24} />
            Total Point:{" "}
            {loading
              ? "---"
              : user?.fspBalance === undefined
                ? "0"
                : user.fspBalance.toLocaleString()}
          </span>
        </Link>

        <button
          onClick={handleLogout}
          className="flex items-center gap-2 p-2 hover:bg-black/20 rounded-full mx-2"
        >
          <LogOut className="w-4 h-4" />
          <span className="text-xs">ログアウト</span>
        </button>
      </div>
    </header>
  );
}
