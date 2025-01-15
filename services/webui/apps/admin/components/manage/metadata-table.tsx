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
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
} from "@ui/components/ui/pagination";
import { useMutation } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint } from "../../utils/query";
import { useToast } from "@ui/hooks/use-toast";

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

interface EditableCellProps {
  value: string;
  onChange: (value: string) => void;
  isEditing: boolean;
}

function EditableCell({ value, onChange, isEditing }: EditableCellProps) {
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

interface MetadataTableProps {
  metadata: Metadata[];
  editingIndex: number | null;
  hasUnregisteredArtists: boolean;
  setEditingIndex: (index: number | null) => void;
  handleMetadataChange: (
    index: number,
    field: keyof Metadata,
    value: string,
  ) => void;
}

const REGISTER_RELEASES = `
  mutation RegisterReleases($input: RegisterReleases!) {
    registerReleases(input: $input) {
      success
    }
  }
`;

export function MetadataTable({
  metadata,
  editingIndex,
  hasUnregisteredArtists,
  setEditingIndex,
  handleMetadataChange,
}: MetadataTableProps) {
  const { toast } = useToast();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 20;
  const totalPages = Math.ceil(metadata.length / itemsPerPage);
  console.log("========== releases count = ", metadata.length);
  const paginatedMetadata = metadata.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage,
  );

  const mutation = useMutation({
    mutationFn: async (metadata: Metadata[]) => {
      const releases = metadata.map((item) => ({
        upc: item.upc,
        format: item.format,
        trackCount: parseInt(item.track_count),
        title: item.title,
        releaseDate: item.release_date,
        isrc: item.isrc,
        trackNo: parseInt(item.track_no),
        trackTitle: item.track_title,
        trackTitleVersion: item.track_title_version,
        artistId: item.artistId || "",
        imageUrl: item.imageUrl || "",
      }));

      return request(endpoint, REGISTER_RELEASES, {
        input: { releases },
      });
    },
    onSuccess: (data: any) => {
      if (data.registerReleases.success) {
        toast({
          title: "メタデータを登録しました",
          variant: "default",
        });
      } else {
        toast({
          title: "登録に失敗しました",
          variant: "destructive",
        });
      }
    },
    onError: (error) => {
      console.error("Registration error:", error);
      toast({
        title: "登録中にエラーが発生しました",
        variant: "destructive",
      });
    },
  });

  const handleRegister = () => {
    if (!metadata.every((item) => item.artistId)) {
      toast({
        title: "アーティストIDが未設定の項目があります",
        variant: "destructive",
      });
      return;
    }
    mutation.mutate(metadata);
  };

  return (
    <div className="overflow-x-auto">
      <div className="flex justify-between items-center mb-4">
        <Pagination>
          <PaginationContent>
            <PaginationItem>
              <PaginationLink
                onClick={() => currentPage > 1 && setCurrentPage((p) => p - 1)}
                className={
                  currentPage === 1
                    ? "pointer-events-none opacity-50"
                    : "cursor-pointer hover:bg-gray-100"
                }
              >
                Prev
              </PaginationLink>
            </PaginationItem>

            {/* 最初のページ */}
            {currentPage > 2 && (
              <>
                <PaginationItem>
                  <PaginationLink
                    onClick={() => setCurrentPage(1)}
                    className="cursor-pointer hover:bg-gray-100"
                  >
                    1
                  </PaginationLink>
                </PaginationItem>
                {currentPage > 3 && (
                  <PaginationItem>
                    <PaginationLink>...</PaginationLink>
                  </PaginationItem>
                )}
              </>
            )}

            {/* 現在のページの前後2ページを表示 */}
            {Array.from({ length: totalPages }, (_, i) => i + 1)
              .filter((page) => Math.abs(page - currentPage) <= 1)
              .map((page) => (
                <PaginationItem key={page}>
                  <PaginationLink
                    onClick={() => setCurrentPage(page)}
                    isActive={currentPage === page}
                    className={
                      currentPage !== page
                        ? "cursor-pointer hover:bg-gray-100"
                        : ""
                    }
                  >
                    {page}
                  </PaginationLink>
                </PaginationItem>
              ))}

            {/* 最後のページ */}
            {currentPage < totalPages - 1 && (
              <>
                {currentPage < totalPages - 2 && (
                  <PaginationItem>
                    <PaginationLink>...</PaginationLink>
                  </PaginationItem>
                )}
                <PaginationItem>
                  <PaginationLink
                    onClick={() => setCurrentPage(totalPages)}
                    className="cursor-pointer hover:bg-gray-100"
                  >
                    {totalPages}
                  </PaginationLink>
                </PaginationItem>
              </>
            )}

            <PaginationItem>
              <PaginationLink
                onClick={() =>
                  currentPage < totalPages && setCurrentPage((p) => p + 1)
                }
                className={
                  currentPage === totalPages
                    ? "pointer-events-none opacity-50"
                    : "cursor-pointer hover:bg-gray-100"
                }
              >
                Next
              </PaginationLink>
            </PaginationItem>
          </PaginationContent>
        </Pagination>
        {!hasUnregisteredArtists && (
          <Button
            onClick={handleRegister}
            className=""
            disabled={mutation.isPending}
          >
            {mutation.isPending ? "登録中..." : "登録"}
          </Button>
        )}
      </div>

      <Table className="text-sm">
        <TableHeader>
          <TableRow className="border-b border-gray-200 dark:border-gray-700">
            <TableHead className="text-center">操作</TableHead>
            <TableHead className="text-center">
              アーティスト名(日本語)
            </TableHead>
            <TableHead className="text-center">アーティスト名(カナ)</TableHead>
            <TableHead className="text-center">アーティスト名(英語)</TableHead>
            <TableHead className="text-center">アーティストID</TableHead>
            <TableHead className="text-center">UPC</TableHead>
            <TableHead className="text-center">商品形態</TableHead>
            <TableHead className="text-center">トラック数</TableHead>
            <TableHead className="text-center">タイトル</TableHead>
            <TableHead className="text-center">リリース日</TableHead>
            <TableHead className="text-center">ISRC</TableHead>
            <TableHead className="text-center">トラック番号</TableHead>
            <TableHead className="text-center">トラックタイトル</TableHead>
            <TableHead className="text-center">
              トラックタイトルバージョン
            </TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {paginatedMetadata.map((item, index) => (
            <TableRow
              key={(currentPage - 1) * itemsPerPage + index}
              className={`border-b border-gray-200 dark:border-gray-700 whitespace-nowrap ${
                editingIndex === index ? "bg-gray-50 dark:bg-gray-800" : ""
              }`}
            >
              <TableCell className="px-6">
                {editingIndex === index ? (
                  <Button onClick={() => setEditingIndex(null)}>保存</Button>
                ) : (
                  <Button onClick={() => setEditingIndex(index)}>編集</Button>
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
                value={item.artist_en}
                onChange={(value) =>
                  handleMetadataChange(index, "artist_en", value)
                }
                isEditing={editingIndex === index}
              />
              <TableCell className="px-4">
                {item.artistId ? (
                  <span className="text-green-500">{item.artistId}</span>
                ) : (
                  <span className="text-red-500">未登録</span>
                )}
              </TableCell>
              <EditableCell
                value={item.upc}
                onChange={(value) => handleMetadataChange(index, "upc", value)}
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
                onChange={(value) => handleMetadataChange(index, "isrc", value)}
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
                  handleMetadataChange(index, "track_title_version", value)
                }
                isEditing={editingIndex === index}
              />
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}
