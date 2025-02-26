"use client";

import Image from "next/image";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, UPDATE_PRODUCT, DELETE_PRODUCT } from "../../utils/query";
import { useState, useCallback } from "react";
import { Input } from "@ui/components/ui/input";
import { Button } from "@ui/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import { Label } from "@ui/components/ui/label";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";
import { useDropzone } from "react-dropzone";
import { Upload, Loader2 } from "lucide-react";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { storage } from "../../config";
import { toast } from "@ui/hooks/use-toast";

interface Product {
  upc: string;
  title: string;
  imgUrl: string | null;
  productType: string;
  distributedAt: string;
  artistId: string;
  artistNameJa: string;
  numberOfTracks: number;
}

interface UpdateProductInput {
  upc: string;
  title?: string;
  imgUrl?: string;
  type?: string;
  distributedAt?: string;
}

interface EditDialogProps {
  product: Product | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onSuccess: () => void;
}

export function EditDialog({
  product,
  open,
  onOpenChange,
  onSuccess,
}: EditDialogProps) {
  const [formData, setFormData] = useState<UpdateProductInput>({
    upc: product?.upc || "",
    title: product?.title || "",
    type: product?.productType || "",
    distributedAt: product?.distributedAt || "",
  });
  const [uploadingImage, setUploadingImage] = useState(false);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);

  const queryClient = useQueryClient();

  const updateProductMutation = useMutation({
    mutationFn: (variables: { input: UpdateProductInput }) =>
      request(endpoint, UPDATE_PRODUCT, variables),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["searchProducts"] });
      onSuccess();
      onOpenChange(false);
    },
  });

  const deleteProductMutation = useMutation({
    mutationFn: (upc: string) => request(endpoint, DELETE_PRODUCT, { upc }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["searchProducts"] });
      onSuccess();
      onOpenChange(false);
    },
  });

  const onDrop = useCallback(
    async (acceptedFiles: File[]) => {
      const file = acceptedFiles[0] || null;
      if (file && product?.upc) {
        setUploadingImage(true);
        setImageFile(file);

        try {
          if (!file.name) {
            throw new Error("File name is undefined");
          }

          if (file.size > 100 * 1024 * 1024) {
            throw new Error("ファイルサイズが100MBを超えています");
          }

          const extension = file.name.split(".").pop() || "";
          const fileName = `${product.upc}_${Date.now()}.${extension}`;
          const storageRef = ref(storage, `products/${fileName}`);
          const uploadResult = await uploadBytes(storageRef, file);
          const imageUrl = await getDownloadURL(uploadResult.ref);

          setFormData((prev) => ({ ...prev, imgUrl: imageUrl }));
          setPreviewUrl(imageUrl);

          toast({
            title: "画像のアップロードが完了しました",
            description: `${file.name}をアップロードしました。`,
          });
        } catch (error) {
          console.error("Failed to upload image:", error);
          toast({
            title: "画像のアップロードに失敗しました",
            description:
              error instanceof Error
                ? error.message
                : "エラーが発生しました。再度お試しください。",
            variant: "destructive",
          });
        } finally {
          setUploadingImage(false);
        }
      } else if (!product?.upc) {
        toast({
          title: "エラー",
          description: "UPCが取得できません。",
          variant: "destructive",
        });
      }
    },
    [product?.upc],
  );

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      "image/*": [".png", ".jpg", ".jpeg"],
    },
    maxFiles: 1,
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    const updates: UpdateProductInput = {
      upc: product?.upc || "",
    };

    // 各フィールドの変更チェック
    if (formData.title && formData.title !== product?.title) {
      updates.title = formData.title;
    }
    if (formData.type && formData.type !== product?.productType) {
      updates.type = formData.type;
    }
    if (
      formData.distributedAt &&
      formData.distributedAt !== product?.distributedAt
    ) {
      updates.distributedAt = formData.distributedAt;
    }
    if (formData.imgUrl && formData.imgUrl !== product?.imgUrl) {
      updates.imgUrl = formData.imgUrl;
    }

    // 変更があるフィールドが1つ以上あるかチェック（upcは除く）
    const hasChanges = Object.keys(updates).length > 1;

    if (hasChanges) {
      console.log("Updating product with:", updates); // デバッグ用
      updateProductMutation.mutate({ input: updates });

      // フォームデータとプレビューをクリア
      setFormData({
        upc: "",
        title: "",
        type: "",
        distributedAt: "",
      });
      setImageFile(null);
      setPreviewUrl(null);
    } else {
      console.log("No changes detected");
    }
  };

  const handleDelete = () => {
    if (window.confirm("本当に削除しますか？")) {
      deleteProductMutation.mutate(product?.upc || "");
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-[70vw] w-full max-h-[90vh] flex flex-col">
        <DialogHeader>
          <DialogTitle>Edit Product</DialogTitle>
        </DialogHeader>
        <div className="flex-1 overflow-y-auto pr-2">
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-3 gap-8 mb-4">
              {/* 現在の画像表示 */}
              <div className="flex flex-col items-center">
                <p className="text-sm text-gray-500 mb-2">現在の画像</p>
                <div className="h-[200px] w-full flex items-center justify-center border rounded-lg">
                  {product?.imgUrl ? (
                    <Image
                      src={product.imgUrl}
                      alt={product.title}
                      width={200}
                      height={200}
                      className="rounded-md object-contain"
                    />
                  ) : (
                    <div className="text-sm text-gray-400">画像なし</div>
                  )}
                </div>
              </div>

              {/* アップロードされた新しい画像 */}
              <div className="flex flex-col items-center">
                <p className="text-sm text-gray-500 mb-2">新しい画像</p>
                <div className="h-[200px] w-full flex items-center justify-center border rounded-lg">
                  {previewUrl ? (
                    <Image
                      src={previewUrl}
                      alt="New image"
                      width={200}
                      height={200}
                      className="rounded-md object-contain"
                    />
                  ) : (
                    <div className="text-sm text-gray-400">
                      新しい画像がアップロードされていません
                    </div>
                  )}
                </div>
              </div>

              {/* 画像アップロードエリア */}
              <div className="flex flex-col items-center">
                <p className="text-sm text-gray-500 mb-2">
                  新しい画像をアップロード
                </p>
                <div
                  {...getRootProps()}
                  className={`
                    w-full h-[200px]
                    border-2 border-dashed rounded-lg
                    flex flex-col justify-center
                    transition-colors duration-200 ease-in-out
                    ${
                      isDragActive
                        ? "border-primary bg-primary/5"
                        : "border-gray-300 dark:border-gray-700"
                    }
                    ${imageFile ? "bg-green-50 dark:bg-green-900/10" : ""}
                  `}
                >
                  <input {...getInputProps()} />
                  <div className="flex flex-col items-center justify-center space-y-2 text-center p-4">
                    <Upload className="h-8 w-8 text-gray-400" />
                    <div className="space-y-1">
                      <p className="text-sm font-medium">
                        {isDragActive
                          ? "ここにファイルをドロップ"
                          : "クリックまたはドラッグ＆ドロップでファイルを選択"}
                      </p>
                      <p className="text-xs text-gray-500 dark:text-gray-400">
                        画像ファイルをアップロード
                      </p>
                    </div>
                  </div>
                  {uploadingImage && (
                    <div className="mt-2 flex items-center justify-center">
                      <Loader2 className="h-4 w-4 animate-spin" />
                      <span className="ml-2 text-sm">アップロード中...</span>
                    </div>
                  )}
                  {imageFile && !uploadingImage && (
                    <div className="mt-2 text-sm text-green-600 dark:text-green-400 text-center">
                      ✓ {imageFile.name}
                    </div>
                  )}
                </div>
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="title">Title</Label>
              <div className="text-sm text-muted-foreground mb-2">
                Current: <span className="font-bold">{product?.title}</span>
              </div>
              <Input
                id="title"
                value={formData.title || ""}
                onChange={(e) =>
                  setFormData({ ...formData, title: e.target.value })
                }
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="type">Type</Label>
              <div className="text-sm text-muted-foreground mb-2">
                Current:{" "}
                <span className="font-bold">{product?.productType}</span>
              </div>
              <Select
                value={formData.type}
                onValueChange={(value) =>
                  setFormData({ ...formData, type: value })
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Select type" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="album">Album</SelectItem>
                  <SelectItem value="single">Single</SelectItem>
                  <SelectItem value="ep">EP</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="distributedAt">Distribution Date</Label>
              <div className="text-sm text-muted-foreground mb-2">
                Current:{" "}
                <span className="font-bold">
                  {product?.distributedAt?.split("T")[0]}
                </span>
              </div>
              <Input
                id="distributedAt"
                type="date"
                value={formData.distributedAt?.split("T")[0] || ""}
                onChange={(e) =>
                  setFormData({ ...formData, distributedAt: e.target.value })
                }
              />
            </div>
          </form>
        </div>
        <DialogFooter className="gap-2 mt-4 border-t pt-4">
          <Button
            type="button"
            variant="destructive"
            onClick={handleDelete}
            disabled={deleteProductMutation.isPending || uploadingImage}
          >
            {deleteProductMutation.isPending ? "Deleting..." : "Delete"}
          </Button>
          <Button
            type="submit"
            onClick={handleSubmit}
            disabled={updateProductMutation.isPending || uploadingImage}
          >
            {updateProductMutation.isPending ? "Updating..." : "Update"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
