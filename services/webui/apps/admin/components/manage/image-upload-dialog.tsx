import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { Loader2, Upload } from "lucide-react";
import { useCallback } from "react";
import { useDropzone } from "react-dropzone";

interface ImageUploadDialogProps {
  showDialog: boolean;
  setShowDialog: (show: boolean) => void;
  unmatchedImages: string[];
  imageFiles: { [key: string]: File };
  handleImageUpload: (files: File[]) => void;
  uploadImagesToFirebase: () => Promise<void>;
  uploadingImages: boolean;
}

export function ImageUploadDialog({
  showDialog,
  setShowDialog,
  unmatchedImages,
  imageFiles,
  handleImageUpload,
  uploadImagesToFirebase,
  uploadingImages,
}: ImageUploadDialogProps) {
  const onDrop = useCallback(
    (acceptedFiles: File[]) => {
      handleImageUpload(acceptedFiles);
    },
    [handleImageUpload],
  );

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      "image/*": [".png", ".jpg", ".jpeg", ".gif"],
    },
    noClick: false,
    noKeyboard: false,
    useFsAccessApi: false,
  });

  return (
    <Dialog open={showDialog} onOpenChange={setShowDialog}>
      <DialogContent className="sm:max-w-[500px]">
        <DialogHeader>
          <DialogTitle>作品画像のアップロード</DialogTitle>
        </DialogHeader>

        <div className="space-y-4">
          <div
            {...getRootProps()}
            className={`
              border-2 border-dashed rounded-lg p-8
              transition-colors duration-200 ease-in-out
              ${
                isDragActive
                  ? "border-primary bg-primary/5"
                  : "border-gray-300 dark:border-gray-700"
              }
              ${
                Object.keys(imageFiles).length > 0
                  ? "bg-green-50 dark:bg-green-900/10"
                  : ""
              }
            `}
          >
            <input {...getInputProps()} />
            <div className="flex flex-col items-center justify-center space-y-4 text-center">
              <Upload className="h-8 w-8 text-gray-400" />
              <div className="space-y-1">
                <p className="text-sm font-medium">
                  {isDragActive
                    ? "ここにファイルをドロップ"
                    : "クリックまたはドラッグ＆ドロップでファイルを選択"}
                </p>
                <p className="text-xs text-gray-500 dark:text-gray-400">
                  フォルダまたは画像ファイルをアップロード
                </p>
              </div>
            </div>
          </div>

          <div className="space-y-2">
            {Object.keys(imageFiles).length > 0 && (
              <div className="rounded-md bg-green-50 dark:bg-green-900/10 p-3">
                <p className="text-sm text-green-600 dark:text-green-400">
                  ✓ {Object.keys(imageFiles).length}件の画像が紐づけ可能です
                </p>
                <div className="mt-2 text-xs text-green-500 dark:text-green-400 max-h-32 overflow-y-auto">
                  {Object.entries(imageFiles).map(([upc, file]) => (
                    <div key={upc} className="flex items-center space-x-2">
                      <span>• {file.name}</span>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {unmatchedImages.length > 0 && (
              <div className="rounded-md bg-yellow-50 dark:bg-yellow-900/10 p-3">
                <p className="text-sm text-yellow-600 dark:text-yellow-400">
                  ⚠️ {unmatchedImages.length}件の画像が紐づけできません:
                </p>
                <ul className="mt-2 ml-4 list-disc text-xs text-yellow-500 dark:text-yellow-400 max-h-32 overflow-y-auto">
                  {unmatchedImages.map((filename, index) => (
                    <li key={index}>{filename}</li>
                  ))}
                </ul>
              </div>
            )}
          </div>

          <div className="flex justify-end">
            <Button
              onClick={uploadImagesToFirebase}
              disabled={Object.keys(imageFiles).length === 0 || uploadingImages}
            >
              {uploadingImages ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  アップロード中...
                </>
              ) : (
                "画像をアップロード"
              )}
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
