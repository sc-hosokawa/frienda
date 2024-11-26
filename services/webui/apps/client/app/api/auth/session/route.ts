import { cookies } from "next/headers";
import { NextResponse } from "next/server";

export async function POST(request: Request) {
  console.log("=== Session API Called ===");

  try {
    // リクエストの内容をログ
    const requestBody = await request.json();
    console.log("Request body received:", {
      hasIdToken: !!requestBody.idToken,
      idTokenLength: requestBody.idToken?.length,
      hasUid: !!requestBody.uid,
      uid: requestBody.uid,
    });

    const { idToken, uid } = requestBody;

    if (!idToken || !uid) {
      console.log("Validation failed: Missing required fields");
      return NextResponse.json(
        {
          error: "Missing required fields",
          details: { hasIdToken: !!idToken, hasUid: !!uid },
        },
        { status: 400 },
      );
    }

    const expiresIn = 60 * 60 * 24; // 1日（秒単位）

    try {
      console.log("Attempting to set cookie...");
      const cookieStore = cookies();
      cookieStore.set("session", JSON.stringify({ idToken, uid }), {
        maxAge: expiresIn,
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        path: "/",
        sameSite: "lax",
      });
      console.log("Cookie set successfully");
    } catch (cookieError) {
      console.error("Cookie setting error:", cookieError);
      throw cookieError;
    }

    console.log("Returning success response");
    return NextResponse.json({
      status: "success",
      debug: {
        cookieSet: true,
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    console.error("Session creation error:", {
      message: error,
    });
    return NextResponse.json(
      {
        error: "Internal Server Error",
        details: error,
        timestamp: new Date().toISOString(),
      },
      { status: 500 },
    );
  }
}
