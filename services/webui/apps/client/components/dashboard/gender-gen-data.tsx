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
import { ChartSkeleton } from "./gender-gen-chart-skelton";
import { useTranslation } from "~/i18n/client";

const GENERATION_COLORS = [
  "rgba(253, 224, 71, 0.6)", // 60% opacity
  "rgba(248, 113, 113, 0.6)",
  "rgba(94, 234, 212, 0.6)",
  "rgba(251, 146, 60, 0.6)",
  "rgba(192, 132, 252, 0.6)",
  "rgba(96, 165, 250, 0.6)",
  "rgba(74, 222, 128, 0.6)",
];
const GENDER_COLORS = ["rgba(94, 234, 212, 0.6)", "rgba(248, 113, 113, 0.6)"];

interface GenderGenViewProps {
  data: any;
  isLoading: boolean;
}

export default function GenderGenView({ data, isLoading }: GenderGenViewProps) {
  const { t } = useTranslation();

  const generationData = [
    { name: "Under 17", value: data?.genRate.under17 },
    { name: "18-22", value: data?.genRate.gen1822 },
    { name: "23-27", value: data?.genRate.gen2327 },
    { name: "28-34", value: data?.genRate.gen2834 },
    { name: "35-44", value: data?.genRate.gen3544 },
    { name: "45-59", value: data?.genRate.gen4559 },
    { name: "60 Over", value: data?.genRate.gen60150 },
  ];

  const genderData = [
    {
      name: "Male",
      value: data?.genderRate.maleCount,
    },
    {
      name: "Female",
      value: data?.genderRate.femaleCount,
    },
  ];

  const hasGenerationData = generationData.some(
    (item) => item.value !== undefined && item.value !== null && item.value > 0,
  );
  const hasGenderData = genderData.some(
    (item) => item.value !== undefined && item.value !== null && item.value > 0,
  );

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-4">
      <Card className="border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100 font-light">Generation</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-[300px]">
            {isLoading ? (
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
                <p>{t("dashboard.no-data-collected")}</p>
                <p>{t("dashboard.no-data-collected-1")}</p>
              </div>
            )}
          </div>
        </CardContent>
        <CardFooter>
          <div className="flex w-full items-start gap-2 text-sm">
            <div className="grid gap-2">
              <div className="flex items-center gap-2 font-medium text-sm leading-none text-muted-foreground">
                <Info className="w-4 h-4" />
                {t("dashboard.notion")}
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
            {isLoading ? (
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
                <p>{t("dashboard.no-data-collected")}</p>
                <p>{t("dashboard.no-data-collected-1")}</p>
              </div>
            )}
          </div>
        </CardContent>
        <CardFooter>
          <div className="flex w-full items-start gap-2 text-sm">
            <div className="grid gap-2">
              <div className="flex items-center gap-2 font-medium text-sm leading-none text-muted-foreground">
                <Info className="w-4 h-4" />
                {t("dashboard.notion")}
              </div>
            </div>
          </div>
        </CardFooter>
      </Card>
    </div>
  );
}
