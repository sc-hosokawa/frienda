"use client";

import { useState } from "react";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "../../../config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter } from "next/navigation";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      // Firebase Authでログイン
      const userCredential = await signInWithEmailAndPassword(
        auth,
        email,
        password,
      );

      // ユーザー情報を取得
      const user = userCredential.user;

      // IDトークンを取得
      const idToken = await user.getIdToken();

      console.log(user);
      console.log(idToken);

      /* 
      // バックエンドAPIに認証情報を送信
      const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${idToken}`,
        },
        body: JSON.stringify({
          uid: user.uid,
          email: user.email,
        }),
      });

      if (response.ok) {
        // ログイン成功後、ダッシュボードにリダイレクト
        router.push('/');
      } else {
        throw new Error('Login failed');
      }
    */
    } catch (error: any) {
      console.error("Error logging in:", error);
      alert(error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleSignUp = () => {
    router.push("/signin");
  };

  return (
    <div className="w-full max-w-4xl mx-auto p-4">
      <div className="space-y-8">
        {/* Logo */}
        <div className="w-16 h-16 relative">
          <div className="w-full h-full rounded-full border-4 border-white animate-[spin_3s_linear_infinite]" />
        </div>

        {/* Header */}
        <div className="space-y-2">
          <h1 className="text-5xl font-light tracking-wider">LOGIN</h1>
          <p className="text-sm">FRIENDSHIP. DAOにログイン</p>
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

          <div className="text-sm">
            <a href="#" className="hover:underline">
              パスワードをお忘れの方はこちら →
            </a>
          </div>

          <div className="flex flex-col sm:flex-row gap-4 pt-4">
            <Button
              type="submit"
              className="flex-1 bg-white text-black hover:bg-white/90"
              disabled={loading}
            >
              {loading ? "ログイン中..." : "ログイン"}
            </Button>
            <Button
              type="button"
              variant="outline"
              className="flex-1 bg-white text-black border-white hover:bg-black hover:text-white transition-colors"
              onClick={handleSignUp}
            >
              新規登録
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
}
