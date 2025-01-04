import React from "react";

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import { Info } from "lucide-react";
import { Skeleton } from "@ui/components/ui/skeleton";
import { ArtistChart } from "./artist-chart";
const PERIOD_OPTIONS = [
  { label: "7 days", value: 7 },
  { label: "30 days", value: 30 },
  { label: "12 months", value: 12 },
  { label: "36 months", value: 36 },
  { label: "All", value: -1 },
] as const;

interface ChartCardProps {
  data: any;
  selectedPeriod: number;
  setSelectedPeriod: React.Dispatch<React.SetStateAction<number>>;
  isLoading: boolean;
  isError: boolean;
}

export function ChartCard({
  data,
  selectedPeriod,
  setSelectedPeriod,
  isLoading,
  isError,
}: ChartCardProps) {
  if (isLoading) {
    return <Skeleton className="h-[800px] w-full rounded-xl" />;
  } else if (isError) {
    return <p className="text-red-500">Error loading data</p>;
  }

  return (
    <Card className="w-full">
      <CardHeader>
        <div className="flex justify-between items-center">
          <div>
            <CardTitle className="font-light">Stacked Chart</CardTitle>
            <CardDescription>
              各DSPの再生数が積み上げられて表示されます
            </CardDescription>
          </div>
          <Select
            value={selectedPeriod.toString()}
            onValueChange={(value) => setSelectedPeriod(Number(value))}
          >
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Select period" />
            </SelectTrigger>
            <SelectContent>
              {PERIOD_OPTIONS.map((option) => (
                <SelectItem key={option.value} value={option.value.toString()}>
                  {option.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </CardHeader>
      <CardContent>
        {!data ? (
          <p>アーティストIDをセットしてください。</p>
        ) : (
          <ArtistChart data={data} />
        )}
      </CardContent>
      <CardFooter>
        <div className="flex w-full items-start gap-2 text-sm">
          <div className="grid gap-2">
            <div className="flex items-center gap-2 font-medium text-sm leading-none text-muted-foreground">
              <Info className="w-4 h-4" />
              各種DSP経由でデータ取得している関係で多少のタイムラグと誤差があります。AmazonとYouTubeは日次のデータがありませんが今後対応予定です。
            </div>
          </div>
        </div>
      </CardFooter>
    </Card>
  );
}
