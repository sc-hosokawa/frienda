"use client";

import { Area, AreaChart, CartesianGrid, XAxis, YAxis } from "recharts";
import { useState } from "react";
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
import { ChartDataByUpc } from "../../../../../generated/graphql";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";

const GET_PLAYCOUNT_HISTORY_BY_UPC = gql`
  query GetPlaycountHistoryByUpc($upc: String!, $period: Int!) {
    getPlaycountHistoryByUpc(upc: $upc, period: $period) {
      lineChartData {
        date
        isrcCount
      }
    }
  }
`;

interface ResData {
  getPlaycountHistoryByUpc: ChartDataByUpc;
}

// 期間の設定を定義
const PERIOD_OPTIONS = [
  { label: "7 days", value: 7 },
  { label: "30 days", value: 30 },
  { label: "12 months", value: 12 },
  { label: "36 months", value: 36 },
  { label: "All", value: -1 },
] as const;

export function HistoricalByUPC({ upc }: { upc: string }) {
  const [selectedPeriod, setSelectedPeriod] = useState<number>(12);

  const { data, loading, error } = useQuery<ResData>(
    GET_PLAYCOUNT_HISTORY_BY_UPC,
    {
      variables: { upc, period: selectedPeriod },
    },
  );

  const chartData =
    data?.getPlaycountHistoryByUpc.lineChartData.map(transformData);
  const generatedChartConfig = generateChartConfig(chartData || []);

  const dataKeys = Object.keys(generatedChartConfig);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  if (!chartData?.length) return <div>No data available</div>;

  return (
    <Card>
      <CardHeader>
        <div className="flex justify-between items-center">
          <div>
            <CardTitle className="font-light">Chart</CardTitle>
            <CardDescription>playcount of product</CardDescription>
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
        <ChartContainer config={generatedChartConfig}>
          <AreaChart
            accessibilityLayer
            data={chartData}
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
              interval={3}
              tickFormatter={(value) => value.slice(0, 7)}
            />
            <YAxis
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              tickFormatter={(value) => value.toLocaleString()}
            />
            <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
            <defs>
              {dataKeys.map((key, index) => (
                <linearGradient
                  key={key}
                  id={`fill${key}`}
                  x1="0"
                  y1="0"
                  x2="0"
                  y2="1"
                >
                  <stop
                    offset="5%"
                    stopColor={generatedChartConfig[key]?.color}
                    stopOpacity={0.8}
                  />
                  <stop
                    offset="95%"
                    stopColor={generatedChartConfig[key]?.color}
                    stopOpacity={0.1}
                  />
                </linearGradient>
              ))}
            </defs>
            {dataKeys.map((key, index) => (
              <Area
                key={key}
                dataKey={key}
                type="natural"
                fill={`url(#fill${key})`}
                fillOpacity={0.4}
                stroke={generatedChartConfig[key]?.color}
                stackId="a"
              />
            ))}
          </AreaChart>
        </ChartContainer>
      </CardContent>
      <CardFooter>
        <div className="flex w-full items-start gap-2 text-sm">
          <div className="grid gap-2">
            <div className="flex items-center gap-2 font-medium leading-none text-muted-foreground">
              <Info className="w-4 h-4" />
              各種DSP経由でデータ取得している関係で多少のタイムラグと誤差があります。AmazonとYouTubeは日次のデータがありませんが今後対応予定です。
            </div>
          </div>
        </div>
      </CardFooter>
    </Card>
  );
}

const transformData = (data: any) => {
  const { date, isrcCount } = data;
  console.log("Transform input:", { date, isrcCount });
  const entries = Object.entries(isrcCount);
  const result = {
    date: date,
    ...Object.fromEntries(entries),
  };
  console.log("Transform result:", result);
  return result;
};

const generateChartConfig = (data: any) => {
  if (!data?.length) {
    console.log("No data length");
    return {};
  }

  // ISRCの一覧を取得
  const isrcs = Object.keys(data[0]).filter((key) => key !== "date");

  // 色のパレット（必要に応じて色を追加）
  const colors = [
    "#2563eb", // blue
    "#16a34a", // green
    "#dc2626", // red
    "#9333ea", // purple
    "#ea580c", // orange
    "#0891b2", // cyan
    "#4f46e5", // indigo
    "#be185d", // pink
  ];

  // ISRCごとにconfigを生成
  return isrcs.reduce((config, isrc, index) => {
    config[isrc] = {
      label: isrc,
      color: colors[index % colors.length],
    };
    return config;
  }, {} as ChartConfig);
};
