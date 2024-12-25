import React from "react";

import { BaseComponent } from "./base";

interface ListProps {
  title: string;
  lists: {
    title: string;
  }[];
}

export function List({ title, lists }: ListProps) {
  return (
    <BaseComponent title={title}>
      <div className="gap-2">
        {lists?.map((list) => (
          <div className="flex flex-col text-white">
            <div className="text-[14px] leading-[24px] text-white">
              {list.title}
            </div>
          </div>
        ))}
      </div>
    </BaseComponent>
  );
}
