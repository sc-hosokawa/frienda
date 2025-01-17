"use client";

import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardFooter,
} from "@ui/components/ui/card";
import {
  Bar,
  BarChart,
  Pie,
  PieChart,
  Cell,
  ResponsiveContainer,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
} from "recharts";
import { Info } from "lucide-react";
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../store/user";
import { GenderGenRateData } from "../../generated/graphql";
import { ChartSkeleton } from "./gender-gen-chart-skelton";

const GET_GENDER_GEN_RATE = gql`
  query GetGenderGenRate($artistId: String!, $userId: String!) {
    getGenderGenRateByArtist(artistId: $artistId, userId: $userId) {
      genderRate {
        maleCount
        femaleCount
      }
      genRate {
        under14
        gen1519
        gen2024
        gen2529
        gen3034
        gen3539
        gen4044
        gen4549
        gen50Over
      }
    }
  }
`;

interface ResData {
  getGenderGenRateByArtist: GenderGenRateData;
}

const GENERATION_COLORS = [
  "rgba(253, 224, 71, 0.6)", // 60% opacity
  "rgba(248, 113, 113, 0.6)",
  "rgba(94, 234, 212, 0.6)",
  "rgba(251, 146, 60, 0.6)",
  "rgba(192, 132, 252, 0.6)",
  "rgba(96, 165, 250, 0.6)",
  "rgba(74, 222, 128, 0.6)",
  "rgba(244, 114, 182, 0.6)",
  "rgba(167, 139, 250, 0.6)",
];
const GENDER_COLORS = ["rgba(94, 234, 212, 0.6)", "rgba(248, 113, 113, 0.6)"];

export function GenderGenView({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const { user } = useUserStore();
  const { data, loading } = useQuery<ResData>(GET_GENDER_GEN_RATE, {
    variables: {
      artistId: selectedArtistId,
      userId: user?.id,
    },
  });

  const generationData = [
    { name: "Under 14", value: data?.getGenderGenRateByArtist.genRate.under14 },
    { name: "15-19", value: data?.getGenderGenRateByArtist.genRate.gen1519 },
    { name: "20-24", value: data?.getGenderGenRateByArtist.genRate.gen2024 },
    { name: "25-29", value: data?.getGenderGenRateByArtist.genRate.gen2529 },
    { name: "30-34", value: data?.getGenderGenRateByArtist.genRate.gen3034 },
    { name: "35-39", value: data?.getGenderGenRateByArtist.genRate.gen3539 },
    { name: "40-44", value: data?.getGenderGenRateByArtist.genRate.gen4044 },
    { name: "45-49", value: data?.getGenderGenRateByArtist.genRate.gen4549 },
    {
      name: "50 Over",
      value: data?.getGenderGenRateByArtist.genRate.gen50Over,
    },
  ];

  const genderData = [
    {
      name: "Male",
      value: data?.getGenderGenRateByArtist.genderRate.maleCount,
    },
    {
      name: "Female",
      value: data?.getGenderGenRateByArtist.genderRate.femaleCount,
    },
  ];

  const hasGenerationData = generationData.some(
    (item) => item.value !== undefined && item.value !== null && item.value > 0
  );
  const hasGenderData = genderData.some(
    (item) => item.value !== undefined && item.value !== null && item.value > 0
  );

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-4">
      <Card className="border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100 font-light">Generation</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-[300px]">
            {loading ? (
              <ChartSkeleton />
            ) : hasGenerationData ? (
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={generationData} layout="vertical">
                  <XAxis type="number" hide />
                  <YAxis
                    type="category"
                    dataKey="name"
                    tick={{ fill: "hsl(var(--muted-foreground))" }}
                    width={80}
                  />
                  <Tooltip
                    contentStyle={{
                      backgroundColor: "hsl(var(--background))",
                      borderColor: "hsl(var(--border))",
                      color: "hsl(var(--foreground))",
                      borderRadius: "6px",
                      padding: "8px",
                    }}
                    labelStyle={{
                      color: "hsl(var(--foreground))",
                      marginBottom: "4px",
                    }}
                    itemStyle={{
                      color: "hsl(var(--muted-foreground))",
                    }}
                    formatter={(value) => [`${value}%`, "Value"]}
                  />
                  <Bar dataKey="value" radius={[0, 4, 4, 0]}>
                    {generationData.map((entry, index) => (
                      <Cell
                        key={`cell-${index}`}
                        fill={
                          GENERATION_COLORS[index % GENERATION_COLORS.length]
                        }
                      />
                    ))}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            ) : (
              <div className="h-full w-full flex flex-col items-center justify-center text-muted-foreground text-center">
                <p>算出に必要なデータが収集できませんでした。</p>
                <p>今後十分な再生数がある場合に算出できるようになります。</p>
              </div>
            )}
          </div>
        </CardContent>
        <CardFooter>
          <div className="flex w-full items-start gap-2 text-sm">
            <div className="grid gap-2">
              <div className="flex items-center gap-2 font-medium text-sm leading-none text-muted-foreground">
                <Info className="w-4 h-4" />
                世代比データはLINE
                Musicのデータを利用しています。集計対象は2021年3月1日以降のデータとなります。今後、他のDSPのデータも統合予定です。
              </div>
            </div>
          </div>
        </CardFooter>
      </Card>

      <Card className="border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100 font-light">Gender</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-[300px]">
            {loading ? (
              <ChartSkeleton />
            ) : hasGenderData ? (
              <ResponsiveContainer width="100%" height="100%">
                <PieChart>
                  <Pie
                    data={genderData}
                    dataKey="value"
                    nameKey="name"
                    cx="50%"
                    cy="50%"
                    outerRadius={80}
                    startAngle={90}
                    endAngle={450}
                    innerRadius={60}
                    strokeWidth={0}
                    label={({ name, percent }) =>
                      `${(percent * 100).toFixed(0)}%`
                    }
                    labelLine={false}
                  >
                    {genderData.map((entry, index) => (
                      <Cell
                        key={`cell-${index}`}
                        fill={GENDER_COLORS[index % GENDER_COLORS.length]}
                      />
                    ))}
                  </Pie>
                  <Tooltip
                    contentStyle={{
                      backgroundColor: "hsl(var(--background))",
                      borderColor: "hsl(var(--border))",
                      color: "hsl(var(--foreground))",
                      borderRadius: "6px",
                      padding: "8px",
                    }}
                    labelStyle={{
                      color: "hsl(var(--foreground))",
                      marginBottom: "4px",
                    }}
                    itemStyle={{
                      color: "hsl(var(--muted-foreground))",
                    }}
                  />
                  <Legend
                    verticalAlign="bottom"
                    height={36}
                    wrapperStyle={{ color: "hsl(var(--muted-foreground))" }}
                  />
                </PieChart>
              </ResponsiveContainer>
            ) : (
              <div className="h-full w-full flex flex-col items-center justify-center text-muted-foreground text-center">
                <p>算出に必要なデータが収集できませんでした。</p>
                <p>今後十分な再生数がある場合に算出できるようになります。</p>
              </div>
            )}
          </div>
        </CardContent>
        <CardFooter>
          <div className="flex w-full items-start gap-2 text-sm">
            <div className="grid gap-2">
              <div className="flex items-center gap-2 font-medium text-sm leading-none text-muted-foreground">
                <Info className="w-4 h-4" />
                性別比データはLINE
                Musicのデータを利用しています。集計対象は2021年3月1日以降のデータとなります。今後、他のDSPのデータも統合予定です。
              </div>
            </div>
          </div>
        </CardFooter>
      </Card>
    </div>
  );
}
