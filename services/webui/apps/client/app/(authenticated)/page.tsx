"use client";

import Image from "next/image";
import Link from "next/link";
import useUserStore from "../../store/user";
import { useQuery, gql } from "@apollo/client";
import { QuestData } from "../../generated/graphql";

const GET_QUESTS_BY_USER = gql`
  query GetQuestsByUser($userId: String!) {
    getQuestByUserId(userId: $userId) {
      id
      name
      description
    }
  }
`;
interface QuestsResData {
  getQuestByUserId: QuestData[];
}

export default function Home() {
  return (
    <div className="h-full bg-black text-white p-6 space-y-8 overflow-x-hidden">
      <div className="flex items-center gap-2">
        <Image
          src="/home.svg"
          alt="logo"
          className="mr-2"
          width={40}
          height={40}
        />
        <h1 className="text-6xl tracking-tight">HOME</h1>
      </div>

      <Actions />
      <Dashboard />
      <Trending />
    </div>
  );
}

function Actions() {
  const { user } = useUserStore();

  const { data } = useQuery<QuestsResData>(GET_QUESTS_BY_USER, {
    variables: { userId: user?.id },
  });

  console.log(data?.getQuestByUserId);

  return (
    <section className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl font-semibold">
          Quests ({data?.getQuestByUserId?.length})
        </h2>
      </div>

      <div className="relative">
        {data?.getQuestByUserId?.length ? (
          <div className="flex gap-4 overflow-x-auto pb-4 -mx-2 px-2">
            {data?.getQuestByUserId?.map((quest) => (
              <div
                key={quest.id}
                className="min-w-[280px] p-6 rounded-xl bg-white/5 space-y-4 hover:bg-white/10 transition-colors"
              >
                <div className="inline-block px-3 py-1 rounded-full text-xs bg-white/10">
                  フレンド追加
                </div>
                <h3 className="font-medium">{quest.name}</h3>
                <p className="text-sm text-gray-400">{quest.description}</p>
                <button className="p-2 hover:bg-white/10 rounded-full">
                  <svg
                    className="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M17 8l4 4m0 0l-4 4m4-4H3"
                    />
                  </svg>
                </button>
              </div>
            ))}
          </div>
        ) : (
          <div className="p-6 rounded-xl bg-white/5 text-center text-gray-400">
            利用可能なクエストはありません
          </div>
        )}
      </div>
    </section>
  );
}

function Dashboard() {
  return (
    <section className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl font-semibold">Dashboard</h2>
        <Link href="/dashboard">
          <button className="px-4 py-2 rounded-full bg-white/10 text-sm hover:bg-white/20">
            詳細を見る
          </button>
        </Link>
      </div>

      <div className="space-y-6">
        <div className="space-y-1">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-gradient-to-br from-blue-400 to-blue-600 rounded" />
            <span className="text-gray-400">Song Played (Total) /</span>
          </div>
          <div className="text-5xl font-light tracking-tight">212,234,566</div>
        </div>

        <div className="space-y-1">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-gradient-to-br from-blue-400 to-blue-600 rounded" />
            <span className="text-gray-400">Song Played (Week) /</span>
          </div>
          <div className="text-5xl font-light tracking-tight">1,234,212</div>
          <div className="text-sm text-green-500">+123,321</div>
        </div>

        <div className="space-y-1">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-gradient-to-br from-blue-400 to-blue-600 rounded" />
            <span className="text-gray-400">Listeners /</span>
          </div>
          <div className="text-5xl font-light tracking-tight">612,345</div>
        </div>
      </div>
    </section>
  );
}

function Trending() {
  const songs = [
    {
      id: 1,
      name: "Song name goes here",
      album: "Awesome Album",
      artist: "The Awesome Band",
      duration: "3:23",
      totalPlays: "192,112,345",
      weeklyPlays: "234,567",
      trend: "up",
    },
    {
      id: 2,
      name: "Song name goes here",
      album: "Awesome Album",
      artist: "The Awesome Band",
      duration: "3:23",
      totalPlays: "192,112,345",
      weeklyPlays: "234,567",
      trend: "up",
      selected: true,
    },
    {
      id: 3,
      name: "Song name goes here",
      album: "Awesome Album",
      artist: "The Awesome Band",
      duration: "3:23",
      totalPlays: "192,112,345",
      weeklyPlays: "234,567",
      trend: "down",
    },
    {
      id: 4,
      name: "Song name goes here",
      album: "Awesome Album",
      artist: "The Awesome Band",
      duration: "3:23",
      totalPlays: "192,112,345",
      weeklyPlays: "234,567",
      trend: "neutral",
    },
    {
      id: 5,
      name: "Song name goes here",
      album: "Awesome Album",
      artist: "The Awesome Band",
      duration: "3:23",
      totalPlays: "192,112,345",
      weeklyPlays: "234,567",
      trend: "up",
    },
  ];

  return (
    <section className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl font-semibold">( Trending )</h2>
        <Link href="/dashboard">
          <button className="px-4 py-2 rounded-full bg-white/10 text-sm hover:bg-white/20">
            詳細を見る
          </button>
        </Link>
      </div>

      <div className="space-y-2">
        {songs.map((song) => (
          <div
            key={song.id}
            className={`p-2 rounded-xl ${
              song.selected ? "bg-blue-500/20" : "hover:bg-white/5"
            }`}
          >
            <div className="flex items-center gap-4">
              <div className="w-8 text-center font-medium">
                {String(song.id).padStart(2, "0")}
                <div
                  className={`w-1 h-1 mx-auto mt-1 rounded-full ${
                    song.trend === "up"
                      ? "bg-green-500"
                      : song.trend === "down"
                        ? "bg-red-500"
                        : "bg-yellow-500"
                  }`}
                />
              </div>

              <div className="w-16 h-16 bg-white/10 rounded-lg overflow-hidden">
                <img
                  src="/placeholder.svg?height=64&width=64"
                  alt=""
                  className="w-full h-full object-cover"
                />
              </div>

              <div className="flex-1 min-w-0">
                <div className="font-medium truncate">{song.name}</div>
                <div className="text-sm text-gray-400 truncate">
                  {song.album} - {song.artist}
                </div>
                <div className="text-sm text-gray-400">{song.duration}</div>
              </div>

              <div className="text-right">
                <div className="text-sm">
                  Total /{" "}
                  <span className="text-gray-400">{song.totalPlays}</span>
                </div>
                <div className="text-sm">
                  Week /{" "}
                  <span className="text-gray-400">{song.weeklyPlays}</span>
                </div>
              </div>

              <div className="flex gap-1">
                <button className="p-2 hover:bg-white/10 rounded-full">
                  <svg className="w-5 h-5" viewBox="0 0 24 24">
                    <circle
                      cx="12"
                      cy="12"
                      r="10"
                      className="fill-current opacity-20"
                    />
                    <path
                      className="fill-current"
                      d="M15.9 10.2l-3.9 3.9-3.9-3.9a1 1 0 0 0-1.4 1.4l4.6 4.6a1 1 0 0 0 1.4 0l4.6-4.6a1 1 0 0 0-1.4-1.4z"
                    />
                  </svg>
                </button>
                <button className="p-2 hover:bg-white/10 rounded-full">
                  <svg className="w-5 h-5" viewBox="0 0 24 24">
                    <circle cx="12" cy="12" r="3" className="fill-current" />
                    <circle cx="4" cy="12" r="3" className="fill-current" />
                    <circle cx="20" cy="12" r="3" className="fill-current" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
