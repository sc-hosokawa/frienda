"use client";

import { useState } from "react";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { auth } from "../../../config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter } from "next/navigation";
import Image from "next/image";

export default function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      // Firebase Authでユーザー登録
      const userCredential = await createUserWithEmailAndPassword(
        auth,
        email,
        password,
      );

      // ユーザーのuidを取得
      const uid = userCredential.user.uid;
      console.log(uid);

      /*
      // TODO: ここでuidをバックエンドに送信して保存する処理を追加
      // 例: APIエンドポイントを呼び出してuidを保
      const response = await fetch('/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          uid,
          email,
        }),
      });

      if (response.ok) {
        // 登録成功後、ダッシュボードなどにリダイレクト
        router.push('/');
      }

      */
    } catch (error: any) {
      // エラーハンドリング
      console.error("Error signing up:", error);
      alert(error.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="w-full max-w-4xl mx-auto p-4">
      <div className="space-y-8">
        {/* Logo */}
        <div className="w-16 h-16 relative">
          <Image
            src="/logo_visualonly_dark.jpg"
            alt="Logo"
            width={64}
            height={64}
            className="object-contain"
          />
        </div>

        {/* Header */}
        <div className="space-y-2">
          <h1 className="text-5xl font-light tracking-wider">新規登録</h1>
          <p className="text-sm">FRIENDSHIP. DAOにサインイン</p>
        </div>

        {/* Form */}
        <form className="space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-2">
            <Label htmlFor="email">メールアドレス</Label>
            <Input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="メールアドレスを入力してください"
              className="bg-black border-white/20 text-white placeholder:text-white/50"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="password">パスワード</Label>
            <Input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="パスワードを入力してください"
              className="bg-black border-white/20 text-white placeholder:text-white/50"
              required
            />
          </div>

          <div className="flex flex-col sm:flex-row gap-4 pt-4">
            <Button
              type="submit"
              className="flex-1 bg-white text-black hover:bg-white/90"
              disabled={loading}
            >
              {loading ? "登録中..." : "アカウントを作成する"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
}
