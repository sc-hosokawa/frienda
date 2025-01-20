import Negotiator from "negotiator";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { SUPPORTED_LOCALES, DEFAULT_LOCALE } from "~/i18n/settings";

type SupportedLocale = (typeof SUPPORTED_LOCALES)[number];

const isValidLocale = (locale: string): locale is SupportedLocale => {
  return SUPPORTED_LOCALES.includes(locale as SupportedLocale);
};

// ロケールの優先順位
// 1. ユーザーが明示的に選択した言語（Cookie）
// 2. ブラウザの言語設定（Accept-Language Header）
// 3. defaultLocale（ja）
const getLocale = (request: NextRequest): SupportedLocale => {
  // First check if there's a preferred locale in cookies
  const preferredLocale = request.cookies.get("preferredLocale")?.value;
  if (preferredLocale && isValidLocale(preferredLocale)) {
    return preferredLocale;
  }

  // Fall back to accept-language header
  const headers = {
    "accept-language": request.headers.get("accept-language") ?? "",
  };

  const negotiatedLocale = new Negotiator({ headers }).language(
    SUPPORTED_LOCALES,
  );
  return isValidLocale(negotiatedLocale!) ? negotiatedLocale : DEFAULT_LOCALE;
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
    (locale) =>
      !pathname.startsWith(`/${locale}/`) && pathname !== `/${locale}`,
  );

  // Get locale from cookies or headers
  const locale = getLocale(request);

  // redirect to the same path with the locale
  if (pathnameIsMissingLocale) {
    return NextResponse.redirect(new URL(`/${locale}${pathname}`, request.url));
  }

  // If a user accesses a page with a specific locale, update their preference
  const pathLocale = pathname.split("/")[1];
  const response = NextResponse.next();

  // 現在のロケールが有効な場合のみクッキーを設定
  if (pathLocale && isValidLocale(pathLocale)) {
    response.cookies.set("preferredLocale", pathLocale, {
      path: "/",
      maxAge: 60 * 60 * 24 * 365, // 1年間有効
    });
  }

  const isRoot = pathname === `/${locale}`;

  // ルートパスの処理
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
    pathname.startsWith(`/${locale}/privacypolicy`) ||
    pathname.startsWith(`/${locale}/tokutei`)
  ) {
    // セッションがある場合はダッシュボードにリダイレクト（利用規約とプライバシーポリシーページは除く）
    if (
      session &&
      !pathname.startsWith(`/${locale}/termofservice`) &&
      !pathname.startsWith(`/${locale}/privacypolicy`) &&
      !pathname.startsWith(`/${locale}/tokutei`)
    ) {
      return NextResponse.redirect(new URL(`/${locale}/home`, request.url));
    }
    return response;
  }

  // セッションがない場合は /login にリダイレクト
  if (!session) {
    return NextResponse.redirect(new URL(`/${locale}/login`, request.url));
  }

  return response;
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
