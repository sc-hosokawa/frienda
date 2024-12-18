import React from "react";
import {
  AlertDialog,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@ui/components/ui/alert-dialog";
import { Button } from "@ui/components/ui/button";
import Image from "next/image";

import { Separator } from "@ui/components/ui/separator";

export function ConciergeDialog({ children }: { children: React.ReactNode }) {
  return (
    <AlertDialog>
      <AlertDialogTrigger asChild>
        <Button
          asChild
          variant="outline"
          className="rounded-full border-dashed border-white cursor-pointer w-[60px] h-[60px]"
        >
          <Image
            src={"/concierge-bell.svg"}
            alt={"concierge"}
            width={24}
            height={24}
          />
        </Button>
      </AlertDialogTrigger>
      <AlertDialogContent className="bg-[#0E0E0E] p-6 max-w-screen-2xl min-h-[90vh] h-[90vh]">
        <AlertDialogHeader className="mb-6">
          <div className="flex flex-row justify-between items-start w-full p-6">
            <div className="flex flex-col mt-16 gap-3">
              <Separator className="w-[960px] border border-[#303030] mb-3" />
              <AlertDialogTitle className="text-left text-[60px] leading-[60px] font-light">
                My Concierge
              </AlertDialogTitle>
            </div>
            <AlertDialogTrigger asChild>
              <Image
                src={"/exit.svg"}
                alt={"exit"}
                width={64}
                height={64}
                className="cursor-pointer"
              />
            </AlertDialogTrigger>
          </div>
        </AlertDialogHeader>
        {children}
      </AlertDialogContent>
    </AlertDialog>
  );
}
