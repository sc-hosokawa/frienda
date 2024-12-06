import React from "react";

import { BadgeList } from "../badge-list";
import { BaseComponent } from "./base";

export function Offers({
  title,
  offers,
}: {
  title: string;
  offers?: string[];
}) {
  return (
    <BaseComponent title={title}>
      <div className="flex flex-wrap gap-2">
        {offers?.map((offer) => (
          <BadgeList
            key={offer}
            className={"text-white border border-white border-dashed"}
            title={offer}
          />
        ))}
      </div>
    </BaseComponent>
  );
}
