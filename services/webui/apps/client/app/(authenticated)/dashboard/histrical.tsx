"use client";

import { Area, AreaChart, CartesianGrid, XAxis, YAxis } from "recharts";
import { Info } from "lucide-react";

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@ui/components/ui/chart";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../store/user";
import { ChartData } from "../../../generated/graphql";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import { useState } from "react";

const GET_HISTORICAL = gql`
  query GetHistorical($artistId: String!, $userId: String!, $period: Int!) {
    getPlayCountHistory(artistId: $artistId, userId: $userId, period: $period) {
      lineChartData {
        date
        spotify
        apple
        line
        youtube
        amazon
      }
    }
  }
`;

interface ResData {
  getPlayCountHistory: ChartData;
}

const chartConfig = {
  spotify: {
    label: "Spotify",
    color: "#1DB954",
  },
  apple: {
    label: "Apple",
    color: "#FF6B6B",
  },
  line: {
    label: "Line",
    color: "#845EF7",
  },
  youtube: {
    label: "Youtube",
    color: "#FCC419",
  },
  amazon: {
    label: "Amazon",
    color: "#339AF0",
  },
} satisfies ChartConfig;

const PERIOD_OPTIONS = [
  { label: "7 days", value: 7 },
  { label: "30 days", value: 30 },
  { label: "12 months", value: 12 },
  { label: "36 months", value: 36 },
  { label: "All", value: -1 },
] as const;

export function Historical({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const [selectedPeriod, setSelectedPeriod] = useState<number>(12);
  const { user } = useUserStore();
  const { data } = useQuery<ResData>(GET_HISTORICAL, {
    variables: {
      artistId: selectedArtistId,
      userId: user?.id,
      period: selectedPeriod,
    },
  });

  return (
    <Card>
      <CardHeader>
        <div className="flex justify-between items-center">
          <div>
            <CardTitle className="font-light">Stacked Chart</CardTitle>
            <CardDescription>各DSPの再生数が積み上げられて表示されます</CardDescription>
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
        <ChartContainer config={chartConfig}>
          <AreaChart
            accessibilityLayer
            data={data?.getPlayCountHistory.lineChartData}
            margin={{
              left: 12,
              right: 12,
            }}
          >
            <CartesianGrid vertical={false} />
            <XAxis
              dataKey="date"
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              interval={2}
              tickFormatter={(value) => value.slice(0, 7)}
            />
            <YAxis
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              tickCount={5}
              tickFormatter={(value) => value.toLocaleString()}
              domain={[0, (dataMax: number) => Math.ceil(dataMax * 1.1)]}
            />
            <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
            <defs>
              {Object.entries(chartConfig).map(([key, value]) => (
                <linearGradient
                  key={key}
                  id={`fill${key}`}
                  x1="0"
                  y1="0"
                  x2="0"
                  y2="1"
                >
                  <stop offset="5%" stopColor={value.color} stopOpacity={0.8} />
                  <stop
                    offset="95%"
                    stopColor={value.color}
                    stopOpacity={0.1}
                  />
                </linearGradient>
              ))}
            </defs>
            {Object.keys(chartConfig).map((key) => (
              <Area
                key={key}
                dataKey={key}
                type="natural"
                fill={`url(#fill${key})`}
                fillOpacity={0.4}
                stroke={chartConfig[key as keyof typeof chartConfig].color}
                stackId="a"
              />
            ))}
          </AreaChart>
        </ChartContainer>
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
