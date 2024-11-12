import { create } from "zustand";
import { persist } from "zustand/middleware";

interface ArtistByUser {
  mappingId?: number;
  artistId: string;
  id: string;
  name: string;
  imageUrl?: string;
  fsp: number;
  status?: string;
  isAdmin?: boolean;
}

interface User {
  id: string;
  name: string;
  realname: string;
  isSuperAdmin: boolean;
  email?: string;
  imageUrl?: string;
  fspBalance: number;
  credentialBalance: number;
  role: string;
  primaryRole: string;
  greeting?: string;
  skill?: string;
  xHandle?: string;
  instagramHandle?: string;
  fbHandle?: string;
  interestOffer?: string;
  createdAt?: Date;
  belongsToArtists: ArtistByUser[];
  primaryArtist?: ArtistByUser;
}

interface UserState {
  user: User | null;
  setUser: (user: User) => void;
  updateUser: (user: Partial<User>) => void;
  updateBalance: (newBalance: number) => void;
  clearUser: () => void;
}

const useUserStore = create<UserState>()(
  persist(
    (set): UserState => ({
      user: null,

      setUser: (user) => {
        console.log("Setting user:", user);
        set({ user });
      },

      updateUser: (user) => {
        set((state) => {
          const updatedUser = state.user ? { ...state.user, ...user } : null;
          console.log("Updating user:", updatedUser);
          return { user: updatedUser };
        });
      },

      updateBalance: (newBalance) => {
        set((state) => {
          const updatedUser = state.user
            ? { ...state.user, fspBalance: newBalance }
            : null;
          console.log(
            "Updating balance:",
            newBalance,
            "Updated user:",
            updatedUser,
          );
          return { user: updatedUser };
        });
      },

      clearUser: () => {
        console.log("Clearing user");
        set({ user: null });
      },
    }),
    {
      name: "user-storage",
    },
  ),
);

export default useUserStore;
