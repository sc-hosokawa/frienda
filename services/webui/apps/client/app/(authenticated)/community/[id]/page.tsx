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
import { mockData } from "../page";

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
  const bgColor = getBgClassByType(user?.type as UserType);

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
              className="rounded-full"
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
