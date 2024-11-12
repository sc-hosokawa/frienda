"use client";

import { useState } from "react";
import { gql, useQuery, useMutation } from "@apollo/client";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Checkbox } from "@ui/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
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
  const handleArtistSelect = (artistId: string) => {
    const newSelected = new Set(selectedArtists);
    if (newSelected.has(artistId)) {
      newSelected.delete(artistId);
    } else {
      newSelected.add(artistId);
    }
    setSelectedArtists(newSelected);
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

        {/* 選択中の件数 */}
        {selectedArtists.size > 0 && (
          <div className="text-sm text-muted-foreground">
            選択中: {selectedArtists.size}件
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
                    onCheckedChange={() => handleArtistSelect(artist.artistId)}
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
