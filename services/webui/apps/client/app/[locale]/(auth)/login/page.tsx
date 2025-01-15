"use client";

import Link from "next/link";
import { useState } from "react";
import {
  signInWithEmailAndPassword,
  sendPasswordResetEmail,
  sendEmailVerification,
} from "firebase/auth";
import { auth } from "~/config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter } from "next/navigation";
import { gql, useLazyQuery } from "@apollo/client";
import useAuthStore from "~/store/auth";
import useUserStore from "~/store/user";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";
import useAuthStepStore from "~/store/authStep";

export default function Login({
  params: { locale },
}: {
  params: { locale: string };
}) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const { setAuthInfo } = useAuthStore();
  const { setUser } = useUserStore();
  const [resetDialogOpen, setResetDialogOpen] = useState(false);
  const [resetEmail, setResetEmail] = useState("");
  const [authCheckComplete, setAuthCheckComplete] = useState(false);
  const { setStep } = useAuthStepStore();

  const [getUserData] = useLazyQuery(GET_USER_DATA, {
    onCompleted: async (data) => {
      try {
        if (data?.getUserData) {
          console.log(data.getUserData);
          setUser(data.getUserData);

          const idToken = await auth.currentUser?.getIdToken(true);
          if (idToken && auth.currentUser?.uid) {
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
              router.push(`/${locale}/home`);
              //setLoading(false);
            } else {
              throw new Error("Session creation failed");
            }
          }
        }
      } catch (error) {
        console.error("Session creation error:", error);
        alert(`セッションの作成に失敗しました: ${error}`);
      } finally {
        // setLoading(false);
      }
    },
    onError: (error) => {
      console.error("GraphQL Error:", error);
      // alert("ユーザー情報の取得に失敗しました");
      setLoading(false);
    },
  });

  const checkAuthStatus = async (user: any) => {
    try {
      const idToken = await user.getIdToken(true);

      const response = await fetch("/api/auth/verify", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ idToken }),
      });

      const result = await response.json();

      if (!result.data.emailVerified) {
        try {
          await sendEmailVerification(user);
          console.log("Verification email resent");
          setStep("verify");
          router.push("/signin");
          alert("認証メールを再送信しました。メールをご確認ください。");
          return false;
        } catch (error: any) {
          console.error("Email verification error:", error);
          let errorMessage = "認証メールの送信に失敗しました";

          if (error.code === "auth/too-many-requests") {
            errorMessage =
              "短時間に多くのメールが送信されました。しばらく待ってから再試行してください。";
          }

          alert(errorMessage);
          return false;
        }
      }

      const { data } = await getUserData({
        variables: {
          userId: user.uid,
        },
      });

      if (!data?.getUserData?.name) {
        setStep("profile");
        router.push("/signin");
        return false;
      }

      return true;
    } catch (error) {
      console.error("Error checking auth status:", error);
      return false;
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const userCredential = await signInWithEmailAndPassword(
        auth,
        email,
        password
      );
      const user = userCredential.user;

      const isAuthComplete = await checkAuthStatus(user);
      if (!isAuthComplete) {
        setLoading(false);
        return;
      }

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
        "パスワードリセットのメールを送信しました。メールをご確認ください。"
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
      {/* Logo - 位置を固定 
      <div className="fixed top-8 left-8">
        <div className="w-16 h-16 relative">
          <Image
            src="/logo_visualonly_dark.jpg"
            alt="Logo"
            width={60}
            height={60}
          />
        </div>
      </div>
      */}

      <div className="space-y-8">
        {/* Header */}
        <div className="">
          <h1 className="text-[90px] font-light tracking-wider">LOGIN</h1>
          <p className="text-sm -mt-4">FRIENDSHIP. DAOにログイン</p>
        </div>

        <hr className="border-white/20" />

        {/* Form */}
        <form className="space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-2">
            <Label htmlFor="email">メールアドレス / Email</Label>
            <Input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="メールアドレスを入力してください / Input your email"
              className="bg-black border-white text-white placeholder:text-white/50 h-[90px] rounded-3xl"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="password">パスワード / Password</Label>
            <Input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="パスワードを入力してください / Input a password"
              className="bg-black border-white text-white placeholder:text-white/50 h-[90px] rounded-3xl"
              required
            />
          </div>

          <div className="text-sm text-gray-400 space-y-2">
            <p>
              <Link
                href="/termofservice"
                className="text-white hover:underline"
              >
                利用規約
              </Link>{" "}
              および{" "}
              <Link
                href="/privacypolicy"
                className="text-white hover:underline"
              >
                プライバシーポリシー
              </Link>{" "}
              をご確認ください。
            </p>
          </div>

          <div className="text-sm">
            <button
              type="button"
              className="hover:underline text-left"
              onClick={() => setResetDialogOpen(true)}
            >
              パスワードをお忘れの方はこちら / Forgot your password? →
            </button>
          </div>

          <div className="flex flex-col sm:flex-row gap-8 pt-4">
            <Button
              type="submit"
              className="bg-white text-black hover:bg-white/90 h-[60px] w-[180px] rounded-full"
              disabled={loading}
            >
              {loading ? "Processing..." : "Login"}
            </Button>
            <Button
              type="button"
              variant="outline"
              className="bg-black text-white border-gray-500 hover:bg-white/90 hover:text-black transition-colors h-[60px] w-[180px] rounded-full border-dashed"
              onClick={handleSignUp}
            >
              Signup
            </Button>
          </div>
        </form>
      </div>

      <Dialog open={resetDialogOpen} onOpenChange={setResetDialogOpen}>
        <DialogContent className="bg-black border border-white/20">
          <DialogHeader>
            <DialogTitle>パスワードリセット / Reset Password</DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="reset-email">メールアドレス / Email</Label>
              <Input
                id="reset-email"
                type="email"
                value={resetEmail}
                onChange={(e) => setResetEmail(e.target.value)}
                placeholder="メールアドレスを入力してください / Input your email"
                className="bg-black border-white/20 text-white placeholder:text-white/50"
              />
            </div>
            <Button
              type="button"
              className="w-full bg-white text-black hover:bg-white/90"
              onClick={handlePasswordReset}
            >
              パスワードを再設定 / reset
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
      realname
      isSuperAdmin
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
