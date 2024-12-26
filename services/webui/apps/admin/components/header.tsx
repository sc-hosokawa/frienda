"use client";

import { Button } from "@ui/components/ui/button";
import Link from "next/link";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@ui/components/ui/avatar";
import { LogOut } from "lucide-react";
import { ModeToggle } from "@ui/components/theme-button";
import { usePathname } from "next/navigation";

export function Header() {
  const pathname = usePathname();

  return (
    <header className="border-b">
      <div className="flex h-16 items-center px-4 justify-between">
        <div className="flex items-center gap-6">
          <div className="font-semibold text-lg">管理システム</div>
          <nav className="flex items-center gap-4">
            <Link
              href="/"
              className={`text-sm hover:text-primary relative ${
                pathname === "/" &&
                "after:absolute after:left-0 after:bottom-[-4px] after:w-full after:h-[2px] after:bg-primary"
              }`}
            >
              Home
            </Link>
            <Link
              href="/manage"
              className={`text-sm hover:text-primary relative ${
                pathname === "/manage" &&
                "after:absolute after:left-0 after:bottom-[-4px] after:w-full after:h-[2px] after:bg-primary"
              }`}
            >
              Manage
            </Link>
            <Link
              href="/analytics"
              className={`text-sm hover:text-primary relative ${
                pathname === "/analytics" &&
                "after:absolute after:left-0 after:bottom-[-4px] after:w-full after:h-[2px] after:bg-primary"
              }`}
            >
              Analytics
            </Link>
            <Link
              href="/system"
              className={`text-sm hover:text-primary relative ${
                pathname === "/system" &&
                "after:absolute after:left-0 after:bottom-[-4px] after:w-full after:h-[2px] after:bg-primary"
              }`}
            >
              System
            </Link>
          </nav>
        </div>

        <div className="flex items-center gap-4">
          <ModeToggle />
          <ProfileMenu />
        </div>
      </div>
    </header>
  );
}

function ProfileMenu() {
  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" className="relative h-8 w-8 rounded-full">
          <Avatar className="h-8 w-8">
            <AvatarImage src="/avatars/01.png" alt="@username" />
            <AvatarFallback>UN</AvatarFallback>
          </Avatar>
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent className="w-56" align="end">
        <DropdownMenuItem>
          <span>ログイン中: admin@example.com</span>
        </DropdownMenuItem>
        <DropdownMenuItem>
          <LogOut className="mr-2 h-4 w-4" />
          <span>ログアウト</span>
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
