import React from "react";
import Image from "next/image";
import Link from "next/link";
import { BaseComponent } from "./base";

interface SocialLinkProps {
  title?: string;
  x?: {
    username: string;
  };
  instagram?: {
    username: string;
  };
  facebook?: {
    username: string;
  };
  spotify?: {
    username: string;
  };
  youtube?: {
    username: string;
  };
  apple?: {
    username: string;
  };
}

export function SocialLink({
  title,
  x,
  instagram,
  facebook,
  spotify,
  youtube,
  apple,
}: SocialLinkProps) {
  return (
    <BaseComponent title={title}>
      <div className="flex flex-wrap gap-2">
        {x && (
          <Link
            href={`https://x.com/${x.username}`}
            target="_blank"
            rel="noopener noreferrer"
            className="w-12 h-12 bg-white rounded-full flex items-center justify-center hover:opacity-80 transition-opacity"
          >
            <Image
              src="/x.svg"
              alt="X"
              width={24}
              height={24}
              className="text-black"
            />
          </Link>
        )}

        {instagram && (
          <Link
            href={`https://instagram.com/${instagram.username}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image
              src="/instagram.svg"
              alt="Instagram"
              width={48}
              height={48}
            />
          </Link>
        )}

        {facebook && (
          <Link
            href={`https://facebook.com/${facebook.username}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image src="/facebook.svg" alt="Facebook" width={48} height={48} />
          </Link>
        )}
        {apple && (
          <Link
            href={`https://apple.com/${apple.username}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image src="/apple.svg" alt="Apple" width={48} height={48} />
          </Link>
        )}
        {spotify && (
          <Link
            href={`https://spotify.com/${spotify.username}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image src="/spotify.svg" alt="Spotify" width={48} height={48} />
          </Link>
        )}
        {youtube && (
          <Link
            href={`https://youtube.com/${youtube.username}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image src="/youtube.svg" alt="YouTube" width={48} height={48} />
          </Link>
        )}
      </div>
    </BaseComponent>
  );
}
