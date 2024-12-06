import React from "react";

export function BaseComponent({
  children,
  title,
}: {
  children: React.ReactNode;
  title: string;
}) {
  return (
    <div className="flex flex-col gap-4">
      <h2 className="text-[14px] leading-[18px]">{title}</h2>
      {children}
    </div>
  );
}
