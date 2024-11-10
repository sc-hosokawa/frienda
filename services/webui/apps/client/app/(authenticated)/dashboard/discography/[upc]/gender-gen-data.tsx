"use client";

import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
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

const generationData = [
  { name: "Under 20", value: 23 },
  { name: "21-30", value: 54 },
  { name: "31-40", value: 21 },
  { name: "41-50", value: 1 },
  { name: "Above 51", value: 1 },
];

const genderData = [
  { name: "Male", value: 65 },
  { name: "Female", value: 33 },
  { name: "Unknown", value: 2 },
];

const GENERATION_COLORS = [
  "#fde047",
  "#f87171",
  "#5eead4",
  "#fb923c",
  "#c084fc",
];
const GENDER_COLORS = ["#5eead4", "#f87171", "#737373"];

export function GenderGenViewByUPC({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-4 bg-black/95">
      <Card className="bg-zinc-900 border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100">Generation</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-[300px]">
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
                  }}
                  labelStyle={{ color: "hsl(var(--foreground))" }}
                  formatter={(value) => [`${value}%`, "Value"]}
                />
                <Bar dataKey="value" radius={[0, 4, 4, 0]}>
                  {generationData.map((entry, index) => (
                    <Cell
                      key={`cell-${index}`}
                      fill={GENERATION_COLORS[index % GENERATION_COLORS.length]}
                    />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>

      <Card className="bg-zinc-900 border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100">Gender</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={genderData}
                  dataKey="value"
                  nameKey="name"
                  cx="50%"
                  cy="50%"
                  outerRadius={80}
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
                  }}
                  labelStyle={{ color: "hsl(var(--foreground))" }}
                />
                <Legend
                  verticalAlign="bottom"
                  height={36}
                  wrapperStyle={{ color: "hsl(var(--muted-foreground))" }}
                />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
