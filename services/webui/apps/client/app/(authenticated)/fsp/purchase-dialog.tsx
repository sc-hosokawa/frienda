"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { ShoppingCart } from "lucide-react";
interface PointOption {
  points: number;
  price: number;
}

export function PurchaseDialog() {
  const [showDialog, setShowDialog] = useState(false);
  const [selectedOption, setSelectedOption] = useState<PointOption>({
    points: 500,
    price: 5000,
  });

  const pointOptions: PointOption[] = [
    { points: 100, price: 150 },
    { points: 300, price: 450 },
    { points: 500, price: 750 },
    { points: 1000, price: 1500 },
    { points: 5000, price: 7500 },
  ];

  const handlePayment = async () => {
    try {
      const response = await fetch("/api/create-checkout-session", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          points: selectedOption.points,
          amount: selectedOption.price,
        }),
      });

      const { url } = await response.json();

      if (url) {
        window.location.href = url;
      }
    } catch (error) {
      console.error("Payment error:", error);
      // エラー処理を追加することをお勧めします
    }
  };

  return (
    <Dialog open={showDialog} onOpenChange={setShowDialog}>
      <DialogTrigger asChild>
        <Button className="w-full opacity-60 hover:opacity-60">
          <ShoppingCart className="mr-2 h-4 w-4" />
          購入(近日公開)
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[600px] bg-black text-white border-zinc-800">
        <DialogHeader>
          <DialogTitle className="text-4xl font-light">
            Point Purchase
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-6">
          <div className="space-y-2">
            <p>ポイントの購入を行えます。</p>
            <p>購入されたいポイント数を選択してお支払いにお進みください。</p>
          </div>

          <div>
            <p className="mb-3 text-zinc-400">オファー対象</p>
            <div className="flex flex-wrap gap-2">
              {pointOptions.map((option) => (
                <button
                  key={option.points}
                  onClick={() => setSelectedOption(option)}
                  className={`px-4 py-2 rounded-full border border-dashed border-zinc-700 transition-colors
                    ${
                      selectedOption.points === option.points
                        ? "bg-white text-black border-solid hover:bg-gray-200"
                        : "hover:bg-zinc-800"
                    }`}
                >
                  {option.points}pt(¥{option.price.toLocaleString()})
                </button>
              ))}
            </div>
          </div>

          <div>
            <p className="text-zinc-400">総額</p>
            <p className="text-4xl">¥{selectedOption.price.toLocaleString()}</p>
          </div>

          <p className="text-sm text-zinc-400">
            FRIENDSHIP.DAO内でのお支払いはStripeにて安全にお支払いいただけます。
          </p>

          <div className="flex justify-end gap-3">
            <Button
              variant="ghost"
              className="text-zinc-400 hover:text-white hover:bg-zinc-800 transition-colors"
              onClick={() => setShowDialog(false)}
            >
              キャンセル
            </Button>
            <Button
              className="bg-[#E6DFD3] text-black hover:bg-[#d6cfb3] transition-colors"
              onClick={handlePayment}
            >
              お支払いにすすむ
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
