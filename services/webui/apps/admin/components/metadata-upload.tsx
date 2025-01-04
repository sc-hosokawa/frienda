"use client";

import { useState } from "react";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import * as XLSX from "xlsx";
import { Loader2, FileUp, Plus } from "lucide-react";

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
}

function EditableCell({
  value,
  onChange,
  isEditing,
}: {
  value: string;
  onChange: (value: string) => void;
  isEditing: boolean;
}) {
  if (!isEditing) return <TableCell className="px-4">{value}</TableCell>;

  return (
    <TableCell className="p-0">
      <Input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="h-full border-2 border-gray-200 focus:ring-0 px-4"
      />
    </TableCell>
  );
}

export function MetadataUpload() {
  const [file, setFile] = useState<File | null>(null);
  const [metadata, setMetadata] = useState<Metadata[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isRegistering, setIsRegistering] = useState(false);
  const [editingIndex, setEditingIndex] = useState<number | null>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFile(e.target.files[0]);
    }
  };

  const handleUpload = async () => {
    if (!file) return;
    setIsLoading(true);

    try {
      const reader = new FileReader();
      reader.onload = (e) => {
        const data = new Uint8Array(e.target?.result as ArrayBuffer);
        const workbook = XLSX.read(data, { type: "array" });
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
          .map((row: unknown) => {
            const rowArray = row as any[];
            return {
              upc: rowArray[1] || "",
              format: rowArray[4] || "",
              track_count: rowArray[7] || "",
              title: rowArray[9] || "",
              artist_jp: rowArray[27] || "",
              artist_kana: rowArray[33] || "",
              release_date: rowArray[73] || "",
              isrc: rowArray[81] || "",
              track_no: rowArray[88] || "",
              track_title: rowArray[93] || "",
              track_title_version: rowArray[104] || "",
            };
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

  const handleRegister = async () => {
    if (metadata.length === 0) return;
    setIsRegistering(true);

    try {
      const response = await fetch("/api/metadata", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ metadata }),
      });

      if (!response.ok) {
        throw new Error("登録に失敗しました");
      }

      setMetadata([]);
      alert("メタデータを登録しました");
    } catch (error) {
      console.error("登録エラー:", error);
      alert("登録中にエラーが発生しました");
    } finally {
      setIsRegistering(false);
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
            className="flex items-center justify-center space-x-2 p-2 border-2 border-dashed rounded-md cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800"
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
            <h3 className="text-lg">アップロードされたメタデータ</h3>
            <Button
              onClick={handleRegister}
              disabled={isRegistering}
              className="ml-4"
            >
              {isRegistering ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  登録中...
                </>
              ) : (
                "登録する"
              )}
            </Button>
          </div>
          <div className="overflow-x-auto">
            <Table className="text-sm">
              <TableHeader>
                <TableRow className="border-b border-gray-200 dark:border-gray-700">
                  <TableHead className="text-center">操作</TableHead>
                  <TableHead className="text-center">
                    アーティスト名(日本語)
                  </TableHead>
                  <TableHead className="text-center">
                    アーティスト名(カナ)
                  </TableHead>
                  <TableHead className="text-center">UPC</TableHead>
                  <TableHead className="text-center">商品形態</TableHead>
                  <TableHead className="text-center">トラック数</TableHead>
                  <TableHead className="text-center">タイトル</TableHead>
                  <TableHead className="text-center">リリース日</TableHead>
                  <TableHead className="text-center">ISRC</TableHead>
                  <TableHead className="text-center">トラック番号</TableHead>
                  <TableHead className="text-center">
                    トラックタイトル
                  </TableHead>
                  <TableHead className="text-center">
                    トラックタイトルバージョン
                  </TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {metadata.map((item, index) => (
                  <TableRow
                    key={index}
                    className={`border-b border-gray-200 dark:border-gray-700 whitespace-nowrap ${
                      editingIndex === index
                        ? "bg-gray-50 dark:bg-gray-800"
                        : ""
                    }`}
                  >
                    <TableCell className="px-6">
                      {editingIndex === index ? (
                        <Button onClick={() => setEditingIndex(null)}>
                          保存
                        </Button>
                      ) : (
                        <Button onClick={() => setEditingIndex(index)}>
                          編集
                        </Button>
                      )}
                    </TableCell>
                    <EditableCell
                      value={item.artist_jp}
                      onChange={(value) =>
                        handleMetadataChange(index, "artist_jp", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.artist_kana}
                      onChange={(value) =>
                        handleMetadataChange(index, "artist_kana", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.upc}
                      onChange={(value) =>
                        handleMetadataChange(index, "upc", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.format}
                      onChange={(value) =>
                        handleMetadataChange(index, "format", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.track_count}
                      onChange={(value) =>
                        handleMetadataChange(index, "track_count", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.title}
                      onChange={(value) =>
                        handleMetadataChange(index, "title", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.release_date}
                      onChange={(value) =>
                        handleMetadataChange(index, "release_date", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.isrc}
                      onChange={(value) =>
                        handleMetadataChange(index, "isrc", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.track_no}
                      onChange={(value) =>
                        handleMetadataChange(index, "track_no", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.track_title}
                      onChange={(value) =>
                        handleMetadataChange(index, "track_title", value)
                      }
                      isEditing={editingIndex === index}
                    />
                    <EditableCell
                      value={item.track_title_version}
                      onChange={(value) =>
                        handleMetadataChange(
                          index,
                          "track_title_version",
                          value,
                        )
                      }
                      isEditing={editingIndex === index}
                    />
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      )}
    </div>
  );
}
