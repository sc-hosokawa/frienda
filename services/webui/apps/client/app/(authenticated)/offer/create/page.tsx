"use client";

import { useState, useCallback } from "react";
import { Calendar, Trash2, Plus, Play } from "lucide-react";
import Image from "next/image";

import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { Textarea } from "@ui/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import { Switch } from "@ui/components/ui/switch";
import useUserStore from "../../../../store/user";
import { gql, useMutation } from "@apollo/client";
import { useRouter } from "next/navigation";
import { storage } from "../../../../config"; // Firebaseの設定が必要
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";

const CREATE_NEW_OFFER = gql`
  mutation CreateNewOffer(
    $owner: String!
    $deadline: String
    $title: String!
    $description: String!
    $fee: Int!
    $imageUrl: String
    $raidId: Int
    $category: String
    $place: String!
    $attention: String
    $requiredSkill: String
    $targetRole: String
    $publicity: Boolean
    $attachedImgs: [String!]
    $attachedFiles: [String!]
  ) {
    createNewOffer(
      input: {
        owner: $owner
        deadline: $deadline
        title: $title
        description: $description
        fee: $fee
        imageUrl: $imageUrl
        raidId: $raidId
        category: $category
        place: $place
        attention: $attention
        requiredSkill: $requiredSkill
        targetRole: $targetRole
        publicity: $publicity
        attachedImgs: $attachedImgs
        attachedFiles: $attachedFiles
      }
    ) {
      id
    }
  }
`;

// selectedFilesの型を拡張して、ファイルタイプの情報も持たせる
type UploadedFile = {
  file: File;
  type: "pdf" | "mp4";
};

