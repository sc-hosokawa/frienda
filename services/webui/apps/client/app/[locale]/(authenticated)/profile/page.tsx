"use client";

import { useState, useEffect, FormEvent } from "react";
import { useRouter } from "next/navigation";
import Image from "next/image";
import { gql, useMutation, useQuery } from "@apollo/client";
import {
  getStorage,
  ref,
  uploadBytes,
  getDownloadURL,
  deleteObject,
} from "firebase/storage";
import useUserStore from "~/store/user";
import { useTranslation } from "~/i18n/client";
import { isAddress } from "ethers";

const GET_USER_DATA = gql`
  query GetUserData($userId: String!) {
    getUserData(userId: $userId) {
      id
      name
      imageUrl
      realname
      email
      evmAddr
      role
      primaryRole
      greeting
      skill
      xHandle
      instagramHandle
      fbHandle
      interestOffer
      createdAt
      belongsToArtists {
        id
        name
        imageUrl
      }
      primaryArtist {
        id
        name
        imageUrl
      }
    }
  }
`;

const UPDATE_USER_DATA = gql`
  mutation UpdateUserData(
    $id: String!
    $name: String
    $imageUrl: String
    $greeting: String
    $skill: String
    $xHandle: String
    $instagramHandle: String
    $fbHandle: String
    $role: String
    $primaryRole: String
    $interestOffer: String
    $evmAddr: String
  ) {
    updateUserData(
      input: {
        id: $id
        name: $name
        imageUrl: $imageUrl
        greeting: $greeting
        skill: $skill
        xHandle: $xHandle
        instagramHandle: $instagramHandle
        fbHandle: $fbHandle
        role: $role
        primaryRole: $primaryRole
        interestOffer: $interestOffer
        evmAddr: $evmAddr
      }
    ) {
      userInfo {
        id
        name
        imageUrl
        fspBalance
        credentialBalance
        evmAddr
        role
        primaryRole
        greeting
        skill
        xHandle
        instagramHandle
        fbHandle
        interestOffer
        createdAt
        belongsToArtists {
          id
          artistId
          name
          imageUrl
          fsp
          status
          isAdmin
        }
        primaryArtist {
          id
          artistId
          name
          imageUrl
          fsp
          status
          isAdmin
        }
      }
    }
  }
`;

