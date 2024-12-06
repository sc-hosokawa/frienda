import React from "react";
import { getBgClassByType, UserType } from "../../utils";
import { BadgeList } from "../badge-list";
import { BaseComponent } from "./base";

interface ConnectionTypesProps {
  title: string;
  types?: UserType[];
}

export function ConnectionTypes({ title, types }: ConnectionTypesProps) {
  return (
    <BaseComponent title={title}>
      <div className="flex flex-wrap gap-2">
        {types?.map((type: UserType) => (
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
