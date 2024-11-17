"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import {
  createUserWithEmailAndPassword,
  sendEmailVerification,
} from "firebase/auth";
import { auth } from "../../../config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter } from "next/navigation";
import Image from "next/image";
import { gql, useMutation, useLazyQuery } from "@apollo/client";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { storage } from "../../../config";
import useUserStore from "../../../store/user";

// GraphQL Mutationの定義
const CREATE_USER_MUTATION = gql`
  mutation CreateNewUserData($input: CreateNewUserDataInput!) {
    createNewUserData(input: $input) {
      userId
      name
      imageUrl
    }
  }
`;

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

export default function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const [step, setStep] = useState<"signup" | "verify" | "profile">("signup");
  const [displayName, setDisplayName] = useState("");
  const [selectedCategory, setSelectedCategory] = useState<string>("");
  const [selectedPrimaryCategory, setSelectedPrimaryCategory] =
    useState<string>("Supporter");
  const [photoURL, setPhotoURL] = useState<string | null>(null);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [realname, setRealname] = useState("");
  const [verificationTimer, setVerificationTimer] =
    useState<NodeJS.Timeout | null>(null);
  const [getUserData, { data: userData }] = useLazyQuery(GET_USER_DATA);

  const { setUser } = useUserStore();

  const categories = [
    { id: "Musician", name: "ミュージシャン" },
    { id: "Curator", name: "キュレーター" },
    { id: "Supporter", name: "その他" },
  ];

  const [createUser] = useMutation(CREATE_USER_MUTATION);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const userCredential = await createUserWithEmailAndPassword(
        auth,
        email,
        password,
      );
      const user = userCredential.user;

      // メール認証を送信
      await sendEmailVerification(user);
      setStep("verify");

      // 認証状態を定期的にチェック
      const timer = setInterval(async () => {
        await user.reload();
        if (user.emailVerified) {
          clearInterval(timer);
          setStep("profile");
        }
      }, 3000);

      setVerificationTimer(timer);
    } catch (error: any) {
      console.error("Error signing up:", error);
      alert(
        "サインインに失敗しました。大変お手数ですが事務局にお問い合わせください。",
      );
    } finally {
      setLoading(false);
    }
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setImageFile(file);
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleProfileSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      let uploadedImageUrl = null;
      if (imageFile) {
        try {
          console.log("Starting image upload process...");
          console.log("Image file:", {
            name: imageFile.name,
            size: imageFile.size,
            type: imageFile.type,
          });

          const timestamp = Date.now();
          const safeFileName = `${auth.currentUser?.uid}_${timestamp}_image.${imageFile.name.split(".").pop()}`;
          console.log("Safe filename:", safeFileName);

          const storageRef = ref(
            storage,
            `user_images/${auth.currentUser?.uid}/${safeFileName}`,
          );
          console.log("Storage path:", storageRef.fullPath);

          const metadata = {
            contentType: imageFile.type,
            customMetadata: {
              originalName: imageFile.name,
            },
          };

          console.log("Starting upload with metadata:", metadata);
          const snapshot = await uploadBytes(storageRef, imageFile, metadata);
          console.log("Upload completed:", snapshot);

          console.log("Getting download URL...");
          uploadedImageUrl = await getDownloadURL(snapshot.ref);
          console.log("Download URL:", uploadedImageUrl);

          setPhotoURL(uploadedImageUrl);
          console.log("Photo URL state updated");
        } catch (error: any) {
          console.error("Upload error details:", {
            error,
            errorCode: error.code,
            errorMessage: error.message,
            errorName: error.name,
          });
          throw error;
        }
      }

      console.log(`selectedCategory: ${selectedCategory}`);
      console.log(`selectedPrimaryCategory: ${selectedPrimaryCategory}`);
      const response = await createUser({
        variables: {
          input: {
            id: auth.currentUser?.uid,
            email: auth.currentUser?.email,
            name: displayName,
            realname: realname,
            imageUrl: uploadedImageUrl,
            category: selectedCategory,
            primaryCategory: selectedPrimaryCategory,
          },
        },
      });

      if (response.data) {
        const { data: fetchedUserData } = await getUserData({
          variables: { userId: auth.currentUser?.uid },
        });
        setUser(fetchedUserData?.getUserData);

        const idToken = await auth.currentUser?.getIdToken(true);
        if (idToken && auth.currentUser?.uid) {
          try {
            const sessionResponse = await fetch("/api/auth/session", {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: JSON.stringify({
                idToken,
                uid: auth.currentUser?.uid,
              }),
            });

            const result = await sessionResponse.json();

            if (!sessionResponse.ok) {
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
            return; // セッション作成に失敗した場合は処理を中断
          }
        }
      }
    } catch (error: any) {
      console.error("Error creating profile:", error);
      alert("プロフィールの作成に失敗しました");
      setLoading(false);
    } finally {
      // setLoading(false);
    }
  };

  useEffect(() => {
    return () => {
      if (verificationTimer) {
        clearInterval(verificationTimer);
      }
    };
  }, [verificationTimer]);

  // メール認証待ち画面のレンダリング
  if (step === "verify") {
    return (
      <div className="w-full max-w-4xl mx-auto p-4">
        <div className="space-y-8">
          <div className="space-y-2">
            <h1 className="text-5xl font-light tracking-wider mb-8">
              メール認証
            </h1>
            <p className="text-sm">
              認証メールを送信しました。メールを確認して認証を完了してください。
            </p>
            <p className="text-sm">
              <span className="text-red-500">
                このページは閉じないでください。
              </span>
              認証が完了すると自動的に次の画面に進みます。
            </p>
            <p className="text-sm">
              次の画面でお名前と属性などの簡単な設定を行い、その後ご利用できるようになります。
            </p>
          </div>
          <Button
            onClick={() => {
              if (auth.currentUser) {
                sendEmailVerification(auth.currentUser);
                alert("認証メールを再送信しました");
              }
            }}
            className="bg-white text-black hover:bg-white/90"
          >
            認証メールを再送信
          </Button>
        </div>
      </div>
    );
  }

  // プロフィール設定画面のレンダリング
  if (step === "profile") {
    return (
      <div className="w-full max-w-4xl mx-auto p-4">
        <div className="space-y-8">
          <div className="space-y-2">
            <h1 className="text-5xl font-light tracking-wider">
              プロフィール設定
            </h1>
            <p className="text-sm">アカウントの詳細情報を入力してください</p>
          </div>

          <form className="space-y-6" onSubmit={handleProfileSubmit}>
            {/* プロフィール画像アップロード */}
            <div className="space-y-2">
              <Label htmlFor="profileImage">
                プロフィール画像（任意、後から設定・変更できます）
              </Label>
              <div className="flex flex-col items-center gap-4">
                {imagePreview && (
                  <div className="w-32 h-32 relative rounded-full overflow-hidden">
                    <Image
                      src={imagePreview}
                      alt="Profile preview"
                      fill
                      className="object-cover"
                    />
                  </div>
                )}
                <Input
                  id="profileImage"
                  type="file"
                  accept="image/*"
                  onChange={handleImageChange}
                  className="bg-black border-white/20 text-white"
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="realname">
                氏名（事務局以外の他のユーザーには許諾なく公開されません）
              </Label>
              <Input
                id="realname"
                value={realname}
                onChange={(e) => setRealname(e.target.value)}
                placeholder="氏名（本名・フルネーム）を入力してください。"
                className="bg-black border-white/20 text-white placeholder:text-white/50"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="displayName">
                ユーザーネーム（他のユーザーに表示されます）
              </Label>
              <Input
                id="displayName"
                value={displayName}
                onChange={(e) => setDisplayName(e.target.value)}
                placeholder="あなたの表示名を入力してください"
                className="bg-black border-white/20 text-white placeholder:text-white/50"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="category">属性</Label>
              <p className="text-sm text-gray-400">
                FRIENDSHIP.のキュレーターの方はキュレーターを選択してください。特に思い当たらない方はその他を選択してください。この設定は後ほど変更できます。
              </p>
              <select
                id="category"
                value={selectedCategory}
                onChange={(e) => setSelectedCategory(e.target.value)}
                className="w-full p-2 bg-black border border-white/20 text-white rounded-md"
                required
              >
                <option value="">選択してください</option>
                {categories.map((cat) => (
                  <option key={cat.id} value={cat.id}>
                    {cat.name}
                  </option>
                ))}
              </select>
            </div>

            <Button
              type="submit"
              className="w-full bg-white text-black hover:bg-white/90"
              disabled={loading}
            >
              {loading ? "保存中..." : "プロフィールを保存"}
            </Button>
          </form>
        </div>
      </div>
    );
  }

  // 既存のサインアップフォームのレンダリング
  return (
    <div className="w-full max-w-4xl mx-auto p-4">
      <div className="space-y-8">
        {/* Header */}
        <div className="space-y-2">
          <h1 className="text-5xl font-light tracking-wider">新規登録</h1>
          <p className="text-sm">FRIENDSHIP. DAOにサインイン</p>
        </div>

        {/* Form */}
        <form className="space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-2">
            <Label htmlFor="email">登録に利用するメールアドレス</Label>
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
            <Label htmlFor="password">登録するパスワード</Label>
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

          {/* 利用規約とプライバシーポリシーの同意文 */}
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
            <p>
              アカウントを作成するボタンをクリックすることで、
              利用規約とプライバシーポリシーに同意したものとみなされます。
            </p>
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
        <div className="flex justify-end">
          <Link
            href="/login"
            className="text-sm text-gray-200 hover:text-gray-400 hover:font-semibold"
          >
            ログインはこちら
          </Link>
        </div>
      </div>
    </div>
  );
}
