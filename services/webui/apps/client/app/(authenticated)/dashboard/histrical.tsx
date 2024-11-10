"use client";

import { TrendingUp } from "lucide-react";
import { Area, AreaChart, CartesianGrid, XAxis } from "recharts";
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

const chartData = [
  {
    month: "January",
    spotify: 186,
    apple: 80,
    line: 100,
    youtube: 100,
    amazon: 100,
  },
  {
    month: "February",
    spotify: 305,
    apple: 200,
    line: 100,
    youtube: 100,
    amazon: 100,
  },
  {
    month: "March",
    spotify: 237,
    apple: 120,
    line: 100,
    youtube: 100,
    amazon: 100,
  },
  {
    month: "April",
    spotify: 73,
    apple: 190,
    line: 100,
    youtube: 100,
    amazon: 100,
  },
  {
    month: "May",
    spotify: 209,
    apple: 130,
    line: 100,
    youtube: 100,
    amazon: 100,
  },
  {
    month: "June",
    spotify: 214,
    apple: 140,
    line: 100,
    youtube: 100,
    amazon: 100,
  },
];

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

export function Historical({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const { user } = useUserStore();
  const { data } = useQuery<ResData>(GET_HISTORICAL, {
    variables: {
      artistId: selectedArtistId,
      userId: user?.id,
      period: 12,
    },
  });

  return (
    <Card>
      <CardHeader>
        <CardTitle className="font-light">Chart</CardTitle>
        <CardDescription>
          all songs
        </CardDescription>
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
              tickFormatter={(value) => value.slice(0, 3)}
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
            <div className="flex items-center gap-2 font-medium leading-none text-muted-foreground">
              注意書きを書く。ほげほげほげほgへおhごえhげおhげおhg
            </div>
          </div>
        </div>
      </CardFooter>
    </Card>
  );
}
