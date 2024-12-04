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

interface Artist {
  id: number;
  nameJa: string;
  nameEn: string;
  nameKana: string;
  isPublic: boolean;
}

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

  // 仮のデータ生成（実際の実装では、APIからデータを取得します）
  useEffect(() => {
    const dummyData = Array.from({ length: 1000 }, (_, i) => ({
      id: i + 1,
      nameJa: `アーティスト${i + 1}`,
      nameEn: `Artist ${i + 1}`,
      nameKana: `アーティスト${i + 1}`,
      isPublic: Math.random() < 0.5,
    }));
    setArtists(dummyData);
  }, []);

  useEffect(() => {
    const filtered = artists.filter((artist) => {
      const matchesSearch =
        artist.nameJa.toLowerCase().includes(searchTerm.toLowerCase()) ||
        artist.nameEn.toLowerCase().includes(searchTerm.toLowerCase()) ||
        artist.nameKana.toLowerCase().includes(searchTerm.toLowerCase());

      // 公開状態でのフィルタリング
      if (sortOrder === "public") return matchesSearch && artist.isPublic;
      if (sortOrder === "private") return matchesSearch && !artist.isPublic;
      return matchesSearch; // all の場合
    });

    setFilteredArtists(filtered);
  }, [artists, searchTerm, sortOrder]);

  const handleTogglePublic = (id: number) => {
    setArtists(
      artists.map((artist) => {
        if (artist.id === id) {
          const newPublicState = !artist.isPublic;
          toast({
            title: "公開状態を変更しました",
            description: `ID: ${id} を${newPublicState ? "公開" : "非公開"}に設定しました`,
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

  const handleFormChange = (field: keyof Artist, value: string) => {
    if (!editForm) return;
    setEditForm({ ...editForm, [field]: value });
  };

  const handleSaveChanges = () => {
    if (!editForm || !selectedArtist) return;

    setArtists(
      artists.map((artist) =>
        artist.id === selectedArtist.id ? editForm : artist,
      ),
    );

    toast({
      title: "変更を保存しました",
      description: `ID: ${selectedArtist.id} の情報を更新しました`,
      variant: "default",
    });

    setIsEditing(false);
  };

  const pageCount = Math.ceil(filteredArtists.length / itemsPerPage);
  const paginatedArtists = filteredArtists.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage,
  );

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
            <TableHead>公開状態</TableHead>
            <TableHead>操作</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {paginatedArtists.map((artist) => (
            <TableRow key={artist.id}>
              <TableCell>{artist.id}</TableCell>
              <TableCell>{artist.nameJa}</TableCell>
              <TableCell>{artist.nameEn}</TableCell>
              <TableCell>{artist.nameKana}</TableCell>
              <TableCell>
                <Switch
                  checked={artist.isPublic}
                  onCheckedChange={() => handleTogglePublic(artist.id)}
                />
              </TableCell>
              <TableCell>
                <Sheet
                  open={isEditing && selectedArtist?.id === artist.id}
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
