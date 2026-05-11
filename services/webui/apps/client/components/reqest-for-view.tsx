"use client";

import { useState } from "react";
import { gql, useQuery, useMutation } from "@apollo/client";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Checkbox } from "@ui/components/ui/checkbox";
import { Textarea } from "@ui/components/ui/textarea";
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
import useUserStore from "~/store/user";
import { useTranslation } from "~/i18n/client";

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
  mutation RequestAccess(
    $userId: String!
    $requests: [RequestToAccessArtistItemInput!]!
  ) {
    requestToAccessArtist(input: { userId: $userId, requests: $requests }) {
      createdMappings {
        mappingId
        id
        artistId
        name
        imageUrl
        fsp
        status
        isAdmin
        requestMessage
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
  const [requestMessages, setRequestMessages] = useState<Map<string, string>>(
    new Map(),
  );
  const { user } = useUserStore();
  const { toast } = useToast();
  const { t } = useTranslation();

  // アーティスト検索クエリ
  const { loading, error, data, refetch } = useQuery(SEARCH_ARTISTS, {
    variables: { name: searchText },
    skip: !searchText,
  });

  // アクセスリクエストミューテーション
  const [requestAccess] = useMutation(REQUEST_ACCESS, {
    onCompleted: (data) => {
      const createdMappings =
        data?.requestToAccessArtist?.createdMappings ?? [];

      toast({
        title: t("common.success"),
        description: (
          <div className="space-y-2">
            <p>{t("home.sent-access-request")}</p>
            {createdMappings.length > 0 && (
              <ul className="space-y-1">
                {createdMappings.map(
                  (mapping: {
                    artistId: string;
                    name: string;
                    requestMessage?: string | null;
                  }) => (
                    <li key={mapping.artistId}>
                      <span className="font-medium">{mapping.name}</span>
                      <span className="text-muted-foreground">
                        {" "}
                        - {mapping.requestMessage || t("common.none")}
                      </span>
                    </li>
                  ),
                )}
              </ul>
            )}
          </div>
        ),
      });
      setSelectedArtists(new Set());
      setSelectedArtistDetails(new Map());
      setRequestMessages(new Map());
      setOpen(false);
    },
    onError: (error) => {
      toast({
        title: t("common.error"),
        description: `${t("common.error-occurred")}: ${error.message}`,
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
    const newRequestMessages = new Map(requestMessages);

    if (newSelected.has(artist.artistId)) {
      newSelected.delete(artist.artistId);
      newSelectedDetails.delete(artist.artistId);
      newRequestMessages.delete(artist.artistId);
    } else {
      newSelected.add(artist.artistId);
      newSelectedDetails.set(artist.artistId, artist);
      newRequestMessages.set(artist.artistId, "");
    }
    setSelectedArtists(newSelected);
    setSelectedArtistDetails(newSelectedDetails);
    setRequestMessages(newRequestMessages);
  };

  // 選択解除ハンドラー
  const handleRemoveSelection = (artistId: string) => {
    const newSelected = new Set(selectedArtists);
    const newSelectedDetails = new Map(selectedArtistDetails);
    const newRequestMessages = new Map(requestMessages);
    newSelected.delete(artistId);
    newSelectedDetails.delete(artistId);
    newRequestMessages.delete(artistId);
    setSelectedArtists(newSelected);
    setSelectedArtistDetails(newSelectedDetails);
    setRequestMessages(newRequestMessages);
  };

  const handleRequestMessageChange = (artistId: string, message: string) => {
    const newRequestMessages = new Map(requestMessages);
    newRequestMessages.set(artistId, message);
    setRequestMessages(newRequestMessages);
  };

  // リクエスト送信ハンドラー
  const handleRequestAccess = () => {
    requestAccess({
      variables: {
        userId: user?.id,
        requests: Array.from(selectedArtists).map((artistId) => {
          const message = requestMessages.get(artistId)?.trim();

          return {
            artistId,
            message: message ? message : null,
          };
        }),
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
          {t("home.request-permission-to-view")}
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{t("home.request-permission-dialog-title")}</DialogTitle>
          <DialogDescription>
            {t("home.request-permission-dialog-description")}
          </DialogDescription>
        </DialogHeader>

        {/* 検索フォーム */}
        <div className="flex gap-2">
          <Input
            placeholder={t("common.enter-artists-name")}
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
            className="flex-grow"
          />
          <Button
            onClick={handleSearch}
            disabled={!searchText.trim() || loading}
          >
            {loading ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : (
              t("common.search")
            )}
          </Button>
        </div>

        {/* 選択中のアーティスト一覧 */}
        {selectedArtists.size > 0 && (
          <div className="space-y-2">
            <div className="text-sm text-muted-foreground">
              {t("common.selecting")}: {selectedArtists.size}
            </div>
            <div className="space-y-3">
              {Array.from(selectedArtistDetails.values()).map((artist) => (
                <div
                  key={artist.artistId}
                  className="space-y-2 rounded-md bg-secondary p-3 text-sm"
                >
                  <div className="flex items-center justify-between gap-2">
                    <span className="font-medium">{artist.name}</span>
                    <button
                      onClick={() => handleRemoveSelection(artist.artistId)}
                      className="text-muted-foreground hover:text-destructive"
                      type="button"
                    >
                      ×
                    </button>
                  </div>
                  <div className="space-y-1">
                    <label
                      className="text-xs text-muted-foreground"
                      htmlFor={`request-message-${artist.artistId}`}
                    >
                      {t("home.request-message-label")}
                    </label>
                    <Textarea
                      id={`request-message-${artist.artistId}`}
                      value={requestMessages.get(artist.artistId) ?? ""}
                      onChange={(event) =>
                        handleRequestMessageChange(
                          artist.artistId,
                          event.target.value,
                        )
                      }
                      maxLength={200}
                      placeholder={t("home.request-message-placeholder")}
                    />
                    <p className="text-xs text-muted-foreground">
                      {t("home.request-message-helper")}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* 検索結果 */}
        <ScrollArea className="h-[300px] w-full rounded-md border p-4">
          {error && (
            <div className="text-destructive">
              {t("common.error-occurred")}: {error.message}
            </div>
          )}
          {!searchText && (
            <div className="text-center text-muted-foreground">
              {t("home.enter-artist-name-to-search")}
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
            {t("common.request")}
          </Button>
        )}
      </DialogContent>
    </Dialog>
  );
}
