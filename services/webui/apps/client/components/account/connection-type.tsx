import React from "react";
import { getBgClassByType, category } from "../../utils";
import { BadgeList } from "../badge-list";
import { BaseComponent } from "./base";

interface ConnectionTypesProps {
  title: string;
  types?: category[] | undefined;
}

export function ConnectionTypes({ title, types }: ConnectionTypesProps) {
  return (
    <BaseComponent title={title}>
      <div className="flex flex-wrap gap-2">
        {types?.map((type: category) => (
          <BadgeList
            key={type}
            className={getBgClassByType(type) + " text-black"}
            title={type}
          />
        ))}
      </div>
    </BaseComponent>
  );
}
