import React from "react";
import Image from "next/image";
import { SocialLink } from "../../../../components/account/social-links";
import { Separator } from "../../../../../../packages/ui/components/ui/separator";
import { ConnectionTypes } from "../../../../components/account/connection-type";
import { UserType } from "../../../../utils";
import { Offers } from "../../../../components/account/offers";
import { Skill } from "../../../../components/community/skill";
import { NotoSansJP } from "../../layout";
import { BorderDash } from "../../../../components/border-dash";
import { Works } from "../../../../components/community/works";

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
  const mockUser = {
    avatar: "",
    username: "john_john",
    lastLogin: "2023/7/23",
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    skill: "バンド、ベース（サポートもできます！）",

    members: [
      { name: "Tetsuo Yoshida", role: "Vocal" },
      { name: "Kei Minami", role: "Owner" },
      { name: "Shinya Fukuda", role: "Drums" },
    ],
    totalPoint: 1234,
  };

  const connections: UserType[] = [
    "artist",
    "curator",
    "producer",
    "designer",
    "filmMaker",
  ];

  const mockOffer: string[] = [
    "Event",
    "Live",
    "Recording",
    "Promoting",
    "Support Musician",
  ];

  return (
    <div className="min-h-screen text-white">
      {/* Profile Header */}
      <div className="flex items-start justify-between p-6">
        <div className="flex items-center gap-4">
          <div>
            <Image
              src={mockUser.avatar || "/logo_visualonly.jpg"}
              alt={mockUser.username}
              width={80}
              height={80}
              className="rounded-full"
            />
          </div>
          <div className="flex flex-col gap-3 mr-12">
            <h1 className="text-[24px] leading-[21px]">{mockUser.username}</h1>
            {mockUser.isOnline ? (
              <div className="flex items-center gap-1">
                <div className="w-[18px] h-[18px] rounded-full bg-[#00B496]" />
                <span className="text-[15px] font-light leading-[15px] text-left group-hover:text-black">
                  Online
                </span>
              </div>
            ) : (
              <span className="text-[12px] font-light leading-[16px] text-left group-hover:text-black">
                {mockUser.lastLogin}
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
              link={`https://x.com/${mockUser.username}`}
            />
            <BorderDash
              imageSrc={"/instagram-white.svg"}
              alt="Instagram"
              width={24}
              height={24}
              className="w-12 h-12"
              link={`https://instagram.com/${mockUser.username}`}
            />
          </div>
        </div>
        <div className="flex gap-2">
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
      <div className="p-6 space-y-8">
        {/* Description */}
        <div className="space-y-4">
          <div className="w-[720px] h-[40px]">
            <p
              className={`${NotoSansJP.className} text-[14px] font-[350] leading-[24px] text-left`}
            >
              {mockUser.description}
            </p>
          </div>
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />

        <div className="grid grid-cols-3 ">
          <Skill title="Skill" skill={mockUser.skill} />
          <ConnectionTypes title={"繋がり"} types={connections} />
          <Offers title={"興味のあるオファー"} offers={mockOffer} />
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
      </div>
    </div>
  );
}
