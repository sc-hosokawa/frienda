import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import { Card, CardContent } from "@ui/components/ui/card";
import { Heart } from "lucide-react";
import { gql, useQuery } from "@apollo/client";
import useUserStore from "../../store/user";

type category = "musician" | "curator" | "creator" | "supporter";

export interface CommunityMapProps {
  id: string;
  name: string;
  imageUrl: string;
  category: string;
  favoriteId: string;
  shortNote: string;
  lastLoggedIn: string;
  connections: string[];
  weight: number;
  refetch: () => void;
}

const CommunityMap = ({
  items,
  center_user_image,
  center_user_name,
  center_user_category,
}: {
  items: CommunityMapProps[];
  center_user_image: string;
  center_user_name: string;
  center_user_category: string;
}) => {
  const [nodes, setNodes] = useState([]);
  const svgRef = useRef<SVGSVGElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);

  const categoryColors: Record<
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

  const filterItems: {
    category: category;
    label: string;
  }[] = [
    { category: "musician", label: "Musician" },
    { category: "curator", label: "Curator" },
    { category: "creator", label: "Creator" },
    { category: "supporter", label: "Supporter" },
  ];

  const calculateLayoutParameters = () => {
    const container = containerRef.current;
    if (!container) return { width: 800, height: 600, radius: 200 };

    const width = container.clientWidth;
    const height = Math.max(600, width * 0.75);
    const radius = Math.min(width, height) * 0.3;

    return { width, height, radius };
  };

  const optimizeNodePositions = () => {
    const { width, height, radius } = calculateLayoutParameters();
    const centerX = width / 2;
    const centerY = height / 2;
    const nodeRadius = 35;
    const spacing = (2 * Math.PI) / items.length;

    const nodes = items.map((item, index) => {
      const angle = spacing * index;
      const radiusWithVariation = radius + (Math.random() * 50 - 25);

      return {
        ...item,
        x: centerX + radiusWithVariation * Math.cos(angle),
        y: centerY + radiusWithVariation * Math.sin(angle),
      };
    });

    for (let i = 0; i < 50; i++) {
      nodes.forEach((node1, index1) => {
        nodes.forEach((node2, index2) => {
          if (index1 < index2) {
            const dx = node2.x - node1.x;
            const dy = node2.y - node1.y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            const minDistance = nodeRadius * 3;

            if (distance < minDistance) {
              const angle = Math.atan2(dy, dx);
              const moveDistance = (minDistance - distance) / 2;

              nodes[index2]?.x &&
                (nodes[index2]!.x += Math.cos(angle) * moveDistance);
              nodes[index2]?.y &&
                (nodes[index2]!.y += Math.sin(angle) * moveDistance);
              nodes[index1]?.x &&
                (nodes[index1]!.x -= Math.cos(angle) * moveDistance);
              nodes[index1]?.y &&
                (nodes[index1]!.y -= Math.sin(angle) * moveDistance);

              [index1, index2].forEach((index) => {
                const node = nodes[index];
                if (!node?.x || !node?.y) return;
                const centerDistance = Math.sqrt(
                  Math.pow(node.x - centerX, 2) + Math.pow(node.y - centerY, 2),
                );
                if (centerDistance > radius * 1.5) {
                  const centerAngle = Math.atan2(
                    node.y - centerY,
                    node.x - centerX,
                  );
                  nodes[index]!.x =
                    centerX + radius * 1.5 * Math.cos(centerAngle);
                  nodes[index]!.y =
                    centerY + radius * 1.5 * Math.sin(centerAngle);
                }
              });
            }
          }
        });
      });
    }

    return { nodes, centerX, centerY };
  };

  useEffect(() => {
    const handleResize = () => {
      const { nodes, centerX, centerY } = optimizeNodePositions();
      setNodes(nodes as any);

      if (svgRef.current) {
        const { width, height } = calculateLayoutParameters();
        svgRef.current.setAttribute("width", width.toString());
        svgRef.current.setAttribute("height", height.toString());
      }
    };

    handleResize();
    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  const { width, height } = calculateLayoutParameters();
  const centerX = width / 2;
  const centerY = height / 2;

  return (
    <div className="min-h-screen bg-black">
      <div className="bg-black text-white p-8">
        <div className="flex gap-8">
          <div className="w-24 flex-shrink-0">
            <div className="text-xl mb-4">Filter</div>
            <div className="flex flex-col gap-2">
              {filterItems.map((item) => (
                <div
                  key={item.category}
                  className="flex items-center gap-2 font-light"
                >
                  <div
                    className="w-4 h-4 rounded-full border-2"
                    style={{
                      backgroundColor: categoryColors[item.category].background,
                      borderColor: categoryColors[item.category].border,
                    }}
                  />
                  <span>{item.label}</span>
                </div>
              ))}
            </div>

            {/* TODO: add common friends 
            <div className="mt-8">
              <div className="text-lg mb-4">共通のフレンド</div>
              <div className="flex gap-2">
                {sampleConnections.slice(0, 4).map((connection, i) => (
                  <div key={i} className="w-12 h-12 rounded-full bg-gray-700" />
                ))}
              </div>
              <div className="text-sm text-gray-400 mt-2">
                {sampleConnections.length} common connections
              </div>
            </div>
						*/}
          </div>

          <Card className="bg-black border-none shadow-none flex-grow">
            <CardContent className="bg-black p-0" ref={containerRef}>
              <svg ref={svgRef} className="bg-black w-full">
                <defs>
                  <clipPath id="circle-clip">
                    <circle r="32" cx="0" cy="0" />
                  </clipPath>
                  <clipPath id="circle-clip-center">
                    <circle r="37" cx="0" cy="0" />
                  </clipPath>
                </defs>

                {nodes.map(
                  (node: {
                    category: any;
                    id: string;
                    x: number;
                    y: number;
                  }) => {
                    const midX = (centerX + node.x) / 2;
                    const midY = (centerY + node.y) / 2;
                    const offset = 30;
                    const controlX =
                      midX -
                      ((node.y - centerY) * offset) /
                        Math.sqrt(
                          (node.x - centerX) ** 2 + (node.y - centerY) ** 2,
                        );
                    const controlY =
                      midY +
                      ((node.x - centerX) * offset) /
                        Math.sqrt(
                          (node.x - centerX) ** 2 + (node.y - centerY) ** 2,
                        );

                    return (
                      <path
                        key={`line-${node.id}`}
                        d={`M ${centerX} ${centerY} Q ${controlX} ${controlY} ${node.x} ${node.y}`}
                        fill="none"
                        stroke={`${categoryColors[node.category as category].border}99`}
                        strokeWidth="2"
                        strokeDasharray="4"
                      />
                    );
                  },
                )}
                {nodes.map(
                  (node: {
                    name: string;
                    imageUrl: string | undefined;
                    id: string;
                    x: number;
                    y: number;
                    category: category;
                  }) => (
                    <Link 
                      href={`/community/${node.id}`}
                      onClick={(e) => {
                        e.preventDefault();
                        window.location.href = `/community/${node.id}`;
                      }}
                    >
                      <g
                        key={node.id}
                        transform={`translate(${node.x},${node.y})`}
                      >
                        <circle
                          r="38"
                          fill={categoryColors[node.category].background}
                          stroke={categoryColors[node.category].border}
                          strokeWidth="2"
                          className="cursor-pointer"
                        />
                        <g clipPath="url(#circle-clip)">
                          <image
                            href={node.imageUrl || "/logo_visualonly.jpg"}
                            x="-32"
                            y="-32"
                            width="64"
                            height="64"
                            className="rounded-full"
                          />
                        </g>
                        <text
                          y="50"
                          textAnchor="middle"
                          fill="white"
                          className="text-sm"
                        >
                          {node.name}
                        </text>
                      </g>
                    </Link>
                  ),
                )}

                <g transform={`translate(${centerX},${centerY})`}>
                  <circle
                    r="43"
                    fill={
                      categoryColors[center_user_category as category]
                        ?.background || categoryColors.supporter.background
                    }
                    stroke={
                      categoryColors[center_user_category as category]
                        ?.border || categoryColors.supporter.border
                    }
                    strokeWidth="2"
                  />
                  <g clipPath="url(#circle-clip-center)">
                    <image
                      href={center_user_image || "/logo_visualonly.jpg"}
                      x="-37"
                      y="-37"
                      width="74"
                      height="74"
                      className="rounded-full"
                    />
                  </g>
                  <text
                    y="60"
                    textAnchor="middle"
                    fill="white"
                    className="text-sm"
                  >
                    {center_user_name}
                  </text>
                </g>
              </svg>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default CommunityMap;
