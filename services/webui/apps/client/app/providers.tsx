"use client";

import { useEffect } from "react";
import { auth } from "~/config";
import { onAuthStateChanged } from "firebase/auth";
import useAuthStore from "~/store/auth";
import clearUser from "~/store/user";
import { useRouter } from "next/navigation";

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const { setAuthInfo } = useAuthStore();

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      if (user) {
        setAuthInfo(user);
      } else {
        clearUser();
        router.push("/login");
      }
    });

    return () => unsubscribe();
  }, []);

  return <>{children}</>;
}
