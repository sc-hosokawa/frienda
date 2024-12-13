"use client";

import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@ui/components/ui/tabs";
import { MetadataUpload } from "./metadata-upload";
import { NewArtistForm } from "./new-artist-form";
import { ArtistTable } from "./artist-table";

export function ArtistManagement() {
  return (
    <div className="min-h-screen flex flex-col">
      <div className="flex-grow container mx-auto p-4">
        <Tabs defaultValue="metadata" className="w-full">
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="metadata">メタデータアップロード</TabsTrigger>
            <TabsTrigger value="new-artist">新規アーティスト追加</TabsTrigger>
            <TabsTrigger value="manage-artists">アーティスト管理</TabsTrigger>
          </TabsList>
          <TabsContent value="metadata">
            <MetadataUpload />
          </TabsContent>
          <TabsContent value="new-artist">
            <NewArtistForm />
          </TabsContent>
          <TabsContent value="manage-artists">
            <ArtistTable />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
