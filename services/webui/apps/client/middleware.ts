import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const session = request.cookies.get("session");

  // APIルートはミドルウェアをスキップ
  if (request.nextUrl.pathname.startsWith("/api/")) {
    return NextResponse.next();
  }

  // パブリックにアクセス可能なページの場合はセッションをチェックしない
  if (
    request.nextUrl.pathname.startsWith("/login") ||
    request.nextUrl.pathname.startsWith("/signin") ||
    request.nextUrl.pathname.startsWith("/termofservice") ||
    request.nextUrl.pathname.startsWith("/privacypolicy")
  ) {
    // セッションがある場合はホームにリダイレクト（利用規約とプライバシーポリシーページは除く）
    if (
      session &&
      !request.nextUrl.pathname.startsWith("/termofservice") &&
      !request.nextUrl.pathname.startsWith("/privacypolicy")
    ) {
      return NextResponse.redirect(new URL("/", request.url));
    }
    return NextResponse.next();
  }

  // セッションがない場合は /login にリダイレクト
  if (!session) {
    return NextResponse.redirect(new URL("/login", request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
