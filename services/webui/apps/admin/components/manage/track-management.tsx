"use client";

import { useMutation, useQueryClient } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, UPDATE_TRACK, DELETE_TRACK } from "../../utils/query";
import { useState } from "react";
import { Input } from "@ui/components/ui/input";
import { Button } from "@ui/components/ui/button";
import { Label } from "@ui/components/ui/label";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@ui/components/ui/dialog";

interface TrackData {
  isrc: string;
  trackTitle: string;
  artistId: string;
  artistName: string;
  productTitle: string;
}

interface UpdateTrackInput {
  isrc: string;
  title?: string;
}

interface EditDialogProps {
  track: TrackData | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onSuccess: () => void;
}

export function EditDialog({
  track,
  open,
  onOpenChange,
  onSuccess,
}: EditDialogProps) {
  const [formData, setFormData] = useState<UpdateTrackInput>({
    isrc: track?.isrc || "",
    title: track?.trackTitle || "",
  });

  const queryClient = useQueryClient();

  const updateTrackMutation = useMutation({
    mutationFn: (variables: { input: UpdateTrackInput }) =>
      request(endpoint, UPDATE_TRACK, variables),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["searchTracks"] });
      onSuccess();
      onOpenChange(false);
    },
  });

  const deleteTrackMutation = useMutation({
    mutationFn: (isrc: string) => request(endpoint, DELETE_TRACK, { isrc }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["searchTracks"] });
      onSuccess();
      onOpenChange(false);
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    const updates: UpdateTrackInput = {
      isrc: track?.isrc || "",
    };

    if (formData.title && formData.title !== track?.trackTitle) {
      updates.title = formData.title;
    }

    const hasChanges = Object.keys(updates).length > 1;

    if (hasChanges) {
      updateTrackMutation.mutate({ input: updates });
      setFormData({
        isrc: "",
        title: "",
      });
    }
  };

  const handleDelete = () => {
    if (window.confirm("本当に削除しますか？")) {
      deleteTrackMutation.mutate(track?.isrc || "");
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-[500px]">
        <DialogHeader>
          <DialogTitle>Edit Track</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="title">Title</Label>
            <div className="text-sm text-muted-foreground mb-2">
              Current: <span className="font-bold">{track?.trackTitle}</span>
            </div>
            <Input
              id="title"
              value={formData.title || ""}
              onChange={(e) =>
                setFormData({ ...formData, title: e.target.value })
              }
            />
          </div>

          <DialogFooter className="gap-2">
            <Button type="submit" disabled={updateTrackMutation.isPending}>
              {updateTrackMutation.isPending ? "Updating..." : "Update"}
            </Button>
            <Button
              type="button"
              variant="destructive"
              onClick={handleDelete}
              disabled={deleteTrackMutation.isPending}
            >
              {deleteTrackMutation.isPending ? "Deleting..." : "Delete"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
