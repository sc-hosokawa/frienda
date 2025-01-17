"use client";

import { useState, useEffect } from "react";
import { Plus } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { useParams } from "next/navigation";

import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { Textarea } from "@ui/components/ui/textarea";
import { Switch } from "@ui/components/ui/switch";
import useUserStore from "~/store/user";
import { gql, useQuery, useMutation } from "@apollo/client";
import { useRouter } from "next/navigation";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";
import { storage } from "~/config";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { useTranslation } from "~/i18n/client";

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
    $attachedImgs: [String]!
    $attachedFiles: [String]!
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
        attachedImgs: $attachedImgs
        attachedFiles: $attachedFiles
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

type AttachedFile = {
  url: string;
  isNew: boolean;
  file?: File;
};

// TODO: rewrite this component with React Hook Form
export default function OfferEditPage() {
  const { user } = useUserStore();
  const router = useRouter();
  const params = useParams();
  const offerId = parseInt(params.id as string);
  const [errors, setErrors] = useState<FormErrors>({});
  const { t } = useTranslation();

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
  const [attachedImages, setAttachedImages] = useState<AttachedFile[]>([]);
  const [attachedFiles, setAttachedFiles] = useState<AttachedFile[]>([]);
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
        setAttachedImages(
          offer.attachedImgs.map((url: string) => ({ url, isNew: false }))
        );
      }

      if (offer.attachedFiles) {
        setAttachedFiles(
          offer.attachedFiles.map((url: string) => ({ url, isNew: false }))
        );
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
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const files = Array.from(e.target.files || []);
    const imageFiles = files
      .filter((file) => {
        if (!file.type.startsWith("image/")) {
          alert(t("common.only-image-can-upload"));
          return false;
        }
        if (file.size > 10 * 1024 * 1024) {
          alert(t("common.image-size-alert"));
          return false;
        }
        return true;
      })
      .map((file) => ({
        url: URL.createObjectURL(file),
        isNew: true,
        file,
      }));
    setAttachedImages((prev) => [...prev, ...imageFiles]);
  };

  const handleMediaFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || []);
    const validFiles = files
      .filter((file) => {
        const isPDF = file.type === "application/pdf";
        const isMP4 = file.type === "video/mp4";
        if (!isPDF && !isMP4) {
          alert("PDFまたはMP4ファイルのみアップロード可能です。");
          return false;
        }
        if (file.size > 100 * 1024 * 1024) {
          alert(t("message.file-size-alert"));
          return false;
        }
        return true;
      })
      .map((file) => ({
        url: URL.createObjectURL(file),
        isNew: true,
        file,
      }));
    setAttachedFiles((prev) => [...prev, ...validFiles]);
  };

  const uploadAttachment = async (file: File): Promise<string> => {
    try {
      const fileName = `${Date.now()}_${file.name}`;
      let path: string;

      if (file.type.startsWith("image/")) {
        // 画像ファイルの場合
        if (file.size > 10 * 1024 * 1024) {
          throw new Error(t("common.image-size-alert"));
        }
        path = `offers/imgs/${fileName}`;
      } else {
        // その他のファイル（PDF, MP4など）の場合
        if (file.size > 100 * 1024 * 1024) {
          throw new Error(t("message.file-size-alert"));
        }
        path = `offers/files/${fileName}`;
      }

      const storageRef = ref(storage, path);
      const snapshot = await uploadBytes(storageRef, file);
      return getDownloadURL(snapshot.ref);
    } catch (error) {
      console.error("Error uploading attachment:", error);
      throw error;
    }
  };

  const handleConfirmedSubmit = async () => {
    setIsLoading(true);
    try {
      let imageUrl = selectedImagePreview;
      if (selectedImage) {
        imageUrl = await handleImageUpload(selectedImage);
      }

      // アップロード処理をtry-catchで個別に処理
      const newImageUrls = await Promise.all(
        attachedImages
          .filter((img) => img.isNew && img.file)
          .map(async (img) => {
            try {
              return await uploadAttachment(img.file!);
            } catch (error) {
              console.error(`Failed to upload image: ${error}`);
              throw error;
            }
          })
      );

      const newFileUrls = await Promise.all(
        attachedFiles
          .filter((file) => file.isNew && file.file)
          .map(async (file) => {
            try {
              return await uploadAttachment(file.file!);
            } catch (error) {
              console.error(`Failed to upload file: ${error}`);
              throw error;
            }
          })
      );

      const finalImageUrls = [
        ...attachedImages.filter((img) => !img.isNew).map((img) => img.url),
        ...newImageUrls,
      ];
      const finalFileUrls = [
        ...attachedFiles.filter((file) => !file.isNew).map((file) => file.url),
        ...newFileUrls,
      ];

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
          attachedImgs: finalImageUrls,
          attachedFiles: finalFileUrls,
        },
      });

      setShowConfirmModal(false);
      router.push("/offer");
    } catch (error) {
      console.error("Error updating offer:", error);
      alert("エラーが発生しました。ファイルサイズと形式を確認してください。");
    } finally {
      setIsLoading(false);
    }
  };

  const handleImageUpload = async (file: File): Promise<string> => {
    try {
      // ファイル名を timestamp_originalname の形式に
      const fileName = `${Date.now()}_${file.name}`;
      const storageRef = ref(storage, `offers/imgs/${fileName}`);

      // ファイルサイズチェック (10MB制限)
      if (file.size > 10 * 1024 * 1024) {
        throw new Error(t("common.image-size-alert"));
      }

      // 画像タイプチェック
      if (!file.type.startsWith("image/")) {
        throw new Error(t("common.only-image-can-upload"));
      }

      const snapshot = await uploadBytes(storageRef, file);
      const downloadURL = await getDownloadURL(snapshot.ref);
      return downloadURL;
    } catch (error) {
      console.error("Error uploading image:", error);
      throw error;
    }
  };

  useEffect(() => {
    return () => {
      if (selectedImagePreview) {
        URL.revokeObjectURL(selectedImagePreview);
      }
      attachedImages.forEach((img) => {
        if (img.isNew && img.url.startsWith("blob:")) {
          URL.revokeObjectURL(img.url);
        }
      });
      attachedFiles.forEach((file) => {
        if (file.isNew && file.url.startsWith("blob:")) {
          URL.revokeObjectURL(file.url);
        }
      });
    };
  }, [selectedImagePreview, attachedImages, attachedFiles]);

  const handleSubmit = () => {
    setShowConfirmModal(true);
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  const categories = ["Creation", "Event", "Promotion", "Other"];

  return (
    <>
      <div className="w-[60px]">
        <Link href="/offer" className="ml-6">
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
            <h1 className="text-[42px] text-white font-light">Edit Offer</h1>
            <p className="">オファー情報を編集します。</p>
          </div>

          <div>
            <h2 className="text-2xl my-20 text-white font-light">
              ( Offer Information )
            </h2>
            <div className="flex flex-col gap-2 mb-6">
              <p className="text-sm text-white">{t("common.category")}</p>
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
                  <Label htmlFor="title">{t("offer.offer-title")}</Label>
                  <Input
                    id="title"
                    placeholder={t("offer.create.title-placeholder")}
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
                  <Label htmlFor="description">
                    {t("offer.offer-description")}
                  </Label>
                  <Textarea
                    id="description"
                    placeholder={t("offer.create.description-placeholder")}
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
                  <Label htmlFor="date">{t("offer.offer-deadline")}</Label>
                  <Input
                    id="date"
                    type="text"
                    placeholder={t("offer.create.deadline-placeholder")}
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
                  <Label htmlFor="place">{t("offer.offer-place")}</Label>
                  <Input
                    id="place"
                    type="text"
                    placeholder={t("offer.create.place-placeholder")}
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
                    {t("offer.offer-fee")}
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
                <Label>{t("offer.offer-subject")}</Label>
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
                  <Label>{t("offer.additional-offer-items")}</Label>
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
                  <Label>{t("offer.offer-skills")}</Label>
                  <Textarea
                    placeholder={t("offer.create.skills-placeholder")}
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
            <Label> {t("offer.cover-image")}</Label>
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
                  {selectedImagePreview
                    ? t("common.change-image")
                    : t("common.add-images")}
                </span>
              </label>
            </div>
          </div>

          <div className="mt-4">
            <Label>{t("offer.attached-image")}</Label>
            <div className="grid grid-cols-4 gap-4 mt-2">
              {attachedImages.map((img, index) => (
                <div key={index} className="relative aspect-square group">
                  <Image
                    src={img.url}
                    alt={`Attached ${index + 1}`}
                    fill
                    className="object-cover rounded-lg"
                    unoptimized
                  />
                  <button
                    onClick={() => {
                      setAttachedImages((prev) =>
                        prev.filter((_, i) => i !== index)
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
                  <span className="text-sm text-white mt-2">
                    {t("common.attach-image")}
                  </span>
                </label>
              )}
            </div>
          </div>

          <div className="mt-4">
            <Label> {t("common.attached-file")}</Label>
            <ul className="mt-2 space-y-2">
              {attachedFiles.map((file, index) => (
                <li
                  key={index}
                  className="text-sm flex items-center justify-between"
                >
                  <a
                    href={file.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-blue-400 hover:underline"
                  >
                    {t("common.attached-file")} {index + 1}
                  </a>
                  <button
                    onClick={() => {
                      setAttachedFiles((prev) =>
                        prev.filter((_, i) => i !== index)
                      );
                    }}
                    className="text-red-500 hover:text-red-600"
                  >
                    {t("common.delete")}
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
              <span className="text-sm text-white mt-2">
                {t("message.add-attach-file")}
              </span>
            </label>
          </div>

          <div className="flex items-center justify-between py-4">
            <div className="flex items-center gap-2">
              <Label htmlFor="public">{t("offer.create.publicity")}:</Label>
              <span className="text-sm">
                {formData.isPublic ? (
                  <span className="text-green-400">{t("common.public")}</span>
                ) : (
                  <span className="text-yellow-400">{t("common.private")}</span>
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
              {t("common.cancel")}
            </Button>
            <Button
              className="bg-[#E4DBC0] hover:bg-gray-100 text-black"
              onClick={handleSubmit}
            >
              {t("common.confirm-modified")}
            </Button>
          </div>
        </div>
      </div>

      <Dialog open={showConfirmModal} onOpenChange={setShowConfirmModal}>
        <DialogContent className="sm:max-w-[600px] max-h-[80vh] flex flex-col">
          <DialogHeader>
            <DialogTitle>{t("common.confirmation-modified")}</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 flex-1 overflow-y-auto">
            {selectedImagePreview && (
              <div>
                <h3 className="text-sm text-white mb-2">
                  {t("offer.cover-image")}
                </h3>
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
              <h3 className="text-sm font-medium">{t("common.category")}</h3>
              <p>{formData.category || t("common.not-selected")}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">{t("offer.offer-title")}</h3>
              <p>{formData.title}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">
                {t("offer.offer-description")}
              </h3>
              <p>{formData.description}</p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <h3 className="text-sm font-medium">
                  {t("offer.offer-deadline")}
                </h3>
                <p>{formData.category || t("common.not-selected")}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium">
                  {t("offer.offer-place")}
                </h3>
                <p>{formData.place}</p>
              </div>
            </div>
            <div>
              <h3 className="text-sm font-medium">
                {t("offer.offer-subject")}
              </h3>
              <p>{formData.targetRole || t("common.not-selected")}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">
                {t("offer.additional-offer-items")}
              </h3>
              <p>{formData.attention}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">{t("offer.offer-skills")}</h3>
              <p>{formData.requiredSkill}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">Fee</h3>
              <p>{formData.fee} FSP</p>
            </div>
            <div>
              <h3 className="text-sm font-medium">
                {t("offer.create.publicity")}
              </h3>
              {formData.isPublic ? t("common.public") : t("common.private")}
            </div>
          </div>
          <DialogFooter className="mt-6">
            <Button
              variant="outline"
              onClick={() => setShowConfirmModal(false)}
              className="text-white hover:bg-gray-600 border-white"
            >
              {t("common.cancel")}
            </Button>
            <Button
              className="bg-[#E4DBC0] hover:bg-gray-100 text-black"
              onClick={handleConfirmedSubmit}
              disabled={isLoading}
            >
              {isLoading ? t("common.updating...") : t("common.update")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
