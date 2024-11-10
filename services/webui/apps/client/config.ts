import { initializeApp } from "@firebase/app";
import { getAuth } from "@firebase/auth";
import { getStorage } from "firebase/storage";

const firebaseConfig = {
  apiKey: "AIzaSyAkYBfsIsL-PALnx6-20rJB1eEGAXMUYF8",
  authDomain: "frienda-auth-test1.firebaseapp.com",
  projectId: "frienda-auth-test1",
  storageBucket: "frienda-auth-test1.appspot.com",
  messagingSenderId: "23181195188",
  appId: "1:23181195188:web:c6798ac7cb4e22317fe4e1",
  measurementId: "G-64BS7X84PL",
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const storage = getStorage(app);
