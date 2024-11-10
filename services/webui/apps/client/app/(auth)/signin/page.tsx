"use client";

import { useState } from "react";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { auth } from "../../../config";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { useRouter } from "next/navigation";
import Image from "next/image";
import { gql, useMutation } from "@apollo/client";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { storage } from "../../../config";

// GraphQL Mutationの定義
const CREATE_USER_MUTATION = gql`
  mutation CreateNewUserData($input: CreateNewUserDataInput!) {
    createNewUserData(input: $input) {
      userId
      name
      realname
      imageUrl
    }
  }
`;

// ファイル名から拡張子を取得する関数
const getExtension = (filename: string): string => {
  return filename.slice(((filename.lastIndexOf(".") - 1) >>> 0) + 1);
};

export default function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const [step, setStep] = useState<"signup" | "profile">("signup");
  const [displayName, setDisplayName] = useState("");
  const [selectedCategory, setSelectedCategory] = useState<string>("");
  const [selectedPrimaryCategory, setSelectedPrimaryCategory] =
    useState<string>("");
  const [photoURL, setPhotoURL] = useState<string | null>(null);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [realname, setRealname] = useState("");

  const categories = [
    { id: "Musician", name: "ミュージシャン" },
    { id: "Curator", name: "キュレーター" },
    { id: "Creator", name: "クリエイター" },
    { id: "Supporter", name: "サポーター" },
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
      const uid = userCredential.user.uid;
      console.log(uid);

      setStep("profile");
    } catch (error: any) {
      console.error("Error signing up:", error);
      alert(error.message);
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

      console.log(selectedCategory);

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
        router.push("/");
      }
    } catch (error: any) {
      console.error("Error creating profile:", error);
      alert("プロフィールの作成に失敗しました");
    } finally {
      setLoading(false);
    }
  };

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
              <Label htmlFor="profileImage">プロフィール画像</Label>
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
              <Label htmlFor="realname">氏名</Label>
              <Input
                id="realname"
                value={realname}
                onChange={(e) => setRealname(e.target.value)}
                placeholder="氏名（本名・フルネーム）を入力してください。他のユーザーには表示されません。"
                className="bg-black border-white/20 text-white placeholder:text-white/50"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="displayName">ユーザーネーム</Label>
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
              <Label htmlFor="category">カテゴリー</Label>
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

            <div className="space-y-2">
              <Label htmlFor="primaryCategory">サブカテゴリー</Label>
              <select
                id="primaryCategory"
                value={selectedPrimaryCategory}
                onChange={(e) => setSelectedPrimaryCategory(e.target.value)}
                className="w-full p-2 bg-black border border-white/20 text-white rounded-md"
                required
              >
                <option value="">選択してください</option>
                {categories
                  .filter((cat) => cat.id !== selectedCategory)
                  .map((cat) => (
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
