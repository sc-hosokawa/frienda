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
import { useMutation } from "@tanstack/react-query";
import request from "graphql-request";
import { useToast } from "@ui/hooks/use-toast";
import { endpoint } from "../../utils/query";

interface Metadata {
  artist_jp: string;
  artist_en: string;
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
    .map(
      (artist) =>
        `${artist.artist_jp},${artist.artist_en},${artist.artist_kana || ""}`,
    )
    .join("\n");
}

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

export function UnregisteredArtistsDialog({
  showDialog,
  setShowDialog,
  unregisteredArtists,
}: UnregisteredArtistsDialogProps) {
  const { toast } = useToast();
  const uniqueArtists = useMemo(
    () => getUniqueArtists(unregisteredArtists),
    [unregisteredArtists],
  );

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

  const handleRegisterArtists = () => {
    const artists = uniqueArtists.map((artist) => ({
      displayNameJp: artist.artist_jp,
      displayNameEn: artist.artist_en,
      displayNameKana: artist.artist_kana,
    }));

    mutation.mutate(artists, {
      onSuccess: (data) => {
        toast({
          title: `${artists.length}件のアーティストを登録しました`,
          variant: "default",
        });
        setShowDialog(false);
        setTimeout(() => {
          window.location.reload();
        }, 1000);
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
                <TableHead>アーティスト名(英語)</TableHead>
                <TableHead>アーティスト名(カナ)</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {uniqueArtists.map((artist, index) => (
                <TableRow key={index}>
                  <TableCell>{artist.artist_jp}</TableCell>
                  <TableCell>{artist.artist_en}</TableCell>
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
              variant="outline"
            >
              CSVダウンロード
            </Button>
            <Button onClick={handleRegisterArtists} variant="default">
              アーティストを登録
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
