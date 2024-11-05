import Image from "next/image";
import Link from "next/link";

export default function Header() {
  return (
    <header className="fixed top-0 right-0 z-50 bg-black text-white px-4 flex justify-end h-12 md:left-[var(--sidebar-width)] transition-[left] duration-200 ease-linear peer-data-[collapsible=icon]:md:left-[var(--sidebar-width-icon)] peer-data-[collapsible=offcanvas]:md:left-0">
      <div className="flex items-center bg-[#d1c3a9] text-black rounded-l-full">
        <div className="flex items-center gap-2 pl-1 pr-2 py-2">
          <Image
            src="/home.svg"
            alt="Profile picture"
            width={24}
            height={24}
            className="rounded-full"
          />
          <span className="text-sm">@nironironirohey</span>
        </div>

        <Link
          href="/fsp"
          className="flex items-center gap-2 bg-black/10 px-3 py-1 hover:bg-black/20"
        >
          <span className="text-xs">Total Point: 1,234</span>
        </Link>
      </div>
    </header>
  );
}
