"use client";

import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, SEARCH_TRACKS } from "../../utils/query";
import { useState } from "react";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import { Input } from "@ui/components/ui/input";
import { Button } from "@ui/components/ui/button";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { Label } from "@ui/components/ui/label";
import { EditDialog } from "../../components/manage/track-management";
import Link from "next/link";

interface TrackData {
  isrc: string;
  trackTitle: string;
  artistId: string;
  artistName: string;
  productTitle: string;
}

interface SearchTracksResponse {
  searchTracks: TrackData[];
}

interface SearchForm {
  isrc?: string;
  trackTitle?: string;
}

export default function TrackManagementPage() {
  const [formData, setFormData] = useState<SearchForm>({});
  const [hasSearched, setHasSearched] = useState(false);
  const [selectedTrack, setSelectedTrack] = useState<TrackData | null>(null);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);

  const searchTracks = useQuery<SearchTracksResponse>({
    queryKey: ["searchTracks", formData],
    queryFn: () => request(endpoint, SEARCH_TRACKS, { input: formData }),
    enabled: false,
  });

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setHasSearched(true);
    searchTracks.refetch();
  };

  const handleFormChange = (newData: Partial<SearchForm>) => {
    setFormData((prev) => ({ ...prev, ...newData }));
  };

  const handleClear = () => {
    setFormData({});
    setHasSearched(false);
  };

  const tracks = searchTracks.data?.searchTracks ?? [];

  const handleEditClick = (track: TrackData) => {
    setSelectedTrack(track);
    setIsEditDialogOpen(true);
  };

  return (
    <>
      <div className="flex min-h-screen">
        <div className="w-1/4 p-6 border-r border-border">
          <Card>
            <CardHeader>
              <CardTitle>トラック検索</CardTitle>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleSearch} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="isrc">ISRC</Label>
                  <Input
                    id="isrc"
                    value={formData.isrc || ""}
                    placeholder="ISRCを入力"
                    onChange={(e) => handleFormChange({ isrc: e.target.value })}
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="title">タイトル</Label>
                  <Input
                    id="title"
                    value={formData.trackTitle || ""}
                    placeholder="タイトルを入力"
                    onChange={(e) =>
                      handleFormChange({ trackTitle: e.target.value })
                    }
                  />
                </div>

                <Button
                  type="submit"
                  className="w-full"
                  disabled={searchTracks.isFetching}
                >
                  {searchTracks.isFetching ? "検索中..." : "検索"}
                </Button>

                <Button
                  type="button"
                  variant="outline"
                  className="w-full"
                  onClick={handleClear}
                >
                  クリア
                </Button>
              </form>
            </CardContent>
          </Card>

          <div className="mt-4 mr-4 text-right">
            <Link href="/manage/product" className="w-full underline">
              プロダクトの管理はこちら
            </Link>
          </div>
        </div>

        <div className="w-3/4 p-6">
          <Card>
            <CardContent>
              {searchTracks.isFetching ? (
                <div className="flex items-center justify-center h-32">
                  <svg
                    className="animate-spin h-8 w-8 text-primary"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    ></circle>
                    <path
                      className="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
                </div>
              ) : !hasSearched ? (
                <div className="flex items-center justify-center h-32 text-muted-foreground">
                  検索してください
                </div>
              ) : tracks.length === 0 ? (
                <div className="flex items-center justify-center h-32 text-muted-foreground">
                  該当するデータがありません。
                </div>
              ) : (
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead className="text-center">ISRC</TableHead>
                      <TableHead className="text-center">タイトル</TableHead>
                      <TableHead className="text-center">
                        アーティスト
                      </TableHead>
                      <TableHead className="text-center">プロダクト</TableHead>
                      <TableHead className="text-center">操作</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {tracks.map((track) => (
                      <TableRow key={track.isrc}>
                        <TableCell className="text-center">
                          {track.isrc}
                        </TableCell>
                        <TableCell className="text-center">
                          {track.trackTitle}
                        </TableCell>
                        <TableCell className="text-center">
                          {track.artistName}
                        </TableCell>
                        <TableCell className="text-center">
                          {track.productTitle}
                        </TableCell>
                        <TableCell className="text-center">
                          <Button
                            variant="default"
                            size="sm"
                            onClick={() => handleEditClick(track)}
                          >
                            編集
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              )}
            </CardContent>
          </Card>
        </div>
      </div>

      <EditDialog
        track={selectedTrack}
        open={isEditDialogOpen}
        onOpenChange={setIsEditDialogOpen}
        onSuccess={() => {
          setSelectedTrack(null);
          searchTracks.refetch();
        }}
      />
    </>
  );
}
