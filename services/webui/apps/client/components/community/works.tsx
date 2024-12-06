import React from "react";

import { SocialLink } from "../account/social-links";
import Image from "next/image";

interface WorksProps {
  title: string;
  imageSrc: string;
  spotify?: {
    username: string;
  };
  apple?: {
    username: string;
  };
}

export function Works({ title, imageSrc, spotify, apple }: WorksProps) {
  return (
    <>
      <Image
        src={imageSrc}
        alt="image"
        width={180}
        height={180}
        className="rounded"
      />
      <SocialLink title={title} spotify={spotify} apple={apple} />
    </>
  );
}
