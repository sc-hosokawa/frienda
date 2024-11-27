import { NextResponse } from "next/server";
import { getAuth } from "firebase-admin/auth";
import { initAdmin } from "../../../../firebase-admin";

export async function POST(request: Request) {
  try {
    const { idToken } = await request.json();

    if (!idToken) {
      return NextResponse.json({ error: "No token provided" }, { status: 400 });
    }

    // Firebase Admin の初期化
    initAdmin();

    // トークンの検証
    const decodedToken = await getAuth().verifyIdToken(idToken);
    const uid = decodedToken.uid;

    // ユーザー情報の取得
    const userRecord = await getAuth().getUser(uid);

    return NextResponse.json({
      status: "success",
      data: {
        emailVerified: userRecord.emailVerified,
        uid: userRecord.uid,
        email: userRecord.email,
      },
    });
  } catch (error) {
    console.error("Auth verification error:", error);
    return NextResponse.json(
      { error: "Authentication failed" },
      { status: 401 },
    );
  }
}
