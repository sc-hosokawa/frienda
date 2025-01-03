"use client";

import { useState } from "react";
import Image from "next/image";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";

interface DashboardInfoProps {
  position: "top-3" | "top-1";
  size: number;
  title: string;
  content: JSX.Element;
}

export function InfoDialog({
  position,
  size,
  title,
  content,
}: DashboardInfoProps) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <>
      <span
        className={`absolute ${position} right-[-60px] cursor-pointer`}
        onClick={() => setIsOpen(true)}
      >
        <Image
          src="/info.svg"
          alt="Info"
          className="mr-2"
          width={size}
          height={size}
        />
      </span>

      <Dialog open={isOpen} onOpenChange={setIsOpen}>
        <DialogContent className="max-w-[80vw] w-full max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="text-2xl font-light">{title}</DialogTitle>
          </DialogHeader>
          <div className="mt-4">{content}</div>
        </DialogContent>
      </Dialog>
    </>
  );
}
