import { create } from "zustand";

interface FspState {
  fsp: number;
  setFsp: (fsp: number) => void;
  updateFsp: (fsp: Partial<number>) => void;
}

const useFspStore = create<FspState>((set) => ({
  fsp: 0,
  setFsp: (fsp) => set({ fsp }),
  updateFsp: (fsp) => set((state) => ({ fsp: state.fsp + fsp })),
}));

export default useFspStore;
