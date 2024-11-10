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
import { useQuery, gql } from "@apollo/client";
import useUserStore from "../../../store/user";
import { GenderGenRateData } from "../../../generated/graphql";

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
  "#fde047",
  "#f87171",
  "#5eead4",
  "#fb923c",
  "#c084fc",
  "#60a5fa",
  "#4ade80",
  "#f472b6",
  "#a78bfa",
];
const GENDER_COLORS = ["#5eead4", "#f87171"];

export function GenderGenView({
  selectedArtistId,
}: {
  selectedArtistId: string | null;
}) {
  const { user } = useUserStore();
  const { data } = useQuery<ResData>(GET_GENDER_GEN_RATE, {
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

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-4">
      <Card className="border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100 font-light">Generation</CardTitle>
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

      <Card className="border-zinc-800">
        <CardHeader>
          <CardTitle className="text-zinc-100 font-light">Gender</CardTitle>
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
