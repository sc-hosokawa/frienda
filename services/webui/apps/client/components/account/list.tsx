import React from "react";

import { BaseComponent } from "./base";

interface ListProps {
  title: string;
  lists: {
    title: string;
    role?: string;
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
              {list.role && (
                <span className="text-white"> {` / ${list.role}`}</span>
              )}
            </div>
          </div>
        ))}
      </div>
    </BaseComponent>
  );
}
