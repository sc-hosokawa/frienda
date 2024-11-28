"use client";

import { useState, useCallback } from "react";
import { Plus } from "lucide-react";
import Image from "next/image";
import Link from "next/link";

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
import { storage } from "../../../../config";
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
    } finally {
      setIsLoading(false);
    }
  };

  const categories = ["Creation", "Event", "Promotion", "Other"];

  return (
    <>
      <Link href="/offer">
        <div className="flex items-center gap-2">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6 -mt-6"
          />
        </div>
      </Link>
      <div className="min-h-screen p-6">
        <div className="max-w-6xl mx-auto space-y-8">
          <div>
            <h1 className="text-6xl mb-2 text-white font-light">New Offer</h1>
            <p className="">情報を入力し、オファーを作成しましょう。</p>
          </div>

          <div>
            <h2 className="text-2xl my-20 text-white font-light">
              ( Offer Information )
            </h2>
            <div className="flex flex-col gap-2 mb-6">
              <p className="text-sm text-white">カテゴリー</p>
              <div className="flex flex-wrap gap-2">
                {categories.map((category) => (
                  <button
                    key={category}
                    onClick={() =>
                      setFormData((prev) => ({ ...prev, category }))
                    }
                    className={`h-[48px] w-[180px] rounded-full text-[18px] transition-colors ${
                      formData.category === category
                        ? "bg-white text-black"
                        : "bg-black text-white border border-white hover:bg-gray-100 hover:text-black"
                    }`}
                  >
                    {category}
                  </button>
                ))}
              </div>
            </div>

            <div className="grid gap-6 mt-12">
              <div className="grid grid-cols-2 gap-6">
                <div className="h-[180px]">
                  <Label htmlFor="title">オファー名</Label>
                  <Input
                    id="title"
                    placeholder="イベントに関係してくれる人募集！"
                    className="border-[#707070] h-[calc(180px-24px)] rounded-2xl"
                    value={formData.title}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        title: e.target.value,
                      }))
                    }
                  />
                </div>

                <div className="h-[180px]">
                  <Label htmlFor="description">概要</Label>
                  <Textarea
                    id="description"
                    placeholder="概要を入力します。"
                    className="border-[#707070] h-[calc(180px-24px)] rounded-2xl"
                    value={formData.description}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        description: e.target.value,
                      }))
                    }
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-6 mt-12">
                <div className="h-[90px]">
                  <Label htmlFor="date">期日</Label>
                  <Input
                    id="date"
                    type="text"
                    placeholder="例：2024年4月末まで"
                    className="border-[#707070] rounded-2xl h-[calc(90px-24px)]"
                    value={formData.deadline}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        deadline: e.target.value,
                      }))
                    }
                  />
                </div>
                <div className="h-[90px]">
                  <Label htmlFor="place">場所</Label>
                  <Input
                    id="place"
                    type="text"
                    placeholder="例：東京都渋谷区"
                    className="border-[#707070] rounded-2xl h-[calc(90px-24px)]"
                    value={formData.place}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        place: e.target.value,
                      }))
                    }
                  />
                </div>
              </div>

              <div className="space-y-4 mt-12">
                <Label>オファー対象</Label>
                <div className="flex flex-wrap gap-2">
                  {[
                    "Musician",
                    "Curator",
                    "Creator",
                    "Supporter",
                    "特になし",
                  ].map((role) => (
                    <button
                      key={role}
                      onClick={() =>
                        setFormData((prev) => ({ ...prev, targetRole: role }))
                      }
                      className={`h-[48px] w-[180px] rounded-full text-[18px] transition-colors ${
                        formData.targetRole === role
                          ? "bg-white text-black"
                          : "bg-black text-white border border-white hover:bg-gray-100 hover:text-black"
                      }`}
                    >
                      {role}
                    </button>
                  ))}
                </div>
              </div>

              <div className="grid gap-6 md:grid-cols-2 mt-12">
                <div className="h-[180px]">
                  <Label>オファー詳細についての補足事項</Label>
                  <Textarea
                    placeholder="追加事項が入ります。"
                    className="border-[#707070] h-[calc(180px-24px)] rounded-2xl"
                    value={formData.attention}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        attention: e.target.value,
                      }))
                    }
                  />
                </div>
                <div className="h-[180px]">
                  <Label>対象となるスキル</Label>
                  <Textarea
                    placeholder="デジタル技術があるアーティスト、フェスのプロモーションをしたことがあるプロモーター"
                    className="border-[#707070] h-[calc(180px-24px)] rounded-2xl"
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
            <h2 className="text-2xl mt-20 text-white font-light">
              ( File Upload )
            </h2>
            <p className="text-sm">
              オファー画像をアップロードするとオファーページのメイン画像、サムネイルに使用されます。
            </p>
            <p className="mb-6 text-sm">
              メディアはオファーに関連する曲、PDF、画像などアップロードするとオファーページに表示されます。
            </p>

            <div className="space-y-12">
              {/* カバー画像セクション */}
              <div>
                <Label className="text-lg mt-12">オファー画像</Label>
                <div className="mt-2 border-2 border-dashed border-gray-400 rounded-lg p-4 h-24">
                  <Plus className="h-6 w-6 text-gray-600" />
                  <span className="text-sm text-gray-600 mt-2">画像を追加</span>
                </div>
              </div>

              {/* 添付画像セクション */}
              <div>
                <Label className="text-lg">
                  メディア（複数アップロード可能）
                </Label>
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
                  <Label className="text-sm font-medium">メディア</Label>
                  <div className="mt-2 border-2 border-dashed border-gray-400 rounded-lg p-6 flex flex-col items-center justify-center cursor-pointer hover:border-gray-500">
                    <Plus className="h-6 w-6 text-gray-600 mb-2" />
                    <span className="text-sm text-gray-600">
                      クリックしてメディアをアップロード
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
            <h2 className="text-xl mt-20">( Publicity )</h2>
            <p className="text-gray-600 mb-4">
              非公開にすると、指定したユーザーのみ閲覧できるようになります。
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
    </>
  );
}
