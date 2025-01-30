import React from "react";

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@ui/components/ui/alert-dialog";
import { Button } from "@ui/components/ui/button";
import { Settings2 } from "lucide-react";
import { Label } from "@ui/components/ui/label";
import { Input } from "@ui/components/ui/input";
import { SelectTargetRole } from "../offer/select-target-role";
import { SelectCategory } from "../offer/select-category";

export interface SearchOfferOptions {
  category?: string;
  targetRole?: string;
  place?: string;
  minPrice?: number;
  maxPrice?: number;
  sortBy?: string;
}

interface SearchOfferDialogProps {
  options: SearchOfferOptions;
  setOptions: React.Dispatch<React.SetStateAction<SearchOfferOptions>>;
  handleOption: (option: SearchOfferOptions) => void;
}

export function SearchOfferDialog({
  options,
  setOptions,
  handleOption,
}: SearchOfferDialogProps) {
  console.log("options", options);
  return (
    <AlertDialog>
      <AlertDialogTrigger asChild>
        <Button asChild variant="outline" size="icon" className="p-1">
          <Settings2 className="w-8 h-8 cursor-pointer" />
        </Button>
      </AlertDialogTrigger>
      <AlertDialogContent className="sm:max-w-md md:max-w-5xl">
        <AlertDialogHeader>
          <div className="flex flex-row justify-between items-center">
            <AlertDialogTitle className="text-6xl font-light">
              Filter
            </AlertDialogTitle>
            <Button
              className="w-[180px] h-[60px] rounded-[60px] hover:bg-gray-500 hover:text-black text-white bg-[#202020] "
              onClick={() => setOptions({})}
            >
              全てクリアする
            </Button>
          </div>
          <AlertDialogDescription className="text-white">
            {"オファーを以下の条件で絞り込みすることができます。"}
          </AlertDialogDescription>
        </AlertDialogHeader>
        <div className="flex flex-col space-y-6">
          <div className="flex flex-col gap-4">
            <Label className="flex justify-start">オファー対象</Label>
            <SelectTargetRole
              setOptions={setOptions}
              selectedTargetRole={options.targetRole}
            />
          </div>
          <div className="flex flex-col gap-4">
            <Label className="flex justify-start">金額</Label>
            <Input
              placeholder="オファーの最高金額を入力してください"
              value={options.maxPrice?.toString() || ""}
              onChange={(e) => {
                const value = e.target.value;
                // only accept numbers
                if (value === "" || /^\d*\.?\d*$/.test(value)) {
                  setOptions((prev) => ({
                    ...prev,
                    maxPrice: value ? parseFloat(value) : undefined,
                  }));
                }
              }}
              className="w-[510px] h-[90px] rounded-[30px] p-4"
            />
          </div>
          <div className="flex flex-col gap-4">
            <Label className="flex justify-start">カテゴリー</Label>
            <SelectCategory
              setOptions={setOptions}
              selectedCategory={options.category}
            />
          </div>
        </div>
        <AlertDialogFooter>
          <AlertDialogCancel
            onClick={() => setOptions({})}
            className="bg-transparent hover:bg-transparent border-none"
          >
            <Button
              variant="outline"
              className="border-none w-[180px] h-[60px] text-white bg-transparent hover:bg-transparent"
            >
              <p className="underline">キャンセル</p>
            </Button>
          </AlertDialogCancel>
          <AlertDialogAction
            className="bg-transparent hover:bg-transparent"
            onClick={() => {
              handleOption(options);
            }}
          >
            <Button
              variant="outline"
              className="border-2 border-dashed w-[180px] h-[60px] rounded-[60px] text-white bg-transparent hover:bg-transparent"
            >
              絞り込む
            </Button>
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
