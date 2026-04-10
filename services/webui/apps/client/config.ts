import { initializeApp } from "@firebase/app";
import { connectAuthEmulator, getAuth } from "@firebase/auth";
import { getStorage } from "firebase/storage";

const firebaseConfigEmulator = {
  apiKey: "fake-api-key",
  projectId: "frienda-local",
};

const firebaseConfigDev = {
  apiKey: "AIzaSyAkYBfsIsL-PALnx6-20rJB1eEGAXMUYF8",
  authDomain: "frienda-auth-test1.firebaseapp.com",
  projectId: "frienda-auth-test1",
  storageBucket: "frienda-auth-test1.appspot.com",
  messagingSenderId: "23181195188",
  appId: "1:23181195188:web:c6798ac7cb4e22317fe4e1",
  measurementId: "G-64BS7X84PL",
};

const firebaseConfigPrd = {
  apiKey: "AIzaSyCZ8YeoVrHJih8M1H5VHrJumHC5Ww9kgjA",
  authDomain: "friendship-dao.firebaseapp.com",
  projectId: "friendship-dao",
  storageBucket: "friendship-dao.firebasestorage.app",
  messagingSenderId: "955799892508",
  appId: "1:955799892508:web:81817a5f2d973106b125d9",
  measurementId: "G-BSD0532YHD",
};

const emulatorHost = process.env.NEXT_PUBLIC_FIREBASE_AUTH_EMULATOR_HOST;

const getFirebaseConfig = () => {
  if (emulatorHost) {
    return firebaseConfigEmulator;
  }
  switch (process.env.NEXT_PUBLIC_ENV) {
    case "production":
      return firebaseConfigPrd;
    case "development":
      return firebaseConfigDev;
    default:
      return firebaseConfigDev;
  }
};

const firebaseConfig = getFirebaseConfig();
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
if (emulatorHost) {
  try {
    connectAuthEmulator(auth, `http://${emulatorHost}`);
  } catch (e) {
    if (!(e instanceof Error) || !e.message.includes("already")) {
      console.error("Failed to connect to Auth Emulator:", e);
    }
  }
}
export const storage = getStorage(app);