export default function SettingPage() {
  const { t } = useTranslation();
  const { user, updateUser } = useUserStore();
  const router = useRouter();
  const [formData, setFormData] = useState({
    name: "",
    greeting: "",
    skill: "",
    xHandle: "",
    instagramHandle: "",
    fbHandle: "",
    role: "",
    primaryRole: "",
    interestOffer: "",
    evmAddr: "",
  });
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [currentImageUrl, setCurrentImageUrl] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isDirty, setIsDirty] = useState(false);

  const userId = user?.id;

  const { data: userData, loading: userDataLoading } = useQuery(GET_USER_DATA, {
    variables: { userId },
    skip: !userId,
  });

  const [updateUserData] = useMutation(UPDATE_USER_DATA);

  useEffect(() => {
    if (userData?.getUserData) {
      const user = userData.getUserData;
      setFormData({
        name: user.name || "",
        greeting: user.greeting || "",
        skill: user.skill || "",
        xHandle: user.xHandle || "",
        instagramHandle: user.instagramHandle || "",
        fbHandle: user.fbHandle || "",
        role: user.role || "",
        primaryRole: user.role || "",
        interestOffer: user.interestOffer || "",
        evmAddr: user.evmAddr || "",
      });
      setCurrentImageUrl(user.imageUrl);
    }
  }, [userData]);

  useEffect(() => {
    if (userData?.getUserData) {
      const hasChanges =
        Object.entries(formData).some(
          ([key, value]) => value !== userData.getUserData[key],
        ) || imageFile !== null;
      setIsDirty(hasChanges);
    }
  }, [formData, imageFile, userData]);

  const handleImageUpload = async (file: File) => {
    const storage = getStorage();
    const timestamp = Date.now();
    const filename = `${userId}_${timestamp}.jpg`;
    const storageRef = ref(storage, `user_images/${userId}/${filename}`);

    try {
      const snapshot = await uploadBytes(storageRef, file, {
        contentType: "image/jpeg",
        customMetadata: { userId: userId || "" },
      });
      return await getDownloadURL(snapshot.ref);
    } catch (error) {
      console.error("Image upload failed:", error);
      throw error;
    }
  };

  const deleteOldImage = async (imageUrl: string) => {
    try {
      const storage = getStorage();
      const imageRef = ref(storage, imageUrl);
      await deleteObject(imageRef);
    } catch (error) {
      console.error("Failed to delete old image:", error);
    }
  };

  const handleSubmit = async (e?: FormEvent) => {
    e?.preventDefault();

    // 必須項目のバリデーション
    if (!formData.name || !formData.role || !formData.interestOffer) {
      alert(t("profile.required-fields"));
      return;
    }

    // SNSハンドルのバリデーション
    if (formData.xHandle && !validateSocialHandle(formData.xHandle, "x")) {
      alert(t("profile.invalid-x-handle"));
      return;
    }
    if (
      formData.instagramHandle &&
      !validateSocialHandle(formData.instagramHandle, "instagram")
    ) {
      alert(t("profile.invalid-instagram-handle"));
      return;
    }
    if (
      formData.fbHandle &&
      !validateSocialHandle(formData.fbHandle, "facebook")
    ) {
      alert(t("profile.invalid-facebook-handle"));
      return;
    }

    // EVMアドレスのバリデーション
    if (formData.evmAddr && !validateEvmAddr(formData.evmAddr)) {
      alert(t("profile.invalid-evm-address"));
      return;
    }

    setIsLoading(true);

    try {
      let imageUrl = currentImageUrl;
      if (imageFile) {
        imageUrl = await handleImageUpload(imageFile);
        if (currentImageUrl) {
          await deleteOldImage(currentImageUrl);
        }
      }

      const res = await updateUserData({
        variables: {
          id: userId,
          name: formData.name,
          imageUrl,
          greeting: formData.greeting,
          skill: formData.skill,
          xHandle: formData.xHandle,
          instagramHandle: formData.instagramHandle,
          fbHandle: formData.fbHandle,
          primaryCategory: formData.role,
          interestOffer: formData.interestOffer,
          evmAddr: formData.evmAddr,
        },
      });

      updateUser(res.data.updateUserData.userInfo);
      alert(t("profile.save-success"));
      router.push("/");
    } catch (error) {
      console.error("Profile update failed:", error);
      alert(t("profile.save-error"));
    } finally {
      setIsLoading(false);
    }
  };

  const roles = ["Musician", "Curator", "Creator", "Supporter"];
  const interestOffers = ["Creation", "Event", "Promotion", "Other"];

  // SNSハンドルのバリデーション
  const validateSocialHandle = (
    handle: string,
    platform: "x" | "instagram" | "facebook",
  ) => {
    const patterns = {
      x: /^https:\/\/(www\.)?(x|twitter)\.com\/[a-zA-Z0-9_]{1,15}\/?$/,
      instagram: /^https:\/\/(www\.)?instagram\.com\/[a-zA-Z0-9_.]{1,30}\/?$/,
      facebook: /^https:\/\/(www\.)?facebook\.com\/[a-zA-Z0-9.]{1,50}\/?$/,
    };
    return patterns[platform].test(handle);
  };

  const validateEvmAddr = (evmAddr: string) => {
    return isAddress(evmAddr);
  };

  if (userDataLoading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="bg-black text-white flex-1 mb-16">
      <div className="flex items-center justify-between pt-[115px] border-gray-800">
        <div className="flex items-center gap-2">
          <div className="flex flex-col">
            <h1 className="text-[60px] font-light tracking-tight leading-none mb-16">
              Edit Profile
            </h1>
          </div>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="flex items-center gap-4">
          <label className="block text-sm font-medium w-1/3">
            {t("common.profile-image")}
          </label>
          <div className="w-2/3">
            <div className="relative inline-block">
              <div className="w-[100px] h-[100px] rounded-full overflow-hidden">
                <Image
                  src={
                    imageFile
                      ? URL.createObjectURL(imageFile)
                      : currentImageUrl || "/logo_visualonly.jpg"
                  }
                  alt="Profile"
                  width={100}
                  height={100}
                  className="object-cover"
                />
              </div>
              <label className="absolute bottom-0 right-0 bg-primary p-2 rounded-full cursor-pointer">
                <input
                  type="file"
                  className="hidden"
                  accept="image/*"
                  onChange={(e) =>
                    e.target.files?.[0] && setImageFile(e.target.files[0])
                  }
                />
                <svg
                  className="w-5 h-5 text-black"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"
                  />
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                </svg>
              </label>
            </div>
          </div>
        </div>

        <div className="space-y-4 mx-auto">
          {Object.entries(formData).map(([key, value]) => {
            if (key === "evmAddr") return null;
            // 役割と興味のあるオファーは特別な処理
            if (key === "role" || key === "interestOffer") {
              const options = key === "role" ? roles : interestOffers;
              return (
                <div key={key} className="flex items-center gap-4">
                  <label className="block text-sm font-medium w-1/3">
                    {key === "role"
                      ? t("common.role")
                      : t("common.interested-offer")}
                    <span className="text-red-500 ml-1">*</span>
                  </label>
                  <div className="flex flex-wrap gap-2 w-2/3">
                    {options.map((option) => (
                      <button
                        key={option}
                        type="button"
                        onClick={() =>
                          setFormData((prev) => ({ ...prev, [key]: option }))
                        }
                        className={`h-[48px] w-[180px] rounded-full text-[18px] transition-colors my-4 ${
                          value === option
                            ? "bg-white text-black"
                            : "bg-black text-white border-dashed border border-white hover:bg-gray-100 hover:text-black"
                        }`}
                      >
                        {option}
                      </button>
                    ))}
                  </div>
                </div>
              );
            }

            // その他のフィールドは既存の処理を維持
            if (key !== "primaryRole") {
              // primaryRoleは除外
              return (
                <div key={key} className="flex items-center gap-4">
                  <label className="block text-sm font-medium w-1/3">
                    {key === "name"
                      ? t("common.username")
                      : key === "greeting"
                        ? t("common.self-introduction")
                        : key === "skill"
                          ? t("common.skill")
                          : key === "xHandle"
                            ? "X (Twitter)"
                            : key === "instagramHandle"
                              ? "Instagram"
                              : key === "fbHandle"
                                ? "Facebook"
                                : key}
                    {key === "name" && (
                      <span className="text-red-500 ml-1">*</span>
                    )}
                  </label>
                  <textarea
                    value={value}
                    onChange={(e) =>
                      setFormData((prev) => ({
                        ...prev,
                        [key]: e.target.value,
                      }))
                    }
                    placeholder={
                      key === "name"
                        ? t("profile.enter-username")
                        : key === "greeting"
                          ? t("profile.enter-self-introduction")
                          : key === "skill"
                            ? t("profile.enter-skill")
                            : key === "xHandle"
                              ? `${t("profile.enter-profile-url")}https://x.com/username`
                              : key === "instagramHandle"
                                ? `${t("profile.enter-profile-url")}https://instagram.com/username`
                                : key === "fbHandle"
                                  ? `${t("profile.enter-profile-url")}https://facebook.com/username`
                                  : key === "role"
                                    ? t("profile.enter-role")
                                    : key === "primaryRole"
                                      ? t("profile.enter-primary-role")
                                      : key === "interestOffer"
                                        ? t("profile.enter-interested-offer")
                                        : ""
                    }
                    className={`mt-1 block w-2/3 ${
                      key === "xHandle" ||
                      key === "instagramHandle" ||
                      key === "fbHandle"
                        ? "h-[48px]"
                        : "h-[90px]"
                    } rounded-2xl border border-white/50 bg-black text-white placeholder-gray-500 p-3`}
                    required={key === "name"}
                  />
                </div>
              );
            }
            return null;
          })}

          <div className="flex items-center gap-4">
            <label className="block text-sm font-medium w-1/3">
              {t("common.evm-address")}
            </label>
            <div className="relative w-2/3">
              <textarea
                value={formData.evmAddr}
                onChange={(e) =>
                  setFormData((prev) => ({
                    ...prev,
                    evmAddr: e.target.value,
                  }))
                }
                placeholder={t("profile.enter-evm-address")}
                className="mt-1 block w-full h-[48px] rounded-2xl border border-white/50 bg-black text-white placeholder-gray-500 p-3"
              />
              {formData.evmAddr && validateEvmAddr(formData.evmAddr) && (
                <div className="absolute top-1/2 -translate-y-1/2 right-4">
                  <svg
                    className="w-6 h-6 text-green-500"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M5 13l4 4L19 7"
                    />
                  </svg>
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="flex justify-end mt-8">
          <button
            type="submit"
            disabled={!isDirty || isLoading}
            className="h-[48px] w-[180px] rounded-full text-[18px] transition-colors bg-[#E4DBC0] hover:bg-gray-100 text-black border border-white hover:text-black disabled:opacity-50 text-sm"
          >
            {isLoading ? t("common.updating...") : t("profile.update-profile")}
          </button>
        </div>
      </form>
    </div>
  );
}
