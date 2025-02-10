import React from "react";

import { getBgClassByType, category } from "~/utils/index";
import { NotoSansJP } from "~/utils/fonts";
import { SearchOfferOptions } from "../dialog/search-offer-dialog";

export function SelectTargetRole({
  setOptions,
  selectedTargetRole,
}: {
  setOptions: React.Dispatch<React.SetStateAction<SearchOfferOptions>>;
  selectedTargetRole?: string;
}) {
  const roles = ["Musician", "Curator", "Creator", "Supporter"];

  return (
    <div className="flex flex-row gap-2">
      {roles.map((role) => (
        <p
          className={`${NotoSansJP.className} text-[14px] leading-[24px] py-2 px-4 rounded-full w-fit border-2 cursor-pointer`}
          onClick={() => {
            setOptions((prev) => ({
              ...prev,
              targetRole: role as string,
            }));
          }}
          style={{
            backgroundColor:
              selectedTargetRole === role
                ? getBgClassByType(role.toLowerCase() as category)
                    .backgroundColor
                : "transparent",
            borderColor: getBgClassByType(role.toLowerCase() as category)
              .borderColor,
            color:
              selectedTargetRole === role
                ? "white"
                : getBgClassByType(role.toLowerCase() as category).borderColor,
          }}
        >
          {role}
        </p>
      ))}
    </div>
  );
}
