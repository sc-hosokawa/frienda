"use client";

import { useState } from "react";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import * as XLSX from "xlsx";
import { FileUp, Plus, AlertCircle } from "lucide-react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_ALL_ARTISTS_ID } from "../utils/query";
import { MetadataTable } from "./manage/metadata-table";
import { UnregisteredArtistsDialog } from "./manage/unregistered-artist-dialog";
import { useToast } from "@ui/hooks/use-toast";
import { storage } from "../config";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { ImageUploadDialog } from "./manage/image-upload-dialog";

interface Metadata {
  upc: string;
  format: string;
  track_count: string;
  title: string;
  artist_jp: string;
  artist_en: string;
  artist_kana: string;
  release_date: string;
  isrc: string;
  track_no: string;
  track_title: string;
  track_title_version: string;
  artistId?: string;
  artistStatus?: string;
  imageUrl?: string;
}

export function MetadataUpload() {
  const [file, setFile] = useState<File | null>(null);
  const [metadata, setMetadata] = useState<Metadata[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [editingIndex, setEditingIndex] = useState<number | null>(null);
  const [showUnregisteredDialog, setShowUnregisteredDialog] = useState(false);
  const [imageFiles, setImageFiles] = useState<{ [key: string]: File }>({});
  const [uploadingImages, setUploadingImages] = useState(false);
  const [unmatchedImages, setUnmatchedImages] = useState<string[]>([]);
  const [showImageUploadDialog, setShowImageUploadDialog] = useState(false);
  const { toast } = useToast();
  const queryClient = useQueryClient();

  const {
    data: artistMapping,
    isLoading: isLoadingArtists,
    isError: isErrorLoadingArtists,
  } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_ARTISTS_ID).then(
        (data: any) => data.getAllArtists,
      );
    },
    staleTime: 0,
  });

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFile(e.target.files[0]);
    }
  };

  const findArtistId = (
    artistJp: string,
    artistKana: string,
    artistEn: string,
  ) => {
    if (!artistMapping?.artistList) return null;

    const artist = artistMapping.artistList.find(
      (artist: any) =>
        artist.name === artistJp ||
        artist.displayNameKana === artistKana ||
        artist.displayNameEn === artistEn,
    );

    return artist?.artistId || null;
  };

  const handleUpload = async () => {
    if (!file) return;

    setIsLoading(true);

    try {
      console.log("fetching artists");
      await queryClient.ensureQueryData({
        queryKey: ["artists"],
        queryFn: async () => {
          return await request(endpoint, GET_ALL_ARTISTS_ID).then(
            (data: any) => data.getAllArtists,
          );
        },
        staleTime: 0,
      });
      console.log("artists fetched");

      if (isErrorLoadingArtists) {
        toast({
          title: "アーティスト情報の取得に失敗",
          description:
            "アーティスト情報が取得できませんでした。再度お試しください。",
          variant: "destructive",
        });
        return;
      }

      console.log("processing file");

      const reader = new FileReader();
      reader.onload = (e) => {
        const data = new Uint8Array(e.target?.result as ArrayBuffer);
        const workbook = XLSX.read(data, {
          type: "array",
          cellNF: false,
          cellStyles: false,
        });
        console.log("workbook", workbook);
        const secondSheetName = workbook.SheetNames[2];
        if (!secondSheetName) {
          throw new Error("Second sheet not found in workbook");
        }
        const secondSheet = workbook.Sheets[secondSheetName];
        if (!secondSheet) {
          throw new Error("Second sheet is empty or invalid");
        }

        const jsonData = XLSX.utils.sheet_to_json(secondSheet, {
          range: 3,
          header: 1,
          blankrows: false,
        });
        const dataRows = jsonData.slice(1);

        console.log("dataRows", dataRows);

        const extractedMetadata: Metadata[] = dataRows
          .slice(2)
          .flatMap((row: unknown) => {
            const rowArray = row as any[];
            const artistJp = rowArray[38] || "";
            const artistEn = rowArray[36] || "";
            const artistKana = rowArray[42] || "";

            const artistJpList = artistJp.split("|").map((a: any) => a.trim());
            const artistEnList = artistEn.split("|").map((a: any) => a.trim());
            const artistKanaList = artistKana
              .split("|")
              .map((a: any) => a.trim());

            return artistJpList.map((splitArtistJp: any, index: any) => {
              const splitArtistKana = artistKanaList[index] || "";
              const splitArtistEn = artistEnList[index] || "";
              const artistId = findArtistId(
                splitArtistJp,
                splitArtistKana,
                splitArtistEn,
              );

              const fullTitle =
                rowArray[11] + (rowArray[20] ? ` (${rowArray[20]})` : "");
              const fullTrackTitle =
                rowArray[95] + (rowArray[104] ? ` (${rowArray[104]})` : "");

              return {
                upc: rowArray[1] || "",
                format: rowArray[4] || "",
                track_count: rowArray[7] || "",
                title: fullTitle,
                artist_jp: splitArtistJp,
                artist_en: splitArtistEn,
                artist_kana: splitArtistKana,
                artistId: artistId || undefined,
                artistStatus: artistId ? "登録済み" : "未登録",
                release_date: rowArray[73] || "",
                isrc: rowArray[81] || "",
                track_no: rowArray[88] || "",
                track_title: fullTrackTitle,
                track_title_version: rowArray[104] || "",
              };
            });
          })
          .filter((item) => item.upc !== "");

        setMetadata(extractedMetadata);
        setIsLoading(false);
      };
      reader.readAsArrayBuffer(file);
    } catch (error) {
      console.error("Error during upload:", error);
      setIsLoading(false);
      toast({
        title: "エラーが発生しました",
        description: "処理中にエラーが発生しました。再度お試しください。",
        variant: "destructive",
      });
    }
  };

  const handleMetadataChange = (
    index: number,
    field: keyof Metadata,
    value: string,
  ) => {
    const newMetadata = [...metadata];
    newMetadata[index] = {
      ...newMetadata[index],
      [field]: value,
    } as Metadata;
    setMetadata(newMetadata);
  };

  const hasUnregisteredArtists = metadata.some((item) => !item.artistId);
  const unregisteredArtists = metadata.filter((item) => !item.artistId);

  const getUniqueUpcs = () => {
    return [...new Set(metadata.map((item) => item.upc))];
  };

  const handleImageUpload = (files: File[]) => {
    const newImageFiles: { [key: string]: File } = {};
    const unmatched: string[] = [];
    const uniqueUpcs = getUniqueUpcs();

    files.forEach((file) => {
      const upc = file.name.split(".")[0];
      if (uniqueUpcs.includes(upc || "")) {
        if (upc) {
          newImageFiles[upc] = file;
        }
      } else {
        unmatched.push(file.name);
      }
    });

    setImageFiles((prev) => ({ ...prev, ...newImageFiles }));
    setUnmatchedImages(unmatched);

    if (unmatched.length > 0) {
      toast({
        title: "一部の画像が紐づけできません",
        description: `以下の画像のUPCがメタデータと一致しません：\n${unmatched.join(", ")}`,
        variant: "destructive",
      });
    }
  };

  const uploadImagesToFirebase = async () => {
    setUploadingImages(true);
    try {
      const uploadPromises = Object.entries(imageFiles).map(
        async ([upc, file]) => {
          const extension = file.name.split(".").pop() || "";
          const fileName = `${upc}_${Date.now()}.${extension}`;
          const storageRef = ref(storage, `products/${fileName}`);

          if (file.size > 100 * 1024 * 1024) {
            throw new Error(`File ${file.name} exceeds 100MB size limit`);
          }

          await uploadBytes(storageRef, file);
          const url = await getDownloadURL(storageRef);
          return { upc, url };
        },
      );

      const uploadResults = await Promise.all(uploadPromises);

      const newMetadata = metadata.map((item) => {
        const imageData = uploadResults.find(
          (result) => result.upc === item.upc,
        );
        return imageData ? { ...item, imageUrl: imageData.url } : item;
      });

      console.log("newMetadata", newMetadata);

      setMetadata(newMetadata);
      setImageFiles({});
      toast({
        title: "画像のアップロードが完了しました",
        description: `${uploadResults.length}件の画像をアップロードしました。`,
      });
    } catch (error) {
      console.error("Error uploading images:", error);
      toast({
        title: "画像のアップロードに失敗しました",
        description:
          error instanceof Error
            ? error.message
            : "エラーが発生しました。再度お試しください。",
        variant: "destructive",
      });
    } finally {
      setUploadingImages(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center space-x-2">
        <div className="relative flex-1">
          <Input
            type="file"
            accept=".xlsx,.xlsm"
            onChange={handleFileChange}
            className="hidden"
            id="file-upload"
          />
          <label
            htmlFor="file-upload"
            className="flex items-center justify-center space-x-2 p-2 border-2 border-dashed rounded-md cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800 dark:border-gray-700"
          >
            {file ? (
              <>
                <FileUp className="h-5 w-5" />
                <span>{file.name}</span>
              </>
            ) : (
              <>
                <Plus className="h-5 w-5" />
                <span>ファイルを選択してください</span>
              </>
            )}
          </label>
        </div>
        {file && (
          <Button
            onClick={handleUpload}
            disabled={isLoading || metadata.length > 0 || isLoadingArtists}
          >
            {isLoading ? (
              <>処理中...</>
            ) : isLoadingArtists ? (
              <>アーティスト情報読み込み中...</>
            ) : (
              "アップロード"
            )}
          </Button>
        )}
      </div>
      {metadata.length > 0 && (
        <div className="mt-8">
          <div className="flex items-center my-12">
            <h3 className="text-lg">
              アップロードされたメタデータ（{metadata.length}件）
            </h3>
            {hasUnregisteredArtists ? (
              <Button
                onClick={() => setShowUnregisteredDialog(true)}
                className="ml-4"
              >
                <>
                  <AlertCircle className="mr-2 h-4 w-4 animate-pulse" />
                  未登録のアーティストを確認
                </>
              </Button>
            ) : (
              <Button
                onClick={() => setShowImageUploadDialog(true)}
                className="ml-4"
                variant="default"
              >
                <>
                  <AlertCircle className="mr-2 h-4 w-4 animate-pulse" />
                  {unmatchedImages.length > 0
                    ? "未紐付けの画像を確認"
                    : "作品画像をアップロード"}
                </>
              </Button>
            )}
          </div>

          <MetadataTable
            metadata={metadata}
            editingIndex={editingIndex}
            hasUnregisteredArtists={hasUnregisteredArtists}
            setEditingIndex={setEditingIndex}
            handleMetadataChange={handleMetadataChange}
          />

          <UnregisteredArtistsDialog
            showDialog={showUnregisteredDialog}
            setShowDialog={setShowUnregisteredDialog}
            unregisteredArtists={unregisteredArtists}
          />
        </div>
      )}

      <ImageUploadDialog
        showDialog={showImageUploadDialog}
        setShowDialog={setShowImageUploadDialog}
        unmatchedImages={unmatchedImages}
        imageFiles={imageFiles}
        handleImageUpload={handleImageUpload}
        uploadImagesToFirebase={uploadImagesToFirebase}
        uploadingImages={uploadingImages}
      />
    </div>
  );
}
