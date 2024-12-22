export type category = "musician" | "curator" | "creator" | "supporter";

export const categoryColors: Record<
  category,
  { border: string; background: string }
> = {
  musician: {
    border: "#FF7178",
    background: "#562C2E",
  },
  curator: {
    border: "#FF692D",
    background: "#6E321A",
  },
  creator: {
    border: "#E1F000",
    background: "#4D520A",
  },
  supporter: {
    border: "#E4DBC0",
    background: "#4E4C43",
  },
};

export const getBgClassByType = (
  type: category,
): { backgroundColor: string; borderColor: string } => {
  const color = categoryColors[type];
  return {
    backgroundColor: color.background,
    borderColor: color.border,
  };
};
