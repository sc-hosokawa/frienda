"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogDescription,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { ShoppingCart } from "lucide-react";
import useUserStore from "../../store/user";
import { useTranslation, useLocale } from "~/i18n/client";

interface PointOption {
  points: number;
  price: number;
}

export function PurchaseDialog() {
  const { t } = useTranslation();
  const locale = useLocale();
  const { user } = useUserStore();
  const [showDialog, setShowDialog] = useState(false);
  const [selectedOption, setSelectedOption] = useState<PointOption>({
    points: 100,
    price: 150,
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
          "x-locale": locale,
        },
        body: JSON.stringify({
          points: selectedOption.points,
          amount: selectedOption.price,
          userId: user?.id,
        }),
      });

      const { url } = await response.json();
      console.log(url);

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
        <Button className="w-full">
          <ShoppingCart className="mr-2 h-4 w-4" />
          {t("common.purchase")}
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[1140px] sm:h-[80vh] bg-black text-white border-zinc-800">
        <DialogHeader>
          <DialogTitle className="text-6xl font-light mb-6">
            Point Purchase
          </DialogTitle>
          <DialogDescription>
            <p>{t("purchase-dialog.title")}</p>
            <p>{t("purchase-dialog.description")}</p>
          </DialogDescription>
        </DialogHeader>
        <div className="space-y-12">
          <div>
            <p className="mb-3 text-zinc-400">
              {t("purchase-dialog.select-amount")}
            </p>
            <div className="flex flex-wrap gap-2">
              {pointOptions.map((option) => (
                <button
                  key={option.points}
                  onClick={() => setSelectedOption(option)}
                  className={`px-4 py-2 w-[180px] h-[48px] rounded-full border border-dashed border-zinc-700 transition-colors
                    ${
                      selectedOption.points === option.points
                        ? "bg-white text-black border-solid hover:bg-gray-200"
                        : "hover:bg-zinc-800"
                    }`}
                >
                  {option.points}fsp (¥{option.price.toLocaleString()})
                </button>
              ))}
            </div>
          </div>

          <div className="space-y-6">
            <p className="text-zinc-400">{t("common.total-value")}</p>
            <p className="text-5xl font-light">
              ¥{selectedOption.price.toLocaleString()}
            </p>
          </div>
        </div>

        <div className="flex items-center justify-between gap-4">
          <p className="text-sm text-zinc-400">{t("purchase-dialog.notion")}</p>

          <div className="flex gap-3">
            <Button
              variant="ghost"
              className="text-zinc-400 hover:text-white hover:bg-zinc-800 transition-colors h-[60px]"
              onClick={() => setShowDialog(false)}
            >
              {t("common.cancel")}
            </Button>
            <Button
              className="bg-[#E6DFD3] text-black hover:bg-[#d6cfb3] transition-colors rounded-full w-[210px] h-[60px]"
              onClick={handlePayment}
            >
              {t("purchase-dialog.process-payment")}
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
