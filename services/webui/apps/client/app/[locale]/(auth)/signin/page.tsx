"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import {
  createUserWithEmailAndPassword,
  sendEmailVerification,
} from "firebase/auth";
import { auth } from "~/config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter, useSearchParams } from "next/navigation";
import Image from "next/image";
import { gql, useMutation, useLazyQuery } from "@apollo/client";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { storage } from "~/config";
import useUserStore from "~/store/user";
import useAuthStepStore from "~/store/authStep";

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

const JOIN_WITH_INVITATION_CODE = gql`
  mutation JoinWithInvitationCode(
    $code: String!
    $joinedUserId: String!
    $joinedEmail: String!
  ) {
    joinWithInvitationCode(
      code: $code
      joinedUserId: $joinedUserId
      joinedEmail: $joinedEmail
    )
  }
`;

export default function SignIn() {
  const { step, setStep } = useAuthStepStore();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();
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
  const searchParams = useSearchParams();
  const inviteCode = searchParams.get("code");
  const [joinWithCode] = useMutation(JOIN_WITH_INVITATION_CODE);

  const { setUser } = useUserStore();

  const categories = [
    { id: "Musician", name: "ミュージシャン" },
    { id: "Curator", name: "キュレーター" },
    { id: "Supporter", name: "その他" },
  ];

  const [createUser] = useMutation(CREATE_USER_MUTATION);
  console.log(`step: ${step}`);

  // checkAuthStatus 関数を useEffect の外で定義
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

      if (result.status === "success") {
        if (result.data.emailVerified) {
          // メール認証完了後、ユーザーデータを確認
          const { data: fetchedUserData } = await getUserData({
            variables: { userId: user.uid },
          });

          if (fetchedUserData?.getUserData) {
            setStep("signup"); // ユーザーデータが存在する場合
          } else {
            setStep("profile"); // ユーザーデータが存在しない場合
          }
        } else {
          setStep("verify");
        }
      }
    } catch (error) {
      console.error("Error checking auth status:", error);
    }
  };

  useEffect(() => {
    // 1. 認証状態の変更を監視
    const unsubscribe = auth.onAuthStateChanged(async (user) => {
      if (user) {
        await user.reload(); // 最新の状態を取得
        await checkAuthStatus(user);
      }
    });

    // 2. verify ステップの場合は定期的にチェック
    const interval = setInterval(async () => {
      if (auth.currentUser && step === "verify") {
        await auth.currentUser.reload();
        await checkAuthStatus(auth.currentUser);
      }
    }, 3000);

    return () => {
      unsubscribe();
      clearInterval(interval);
    };
  }, [step]); // step の変更も監視

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const userCredential = await createUserWithEmailAndPassword(
        auth,
        email,
        password
      );
      const user = userCredential.user;

      await sendEmailVerification(user);
      setStep("verify");

      const checkVerification = setInterval(async () => {
        await checkAuthStatus(user);
      }, 3000);

      setVerificationTimer(checkVerification);
    } catch (error: any) {
      console.error("Error signing up:", error);
      alert(
        "サインインに失敗しました。大変お手数ですが事務局にお問い合わせください。"
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
            `user_images/${auth.currentUser?.uid}/${safeFileName}`
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

      if (inviteCode) {
        try {
          const { data } = await joinWithCode({
            variables: {
              code: inviteCode,
              joinedUserId: auth.currentUser?.uid,
              joinedEmail: auth.currentUser?.email,
            },
          });

          if (!data.joinWithInvitationCode) {
            console.error("Invitation code processing failed");
          } else {
            console.log("Invitation code processed successfully");
          }
        } catch (error) {
          console.error("Error processing invitation code:", error);
        }
      }

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
              setStep("signup");
              router.push("/");
            } else {
              throw new Error("Session creation failed");
            }
          } catch (error) {
            console.error("Session creation error:", error);
            alert(`セッションの作成に失敗しました: ${error}`);
            return;
          }
        }
      }
    } catch (error: any) {
      console.error("Error creating profile:", error);
      alert("プロフィールの作成に失敗しました");
    } finally {
      setLoading(false);
    }
  };

  // メール認証待ち画面のレンダリング
  if (step === "verify") {
    return (
      <div className="w-full max-w-4xl mx-auto p-4">
        <div className="space-y-8">
          <div className="space-y-2">
            <h1 className="text-5xl font-light tracking-wider mb-8">
              メール認証 / Email Verification
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
            <p className="text-sm text-gray-400">
              A verification email has been sent. Please check your email and
              complete the verification.
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
            認証メールを再送信 / Resend
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
              プロフィール設定 / Profile Setting
            </h1>
            <p className="text-sm">アカウントの詳細情報を入力してください</p>
          </div>

          <form className="space-y-6" onSubmit={handleProfileSubmit}>
            <div className="space-y-2">
              <Label htmlFor="profileImage">プロフィール画像</Label>
              <p className="text-sm text-gray-400">Profile image</p>
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
              <p className="text-sm text-gray-400">Name</p>
              <Input
                id="realname"
                value={realname}
                onChange={(e) => setRealname(e.target.value)}
                placeholder="氏名（本名・フルネーム）を入力してください。"
                className="bg-black border-white text-white placeholder:text-white/50"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="displayName">
                ユーザーネーム（他のユーザーに表示されます）
              </Label>
              <p className="text-sm text-gray-400">Username</p>
              <Input
                id="displayName"
                value={displayName}
                onChange={(e) => setDisplayName(e.target.value)}
                placeholder="あなたの表示名を入力してください"
                className="bg-black border-white text-white placeholder:text-white/50"
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
                className="w-full p-2 bg-black border border-white text-white rounded-md"
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
        <div className="">
          <h1 className="text-[90px] font-light tracking-wider">SIGNUP</h1>
          <p className="text-sm -mt-4">FRIENDSHIP. DAOにサインイン</p>
        </div>

        {inviteCode && (
          <div className="bg-white/10 p-4 rounded-lg">
            <p className="text-sm">
              招待リンクからアクセスされました。このまま登録を進めてください。
            </p>
          </div>
        )}

        <hr className="border-white/20" />

        {/* Form */}
        <form className="space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-2">
            <Label htmlFor="email">登録に利用するメールアドレス / Email</Label>
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
            <Label htmlFor="password">登録するパスワード / Password</Label>
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
              {loading ? "Signing up..." : "Create an Account"}
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
