import { stripe } from "../../../provider/stripe-provider";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    let totalAmount = 0;
    const balanceTransactions = await stripe.balanceTransactions.list();
    for (const transaction of balanceTransactions.data) {
      totalAmount += transaction.amount;
    }
    return NextResponse.json({ totalAmount });
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch balance transactions" },
      { status: 500 },
    );
  }
}
