import React from "react";

import { BaseComponent } from "../account/base";
import { NotoSansJP } from "~/utils/fonts";

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
