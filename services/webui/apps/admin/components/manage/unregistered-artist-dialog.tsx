import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { useState, useMemo } from "react";

interface Metadata {
  artist_jp: string;
  artist_kana: string;
}

interface UnregisteredArtistsDialogProps {
  showDialog: boolean;
  setShowDialog: (show: boolean) => void;
  unregisteredArtists: Metadata[];
}

// ユニークなアーティストデータを取得する関数
function getUniqueArtists(artists: Metadata[]): Metadata[] {
  const uniqueMap = new Map<string, Metadata>();

  artists.forEach((artist) => {
    const key = `${artist.artist_jp}-${artist.artist_kana}`;
    if (!uniqueMap.has(key)) {
      uniqueMap.set(key, artist);
    }
  });

  return Array.from(uniqueMap.values());
}

function generateCsv(artists: Metadata[]): string {
  return artists
    .map((artist) => `${artist.artist_jp},,${artist.artist_kana || ""}`)
    .join("\n");
}

export function UnregisteredArtistsDialog({
  showDialog,
  setShowDialog,
  unregisteredArtists,
}: UnregisteredArtistsDialogProps) {
  const uniqueArtists = useMemo(
    () => getUniqueArtists(unregisteredArtists),
    [unregisteredArtists],
  );

  const handleDownloadCsv = () => {
    const csvContent = generateCsv(uniqueArtists);
    const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    const url = URL.createObjectURL(blob);

    link.setAttribute("href", url);
    link.setAttribute("download", "unregistered_artists.csv");
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <Dialog open={showDialog} onOpenChange={setShowDialog}>
      <DialogContent className="max-w-3xl">
        <DialogHeader>
          <DialogTitle>未登録アーティスト一覧</DialogTitle>
        </DialogHeader>
        <div className="mt-4">
          <div className="mb-4">
            <p className="text-sm text-gray-500">
              {uniqueArtists.length}件のユニークなアーティストが見つかりました
              （重複を除外済み）
            </p>
          </div>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>アーティスト名(日本語)</TableHead>
                <TableHead>アーティスト名(カナ)</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {uniqueArtists.map((artist, index) => (
                <TableRow key={index}>
                  <TableCell>{artist.artist_jp}</TableCell>
                  <TableCell>{artist.artist_kana}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
          <div className="mt-4 flex justify-end space-x-2">
            <Button variant="outline" onClick={() => setShowDialog(false)}>
              閉じる
            </Button>
            <Button
              onClick={() => {
                handleDownloadCsv();
                setShowDialog(false);
              }}
              variant="default"
            >
              CSVダウンロード
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
