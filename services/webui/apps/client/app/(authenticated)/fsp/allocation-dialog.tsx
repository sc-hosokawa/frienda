"use client";

import { useState, useEffect } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { Share2, User, ArrowLeft } from "lucide-react";
import { Input } from "@ui/components/ui/input";
import { Avatar, AvatarImage, AvatarFallback } from "@ui/components/ui/avatar";
import useUserStore from "../../../store/user";
import { useQuery, useMutation, gql } from "@apollo/client";

interface Artist {
  artistId: string;
  name: string;
  imageUrl?: string;
  fsp: number;
}

interface Member {
  id: string;
  name: string;
  imageUrl?: string;
  fsp: number;
}

const GET_MEMBERS = gql`
  query GetMembers($artistId: String!) {
    getMembersJoinedToArtist(artistId: $artistId) {
      id
      name
      imageUrl
    }
  }
`;

const CREATE_BULK_FSP_TX = gql`
  mutation CreateBulkFspTx($input: [CreateNewTransactionInput!]!) {
    createBulkFspTx(input: $input) {
      txId
    }
  }
`;

const GET_USER_POINT_BALANCE = gql`
  query GetUserPointBalance($userId: String!) {
    getUserPointBalance(userId: $userId) {
      fspBalance
    }
  }
`;

