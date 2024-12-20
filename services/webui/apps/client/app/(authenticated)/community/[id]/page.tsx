import React from "react";
import Image from "next/image";
import { SocialLink } from "../../../../components/account/social-links";
import { Separator } from "../../../../../../packages/ui/components/ui/separator";
import { ConnectionTypes } from "../../../../components/account/connection-type";
import { getBgClassByType, UserType } from "../../../../utils";
import { Offers } from "../../../../components/account/offers";
import { Skill } from "../../../../components/community/skill";
import { NotoSansJP } from "../../layout";
import { BorderDash } from "../../../../components/border-dash";
import { Works } from "../../../../components/community/works";
import { OfferCard } from "../../../../components/community/offer-card";
import { List } from "../../../../components/account/list";
import { BaseComponent } from "../../../../components/account/base";

interface CommunityListsRowProps {
  id: string;
  name: string;
  friendCount: number;
  rate: string;
  type: {
    title: string;
    role?: string;
  };
  comment?: string;
  connection: {
    offer: string;
    date: string;
  };
  isOnline: boolean;
  description: string;
  connectedSince: string;
  avatar: string;
  skill: string;
  members: { title: string; role?: string }[];
  lastLogin: string;
  offers?: string[] | undefined;
  connections?: UserType[] | undefined;
}

const mockData: CommunityListsRowProps[] = [
  {
    id: "1",
    name: "taro_yoshida",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "artist",
      role: "Vocal",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "2",
    name: "sayaka_kyoda",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "artist",
      role: "Vocal",
    },
    comment: "イベントいつも最高",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "3",
    name: "photoone",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "promoter",
      role: "Photographer",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "4",
    name: "lisa_fukuda",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "curator",
      role: "manager",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "5",
    name: "minoru_kou",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "curator",
      role: "manager",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "6",
    name: "john_john",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "artist",
      role: "Vocal",
    },
    comment: "次のMVの時きく!",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
];

