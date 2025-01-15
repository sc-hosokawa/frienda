import React from "react";

import { BaseComponent } from "../account/base";

import { getBgClassByType, category } from "~/utils/index";
import { NotoSansJP } from "~/utils/fonts";

export function Category({
  title,
  category,
}: {
  title: string;
  category: category;
}) {
  return (
    <BaseComponent title={title}>
      <p
        className={`${NotoSansJP.className} text-[14px] leading-[24px] text-white py-2 px-4 rounded-full w-fit border-2`}
        style={{
          backgroundColor: getBgClassByType(category).backgroundColor,
          borderColor: getBgClassByType(category).borderColor,
        }}
      >
        {category}
      </p>
    </BaseComponent>
  );
}
