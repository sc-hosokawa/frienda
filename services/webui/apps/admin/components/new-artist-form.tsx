"use client";

import { useState } from "react";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { Separator } from "@ui/components/ui/separator";
import { useToast } from "@ui/hooks/use-toast";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";

import { endpoint, CREATE_NEW_ARTIST } from "../utils/query";
import { useMutation } from "@tanstack/react-query";
import request from "graphql-request";

type CreateNewArtistInput = {
  displayNameJp: string;
  displayNameEn: string;
  displayNameKana?: string;
};

type CreateNewArtistResponse = {
  createNewArtist: {
    addedArtists: Array<{
      artistId: string;
      displayNameJp: string;
    }>;
  };
};

export function NewArtistForm() {
  const [nameJa, setNameJa] = useState("");
  const [nameEn, setNameEn] = useState("");
  const [nameKana, setNameKana] = useState("");
  const [csvFile, setCsvFile] = useState<File | null>(null);
  const [previewData, setPreviewData] = useState<CreateNewArtistInput[]>([]);
  const [editingIndex, setEditingIndex] = useState<number | null>(null);
  const { toast } = useToast();

  const mutation = useMutation({
    mutationFn: async (artists: CreateNewArtistInput[]) => {
      const mutation = `
        mutation CreateNewArtist($input: [CreateNewArtistInput!]!) {
          createNewArtist(input: $input) {
            addedArtists {
              artistId
              displayNameJp
            }
          }
        }
      `;

      return request<CreateNewArtistResponse>(endpoint, mutation, {
        input: artists,
      });
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    const newArtist: CreateNewArtistInput = {
      displayNameJp: nameJa,
      displayNameEn: nameEn,
      displayNameKana: nameKana,
    };

    mutation.mutate([newArtist], {
      onSuccess: (data) => {
        console.log("Artist created successfully:", data);
        // Reset form
        setNameJa("");
        setNameEn("");
        setNameKana("");
      },
      onError: (error) => {
        console.error("Error creating artist:", error);
      },
    });
  };

  const handleCsvUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      const file = e.target.files[0];
      if (file) {
        setCsvFile(file);
        try {
          const text = await file.text();
          const rows = text.split("\n").filter((row) => row.trim());

          const artists: CreateNewArtistInput[] = rows.map((row) => {
            const [nameJp, nameEn, nameKana] = row
              .split(",")
              .map((field) => field.trim());

            return {
              displayNameJp: nameJp || "",
              displayNameEn: nameEn || "",
              displayNameKana: nameKana || "",
            };
          });

          setPreviewData(artists);
        } catch (error) {
          console.error("Error processing CSV:", error);
          toast({
            title: "CSVファイルの処理に失敗しました",
            variant: "destructive",
          });
        }
      }
    }
  };

  const handleCsvSubmit = async () => {
    const invalidData = previewData.some(
      (artist) => !artist.displayNameJp || !artist.displayNameEn,
    );

    if (invalidData) {
      toast({
        title: "必須項目が入力されていない行があります",
        variant: "destructive",
      });
      return;
    }

    mutation.mutate(previewData, {
      onSuccess: (data) => {
        toast({
          title: `${previewData.length}件のアーティストを登録しました`,
          variant: "default",
        });
        setPreviewData([]);
        setCsvFile(null);
        if (document.getElementById("csv-upload")) {
          (document.getElementById("csv-upload") as HTMLInputElement).value =
            "";
        }
      },
      onError: (error) => {
        console.error("Error creating artists:", error);
        toast({
          title: "アーティストの登録に失敗しました",
          variant: "destructive",
        });
      },
    });
  };

  const handleEditData = (
    index: number,
    field: keyof CreateNewArtistInput,
    value: string,
  ) => {
    const newData = [...previewData];
    // @ts-ignore
    newData[index] = { ...newData[index], [field]: value };
    setPreviewData(newData);
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
          {previewData.length > 0 && (
            <div className="my-4">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>アーティスト名（日本語）*</TableHead>
                    <TableHead>アーティスト名（英語）*</TableHead>
                    <TableHead>アーティスト名（カナ）</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {previewData.map((artist, index) => (
                    <TableRow key={index}>
                      <TableCell>
                        <Input
                          value={artist.displayNameJp}
                          onChange={(e) =>
                            handleEditData(
                              index,
                              "displayNameJp",
                              e.target.value,
                            )
                          }
                          className={
                            !artist.displayNameJp ? "border-red-500" : ""
                          }
                        />
                      </TableCell>
                      <TableCell>
                        <Input
                          value={artist.displayNameEn}
                          onChange={(e) =>
                            handleEditData(
                              index,
                              "displayNameEn",
                              e.target.value,
                            )
                          }
                          className={
                            !artist.displayNameEn ? "border-red-500" : ""
                          }
                        />
                      </TableCell>
                      <TableCell>
                        <Input
                          value={artist.displayNameKana || ""}
                          onChange={(e) =>
                            handleEditData(
                              index,
                              "displayNameKana",
                              e.target.value,
                            )
                          }
                        />
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          )}
          <Button onClick={handleCsvSubmit} className="w-full">
            CSVファイルをアップロード
          </Button>
        </div>
      </div>
    </div>
  );
}
