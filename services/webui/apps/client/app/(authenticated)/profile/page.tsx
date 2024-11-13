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
import useUserStore from "../../../store/user";

const GET_USER_DATA = gql`
  query GetUserData($userId: String!) {
    getUserData(userId: $userId) {
      id
      name
      imageUrl
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
      }
    ) {
      userInfo {
        id
        name
        imageUrl
        fspBalance
        credentialBalance
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
  const { user, updateUser } = useUserStore();
  const router = useRouter();
  const [formData, setFormData] = useState({
    name: "",
    greeting: "",
    skill: "",
    xHandle: "",
    instagramHandle: "",
    fbHandle: "",
  });
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [currentImageUrl, setCurrentImageUrl] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

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
      });
      setCurrentImageUrl(user.imageUrl);
    }
  }, [userData]);

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

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      let imageUrl = currentImageUrl;
      if (imageFile) {
        imageUrl = await handleImageUpload(imageFile);
        if (currentImageUrl) {
          await deleteOldImage(currentImageUrl);
        }
      }

      console.log(formData);

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
        },
      });

      console.log(res);

      updateUser(res.data.updateUserData.userInfo);

      router.push("/");
    } catch (error) {
      console.error("Profile update failed:", error);
    } finally {
      setIsLoading(false);
    }
  };

  if (userDataLoading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="max-w-2xl mx-auto p-4">
      <h1 className="text-2xl font-bold mb-6">プロフィール編集</h1>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="flex justify-center">
          <div className="relative">
            <div className="w-[100px] h-[100px] rounded-full overflow-hidden">
              <Image
                src={
                  imageFile
                    ? URL.createObjectURL(imageFile)
                    : currentImageUrl || "/default_avatar.png"
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

        <div className="space-y-4">
          {Object.entries(formData).map(([key, value]) => (
            <div key={key}>
              <label className="block text-sm font-medium">
                {key === "name"
                  ? "名前"
                  : key === "greeting"
                    ? "自己紹介"
                    : key === "skill"
                      ? "スキル"
                      : key === "xHandle"
                        ? "X (Twitter)"
                        : key === "instagramHandle"
                          ? "Instagram"
                          : "Facebook"}
              </label>
              <input
                type="text"
                value={value}
                onChange={(e) =>
                  setFormData((prev) => ({ ...prev, [key]: e.target.value }))
                }
                className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary"
                required={key === "name"}
              />
            </div>
          ))}
        </div>

        <button
          type="submit"
          disabled={isLoading}
          className="w-full py-2 px-4 rounded-md hover:bg-white hover:text-black disabled:opacity-50 border border-primary"
        >
          {isLoading ? "更新中..." : "プロフィールを更新"}
        </button>
      </form>
    </div>
  );
}
