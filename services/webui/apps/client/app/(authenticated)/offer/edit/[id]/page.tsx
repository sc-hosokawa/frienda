"use client";

import { useState, useCallback, useEffect } from "react";
import { Plus } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { useParams } from "next/navigation";

import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { Textarea } from "@ui/components/ui/textarea";
import { Switch } from "@ui/components/ui/switch";
import useUserStore from "../../../../../store/user";
import { gql, useQuery, useMutation } from "@apollo/client";
import { useRouter } from "next/navigation";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";
import { storage } from "../../../../../config";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";

const GET_OFFER_BY_ID = gql`
  query GetOfferById($offerId: Int!, $userId: String!) {
    getOffersById(offerId: $offerId, userId: $userId) {
      id
      title
      description
      imageUrl
      fee
      category
      place
      attention
      requiredSkill
      targetRole
      publicity
      attachedImgs
      attachedFiles
      status
    }
  }
`;

const UPDATE_OFFER = gql`
  mutation UpdateOfferInfo(
    $id: Int!
    $title: String
    $description: String
    $fee: Int
    $imageUrl: String
    $category: String
    $place: String
    $attention: String
    $requiredSkill: String
    $targetRole: String
    $publicity: Boolean
  ) {
    updateOfferInfo(
      input: {
        id: $id
        title: $title
        description: $description
        fee: $fee
        imageUrl: $imageUrl
        category: $category
        place: $place
        attention: $attention
        requiredSkill: $requiredSkill
        targetRole: $targetRole
        publicity: $publicity
      }
    ) {
      id
    }
  }
`;

type FormData = {
  title: string;
  description: string;
  deadline: string;
  place: string;
  category: string;
  attention: string;
  requiredSkill: string;
  fee: number;
  isPublic: boolean;
  targetRole: string;
};

// エラー型定義を追加
type FormErrors = {
  title?: string;
  description?: string;
  place?: string;
  coverImage?: string;
  fee?: string;
};

