"use client";

import { useState } from "react";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { Separator } from "@ui/components/ui/separator";

export function NewArtistForm() {
  const [nameJa, setNameJa] = useState("");
  const [nameEn, setNameEn] = useState("");
  const [nameKana, setNameKana] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // ここでフォームデータの送信処理を実装
    console.log("Submitting new artist:", { nameJa, nameEn, nameKana });
  };

  const handleCsvUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      const file = e.target.files[0];
      if (file) {
        // ここでCSVファイルの処理を実装
        console.log("Uploading CSV file:", file.name);
      }
    }
  };

  const handleCsvSubmit = () => {
    // ここでCSVファイルの処理とアップロードを実装
    console.log("Processing and uploading CSV file");
  };

  return (
    <div className="container mx-auto p-4 max-w-2xl">
      <div className="mb-8">
        <h3 className="text-xl font-semibold mb-4">
          フォームで新規アーティストを追加
        </h3>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid gap-4">
            <div>
              <Label htmlFor="nameJa">アーティスト名（日本語）</Label>
              <Input
                type="text"
                id="nameJa"
                value={nameJa}
                onChange={(e) => setNameJa(e.target.value)}
                required
              />
            </div>
            <div>
              <Label htmlFor="nameEn">アーティスト名（英語）</Label>
              <Input
                type="text"
                id="nameEn"
                value={nameEn}
                onChange={(e) => setNameEn(e.target.value)}
                required
              />
            </div>
            <div>
              <Label htmlFor="nameKana">アーティスト名（カナ）</Label>
              <Input
                type="text"
                id="nameKana"
                value={nameKana}
                onChange={(e) => setNameKana(e.target.value)}
                required
              />
            </div>
          </div>
          <Button type="submit" className="w-full">
            アーティストを追加
          </Button>
        </form>
      </div>
      <Separator className="my-8" />
      <div>
        <h3 className="text-xl font-semibold mb-4">
          CSVファイルでアーティストを一括追加
        </h3>
        <div className="space-y-4">
          <p className="text-sm text-gray-600">
            CSVファイルを使用して複数のアーティストを一度に追加できます。
            ファイルは「日本語名,英語名,カナ名」の形式で各アーティストを1行ずつ記述してください。
          </p>
          <div className="space-y-2">
            <Label htmlFor="csv-upload">CSVファイルを選択</Label>
            <Input
              id="csv-upload"
              type="file"
              accept=".csv"
              onChange={handleCsvUpload}
            />
          </div>
          <Button onClick={handleCsvSubmit} className="w-full">
            CSVファイルをアップロード
          </Button>
        </div>
      </div>
    </div>
  );
}