export default function CommunityAccountPage({
  params,
}: {
  params: { id: string };
}) {
  // TODO: get user data by id
  /*
   * e.g.:
   * const { data, error } = useQuery(["user", params.id], () => getUser(params.id));
   */
  function getuser(id: string) {
    return mockData[parseInt(id) - 1];
  }
  const user = getuser(params.id);
  const bgColor = getBgClassByType(user?.type.title as UserType);

  return (
    <div className="min-h-screen text-white">
      {/* Profile Header */}
      <div className="flex items-center justify-between p-6">
        <div className="flex items-center gap-4">
          <div>
            <Image
              src={user?.avatar || "/logo_visualonly.jpg"}
              alt="avatar"
              width={80}
              height={80}
              className={`p-1 rounded-full object-cover ${getBgClassByType(user?.type.title as UserType)}`}
            />
          </div>
          <div className="flex flex-col gap-3 mr-12">
            <h1 className="text-[24px] leading-[21px]">{user?.name}</h1>
            {user?.isOnline ? (
              <div className="flex items-center gap-1">
                <div className="w-[18px] h-[18px] rounded-full bg-[#00B496]" />
                <span className="text-[15px] font-light leading-[15px] text-left group-hover:text-black">
                  Online
                </span>
              </div>
            ) : (
              <span className="text-[12px] font-light leading-[16px] text-left group-hover:text-black">
                {user?.lastLogin}
              </span>
            )}
          </div>
          <div className="flex gap-2">
            <BorderDash
              imageSrc={"/x-white.svg"}
              alt="X"
              width={24}
              height={24}
              className="w-12 h-12"
              link={`https://x.com/${user?.name}`}
            />
            <BorderDash
              imageSrc={"/instagram-white.svg"}
              alt="Instagram"
              width={24}
              height={24}
              className="w-12 h-12"
              link={`https://instagram.com/${user?.name}`}
            />
          </div>
        </div>
        <div>
          {user?.comment && (
            <span
              className={`px-3 py-1 ${bgColor} text-black rounded-full text-sm transition-colors`}
            >
              {user?.comment}
            </span>
          )}
        </div>
        <div className="flex items-center gap-2">
          <BorderDash
            imageSrc={"/share.svg"}
            alt="share"
            width={24}
            height={24}
            className="w-12 h-12"
            link={"/"}
          />

          <BorderDash
            imageSrc={"/mail.svg"}
            alt="mail"
            width={24}
            height={24}
            className="w-12 h-12"
            link={"/"}
          />

          <BorderDash
            imageSrc={"/more-horizontal.svg"}
            alt="more"
            width={24}
            height={24}
            className="w-12 h-12"
            link={"/"}
          />
        </div>
      </div>

      {/* Content */}
      <div className="p-6 space-y-12">
        {/* Description */}
        <div className="space-y-4">
          <div className="w-[720px] h-[40px]">
            <p
              className={`${NotoSansJP.className} text-[14px] font-[350] leading-[24px] text-left`}
            >
              {user?.description}
            </p>
          </div>
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />

        <div className="grid grid-cols-3 ">
          <Skill title="Skill" skill={user?.skill} />
          <ConnectionTypes title={"繋がり"} types={user?.connections} />
          <Offers title={"興味のあるオファー"} offers={user?.offers} />
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />

        <div className="grid grid-cols-3 ">
          <BaseComponent title={"Type"}>
            <div className="flex flex-wrap gap-2">
              <div className="flex flex-col text-white">
                <div>
                  {user?.type.title}
                  {user?.type?.role && (
                    <span className="text-white">
                      {" "}
                      {` / ${user?.type.role}`}
                    </span>
                  )}
                </div>
              </div>
            </div>
          </BaseComponent>

          <div>
            <List title="Members" lists={user?.members!} />
          </div>
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />
        {/* Social Links */}
        <div className="grid grid-cols-3 ">
          <SocialLink
            title="Artist SNS"
            x={{ username: "mock" }}
            instagram={{ username: "mock" }}
            facebook={{ username: "mock" }}
          />
          <SocialLink
            title="Music Channel"
            spotify={{ username: "mock" }}
            apple={{ username: "mock" }}
            youtube={{ username: "mock" }}
          />
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />

        <div className="grid grid-cols-3 gap-4">
          <div>
            <Works
              title="The Band Super Album"
              imageSrc="/membership.png"
              spotify={{ username: "mock" }}
              apple={{ username: "mock" }}
            />
          </div>
        </div>

        <div className="grid grid-cols-2 gap-10">
          {sampleData.map((data, index) => (
            <OfferCard key={index} {...data} />
          ))}
        </div>
      </div>
    </div>
  );
}

const sampleData = [
  {
    status: "In-Progress" as const,
    offerId: "123",
    title: "イベントに参加してくれるアーティスト募集中！",
    lastUpdated: "2024/10/10",
    participants: [
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 1",
      },
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 2",
      },
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 3",
      },
    ],
    deadline: "2024/11/10",
    location: "東京都",
    target: "2 Artists",
    borderColor: "#2D78FF",
  },
  {
    status: "Offer Applied" as const,
    offerId: "124",
    title: "イベントに参加してくれるアーティスト募集中！",
    lastUpdated: "2024/10/10",
    participants: [
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 1",
      },
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 2",
      },
    ],
    deadline: "2024/11/10",
    location: "東京都",
    target: "2 Artists",
    borderColor: "#00B496",
  },
  {
    status: "Offer Applied" as const,
    offerId: "124",
    title: "イベントに参加してくれるアーティスト募集中！",
    lastUpdated: "2024/10/10",
    participants: [
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 1",
      },
      {
        avatar: "/logo_visualonly.jpg",
        name: "User 2",
      },
    ],
    deadline: "2024/11/10",
    location: "東京都",
    target: "2 Artists",
    borderColor: "#00B496",
  },
];
