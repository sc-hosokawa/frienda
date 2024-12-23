import React from "react";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import { Skeleton } from "@ui/components/ui/skeleton";

export function StatsCard({
  title,
  amount,
  isLoading,
  image,
  unit,
}: {
  title: string;
  amount: number;
  isLoading?: boolean;
  image: React.ReactNode;
  unit?: string;
}) {
  return (
    <Card className="w-[300px] bg-[#1E1E1E]">
      <CardHeader className="flex flex-row items-center justify-between space-y-0">
        <CardTitle className="text-sm font-medium">{title}</CardTitle>
        {image}
      </CardHeader>
      <CardContent>
        {isLoading ? (
          <Skeleton className="w-full h-[32px]" />
        ) : (
          <div className="text-3xl font-bold">
            {amount}
            <span className="text-sm text-right">{unit ? ` ${unit}` : ""}</span>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
