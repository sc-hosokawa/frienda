import React from "react";

import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@ui/components/ui/chart";

import { Area, AreaChart, CartesianGrid, XAxis, YAxis } from "recharts";

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

export function ArtistChart({ data }: { data: any }) {
  return (
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
              <stop offset="95%" stopColor={value.color} stopOpacity={0.1} />
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
  );
}