export default function OfferEditPage() {
  const { user } = useUserStore();
  const router = useRouter();
  const params = useParams();
  const offerId = parseInt(params.id as string);
  const [errors, setErrors] = useState<FormErrors>({});

  const [formData, setFormData] = useState<FormData>({
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
  const [attachedImages, setAttachedImages] = useState<string[]>([]);
  const [attachedFiles, setAttachedFiles] = useState<string[]>([]);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [updateOffer] = useMutation(UPDATE_OFFER);

  const { loading, error, data } = useQuery(GET_OFFER_BY_ID, {
    variables: {
      offerId,
      userId: user?.id,
    },
    skip: !user?.id,
  });

  useEffect(() => {
    if (data?.getOffersById) {
      const offer = data.getOffersById;
      setFormData({
        title: offer.title,
        description: offer.description,
        deadline: "",
        place: offer.place,
        category: offer.category || "",
        attention: offer.attention || "",
        requiredSkill: offer.requiredSkill || "",
        fee: offer.fee,
        isPublic: offer.publicity,
        targetRole: offer.targetRole || "",
      });

      if (offer.imageUrl) {
        setSelectedImagePreview(offer.imageUrl);
      }

      if (offer.attachedImgs) {
        setAttachedImages(offer.attachedImgs);
      }

      if (offer.attachedFiles) {
        setAttachedFiles(offer.attachedFiles);
      }
    }
  }, [data]);

  const handleMainImageSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file && file.type.startsWith("image/")) {
      setSelectedImage(file);
      const previewUrl = URL.createObjectURL(file);
      setSelectedImagePreview(previewUrl);
    }
  };

  const handleAttachedImagesSelect = (
    e: React.ChangeEvent<HTMLInputElement>,
  ) => {
    const files = Array.from(e.target.files || []);
    const imageFiles = files
      .filter((file) => file.type.startsWith("image/"))
      .map((file) => URL.createObjectURL(file));
    setAttachedImages((prev) => [...prev, ...imageFiles]);
  };

  const handleMediaFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || []);
    const validFiles = files.filter((file) => {
      const isPDF = file.type === "application/pdf";
      const isMP4 = file.type === "video/mp4";
      return isPDF || isMP4;
    });
    const fileUrls = validFiles.map((file) => URL.createObjectURL(file));
    setAttachedFiles((prev) => [...prev, ...fileUrls]);
  };

  useEffect(() => {
    return () => {
      if (selectedImagePreview) {
        URL.revokeObjectURL(selectedImagePreview);
      }
      attachedImages.forEach((url) => {
        if (url.startsWith("blob:")) {
          URL.revokeObjectURL(url);
        }
      });
      attachedFiles.forEach((url) => {
        if (url.startsWith("blob:")) {
          URL.revokeObjectURL(url);
        }
      });
    };
  }, [selectedImagePreview, attachedImages, attachedFiles]);

  const handleSubmit = () => {
    setShowConfirmModal(true);
  };

  const handleConfirmedSubmit = async () => {
    setIsLoading(true);
    try {
      let imageUrl = selectedImagePreview;

      if (selectedImage) {
        imageUrl = await handleImageUpload(selectedImage);
      }

      await updateOffer({
        variables: {
          id: offerId,
          title: formData.title,
          description: formData.description,
          fee: formData.fee,
          imageUrl,
          category: formData.category,
          place: formData.place,
          attention: formData.attention,
          requiredSkill: formData.requiredSkill,
          targetRole: formData.targetRole,
          publicity: formData.isPublic,
        },
      });

      setShowConfirmModal(false);
      router.push("/offer");
    } catch (error) {
      console.error("Error updating offer:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleImageUpload = async (file: File): Promise<string> => {
    try {
      const storageRef = ref(storage, `offers/imgs/${Date.now()}_${file.name}`);
      const snapshot = await uploadBytes(storageRef, file);
      const downloadURL = await getDownloadURL(snapshot.ref);
      return downloadURL;
    } catch (error) {
      console.error("Error uploading image:", error);
      throw error;
    }
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const categories = ["Creation", "Event", "Promotion", "Other"];

  return (
    <>
      <Link href="/offer">
        <div className="flex items-center gap-2 mt-20">
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
            <h1 className="text-[42px] text-white font-light">Edit Offer</h1>
            <p className="">オファー情報を編集します。</p>
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
                  <Input
                    id="title"
                    placeholder="例：イベントに関係してくれる人募集！"
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
                      className={`h-[48px] w-[160px] rounded-full text-[18px] transition-colors ${
                        formData.targetRole === role
                          ? "bg-white text-black"
                          : "bg-black text-white border border-dashed border-white hover:bg-gray-100 hover:text-black"
                      }`}
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

          <div className="mt-4">
            <Label>カバー画像</Label>
            <div className="mt-2 flex gap-4">
              {selectedImagePreview && (
                <div className="relative h-48 w-2/3">
                  <Image
                    src={selectedImagePreview}
                    alt="Current cover"
                    fill
                    className="object-contain"
                    unoptimized
                  />
                </div>
              )}
              <label className="border border-dashed border-white rounded-lg p-4 h-48 w-1/3 flex flex-col items-center justify-center cursor-pointer">
                <input
                  type="file"
                  accept="image/*"
                  className="hidden"
                  onChange={handleMainImageSelect}
                />
                <Plus className="h-6 w-6 text-white" />
                <span className="text-sm text-white mt-2">
                  {selectedImagePreview ? "画像を変更" : "画像を追加"}
                </span>
              </label>
            </div>
          </div>

          <div className="mt-4">
            <Label>添付画像</Label>
            <div className="grid grid-cols-4 gap-4 mt-2">
              {attachedImages.map((url, index) => (
                <div key={index} className="relative aspect-square group">
                  <Image
                    src={url}
                    alt={`Attached ${index + 1}`}
                    fill
                    className="object-cover rounded-lg"
                    unoptimized
                  />
                  <button
                    onClick={() => {
                      setAttachedImages((prev) =>
                        prev.filter((_, i) => i !== index),
                      );
                    }}
                    className="absolute top-2 right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600 opacity-0 group-hover:opacity-100 transition-opacity"
                  >
                    ×
                  </button>
                </div>
              ))}
              {attachedImages.length < 4 && (
                <label className="aspect-square border border-dashed border-white rounded-lg flex flex-col items-center justify-center cursor-pointer hover:border-gray-500">
                  <input
                    type="file"
                    accept="image/*"
                    className="hidden"
                    onChange={handleAttachedImagesSelect}
                  />
                  <Plus className="h-6 w-6 text-white" />
                  <span className="text-sm text-white mt-2">画像を追加</span>
                </label>
              )}
            </div>
          </div>

          <div className="mt-4">
            <Label>添付ファイル</Label>
            <ul className="mt-2 space-y-2">
              {attachedFiles.map((url, index) => (
                <li
                  key={index}
                  className="text-sm flex items-center justify-between"
                >
                  <a
                    href={url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-blue-400 hover:underline"
                  >
                    添付ファイル {index + 1}
                  </a>
                  <button
                    onClick={() => {
                      setAttachedFiles((prev) =>
                        prev.filter((_, i) => i !== index),
                      );
                    }}
                    className="text-red-500 hover:text-red-600"
                  >
                    削除
                  </button>
                </li>
              ))}
            </ul>
            <label className="mt-4 border border-dashed border-white rounded-lg p-4 flex flex-col items-center justify-center cursor-pointer">
              <input
                type="file"
                accept=".pdf,.mp4"
                multiple
                className="hidden"
                onChange={handleMediaFileSelect}
              />
              <Plus className="h-6 w-6 text-white" />
              <span className="text-sm text-white mt-2">ファイルを追加</span>
            </label>
          </div>

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

          <div className="flex justify-end gap-4">
            <Button
              variant="outline"
              className="text-white hover:bg-gray-600 border-white"
              onClick={() => router.back()}
            >
              キャンセル
            </Button>
            <Button
              className="bg-[#E4DBC0] hover:bg-gray-100 text-black"
              onClick={handleSubmit}
            >
              変更内容を確認する
            </Button>
          </div>
        </div>
      </div>

      <Dialog open={showConfirmModal} onOpenChange={setShowConfirmModal}>
        <DialogContent className="sm:max-w-[600px] max-h-[80vh] flex flex-col">
          <DialogHeader>
            <DialogTitle>変更内容の確認</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 flex-1 overflow-y-auto">
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

            <div>
              <h3 className="text-sm font-medium">カテゴリー</h3>
              <p>{formData.category || "未選択"}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">オファー名</h3>
              <p>{formData.title}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">概要</h3>
              <p>{formData.description}</p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <h3 className="text-sm font-medium">期日</h3>
                <p>{formData.deadline || "未設定"}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium">場所</h3>
                <p>{formData.place}</p>
              </div>
            </div>
            <div>
              <h3 className="text-sm font-medium">オファー対象</h3>
              <p>{formData.targetRole || "未選択"}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">補足項目</h3>
              <p>{formData.attention || "なし"}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">対象となるスキル</h3>
              <p>{formData.requiredSkill || "なし"}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">Fee</h3>
              <p>{formData.fee} FSP</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">公開設定</h3>
              <p>{formData.isPublic ? "公開" : "非公開"}</p>
            </div>
          </div>
          <DialogFooter className="mt-6">
            <Button
              variant="outline"
              onClick={() => setShowConfirmModal(false)}
              className="text-white hover:bg-gray-600 border-white"
            >
              キャンセル
            </Button>
            <Button
              className="bg-[#E4DBC0] hover:bg-gray-100 text-black"
              onClick={handleConfirmedSubmit}
              disabled={isLoading}
            >
              {isLoading ? "更新中..." : "変更する"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
