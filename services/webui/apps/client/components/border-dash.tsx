import React from "react";
import { Button } from "../../../packages/ui/components/ui/button";
import Image from "next/image";
import { StaticImport } from "next/dist/shared/lib/get-img-props";
import Link from "next/link";

interface BorderDashProps {
  imageSrc: string;
  alt: string;
  width: number;
  height: number;
  className?: string;
}

export function BorderDash({
  imageSrc,
  alt,
  className,
  width,
  height,
}: BorderDashProps) {
  return (
    <Button
      asChild
      variant="outline"
      className={`rounded-full border-dashed border-white ${className}`}
    >
      <Image src={imageSrc} alt={alt} width={width} height={height} />
    </Button>
  );
}
