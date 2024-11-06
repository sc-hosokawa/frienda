"use client";

import Image from "next/image";
import Link from "next/link";
import useUserStore from "../../store/user";
import { useRouter } from "next/navigation";

export default function Header() {
  const { user, clearUser } = useUserStore();
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
    <header className="fixed top-0 right-0 z-50 bg-black text-white px-4 flex justify-end h-12 md:left-[var(--sidebar-width)] transition-[left] duration-200 ease-linear peer-data-[collapsible=icon]:md:left-[var(--sidebar-width-icon)] peer-data-[collapsible=offcanvas]:md:left-0">
      <div className="flex items-center bg-[#d1c3a9] text-black rounded-l-full">
        <Link
          href="/profile"
          className="flex items-center gap-2 pl-1 pr-2 py-2 hover:bg-black/10"
        >
          <Image
            src={user?.imageUrl || "/logo_visualonly.jpg"}
            alt="Profile picture"
            width={24}
            height={24}
            className="rounded-full"
          />
          <span className="text-sm">{user?.name}</span>
          <span className="text-sm">{user?.id}</span>
        </Link>

        <Link
          href="/fsp"
          className="flex items-center gap-2 bg-black/10 px-3 py-1 hover:bg-black/20"
        >
          <span className="text-xs">Total Point: {user?.fspBalance}</span>
        </Link>

        <button
          onClick={handleLogout}
          className="flex items-center gap-2 bg-black/10 px-3 py-1 hover:bg-black/20 border-l border-black/20"
        >
          <span className="text-xs">ログアウト</span>
        </button>
      </div>
    </header>
  );
}
