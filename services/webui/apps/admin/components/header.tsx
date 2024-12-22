import { Button } from "@ui/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@ui/components/ui/avatar";
import { LogOut } from "lucide-react";
import { ModeToggle } from "@ui/components/theme-button";

export function Header() {
  return (
    <header className="border-b">
      <div className="flex h-16 items-center px-4 justify-between">
        <div className="font-semibold text-lg">アーティスト管理システム</div>

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
