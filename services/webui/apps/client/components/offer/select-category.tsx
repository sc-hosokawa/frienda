import React from "react";
import { Button } from "@ui/components/ui/button";
import { SearchOfferOptions } from "../dialog/search-offer-dialog";

interface SelectCategoryProps {
  setOptions: React.Dispatch<React.SetStateAction<SearchOfferOptions>>;
  selectedCategory?: string;
}

export function SelectCategory({
  setOptions,
  selectedCategory,
}: SelectCategoryProps) {
  const categories = ["Creation", "Promotion", "Event", "Other"];

  return (
    <div className="flex flex-wrap gap-4">
      {categories.map((category) => (
        <Button
          key={category}
          variant="outline"
          className={`px-6 py-2 rounded-full ${
            selectedCategory === category
              ? "bg-white text-black"
              : "bg-transparent text-white"
          }`}
          onClick={() =>
            setOptions((prev) => ({
              ...prev,
              category: selectedCategory === category ? undefined : category,
            }))
          }
        >
          {category}
        </Button>
      ))}
    </div>
  );
}
