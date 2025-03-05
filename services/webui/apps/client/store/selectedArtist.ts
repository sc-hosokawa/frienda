import { create } from "zustand";
import { persist } from "zustand/middleware";

interface SelectedArtistState {
  artistId: string | null;
  setArtistId: (id: string | null) => void;
}

const useSelectedArtistStore = create<SelectedArtistState>()(
  persist(
    (set) => ({
      artistId: null,
      setArtistId: (id) => set({ artistId: id }),
    }),
    {
      name: "selected-artist-storage",
    },
  ),
);

export default useSelectedArtistStore;