export default function OfferCreatePage() {
  const { user } = useUserStore();
  const router = useRouter();
  const [formData, setFormData] = useState({
    title: "",
    description: "",
    deadline: "",
    place: "",
    category: "",
    attention: "",
    requiredSkill: "",
    fee: 0,
    isPublic: true,
    targetRole: "",
  });
  const [selectedImage, setSelectedImage] = useState<File | null>(null);
  const [selectedFiles, setSelectedFiles] = useState<UploadedFile[]>([]);
  const [isLoading, setIsLoading] = useState(false);

  const [createNewOffer] = useMutation(CREATE_NEW_OFFER);

  const handleImageUpload = useCallback(async (file: File) => {
    const storageRef = ref(storage, `offers/imgs/${Date.now()}_${file.name}`);
    await uploadBytes(storageRef, file);
    return getDownloadURL(storageRef);
  }, []);

  const handleFilesUpload = useCallback(async (files: File[]) => {
    const uploadPromises = files.map(async (file) => {
      const storageRef = ref(
        storage,
        `offers/files/${Date.now()}_${file.name}`,
      );
      await uploadBytes(storageRef, file);
      return getDownloadURL(storageRef);
    });
    return Promise.all(uploadPromises);
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      let imageUrl = null;
      let fileUrls: string[] = [];

      if (selectedImage) {
        imageUrl = await handleImageUpload(selectedImage);
      }

      if (selectedFiles.length > 0) {
        fileUrls = await handleFilesUpload(
          selectedFiles.map((file) => file.file),
        );
      }

      const result = await createNewOffer({
        variables: {
          owner: user?.id,
          ...formData,
          imageUrl,
          attachedImgs: imageUrl ? [imageUrl] : [],
          attachedFiles: fileUrls,
        },
      });

      router.push("/offers");
    } catch (error) {
      console.error("Error creating offer:", error);
      // エラー処理を追加
    } finally {
      setIsLoading(false);
    }
  };

  const categories = ["Creation", "Event", "Promotion", "Other"];

  return (
    <div className="min-h-screen  p-6">
      <div className="max-w-4xl mx-auto space-y-8">
        <div>
          <h1 className="text-6xl mb-2 text-white">New Offer</h1>
          <p className="text-gray-600">
            情報を入力し、オファーを作成しましょう。
          </p>
        </div>

        <div>
          <h2 className="text-xl font-semibold mb-4 text-white">
            Offer Information
          </h2>
          <div className="flex flex-wrap gap-2 mb-6">
            {categories.map((category, index) => (
              <span
                key={index}
                className={`px-4 py-1 rounded-full text-sm ${
                  index === 0
                    ? "bg-teal-500 text-white"
                    : "bg-gray-200 text-gray-800"
                }`}
              >
                {category}
              </span>
            ))}
          </div>

          <div className="grid gap-6">
            <div>
              <Label htmlFor="title">オファータイトル</Label>
              <Input
                id="title"
                placeholder="イベントに関係してくれる人募集！"
                className="border-gray-300"
                value={formData.title}
                onChange={(e) =>
                  setFormData((prev) => ({ ...prev, title: e.target.value }))
                }
              />
            </div>

            <div>
              <Label htmlFor="description">概要</Label>
              <Textarea
                id="description"
                placeholder="ここにイベントの詳細が入ります。ここにイベントの詳細が入ります。ここにイベントの詳細が入ります。ここにイベントの詳細が入ります。ここにイベントの詳細が入ります。"
                className="border-gray-300 min-h-[100px]"
                value={formData.description}
                onChange={(e) =>
                  setFormData((prev) => ({
                    ...prev,
                    description: e.target.value,
                  }))
                }
              />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <Label htmlFor="date">期日</Label>
                <div className="relative">
                  <Input
                    id="date"
                    type="date"
                    className="border-gray-300"
                    value={formData.deadline}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        deadline: e.target.value,
                      }))
                    }
                  />
                  <Calendar className="absolute right-3 top-2.5 h-5 w-5 text-gray-600" />
                </div>
              </div>
              <div>
                <Label htmlFor="category">カテゴリー</Label>
                <Select
                  value={formData.category}
                  onValueChange={(value) =>
                    setFormData((prev) => ({ ...prev, category: value }))
                  }
                >
                  <SelectTrigger className="border-gray-300">
                    <SelectValue placeholder="カテゴリーを選択" />
                  </SelectTrigger>
                  <SelectContent>
                    {categories.map((category) => (
                      <SelectItem key={category} value={category}>
                        {category}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="space-y-4">
              <Label>役割を選択してください</Label>
              <div className="flex flex-wrap gap-2">
                {[
                  "Musician",
                  "Curator",
                  "Creator",
                  "Supporter",
                  "特になし",
                ].map((role) => (
                  <Button
                    key={role}
                    variant={
                      formData.targetRole === role ? "default" : "outline"
                    }
                    onClick={() =>
                      setFormData((prev) => ({ ...prev, targetRole: role }))
                    }
                    className={`rounded-full ${
                      formData.targetRole === role
                        ? "bg-teal-600 text-white"
                        : "text-white"
                    }`}
                  >
                    {role}
                  </Button>
                ))}
              </div>
            </div>

            <div className="grid gap-6 md:grid-cols-2">
              <div>
                <Label>オファー詳細についての補足事項</Label>
                <Textarea
                  placeholder="追加事項が入ります。追加事項が入ります。"
                  className="border-gray-300"
                  value={formData.attention}
                  onChange={(e) =>
                    setFormData((prev) => ({
                      ...prev,
                      attention: e.target.value,
                    }))
                  }
                />
              </div>
              <div>
                <Label>対象となるスキル</Label>
                <Textarea
                  placeholder="デジタル技術があるアーティスト、フェスのプロモーションをしたことがあるプロモーター"
                  className="border-gray-300"
                  value={formData.requiredSkill}
                  onChange={(e) =>
                    setFormData((prev) => ({
                      ...prev,
                      requiredSkill: e.target.value,
                    }))
                  }
                />
              </div>
            </div>
          </div>
        </div>

        <div>
          <h2 className="text-xl font-semibold mb-4 text-gray-900">
            File Upload
          </h2>
          <p className="text-gray-600 mb-6">
            オファー関連をアップロードするとオファーページに反映されます。
            メディアのアップロードは任意です。
          </p>

          <div className="space-y-8">
            {/* カバー画像セクション */}
            <div>
              <Label className="text-lg font-semibold">カバー画像</Label>
              <p className="text-sm text-gray-600 mb-2">
                オファーの表紙として使用される画像です
              </p>
              <div className="mt-2 border-2 border-dashed border-gray-400 rounded-lg p-4">
                <div className="w-24 h-24 bg-gray-200 rounded-lg overflow-hidden">
                  <Image
                    src="/placeholder.svg"
                    alt="Cover preview"
                    width={96}
                    height={96}
                    className="w-full h-full object-cover"
                  />
                </div>
              </div>
            </div>

            {/* 添付画像セクション */}
            <div>
              <Label className="text-lg font-semibold">
                添付画像アップロード
              </Label>
              <p className="text-sm text-gray-600 mb-2">
                複数の画像をアップロードできます（jpg, png）
              </p>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mt-2">
                {[1, 2, 3, 4].map((i) => (
                  <div
                    key={i}
                    className="aspect-square border-2 border-dashed border-gray-400 rounded-lg flex flex-col items-center justify-center cursor-pointer hover:border-gray-500"
                  >
                    <Plus className="h-6 w-6 text-gray-600" />
                    <span className="text-sm text-gray-600 mt-2">
                      画像を追加
                    </span>
                  </div>
                ))}
              </div>
            </div>

            {/* 添付メディアセクション */}
            <div>
              <Label className="text-lg font-semibold">添付メディア</Label>
              <p className="text-sm text-gray-600 mb-2">
                PDFファイルや動画ファイル（MP4）をアップロードできます
              </p>

              {/* PDFアップロード */}
              <div className="mb-4">
                <Label className="text-sm font-medium">PDFファイル</Label>
                <div className="mt-2 border-2 border-dashed border-gray-400 rounded-lg p-6 flex flex-col items-center justify-center cursor-pointer hover:border-gray-500">
                  <Plus className="h-6 w-6 text-gray-600 mb-2" />
                  <span className="text-sm text-gray-600">
                    クリックしてPDFをアップロード
                  </span>
                  <span className="text-xs text-gray-500 mt-1">
                    または、ファイルをドラッグ＆ドロップ
                  </span>
                </div>
              </div>

              {/* 動画アップロード */}
              <div>
                <Label className="text-sm font-medium">
                  動画ファイル（MP4）
                </Label>
                <div className="mt-2 border-2 border-dashed border-gray-400 rounded-lg p-6 flex flex-col items-center justify-center cursor-pointer hover:border-gray-500">
                  <Plus className="h-6 w-6 text-gray-600 mb-2" />
                  <span className="text-sm text-gray-600">
                    クリックして動画をアップロード
                  </span>
                  <span className="text-xs text-gray-500 mt-1">
                    または、ファイルをドラッグ＆ドロップ
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div>
          <h2 className="text-xl font-semibold mb-4 text-gray-900">
            Publicity
          </h2>
          <p className="text-gray-600 mb-4">
            投稿開始すると、指定したユーザーのみ閲覧できるようになります。
          </p>
          <div className="flex items-center justify-between py-4">
            <Label htmlFor="public">公開/非公開</Label>
            <Switch id="public" />
          </div>
        </div>

        <div className="flex justify-end gap-4">
          <Button variant="ghost" className="text-gray-700">
            キャンセル
          </Button>
          <Button
            className="bg-teal-600 hover:bg-teal-700 text-white"
            onClick={handleSubmit}
          >
            登録完了へ
          </Button>
        </div>
      </div>
    </div>
  );
}
