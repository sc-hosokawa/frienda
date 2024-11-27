import { create } from "zustand";

type AuthStep = "signup" | "verify" | "profile";

interface AuthStepState {
  step: AuthStep;
  setStep: (step: AuthStep) => void;
}

const useAuthStepStore = create<AuthStepState>((set) => ({
  step: "signup",
  setStep: (step) => set({ step }),
}));

export default useAuthStepStore;