export function AllocationDialog() {
  const { user, updateBalance, updateUser } = useUserStore();
  const [selectedArtist, setSelectedArtist] = useState<Artist | null>(null);
  const [members, setMembers] = useState<Member[]>([]);
  const [allocatedPoints, setAllocatedPoints] = useState<{
    [key: string]: number;
  }>({});
  const [showConfirmation, setShowConfirmation] = useState(false);

  const [createBulkFspTx] = useMutation(CREATE_BULK_FSP_TX);

  // クエリフックを追加
  const { refetch } = useQuery(GET_USER_POINT_BALANCE, {
    variables: { userId: user?.id },
    skip: !user?.id,
    onCompleted: (data) => {
      updateBalance(data.getUserPointBalance.fspBalance);
    },
  });

  const { refetch: refetchUser } = useQuery(GET_USER_DATA, {
    variables: { userId: user?.id },
    skip: !user?.id,
    onCompleted: (data) => {
      updateUser(data.getUserData);
    },
  });

  const {
    loading: membersLoading,
    error: membersError,
    data: membersData,
  } = useQuery(GET_MEMBERS, {
    variables: { artistId: selectedArtist?.artistId },
    skip: !selectedArtist,
  });

  // アーティスト選択時にメンバーリストを更新
  useEffect(() => {
    if (selectedArtist && membersData) {
      const fetchedMembers = membersData.getMembersJoinedToArtist.map(
        (member: any) => ({
          id: member.id,
          name: member.name,
          imageUrl: member.imageUrl,
          fsp: 0,
        }),
      );
      setMembers(fetchedMembers);
      // 新しいメンバーリストに基づいて配分ポイントをリセット
      setAllocatedPoints({});
    }
  }, [selectedArtist, membersData]);

  const handlePointsChange = (memberId: string, points: number) => {
    if (points < 0) return;

    const currentPoints = allocatedPoints[memberId] || 0;
    const totalAllocated =
      Object.values(allocatedPoints).reduce((a, b) => a + b, 0) -
      currentPoints +
      points;

    if (selectedArtist && totalAllocated <= selectedArtist.fsp) {
      setAllocatedPoints((prev) => ({
        ...prev,
        [memberId]: points,
      }));
    }
  };

  const handleConfirm = async () => {
    try {
      // 分配データを CreateNewTransactionInput の配列に変換
      console.log(`selectedArtist: ${selectedArtist?.artistId}`);
      const transactions = Object.entries(allocatedPoints)
        .filter(([_, amount]) => amount > 0) // 0以上のポイントのみを送信
        .map(([memberId, amount]) => ({
          from: selectedArtist?.artistId,
          amount,
          to: memberId,
          note: `FSP allocation from ${selectedArtist?.name}`,
        }));

      // ミューテーションを実行
      await createBulkFspTx({
        variables: {
          input: transactions,
        },
      });

      console.log("ポイント分配完了:", allocatedPoints);

      console.log("refetch");
      const { data: newBalance } = await refetch();
      const { data: newUser } = await refetchUser();
      console.log("newBalance", newBalance);
      updateBalance(newBalance.getUserPointBalance.fspBalance);
      updateUser(newUser.getUserData);

      setShowConfirmation(false);
      setAllocatedPoints({});
      setSelectedArtist(null);
    } catch (error) {
      console.error("Failed to allocate points:", error);
      // TODO: エラー処理を追加（例：トースト通知など）
    }
  };

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button className="w-full">
          <Share2 className="mr-2 h-4 w-4" />
          分配
        </Button>
      </DialogTrigger>
      <DialogContent className="w-4/5 h-4/5 max-w-none">
        <DialogHeader>
          <div className="flex items-center">
            {(selectedArtist || showConfirmation) && (
              <Button
                variant="ghost"
                size="icon"
                className="mr-2"
                onClick={() => {
                  if (showConfirmation) {
                    setShowConfirmation(false);
                  } else {
                    setSelectedArtist(null);
                    setAllocatedPoints({});
                  }
                }}
              >
                <ArrowLeft className="h-4 w-4" />
              </Button>
            )}
            <DialogTitle className="font-light">
              {showConfirmation
                ? "確認"
                : selectedArtist
                  ? `${selectedArtist.name}のメンバー`
                  : "アーティスト選択"}
            </DialogTitle>
          </div>
        </DialogHeader>

        <div className="flex-1 overflow-auto p-4">
          {!showConfirmation ? (
            !selectedArtist ? (
              // アーティスト選択画面
              <div className="space-y-2">
                {!user?.belongsToArtists?.length ? (
                  <div className="text-center text-gray-500 py-8">
                    選択できるアーティストがありません。
                  </div>
                ) : (
                  user.belongsToArtists.map((artist) => (
                    <div
                      key={artist.artistId}
                      className="flex items-center justify-between p-2 hover:bg-gray-100 hover:text-black cursor-pointer"
                      onClick={() => setSelectedArtist(artist)}
                    >
                      <div className="flex items-center gap-3">
                        <span>{artist.name}</span>
                      </div>
                      <span>{artist.fsp.toLocaleString()} ポイント</span>
                    </div>
                  ))
                )}
              </div>
            ) : (
              // メンバー一覧と分配画面
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span>分配可能なFSP: {selectedArtist.fsp}</span>
                  <Button onClick={() => setShowConfirmation(true)}>
                    送付
                  </Button>
                </div>
                {membersLoading ? (
                  <div className="flex justify-center">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900" />
                  </div>
                ) : membersError ? (
                  <div className="text-center text-red-500">
                    メンバー一覧の取得に失敗しました
                  </div>
                ) : members.length === 0 ? (
                  <div className="text-center text-gray-500 py-8">
                    No member you can allocate FSP.
                  </div>
                ) : (
                  <div className="space-y-2">
                    {members.map((member) => (
                      <div
                        key={member.id}
                        className="flex items-center justify-between p-2"
                      >
                        <span>{member.name}</span>
                        <Input
                          type="number"
                          min="0"
                          className="w-24"
                          value={allocatedPoints[member.id] ?? ""}
                          onChange={(e) =>
                            handlePointsChange(
                              member.id,
                              parseInt(e.target.value) || 0,
                            )
                          }
                        />
                      </div>
                    ))}
                  </div>
                )}
                <div className="text-right">
                  残りポイント:{" "}
                  {selectedArtist.fsp -
                    Object.values(allocatedPoints).reduce((a, b) => a + b, 0)}
                </div>
              </div>
            )
          ) : (
            // 確認画面
            <div className="space-y-4">
              {members.map((member) => (
                <div key={member.id} className="flex justify-between p-2">
                  <span>{member.name}</span>
                  <span>{allocatedPoints[member.id] || 0} ポイント</span>
                </div>
              ))}
              <Button className="w-full" onClick={handleConfirm}>
                確定する
              </Button>
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}

// GraphQLクエリの定義
const GET_USER_DATA = gql`
  query GetUserData($userId: String!) {
    getUserData(userId: $userId) {
      id
      name
      imageUrl
      realname
      isSuperAdmin
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
`;
