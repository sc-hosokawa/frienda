import React from "react";
import { Button } from "@ui/components/ui/button";
import Image from "next/image";

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
