"use client";

import { useState } from "react";
import { gql, useQuery, useMutation } from "@apollo/client";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Checkbox } from "@ui/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { ScrollArea } from "@ui/components/ui/scroll-area";
import { useToast } from "@ui/hooks/use-toast";
import { Loader2 } from "lucide-react";
import useUserStore from "../../store/user";

// GraphQL クエリとミューテーションの定義
const SEARCH_ARTISTS = gql`
  query SearchArtists($name: String!) {
    getArtistsByName(name: $name) {
      artistList {
        id
        artistId
        name
        imageUrl
        fsp
      }
    }
  }
`;

const REQUEST_ACCESS = gql`
  mutation RequestAccess($userId: String!, $artistIds: [String!]!) {
    requestToAccessArtist(input: { userId: $userId, artistIds: $artistIds }) {
      createdMappings {
        mappingId
        id
        artistId
        name
        imageUrl
        fsp
        status
        isAdmin
      }
    }
  }
`;

export function RequestForViewDialog() {
  const [open, setOpen] = useState(false);
  const [searchText, setSearchText] = useState("");
  const [selectedArtists, setSelectedArtists] = useState<Set<string>>(
    new Set(),
  );
  const [selectedArtistDetails, setSelectedArtistDetails] = useState<
    Map<string, any>
  >(new Map());
  const { user } = useUserStore();
  const { toast } = useToast();

  // アーティスト検索クエリ
  const { loading, error, data, refetch } = useQuery(SEARCH_ARTISTS, {
    variables: { name: searchText },
    skip: !searchText,
  });

  // アクセスリクエストミューテーション
  const [requestAccess] = useMutation(REQUEST_ACCESS, {
    onCompleted: () => {
      toast({
        title: "成功",
        description: "アクセスリクエストを送信しました",
      });
      setSelectedArtists(new Set());
      setSelectedArtistDetails(new Map());
      setOpen(false);
    },
    onError: (error) => {
      toast({
        title: "エラー",
        description: `エラーが発生しました: ${error.message}`,
        variant: "destructive",
      });
    },
  });

  // 検索ハンドラー
  const handleSearch = () => {
    if (searchText.trim()) {
      refetch();
    }
  };

  // アーティスト選択ハンドラー
  const handleArtistSelect = (artist: any) => {
    const newSelected = new Set(selectedArtists);
    const newSelectedDetails = new Map(selectedArtistDetails);

    if (newSelected.has(artist.artistId)) {
      newSelected.delete(artist.artistId);
      newSelectedDetails.delete(artist.artistId);
    } else {
      newSelected.add(artist.artistId);
      newSelectedDetails.set(artist.artistId, artist);
    }
    setSelectedArtists(newSelected);
    setSelectedArtistDetails(newSelectedDetails);
  };

  // 選択解除ハンドラー
  const handleRemoveSelection = (artistId: string) => {
    const newSelected = new Set(selectedArtists);
    const newSelectedDetails = new Map(selectedArtistDetails);
    newSelected.delete(artistId);
    newSelectedDetails.delete(artistId);
    setSelectedArtists(newSelected);
    setSelectedArtistDetails(newSelectedDetails);
  };

  // リクエスト送信ハンドラー
  const handleRequestAccess = () => {
    requestAccess({
      variables: {
        userId: user?.id,
        artistIds: Array.from(selectedArtists),
      },
    });
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button
          variant="outline"
          className="border-white rounded-full bg-white text-black hover:bg-black hover:text-white"
        >
          アーティストを探す
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>アーティストを探す</DialogTitle>
          <DialogDescription>
            正式名称で検索してください。検索結果はスクロールできます。うまくヒットしない場合は、大文字と小文字を入れ替えたり、頭文字だけ入れてスクロールして探してみるなどしてみてください。どうしても表示されない場合は事務局までご連絡ください。
          </DialogDescription>
        </DialogHeader>

        {/* 検索フォーム */}
        <div className="flex gap-2">
          <Input
            placeholder="アーティスト名を入力"
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
            className="flex-grow"
          />
          <Button
            onClick={handleSearch}
            disabled={!searchText.trim() || loading}
          >
            {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : "検索"}
          </Button>
        </div>

        {/* 選択中のアーティスト一覧 */}
        {selectedArtists.size > 0 && (
          <div className="space-y-2">
            <div className="text-sm text-muted-foreground">
              選択中: {selectedArtists.size}件
            </div>
            <div className="flex flex-wrap gap-2">
              {Array.from(selectedArtistDetails.values()).map((artist) => (
                <div
                  key={artist.artistId}
                  className="flex items-center gap-1 bg-secondary px-2 py-1 rounded-full text-sm"
                >
                  <span>{artist.name}</span>
                  <button
                    onClick={() => handleRemoveSelection(artist.artistId)}
                    className="hover:text-destructive"
                  >
                    ×
                  </button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* 検索結果 */}
        <ScrollArea className="h-[300px] w-full rounded-md border p-4">
          {error && (
            <div className="text-destructive">
              エラーが発生しました: {error.message}
            </div>
          )}
          {!searchText && (
            <div className="text-center text-muted-foreground">
              アーティスト名を入力して検索してください
            </div>
          )}
          {data?.getArtistsByName?.artistList && (
            <div className="space-y-4">
              {data.getArtistsByName.artistList.map((artist: any) => (
                <div
                  key={artist.artistId}
                  className="flex items-center space-x-2 border-b pb-2"
                >
                  <Checkbox
                    id={artist.artistId}
                    checked={selectedArtists.has(artist.artistId)}
                    onCheckedChange={() => handleArtistSelect(artist)}
                  />
                  <label
                    htmlFor={artist.artistId}
                    className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                  >
                    {artist.name}
                  </label>
                </div>
              ))}
            </div>
          )}
        </ScrollArea>

        {/* リクエストボタン */}
        {selectedArtists.size > 0 && (
          <Button className="w-full" onClick={handleRequestAccess}>
            リクエスト
          </Button>
        )}
      </DialogContent>
    </Dialog>
  );
}
