import React from "react";

import { BaseComponent } from "../account/base";
import { NotoSansJP } from "../../app/(authenticated)/layout";
import { getBgClassByType, category } from "../../utils/index";

export function Skill({
  title,
  skill,
}: {
  title: string;
  skill: string | undefined;
}) {
  return (
    <BaseComponent title={title}>
      <p
        className={`${NotoSansJP.className} text-[14px] leading-[24px] text-white`}
      >
        {skill}
      </p>
    </BaseComponent>
  );
}
