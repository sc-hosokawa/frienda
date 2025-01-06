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
    <Card className="dark:border dark:border-white dark:border-opacity-10">
      <CardHeader className="flex flex-row items-center justify-between space-y-0">
        <CardTitle className="text-sm font-medium">{title}</CardTitle>
        {image}
      </CardHeader>
      <CardContent>
        {isLoading ? (
          <Skeleton className="w-full h-[32px]" />
        ) : (
          <div className="text-3xl">
            {amount.toLocaleString()}
            <span className="text-sm text-right ml-1">
              {unit ? ` ${unit}` : ""}
            </span>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
