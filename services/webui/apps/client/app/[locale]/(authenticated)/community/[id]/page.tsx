"use client";
import React from "react";
import Image from "next/image";
import { SocialLink } from "~/components/account/social-links";
import { Separator } from "@ui/components/ui/separator";
import { ConnectionTypes } from "~/components/account/connection-type";
import { getBgClassByType, category } from "~/utils";
import { Offers } from "~/components/account/offers";
import { Skill } from "~/components/community/skill";
import { Category } from "~/components/community/category";
import { BorderDash } from "~/components/border-dash";
import { Works } from "~/components/community/works";
import { OfferCard } from "~/components/community/offer-card";
import { List } from "~/components/account/list";
import { BaseComponent } from "~/components/account/base";
import { gql, useQuery, useMutation } from "@apollo/client";
import useUserStore from "~/store/user";
import CommunityMap from "~/components/community/community-map";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@ui/components/ui/popover";
import { Copy, Check, MessageSquare, Pencil } from "lucide-react";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { NotoSansJP } from "~/utils/fonts";
import { useTranslation } from "~/i18n/client";

const GET_USER_PROFILE = gql`
  query GetUserProfile($viewerId: String!, $userId: String!) {
    getUserProfile(viewerId: $viewerId, userId: $userId) {
      id
      imageUrl
      name
      lastLoggedIn
      xHandle
      instagramHandle
      fbHandle
      shortNote
      greeting
      skill
      connections
      interestOffer
      category
      belongsToArtists
      portfolios {
        id
        title
        description
        imageUrl
        refLink
        createdAt
      }
      offers {
        id
        title
        description
        imageUrl
        fee
        category
      }
    }
  }
`;

const GET_OTHER_USER_COMMUNITY = gql`
  query GetOtherUserCommunity($viewerId: String!, $targetUserId: String!) {
    getOtherUserCommunity(viewerId: $viewerId, targetUserId: $targetUserId) {
      community {
        id
        name
        imageUrl
        category
        favoriteId
        shortNoteId
        shortNote
        lastLoggedIn
        connections
        weight
      }
    }
  }
`;

const CREATE_MESSAGE_ROOM = gql`
  mutation CreateNewMessageRoom($input: CreateNewMessageRoomInput!) {
    createNewMessageRoom(input: $input) {
      id
    }
  }
`;

