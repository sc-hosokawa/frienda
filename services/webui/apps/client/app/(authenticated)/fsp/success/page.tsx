"use client";

import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import { Button } from "@ui/components/ui/button";
import Link from "next/link";

export default function SuccessPage() {
  const [loading, setLoading] = useState(true);
  const searchParams = useSearchParams();
  const sessionId = searchParams.get("session_id");

  useEffect(() => {
    // セッションIDを使って支払い状態を確認したり
    // ポイントを付与するAPIを呼び出したりする処理をここに
    const verifyPayment = async () => {
      try {
        // 支払い確認のAPI呼び出し
        setLoading(false);
      } catch (error) {
        console.error("Payment verification failed:", error);
      }
    };

    if (sessionId) {
      verifyPayment();
    }
  }, [sessionId]);

  if (loading) {
    return <div>処理中...</div>;
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-[50vh] space-y-4">
      <h1 className="text-2xl font-light">お支払いが完了しました</h1>
      <p>ポイントが追加されました。</p>
      <Link href="/fsp">
        <Button>戻る</Button>
      </Link>
    </div>
  );
}
