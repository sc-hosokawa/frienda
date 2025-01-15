"use client";

import { useState, useCallback, useEffect } from "react";
import { Plus } from "lucide-react";
import Image from "next/image";
import Link from "next/link";

import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { Textarea } from "@ui/components/ui/textarea";
import { Switch } from "@ui/components/ui/switch";
import useUserStore from "../../../../../store/user";
import { gql, useMutation } from "@apollo/client";
import { useRouter } from "next/navigation";
import { storage } from "../../../../../config";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { ApolloError } from "@apollo/client";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";

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
  url: string;
};

// 添付画像の型定義を追加
type AttachedImage = {
  file: File;
  previewUrl: string;
};

// バリデーションエラーの型定義を追加
type FormErrors = {
  title?: string;
  description?: string;
  place?: string;
  coverImage?: string;
  fee?: string;
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
  const [selectedImagePreview, setSelectedImagePreview] = useState<
    string | null
  >(null);
  const [attachedImages, setAttachedImages] = useState<AttachedImage[]>([]);
  const [selectedFiles, setSelectedFiles] = useState<File[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [errors, setErrors] = useState<FormErrors>({});

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
        `offers/files/${Date.now()}_${file.name}`
      );
      await uploadBytes(storageRef, file);
      return getDownloadURL(storageRef);
    });
    return Promise.all(uploadPromises);
  }, []);

  const validateForm = (): boolean => {
    const newErrors: FormErrors = {};

    if (!formData.title.trim()) {
      newErrors.title = "タイトルは必須です";
    }
    if (!formData.description.trim()) {
      newErrors.description = "概要は必須です";
    }
    if (!formData.place.trim()) {
      newErrors.place = "場所は必須です";
    }
    if (!selectedImage) {
      newErrors.coverImage = "カバー画像は必須です";
    }
    if (!formData.fee || formData.fee <= 0) {
      newErrors.fee = "FSPは1以上を指定してください";
    }
    if (formData.fee > (user?.fspBalance || 0)) {
      newErrors.fee = `保有FSP（${user?.fspBalance}）を超えて指定することはできません`;
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateForm()) {
      return;
    }
    setShowConfirmModal(true);
  };

  const handleConfirmedSubmit = async () => {
    setIsLoading(true);

    try {
      let imageUrl = null;
      if (selectedImage) {
        imageUrl = await handleImageUpload(selectedImage);
      }

      const attachedImageUrls = await Promise.all(
        attachedImages.map((file) => handleImageUpload(file.file))
      );

      const fileUrls = await handleFilesUpload(selectedFiles);

      await createNewOffer({
        variables: {
          owner: user?.id,
          ...formData,
          imageUrl,
          fee: formData.fee,
          publicity: formData.isPublic,
          attachedImgs: attachedImageUrls.length > 0 ? attachedImageUrls : null,
          attachedFiles: fileUrls.length > 0 ? fileUrls : null,
        },
      });

      setShowConfirmModal(false);
      router.push("/offer");
    } catch (error) {
      if (error instanceof ApolloError) {
        console.error("GraphQL Error:", error.message);
      } else {
        console.error("Unexpected error:", error);
      }
    } finally {
      setIsLoading(false);
    }
  };

  const categories = ["Creation", "Event", "Promotion", "Other"];

  const handleMainImageSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file && file.type.startsWith("image/")) {
      setSelectedImage(file);
      const previewUrl = URL.createObjectURL(file);
      setSelectedImagePreview(previewUrl);
    }
  };

  const handleAttachedImagesSelect = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const files = Array.from(e.target.files || []);
    const imageFiles = files
      .filter((file) => file.type.startsWith("image/"))
      .map((file) => ({
        file,
        previewUrl: URL.createObjectURL(file),
      }));
    setAttachedImages((prev) => [...prev, ...imageFiles]);
  };

  const handleMediaFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || []);
    const validFiles = files.filter((file) => {
      const isPDF = file.type === "application/pdf";
      const isMP4 = file.type === "video/mp4";
      return isPDF || isMP4;
    });
    setSelectedFiles((prev) => [...prev, ...validFiles]);
  };

  // コンポーネントのクリーンアップ
  useEffect(() => {
    return () => {
      // プレビューURLのクリーンアップ
      if (selectedImagePreview) {
        URL.revokeObjectURL(selectedImagePreview);
      }
      attachedImages.forEach((img) => URL.revokeObjectURL(img.previewUrl));
    };
  }, [selectedImagePreview, attachedImages]);

  // オファー対象の選択肢を定義
  const targetRoles = [
    "Musician",
    "Curator",
    "Creator",
    "Supporter",
    "特になし",
  ];

  return (
    <>
      <div className="w-[60px]">
        <Link href="/offer" className="ml-24">
          <Image
            src="/arrow-left.svg"
            alt="arrow-left"
            width={60}
            height={60}
            className="ml-6"
          />
        </Link>
      </div>
      <div className="min-h-screen p-6">
        <div className="max-w-6xl mx-auto space-y-8">
          <div>
            <h1 className="text-[42px] mb-2 text-white font-light">
              New Offer
            </h1>
            <p className="">情報入力し、オファーを作成しましょう。</p>
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
                        : "bg-black text-white border-dashed border border-white hover:bg-gray-100 hover:text-black"
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
                  <span className="text-red-500 ml-1">*</span>
                  <Input
                    id="title"
                    placeholder="例：イベントに関係してくれる人募集！"
                    className={`border-[#707070] h-[calc(180px-24px)] rounded-2xl ${
                      errors.title ? "border-red-500" : ""
                    }`}
                    value={formData.title}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        title: e.target.value,
                      }))
                    }
                    required
                  />
                  {errors.title && (
                    <p className="text-red-500 text-sm mt-1">{errors.title}</p>
                  )}
                </div>

                <div className="h-[180px]">
                  <Label htmlFor="description">概要</Label>
                  <span className="text-red-500 ml-1">*</span>
                  <Textarea
                    id="description"
                    placeholder="概要を入力します。"
                    className={`border-[#707070] h-[calc(180px-24px)] rounded-2xl flex items-center pt-[calc((180px-24px-1.5rem)/2)] ${
                      errors.description ? "border-red-500" : ""
                    }`}
                    value={formData.description}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        description: e.target.value,
                      }))
                    }
                    required
                  />
                  {errors.description && (
                    <p className="text-red-500 text-sm mt-1">
                      {errors.description}
                    </p>
                  )}
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
                  <span className="text-red-500 ml-1">*</span>
                  <Input
                    id="place"
                    type="text"
                    placeholder="例：東京都渋谷区"
                    className={`border-[#707070] rounded-2xl h-[calc(90px-24px)] ${
                      errors.place ? "border-red-500" : ""
                    }`}
                    value={formData.place}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        place: e.target.value,
                      }))
                    }
                    required
                  />
                  {errors.place && (
                    <p className="text-red-500 text-sm mt-1">{errors.place}</p>
                  )}
                </div>
              </div>

              <div className="grid grid-cols-2 gap-6 mt-12">
                <div className="h-[90px]">
                  <Label htmlFor="fee">
                    Fee
                    <span className="text-red-500 ml-1">*</span>
                  </Label>
                  <Input
                    id="fee"
                    type="number"
                    min="1"
                    max={user?.fspBalance || 0}
                    placeholder={`1 ~ ${user?.fspBalance || 0}`}
                    className={`border-[#707070] rounded-2xl h-[calc(90px-24px)] ${
                      errors.fee ? "border-red-500" : ""
                    }`}
                    value={formData.fee || ""}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        fee: parseInt(e.target.value) || 0,
                      }))
                    }
                    required
                  />
                  {errors.fee && (
                    <p className="text-red-500 text-sm mt-1">{errors.fee}</p>
                  )}
                </div>
              </div>

              <div className="mt-12">
                <Label>オファー対象</Label>
                <span className="text-red-500 ml-1">*</span>
                <div className="flex flex-wrap gap-2">
                  {targetRoles.map((role) => (
                    <button
                      key={role}
                      onClick={() =>
                        setFormData((prev) => ({ ...prev, targetRole: role }))
                      }
                      className={`h-[48px] w-[160px] rounded-full text-[18px] transition-colors ${
                        formData.targetRole === role
                          ? "bg-white text-black"
                          : "bg-black text-white border-dashed border border-white hover:bg-gray-100 hover:text-black"
                      }`}
                      type="button"
                    >
                      {role}
                    </button>
                  ))}
                </div>
              </div>

              <div className="grid gap-6 md:grid-cols-2 mt-12">
                <div className="h-[180px]">
                  <Label>オファー詳細についての補足項目</Label>
                  <Textarea
                    placeholder=""
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
                    placeholder="例：デジタル技術があるアーティスト、フェスのプロモーションをしたことがあるプロモーター"
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
                <Label className="text-lg mt-12">
                  カバー画像
                  <span className="text-red-500 ml-1">*</span>
                </Label>
                <label
                  className={`mt-2 border border-dashed rounded-lg p-4 h-24 flex flex-col items-center justify-center cursor-pointer relative ${
                    errors.coverImage ? "border-red-500" : "border-white"
                  }`}
                >
                  <input
                    type="file"
                    accept="image/*"
                    className="hidden"
                    onChange={handleMainImageSelect}
                    required
                  />
                  {selectedImagePreview ? (
                    <div className="absolute inset-0 w-full h-full">
                      <img
                        src={selectedImagePreview}
                        alt="Preview"
                        className="w-full h-full object-contain rounded-lg"
                      />
                    </div>
                  ) : (
                    <>
                      <Plus className="h-6 w-6 text-white" />
                      <span className="text-sm text-white mt-2">
                        画像を追加
                      </span>
                    </>
                  )}
                </label>
                {errors.coverImage && (
                  <p className="text-red-500 text-sm mt-1">
                    {errors.coverImage}
                  </p>
                )}
              </div>

              {/* 添付画像セクション */}
              <div>
                <Label className="text-lg">添付画像</Label>
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mt-2">
                  {[...Array(4)].map((_, i) => {
                    const attachedImage = attachedImages[i];
                    return (
                      <label
                        key={i}
                        className="aspect-square border border-dashed border-white rounded-lg flex flex-col items-center justify-center cursor-pointer hover:border-gray-500 relative overflow-hidden"
                      >
                        <input
                          type="file"
                          accept="image/*"
                          className="hidden"
                          onChange={handleAttachedImagesSelect}
                          disabled={i < attachedImages.length}
                        />
                        {attachedImage ? (
                          <>
                            <img
                              src={attachedImage.previewUrl}
                              alt={`Attached ${i + 1}`}
                              className="absolute inset-0 w-full h-full object-cover"
                            />
                            <button
                              onClick={(e) => {
                                e.preventDefault();
                                setAttachedImages((prev) =>
                                  prev.filter((_, index) => index !== i)
                                );
                              }}
                              className="absolute top-2 right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600"
                            >
                              ×
                            </button>
                          </>
                        ) : (
                          <>
                            <Plus className="h-6 w-6 text-white" />
                            <span className="text-sm text-white mt-2">
                              画像を追加
                            </span>
                          </>
                        )}
                      </label>
                    );
                  })}
                </div>
              </div>

              {/* 添付メディアセクション */}
              <div>
                <Label className="text-lg font-semibold">添付メディア</Label>
                <p className="text-sm text-white mb-2">
                  PDFファイルや動画ファイル（MP4）をアップロードできます
                </p>
                <label className="mt-2 border border-dashed border-white rounded-lg p-6 flex flex-col items-center justify-center cursor-pointer">
                  <input
                    type="file"
                    accept=".pdf,.mp4"
                    multiple
                    className="hidden"
                    onChange={handleMediaFileSelect}
                  />
                  <Plus className="h-6 w-6 text-white mb-2" />
                  <span className="text-sm text-white">
                    クリックしてメディアをアップロード
                  </span>
                </label>
                {/* 選択されたファイルの一覧表示 */}
                {selectedFiles.length > 0 && (
                  <div className="mt-4 space-y-2">
                    {selectedFiles.map((file, index) => (
                      <div
                        key={index}
                        className="flex items-center gap-2 text-sm"
                      >
                        <span>{file.name}</span>
                        <button
                          onClick={() =>
                            setSelectedFiles((files) =>
                              files.filter((_, i) => i !== index)
                            )
                          }
                          className="text-red-500"
                        >
                          削除
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </div>
          </div>

          <div>
            <h2 className="text-xl mt-20">( Publicity )</h2>
            <p className="text-white mb-4">
              非公開にすると、指定したユーザーのみ閲覧できるようになります。
            </p>
            <div className="flex items-center justify-between py-4">
              <div className="flex items-center gap-2">
                <Label htmlFor="public">公開設定:</Label>
                <span className="text-sm">
                  {formData.isPublic ? (
                    <span className="text-green-400">公開</span>
                  ) : (
                    <span className="text-yellow-400">非公開</span>
                  )}
                </span>
              </div>
              <Switch
                id="public"
                checked={formData.isPublic}
                onCheckedChange={(checked) =>
                  setFormData((prev) => ({ ...prev, isPublic: checked }))
                }
              />
            </div>
          </div>

          <div className="flex justify-end gap-4">
            <Button
              variant="outline"
              className="text-white hover:bg-gray-600 border-white"
            >
              キャンセル
            </Button>
            <Button
              className="bg-[#E4DBC0] hover:bg-gray-100 text-black"
              onClick={handleSubmit}
            >
              確認画面へ
            </Button>
          </div>
        </div>
      </div>

      <Dialog open={showConfirmModal} onOpenChange={setShowConfirmModal}>
        <DialogContent className="sm:max-w-[600px] max-h-[80vh] flex flex-col">
          <DialogHeader>
            <DialogTitle>入力内容の確認</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 flex-1 overflow-y-auto">
            {/* メイン画像のプレビュー */}
            {selectedImagePreview && (
              <div>
                <h3 className="text-sm text-white mb-2">カバー画像</h3>
                <div className="relative w-full h-[200px] bg-gray-800 rounded-lg overflow-hidden">
                  <Image
                    src={selectedImagePreview}
                    alt="メイン画像"
                    fill
                    className="object-contain"
                    unoptimized
                  />
                </div>
              </div>
            )}

            {/* 既存のフォーム内容 */}
            <div>
              <h3 className="">カテゴリー</h3>
              <p>{formData.category || "未選択"}</p>
            </div>
            <div>
              <h3 className="">オファー名</h3>
              <p>{formData.title}</p>
            </div>
            <div>
              <h3 className="">概要</h3>
              <p>{formData.description}</p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <h3 className="">期日</h3>
                <p>{formData.deadline}</p>
              </div>
              <div>
                <h3 className="">場所</h3>
                <p>{formData.place}</p>
              </div>
            </div>
            <div>
              <h3 className="">オファー対象</h3>
              <p>{formData.targetRole || "未選択"}</p>
            </div>
            <div>
              <h3 className="">補足項目</h3>
              <p>{formData.attention}</p>
            </div>
            <div>
              <h3 className="">対象となるスキル</h3>
              <p>{formData.requiredSkill}</p>
            </div>
            <div>
              <h3 className="">Fee</h3>
              <p>{formData.fee}</p>
            </div>
            <div>
              <h3 className="">公開設定</h3>
              <p>{formData.isPublic ? "公開" : "非公開"}</p>
            </div>
            {/* 添付画像のプレビュー */}
            {attachedImages.length > 0 && (
              <div>
                <h3 className="mb-2">添付画像</h3>
                <div className="grid grid-cols-4 gap-2">
                  {attachedImages.map((img, index) => (
                    <div
                      key={index}
                      className="aspect-square relative rounded-lg overflow-hidden"
                    >
                      <img
                        src={img.previewUrl}
                        alt={`添付画像 ${index + 1}`}
                        className="w-full h-full object-cover"
                      />
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* 添付ファイル一覧 */}
            {selectedFiles.length > 0 && (
              <div>
                <h3 className="mb-2">添付ファイル</h3>
                <ul className="text-sm space-y-1">
                  {selectedFiles.map((file, index) => (
                    <li key={index} className="flex items-center gap-2">
                      <span>
                        {file.type === "application/pdf" ? "📄" : "🎥"}
                      </span>
                      {file.name}
                    </li>
                  ))}
                </ul>
              </div>
            )}
          </div>
          <DialogFooter className="mt-6">
            <Button
              className="hover:bg-gray-600"
              variant="outline"
              onClick={() => setShowConfirmModal(false)}
            >
              戻る
            </Button>
            <Button
              className="bg-[#E4DBC0] hover:bg-gray-100 text-black"
              onClick={handleConfirmedSubmit}
              disabled={isLoading}
            >
              {isLoading ? "登録中..." : "登録する"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