export default function CommunityAccountPage({
  params,
}: {
  params: { id: string };
}) {
  const router = useRouter();
  const { user } = useUserStore();
  const [createRoom] = useMutation(CREATE_MESSAGE_ROOM);
  const { t } = useTranslation();

  const { loading: communityLoading, data: communityData } = useQuery(
    GET_OTHER_USER_COMMUNITY,
    {
      variables: {
        viewerId: user?.id,
        targetUserId: params.id,
      },
    }
  );

  const { loading, error, data } = useQuery(GET_USER_PROFILE, {
    variables: {
      viewerId: user?.id,
      userId: params.id,
    },
  });

  const [showCopied, setShowCopied] = useState(false);

  const handleMessageClick = async (e: React.MouseEvent) => {
    e.stopPropagation();
    try {
      const result = await createRoom({
        variables: {
          input: {
            createdBy: user?.id,
            userList: [user?.id, params.id],
            category: "dm",
          },
        },
      });

      if (result.data?.createNewMessageRoom?.id) {
        router.push(`/message/${result.data.createNewMessageRoom.id}`);
      }
    } catch (err) {
      console.error("Failed to create message room:", err);
    }
  };

  const isOwnProfile = user?.id === params.id;

  const handleEditProfile = (e: React.MouseEvent) => {
    e.stopPropagation();
    router.push("/profile");
  };

  if (loading || communityLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  console.log(data?.getUserProfile?.category);

  return (
    <div className="min-h-screen text-white">
      <div className="flex items-center justify-between p-6">
        <div className="flex items-center gap-4">
          <div className="w-[80px] h-[80px] relative rounded-full overflow-hidden">
            <Image
              src={data?.getUserProfile?.imageUrl || "/logo_visualonly.jpg"}
              alt="avatar"
              width={80}
              height={80}
              className="w-full h-full object-cover border-2 rounded-full"
              style={getBgClassByType(
                data?.getUserProfile?.category as category
              )}
            />
          </div>
          <div className="flex flex-col gap-3 mr-12">
            <h1 className="text-[24px] leading-[21px]">
              {data?.getUserProfile?.name}
            </h1>
            {(() => {
              if (!data?.getUserProfile?.lastLoggedIn) return null;

              const lastLogin = new Date(data.getUserProfile.lastLoggedIn);
              const now = new Date();
              const diffInMinutes = Math.floor(
                (now.getTime() - lastLogin.getTime()) / (1000 * 60)
              );

              if (diffInMinutes <= 15) {
                return (
                  <div className="flex items-center gap-1">
                    <div className="w-[18px] h-[18px] rounded-full bg-[#00B496] animate-pulse mr-1" />
                    <span className="text-[15px] font-light leading-[15px] text-left group-hover:text-black">
                      Online
                    </span>
                  </div>
                );
              }

              if (diffInMinutes < 60) {
                return (
                  <span className="text-[12px] font-light leading-[16px] text-left">
                    {diffInMinutes}分前
                  </span>
                );
              } else if (diffInMinutes < 1440) {
                const hours = Math.floor(diffInMinutes / 60);
                return (
                  <span className="text-[12px] font-light leading-[16px] text-left">
                    {hours}時間前
                  </span>
                );
              } else {
                const days = Math.floor(diffInMinutes / 1440);
                return (
                  <span className="text-[12px] font-light leading-[16px] text-left">
                    {days}日前
                  </span>
                );
              }
            })()}
          </div>
          <div className="flex gap-2">
            <BorderDash
              imageSrc={"/x-white.svg"}
              alt="X"
              width={24}
              height={24}
              className="w-12 h-12"
            />
            <BorderDash
              imageSrc={"/instagram-white.svg"}
              alt="Instagram"
              width={24}
              height={24}
              className="w-12 h-12"
            />
          </div>
        </div>
        <div>
          {data?.getUserProfile?.shortNote && (
            <span
              className={`px-3 py-1 text-white rounded-full text-sm transition-colors`}
            >
              {data?.getUserProfile?.shortNote}
            </span>
          )}
        </div>
        <div className="flex items-center gap-2">
          <Popover>
            <PopoverTrigger>
              <BorderDash
                imageSrc={"/share.svg"}
                alt="share"
                width={24}
                height={24}
                className="w-12 h-12"
              />
            </PopoverTrigger>
            <PopoverContent className="p-1">
              <button
                onClick={async () => {
                  await navigator.clipboard.writeText(window.location.href);
                  setShowCopied(true);
                  setTimeout(() => setShowCopied(false), 2000);
                }}
                className="w-full px-3 py-2 text-sm text-left hover:bg-gray-100 hover:text-black rounded flex items-center gap-2"
              >
                {showCopied ? (
                  <>
                    <Check className="w-4 h-4 text-green-500" />
                    <span>{t("common.copied")}</span>
                  </>
                ) : (
                  <>
                    <Copy className="w-4 h-4" />
                    <span>{t("common.copy-url")}</span>
                  </>
                )}
              </button>
            </PopoverContent>
          </Popover>

          {isOwnProfile ? (
            <Popover>
              <PopoverTrigger>
                <BorderDash
                  imageSrc={"/more-horizontal.svg"}
                  alt="edit"
                  width={24}
                  height={24}
                  className="w-12 h-12"
                />
              </PopoverTrigger>
              <PopoverContent className="p-1">
                <button
                  onClick={handleEditProfile}
                  className="w-full px-3 py-2 text-sm text-left hover:bg-gray-100 hover:text-black rounded flex items-center gap-2"
                >
                  <Pencil className="w-4 h-4" />
                  <span>{t("common.edit-profile")}</span>
                </button>
              </PopoverContent>
            </Popover>
          ) : (
            <Popover>
              <PopoverTrigger>
                <BorderDash
                  imageSrc={"/mail.svg"}
                  alt="mail"
                  width={24}
                  height={24}
                  className="w-12 h-12"
                />
              </PopoverTrigger>
              <PopoverContent className="p-1">
                <button
                  onClick={handleMessageClick}
                  className="w-full px-3 py-2 text-sm text-left hover:bg-gray-100 hover:text-black rounded flex items-center gap-2"
                >
                  <MessageSquare className="w-4 h-4" />
                  <span>{t("common.send-message")}</span>
                </button>
              </PopoverContent>
            </Popover>
          )}
        </div>
      </div>

      <div className="p-6 space-y-12">
        <div className="space-y-4">
          <div className="">
            <p
              className={`${NotoSansJP.className} text-[14px] font-[350] leading-[24px] text-left`}
            >
              {data?.getUserProfile?.greeting}
            </p>
          </div>
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />

        <div className="grid grid-cols-3 gap-8">
          <Skill title="スキル" skill={data?.getUserProfile?.skill} />
          <Category title="属性" category={data?.getUserProfile?.category} />
          <Offers
            title={"興味のあるオファー"}
            offers={
              data?.getUserProfile?.interestOffer
                ? [data?.getUserProfile?.interestOffer]
                : []
            }
          />
        </div>

        <Separator className="w-full border border-dashed border-[#505050]" />

        <div className="grid grid-cols-3 ">
          {/* 
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
          */}

          <div>
            <List
              title="所属するArtists"
              lists={
                data?.getUserProfile?.belongsToArtists?.map((artist: any) => ({
                  title: artist,
                  role: "",
                })) ?? []
              }
            />
          </div>
        </div>

        {/* Social Links 
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
        */}

        <Separator className="w-full border border-dashed border-[#505050]" />

        {/* Works 
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
        */}

        <div className="grid grid-cols-2 gap-10">
          {data?.getUserProfile?.offers?.map((offer: any, index: number) => (
            <OfferCard key={index} {...offer} />
          ))}
        </div>

        {communityData?.getOtherUserCommunity?.community && (
          <CommunityMap
            items={communityData.getOtherUserCommunity.community}
            center_user_image={data?.getUserProfile?.imageUrl}
            center_user_name={data?.getUserProfile?.name}
            center_user_category={data?.getUserProfile?.category}
          />
        )}
      </div>
    </div>
  );
}
