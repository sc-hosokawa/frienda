import React from "react";
import { Button } from "../../../packages/ui/components/ui/button";
import Image from "next/image";
import { StaticImport } from "next/dist/shared/lib/get-img-props";
import Link from "next/link";

interface BorderDashProps {
  imageSrc: string | StaticImport;
  alt: string;
  className?: string;
  width: number;
  height: number;
  link: string;
}

export function BorderDash({
  imageSrc,
  alt,
  className,
  width,
  height,
  link,
}: BorderDashProps) {
  return (
    <Button
      asChild
      variant="outline"
      className={`rounded-full border-dashed border-white ${className}`}
    >
      <Link href={link} target="_blank" rel="noopener noreferrer">
        <Image src={imageSrc} alt={alt} width={width} height={height} />
      </Link>
    </Button>
  );
}
