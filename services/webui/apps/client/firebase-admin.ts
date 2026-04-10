import { getApps, initializeApp, cert } from "firebase-admin/app";

export function initAdmin() {
  if (getApps().length === 0) {
    if (process.env.FIREBASE_AUTH_EMULATOR_HOST) {
      // Firebase Emulator使用時はプロジェクトIDのみで初期化
      if (!process.env.FIREBASE_PROJECT_ID) {
        throw new Error("FIREBASE_PROJECT_ID is required when using Firebase Auth Emulator");
      }
      initializeApp({ projectId: process.env.FIREBASE_PROJECT_ID });
    } else {
      initializeApp({
        credential: cert({
          projectId: process.env.FIREBASE_PROJECT_ID,
          clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
          privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, "\n"),
        }),
      });
    }
  }
}
