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
import { Image as ImageIcon } from "lucide-react";

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
  if (!isEditing)
    return <TableCell className="px-4 text-center">{value}</TableCell>;

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

// メタデータをグループ化するためのインターフェース
interface GroupedMetadata {
  key: string; // アーティスト名_UPC
  artist_jp: string;
  artist_en: string;
  artist_kana: string;
  upc: string;
  title: string;
  artistId?: string;
  tracks: Metadata[];
}

export function MetadataTable({
  metadata,
  editingIndex,
  hasUnregisteredArtists,
  setEditingIndex,
  handleMetadataChange,
}: MetadataTableProps) {
  const { toast } = useToast();
  const [currentPage, setCurrentPage] = useState(1);
  const [expandedGroups, setExpandedGroups] = useState<Set<string>>(new Set());
  const itemsPerPage = 10;

  // メタデータをグループ化
  const groupedMetadata: GroupedMetadata[] = metadata.reduce(
    (groups: GroupedMetadata[], item) => {
      const key = `${item.artist_jp}_${item.upc}`;
      const existingGroup = groups.find((g) => g.key === key);

      if (existingGroup) {
        existingGroup.tracks.push(item);
      } else {
        groups.push({
          key,
          artist_jp: item.artist_jp,
          artist_en: item.artist_en,
          artist_kana: item.artist_kana,
          upc: item.upc,
          title: item.title,
          artistId: item.artistId,
          tracks: [item],
        });
      }
      return groups;
    },
    [],
  );

  const totalPages = Math.ceil(groupedMetadata.length / itemsPerPage);
  const paginatedGroups = groupedMetadata.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage,
  );

  const toggleGroup = (key: string) => {
    const newExpanded = new Set(expandedGroups);
    if (newExpanded.has(key)) {
      newExpanded.delete(key);
    } else {
      newExpanded.add(key);
    }
    setExpandedGroups(newExpanded);
  };

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
        setTimeout(() => {
          window.location.reload();
        }, 1000);
      } else {
        toast({
          title: "登録に失敗しました。最初からやり直してください。",
          variant: "destructive",
        });
      }
    },
    onError: (error) => {
      console.error("Registration error:", error);
      toast({
        title: "登録中にエラーが発生しました。最初からやり直してください。",
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
    console.log(`metadata: ${metadata}`);
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

      <div className="space-y-2">
        {paginatedGroups.map((group) => (
          <div key={group.key} className="border rounded-lg">
            <div
              className="flex items-center justify-between p-4 cursor-pointer bg-gray-50 hover:bg-gray-100"
              onClick={() => toggleGroup(group.key)}
            >
              <div className="flex-1 grid grid-cols-4 gap-4">
                <div>
                  <div className="font-medium">{group.artist_jp}</div>
                  <div className="text-sm text-gray-500">{group.artist_en}</div>
                </div>
                <div>
                  <div className="text-sm">{group.title}</div>
                </div>
                <div className="text-sm flex items-center gap-2">
                  {group.tracks[0]?.imageUrl ? (
                    <ImageIcon className="w-4 h-4 text-green-500" />
                  ) : (
                    <ImageIcon className="w-4 h-4 text-gray-300" />
                  )}
                  {group.upc}
                </div>
                <div>
                  {group.artistId ? (
                    <span className="text-green-500 text-sm">
                      {group.artistId}
                    </span>
                  ) : (
                    <span className="text-red-500 text-sm">未登録</span>
                  )}
                </div>
              </div>
              <div className="ml-4">
                <span className="text-sm text-gray-500">
                  {group.tracks.length} トラック
                </span>
                {expandedGroups.has(group.key) ? "▼" : "▶"}
              </div>
            </div>

            {expandedGroups.has(group.key) && (
              <div className="p-4 border-t">
                <Table className="text-sm">
                  <TableHeader>
                    <TableRow>
                      <TableHead className="text-center">操作</TableHead>
                      <TableHead className="text-center">
                        トラック番号
                      </TableHead>
                      <TableHead className="text-center">
                        トラックタイトル
                      </TableHead>
                      <TableHead className="text-center">ISRC</TableHead>
                      <TableHead className="text-center">リリース日</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {group.tracks.map((track, index) => (
                      <TableRow key={index}>
                        <TableCell className="text-center">
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
                          value={track.track_no}
                          onChange={(value) =>
                            handleMetadataChange(index, "track_no", value)
                          }
                          isEditing={editingIndex === index}
                        />
                        <EditableCell
                          value={track.track_title}
                          onChange={(value) =>
                            handleMetadataChange(index, "track_title", value)
                          }
                          isEditing={editingIndex === index}
                        />
                        <EditableCell
                          value={track.isrc}
                          onChange={(value) =>
                            handleMetadataChange(index, "isrc", value)
                          }
                          isEditing={editingIndex === index}
                        />
                        <EditableCell
                          value={track.release_date}
                          onChange={(value) =>
                            handleMetadataChange(index, "release_date", value)
                          }
                          isEditing={editingIndex === index}
                        />
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
