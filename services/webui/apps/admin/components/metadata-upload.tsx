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
import { Loader2 } from "lucide-react";

interface Metadata {
  upc: string;
  format: string;
}

export function MetadataUpload() {
  const [file, setFile] = useState<File | null>(null);
  const [metadata, setMetadata] = useState<Metadata[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isRegistering, setIsRegistering] = useState(false);

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
        console.log(dataRows);

        const extractedMetadata: Metadata[] = dataRows
          .slice(2)
          .map((row: unknown) => {
            const rowArray = row as any[];
            return {
              upc: rowArray[1] || "",
              format: rowArray[4] || "",
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

      // 成功したらメタデータをクリア
      setMetadata([]);
      alert("メタデータを登録しました");
    } catch (error) {
      console.error("登録エラー:", error);
      alert("登録中にエラーが発生しました");
    } finally {
      setIsRegistering(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center space-x-2">
        <Input type="file" accept=".xlsx,.xlsm" onChange={handleFileChange} />
        <Button onClick={handleUpload} disabled={isLoading}>
          {isLoading ? (
            <>
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              処理中...
            </>
          ) : (
            "アップロード"
          )}
        </Button>
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
                  <TableHead>UPC</TableHead>
                  <TableHead>商品形態</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {metadata.map((item, index) => (
                  <TableRow
                    key={index}
                    className="border-b border-gray-200 dark:border-gray-700"
                  >
                    <TableCell>{item.upc}</TableCell>
                    <TableCell>{item.format}</TableCell>
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
