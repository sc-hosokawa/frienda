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
import { useTranslation } from "~/i18n/client";

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
  // TODO: consider using zod for validation
  const { t } = useTranslation();
  function validateFee(): boolean {
    return options.minPrice &&
      options.maxPrice &&
      options.minPrice > options.maxPrice
      ? false
      : true;
  }
  return (
    <AlertDialog>
      <AlertDialogTrigger asChild>
        <Button asChild variant="outline" size="icon" className="p-1">
          <Settings2 className="w-8 h-8 cursor-pointer" />
        </Button>
      </AlertDialogTrigger>
      <AlertDialogContent className="sm:max-w-md md:max-w-6xl">
        <AlertDialogHeader>
          <div className="flex flex-row justify-between items-center">
            <AlertDialogTitle className="text-6xl font-light">
              Filter
            </AlertDialogTitle>
            <Button
              className="w-[180px] h-[60px] rounded-[60px] hover:bg-gray-500 hover:text-black text-white bg-[#202020] "
              onClick={() => setOptions({})}
            >
              {t("common.clear-all")}
            </Button>
          </div>
          <AlertDialogDescription className="text-white">
            {t("offer.dialog-descrioption")}
          </AlertDialogDescription>
        </AlertDialogHeader>
        <div className="flex flex-col space-y-6">
          <div className="flex flex-col gap-4">
            <Label className="flex justify-start">
              {t("offer.dialog-targetRole")}
            </Label>
            <SelectTargetRole
              setOptions={setOptions}
              selectedTargetRole={options.targetRole}
            />
          </div>
          <div className="flex flex-col gap-4">
            <Label className="flex justify-start">FSP</Label>
            <div className="flex items-center flex-row justify-between gap-4">
              <Input
                placeholder={t("offer.dialog-enter-min-fee")}
                value={options.minPrice?.toString() || ""}
                onChange={(e) => {
                  const value = e.target.value;
                  // only accept numbers
                  if (value === "" || /^\d*\.?\d*$/.test(value)) {
                    setOptions((prev) => ({
                      ...prev,
                      minPrice: value ? parseFloat(value) : undefined,
                    }));
                  }
                }}
                className="w-[510px] h-[90px] rounded-[30px] p-4"
              />

              <p className="flex items-center">〜</p>
              <Input
                placeholder={t("offer.dialog-enter-max-fee")}
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
            {!validateFee() && (
              <>
                <p className="text-red-500">
                  {t("offer.error.min-larger-than-max")}
                </p>
              </>
            )}
          </div>
          <div className="flex flex-col gap-4">
            <Label className="flex justify-start">{t("common.category")}</Label>
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
              <p className="underline">{t("common.cancel")}</p>
            </Button>
          </AlertDialogCancel>
          <AlertDialogAction
            className="bg-transparent hover:bg-transparent"
            disabled={!validateFee()}
            onClick={() => {
              handleOption(options);
            }}
          >
            <Button
              variant="outline"
              className="border-2 border-dashed w-[180px] h-[60px] rounded-[60px] text-white bg-transparent hover:bg-transparent"
            >
              {t("offer.apply-filter")}
            </Button>
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
