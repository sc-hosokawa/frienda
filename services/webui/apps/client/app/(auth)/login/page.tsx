"use client";

import { useState } from "react";
import {
  signInWithEmailAndPassword,
  sendPasswordResetEmail,
} from "firebase/auth";
import { auth } from "../../../config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter } from "next/navigation";
import { gql, useLazyQuery } from "@apollo/client";
import useAuthStore from "../../../store/auth";
import useUserStore from "../../../store/user";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const { setAuthInfo } = useAuthStore();
  const { setUser } = useUserStore();
  const [resetDialogOpen, setResetDialogOpen] = useState(false);
  const [resetEmail, setResetEmail] = useState("");

  const [getUserData] = useLazyQuery(GET_USER_DATA, {
    onCompleted: async (data) => {
      if (data?.getUserData) {
        console.log(data.getUserData);
        setUser(data.getUserData);

        const idToken = await auth.currentUser?.getIdToken(true);
        if (idToken && auth.currentUser?.uid) {
          try {
            const response = await fetch("/api/auth/session", {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: JSON.stringify({
                idToken,
                uid: auth.currentUser?.uid,
              }),
            });

            const result = await response.json();

            if (!response.ok) {
              throw new Error(result.error || "Failed to set session");
            }

            if (result.status === "success") {
              console.log("Session created successfully");
              router.push("/");
            } else {
              throw new Error("Session creation failed");
            }
          } catch (error) {
            console.error("Session creation error:", error);
            alert(`セッションの作成に失敗しました: ${error}`);
          }
        }
      }
    },
    onError: (error) => {
      console.error("GraphQL Error:", error);
      alert("ユーザー情報の取得に失敗しました");
    },
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const userCredential = await signInWithEmailAndPassword(
        auth,
        email,
        password,
      );
      const user = userCredential.user;

      await setAuthInfo(user);

      getUserData({
        variables: {
          userId: user.uid,
        },
      });
    } catch (error: any) {
      console.error("Error logging in:", error);
      let errorMessage = "ログインに失敗しました";

      if (error.code === "auth/user-not-found") {
        errorMessage = "ユーザーが見つかりません";
      } else if (error.code === "auth/wrong-password") {
        errorMessage = "パスワードが間違っています";
      }

      alert(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  const handleSignUp = () => {
    router.push("/signin");
  };

  const handlePasswordReset = async () => {
    if (!resetEmail) {
      alert("メールアドレスを入力してください");
      return;
    }

    try {
      await sendPasswordResetEmail(auth, resetEmail);
      alert(
        "パスワードリセットのメールを送信しました。メールをご確認ください。",
      );
      setResetDialogOpen(false);
      setResetEmail("");
    } catch (error: any) {
      console.error("Password reset error:", error);
      let errorMessage = "パスワードリセットメールの送信に失敗しました";

      if (error.code === "auth/user-not-found") {
        errorMessage = "このメールアドレスのユーザーが見つかりません";
      } else if (error.code === "auth/invalid-email") {
        errorMessage = "無効なメールアドレスです";
      }

      alert(errorMessage);
    }
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
            <button
              type="button"
              className="hover:underline text-left"
              onClick={() => setResetDialogOpen(true)}
            >
              パスワードをお忘れの方はこちら →
            </button>
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
              className="flex-1 bg-black text-white border-gray-500 hover:bg-white/90 hover:text-black transition-colors"
              onClick={handleSignUp}
            >
              新規登録
            </Button>
          </div>
        </form>
      </div>

      <Dialog open={resetDialogOpen} onOpenChange={setResetDialogOpen}>
        <DialogContent className="bg-black border border-white/20">
          <DialogHeader>
            <DialogTitle>パスワードリセット</DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="reset-email">メールアドレス</Label>
              <Input
                id="reset-email"
                type="email"
                value={resetEmail}
                onChange={(e) => setResetEmail(e.target.value)}
                placeholder="メールアドレスを入力してください"
                className="bg-black border-white/20 text-white placeholder:text-white/50"
              />
            </div>
            <Button
              type="button"
              className="w-full bg-white text-black hover:bg-white/90"
              onClick={handlePasswordReset}
            >
              パスワードを再設定
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}

// GraphQLクエリの定義
const GET_USER_DATA = gql`
  query GetUserData($userId: String!) {
    getUserData(userId: $userId) {
      id
      name
      imageUrl
      fspBalance
      credentialBalance
      role
      primaryRole
      greeting
      skill
      xHandle
      instagramHandle
      fbHandle
      interestOffer
      createdAt
      belongsToArtists {
        id
        artistId
        name
        imageUrl
        fsp
        status
        isAdmin
      }
      primaryArtist {
        id
        artistId
        name
        imageUrl
        fsp
        status
        isAdmin
      }
    }
  }
`;
