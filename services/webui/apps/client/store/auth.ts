import { create } from "zustand";
import { User } from "firebase/auth";

interface AuthState {
  uid?: string | null;
  email?: string | null;
  idToken?: string | null;
}

interface AuthStore extends AuthState {
  setAuthInfo: (user: User) => Promise<void>;
  signOut: () => void;
}

const useAuthStore = create<AuthStore>((set) => ({
  uid: null,
  email: null,
  idToken: null,

  setAuthInfo: async (user: User) => {
    const idToken = await user.getIdToken();
    set({
      uid: user.uid,
      email: user.email,
      idToken: idToken,
    });
  },

  signOut: () => {
    set({
      uid: null,
      email: null,
      idToken: null,
    });
  },
}));

export default useAuthStore;
