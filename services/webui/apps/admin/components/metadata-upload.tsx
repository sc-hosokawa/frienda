"use client";

import { useState } from "react";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import * as XLSX from "xlsx";
import { Loader2, FileUp, Plus, AlertCircle } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_ALL_ARTISTS_ID } from "../utils/query";
import { MetadataTable } from "./manage/metadata-table";
import { UnregisteredArtistsDialog } from "./manage/unregistered-artist-dialog";

interface Metadata {
  upc: string;
  format: string;
  track_count: string;
  title: string;
  artist_jp: string;
  artist_kana: string;
  release_date: string;
  isrc: string;
  track_no: string;
  track_title: string;
  track_title_version: string;
  artistId?: string;
  artistStatus?: string;
}

export function MetadataUpload() {
  const [file, setFile] = useState<File | null>(null);
  const [metadata, setMetadata] = useState<Metadata[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [editingIndex, setEditingIndex] = useState<number | null>(null);
  const [showUnregisteredDialog, setShowUnregisteredDialog] = useState(false);

  const {
    data: artistMapping,
    isLoading: isLoadingArtists,
    error,
  } = useQuery({
    queryKey: ["artists"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_ARTISTS_ID).then(
        (data: any) => data.getAllArtists,
      );
    },
  });

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFile(e.target.files[0]);
    }
  };

  const findArtistId = (artistJp: string, artistKana: string) => {
    if (!artistMapping?.artistList) return null;

    const artist = artistMapping.artistList.find(
      (artist: any) =>
        artist.name === artistJp || artist.displayNameKana === artistKana,
    );

    return artist?.artistId || null;
  };

  const handleUpload = async () => {
    if (!file) return;
    setIsLoading(true);

    try {
      const reader = new FileReader();
      reader.onload = (e) => {
        const data = new Uint8Array(e.target?.result as ArrayBuffer);
        const workbook = XLSX.read(data, {
          type: "array",
          cellNF: false,
          cellStyles: false,
        });
        const secondSheetName = workbook.SheetNames[1];
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

        const extractedMetadata: Metadata[] = dataRows
          .slice(2)
          .flatMap((row: unknown) => {
            const rowArray = row as any[];
            const artistJp = rowArray[27] || "";
            const artistKana = rowArray[33] || "";

            const artistJpList = artistJp.split("|").map((a: any) => a.trim());
            const artistKanaList = artistKana
              .split("|")
              .map((a: any) => a.trim());

            return artistJpList.map((splitArtistJp: any, index: any) => {
              const splitArtistKana = artistKanaList[index] || "";
              const artistId = findArtistId(splitArtistJp, splitArtistKana);

              return {
                upc: rowArray[1] || "",
                format: rowArray[4] || "",
                track_count: rowArray[7] || "",
                title: rowArray[9] || "",
                artist_jp: splitArtistJp,
                artist_kana: splitArtistKana,
                artistId: artistId || undefined,
                artistStatus: artistId ? "登録済み" : "未登録",
                release_date: rowArray[73] || "",
                isrc: rowArray[81] || "",
                track_no: rowArray[88] || "",
                track_title: rowArray[93] || "",
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
      setIsLoading(false);
      console.error("Error processing file:", error);
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
            disabled={isLoading || metadata.length > 0}
          >
            {isLoading ? <>処理中...</> : "アップロード"}
          </Button>
        )}
      </div>
      {metadata.length > 0 && (
        <div className="mt-8">
          <div className="flex items-center my-12">
            <h3 className="text-lg">
              アップロードされたメタデータ（{metadata.length}件）
            </h3>
            {hasUnregisteredArtists && (
              <Button
                onClick={() => setShowUnregisteredDialog(true)}
                className="ml-4"
              >
                <>
                  <AlertCircle className="mr-2 h-4 w-4 animate-pulse" />
                  未登録のアーティストを確認
                </>
              </Button>
            )}
          </div>

          <MetadataTable
            metadata={metadata}
            editingIndex={editingIndex}
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
    </div>
  );
}
