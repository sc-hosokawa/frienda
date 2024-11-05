import { cookies } from "next/headers";
import { NextResponse } from "next/server";

export async function POST() {
  console.log("=== Logout API Called ===");

  try {
    const response = NextResponse.json({ status: "success" });
    console.log(`Deleting session cookie: ${response.cookies}`);
    response.cookies.delete("session");

    return response;
  } catch (error) {
    console.error("Logout error:", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 },
    );
  }
}
