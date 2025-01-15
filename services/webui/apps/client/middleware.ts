import Negotiator from "negotiator";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { SUPPORTED_LOCALES, DEFAULT_LOCALE } from "~/i18n/settings";

const extractLocale = (headers: Negotiator.Headers) => {
  return (
    new Negotiator({ headers }).language(SUPPORTED_LOCALES) ?? DEFAULT_LOCALE
  );
};

export function middleware(request: NextRequest) {
  const session = request.cookies.get("session");
  const pathname = request.nextUrl.pathname;
  
	// public配下のファイルへのリクエストはスキップ
  if (pathname.includes(".")) {
    return NextResponse.next();
  }
  // APIルートはミドルウェアをスキップ
  if (pathname.startsWith("/api/")) {
    return NextResponse.next();
  }

  const pathnameIsMissingLocale = SUPPORTED_LOCALES.every(
    (locale) => !pathname.startsWith(`/${locale}/`) && pathname !== `/${locale}`
  );

  // get locale from headers
  const headers = {
    "accept-language": request.headers.get("accept-language") ?? "",
  };

  const locale = extractLocale(headers);

  // redirect to the same path with the locale
  if (pathnameIsMissingLocale) {
    return NextResponse.redirect(new URL(`/${locale}${pathname}`, request.url));
  }

  const isRoot = pathname === `/${locale}`;

  // ルートパスの処理を修正
  if (isRoot) {
    if (session) {
      return NextResponse.redirect(new URL(`/${locale}/home`, request.url));
    }
    return NextResponse.redirect(new URL(`/${locale}/login`, request.url));
  }

  // パブリックにアクセス可能なページの場合はセッションをチェックしない
  if (
    pathname.startsWith(`/${locale}/login`) ||
    pathname.startsWith(`/${locale}/signin`) ||
    pathname.startsWith(`/${locale}/termofservice`) ||
    pathname.startsWith(`/${locale}/privacypolicy`)
  ) {
    // セッションがある場合はダッシュボードにリダイレクト（利用規約とプライバシーポリシーページは除く）
    if (
      session &&
      !pathname.startsWith(`/${locale}/termofservice`) &&
      !pathname.startsWith(`/${locale}/privacypolicy`)
    ) {
      return NextResponse.redirect(new URL(`/${locale}/home`, request.url));
    }
    return NextResponse.next();
  }

  // セッションがない場合は /login にリダイレクト
  if (!session) {
    return NextResponse.redirect(new URL(`/${locale}/login`, request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
