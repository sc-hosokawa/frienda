"use client";

import { useState, useEffect } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { Switch } from "@ui/components/ui/switch";
import { Input } from "@ui/components/ui/input";
import { Button } from "@ui/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import { useToast } from "@ui/hooks/use-toast";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@ui/components/ui/sheet";
import { ArrowLeftIcon, ArrowRightIcon } from "lucide-react";
import { useQuery, gql } from "@apollo/client";

interface Artist {
  artistId: string;
  nameJa: string;
  nameEn: string;
  nameKana: string;
  isPublic: boolean;
}

const GET_ARTISTS = gql`
  query GetAllArtists {
    getAllArtists {
      artistList {
        artistId
        name
        imageUrl
        fsp
      }
    }
  }
`;

export function ArtistTable() {
  const [artists, setArtists] = useState<Artist[]>([]);
  const [filteredArtists, setFilteredArtists] = useState<Artist[]>([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [sortOrder, setSortOrder] = useState<"all" | "public" | "private">(
    "all",
  );
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedArtist, setSelectedArtist] = useState<Artist | null>(null);
  const [isEditing, setIsEditing] = useState(false);
  const [editForm, setEditForm] = useState<Artist | null>(null);
  const itemsPerPage = 10;
  const { toast } = useToast();

  const { loading, error, data } = useQuery(GET_ARTISTS);

  useEffect(() => {
    console.log("GraphQL Response:", data); // APIレスポンスの確認

    if (data?.getAllArtists?.artistList) {
      const formattedArtists = data.getAllArtists.artistList.map(
        (artist: any) => {
          const formatted = {
            id: parseInt(artist.artistId),
            artistId: artist.artistId,
            nameJa: artist.name,
            nameEn: artist.name,
            nameKana: artist.name,
            isPublic: true,
          };
          return formatted;
        },
      );
      setArtists(formattedArtists);
    }
  }, [data]);

  useEffect(() => {
    const filtered = artists.filter((artist) => {
      const matchesSearch =
        artist.nameJa.toLowerCase().includes(searchTerm.toLowerCase()) ||
        artist.nameEn.toLowerCase().includes(searchTerm.toLowerCase()) ||
        artist.nameKana.toLowerCase().includes(searchTerm.toLowerCase());

      if (sortOrder === "public") return matchesSearch && artist.isPublic;
      if (sortOrder === "private") return matchesSearch && !artist.isPublic;
      return matchesSearch;
    });

    setFilteredArtists(filtered);
  }, [artists, searchTerm, sortOrder]);

  const handleTogglePublic = (artistId: string) => {
    setArtists(
      artists.map((artist) => {
        if (artist.artistId === artistId) {
          const newPublicState = !artist.isPublic;
          toast({
            title: "公開状態を変更しました",
            description: `ID: ${artistId} を${newPublicState ? "公開" : "非公開"}に設定しました`,
            variant: "default",
          });
          return { ...artist, isPublic: newPublicState };
        }
        return artist;
      }),
    );
  };

  const handleEdit = (artist: Artist) => {
    setSelectedArtist(artist);
    setEditForm(artist);
    setIsEditing(true);
  };

  const handleFormChange = (field: keyof Artist, value: string | boolean) => {
    if (!editForm) return;
    setEditForm({ ...editForm, [field]: value });
  };

  const handleSaveChanges = () => {
    if (!editForm || !selectedArtist) return;

    setArtists(
      artists.map((artist) =>
        artist.artistId === selectedArtist.artistId ? editForm : artist,
      ),
    );

    toast({
      title: "変更を保存しました",
      description: `ID: ${selectedArtist.artistId} の情報を更新しました`,
      variant: "default",
    });

    setIsEditing(false);
  };

  const pageCount = Math.ceil(filteredArtists.length / itemsPerPage);
  const paginatedArtists = filteredArtists.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage,
  );

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center space-x-2">
        <Input
          placeholder="アーティストを検索..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="max-w-sm"
        />
        <Select
          value={sortOrder}
          onValueChange={(value: "all" | "public" | "private") =>
            setSortOrder(value)
          }
        >
          <SelectTrigger className="w-[180px]">
            <SelectValue placeholder="表示" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">すべて表示</SelectItem>
            <SelectItem value="public">公開のみ</SelectItem>
            <SelectItem value="private">非公開のみ</SelectItem>
          </SelectContent>
        </Select>
      </div>
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>ID</TableHead>
            <TableHead>名前（日本語）</TableHead>
            <TableHead>名前（英語）</TableHead>
            <TableHead>名前（カナ）</TableHead>
            <TableHead>操作</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {paginatedArtists.map((artist) => (
            <TableRow key={artist.artistId}>
              <TableCell>{artist.artistId}</TableCell>
              <TableCell>{artist.nameJa}</TableCell>
              <TableCell>{artist.nameEn}</TableCell>
              <TableCell>{artist.nameKana}</TableCell>
              <TableCell>
                <Sheet
                  open={
                    isEditing && selectedArtist?.artistId === artist.artistId
                  }
                  onOpenChange={setIsEditing}
                >
                  <SheetTrigger asChild>
                    <Button onClick={() => handleEdit(artist)}>編集</Button>
                  </SheetTrigger>
                  <SheetContent>
                    <SheetHeader>
                      <SheetTitle>アーティスト編集</SheetTitle>
                    </SheetHeader>
                    <div className="space-y-4 py-4">
                      <div className="space-y-2">
                        <label>名前（日本語）</label>
                        <Input
                          value={editForm?.nameJa}
                          onChange={(e) =>
                            handleFormChange("nameJa", e.target.value)
                          }
                        />
                      </div>
                      <div className="space-y-2">
                        <label>名前（英語）</label>
                        <Input
                          value={editForm?.nameEn}
                          onChange={(e) =>
                            handleFormChange("nameEn", e.target.value)
                          }
                        />
                      </div>
                      <div className="space-y-2">
                        <label>名前（カナ）</label>
                        <Input
                          value={editForm?.nameKana}
                          onChange={(e) =>
                            handleFormChange("nameKana", e.target.value)
                          }
                        />
                      </div>
                      <div className="space-y-2">
                        <label>公開状態</label>
                        <div className="flex items-center space-x-2">
                          <Switch
                            checked={editForm?.isPublic}
                            onCheckedChange={() =>
                              handleFormChange("isPublic", !editForm?.isPublic)
                            }
                          />
                          <span>{editForm?.isPublic ? "公開" : "非公開"}</span>
                        </div>
                      </div>
                      <div className="flex justify-end pt-4">
                        <Button onClick={handleSaveChanges}>変更を保存</Button>
                      </div>
                    </div>
                  </SheetContent>
                </Sheet>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <div className="flex items-center justify-between">
        <div>
          全{filteredArtists.length}件中 {(currentPage - 1) * itemsPerPage + 1}{" "}
          - {Math.min(currentPage * itemsPerPage, filteredArtists.length)}
          件を表示
        </div>
        <div className="space-x-2">
          <Button
            onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            disabled={currentPage === 1}
          >
            <ArrowLeftIcon />
          </Button>
          <Button
            onClick={() =>
              setCurrentPage((prev) => Math.min(prev + 1, pageCount))
            }
            disabled={currentPage === pageCount}
          >
            <ArrowRightIcon />
          </Button>
        </div>
      </div>
    </div>
  );
}
