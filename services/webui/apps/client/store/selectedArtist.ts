import { create } from "zustand";
import { persist } from "zustand/middleware";

interface SelectedArtistState {
  artistId: string | null;
  userId: string | null;
  setArtistId: (id: string | null) => void;
  setUserId: (id: string | null) => void;
}

const useSelectedArtistStore = create<SelectedArtistState>()(
  persist(
    (set) => ({
      artistId: null,
      userId: null,
      setArtistId: (id) => set({ artistId: id }),
      setUserId: (id) => set({ userId: id }),
    }),
    {
      name: "selected-artist-storage",
    },
  ),
);

export default useSelectedArtistStore;
