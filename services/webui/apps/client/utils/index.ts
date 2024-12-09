export type UserType =
  | "artist"
  | "curator"
  | "producer"
  | "designer"
  | "filmMaker"
  | "promoter"
  | "supporter"
  | "other"
  | "invited";

export const getColorByType = (type: UserType): string => {
  const colorMap: Record<UserType, string> = {
    artist: "#FF7178",
    curator: "#FF692D",
    producer: "#E1F000",
    designer: "#00B496",
    filmMaker: "#2D78FF",
    promoter: "#B487FF",
    supporter: "#BFBFBF",
    other: "#565656",
    invited: "##FFFFFF",
  };

  return colorMap[type];
};

export const getBgClassByType = (type: UserType): string => {
  const color = getColorByType(type);
  return `bg-[${color}]`;
};
