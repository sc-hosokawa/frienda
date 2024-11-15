"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";
import {
  Tabs,
  TabsList,
  TabsTrigger,
  TabsContent,
} from "@ui/components/ui/tabs";
import { Button } from "@ui/components/ui/button";
import { ScrollArea } from "@ui/components/ui/scroll-area";
import { Check, Settings, X } from "lucide-react";
import useUserStore from "../../store/user";
import { gql, useQuery, useMutation } from "@apollo/client";

const MARK_AS_MEMBER = gql`
  mutation MarkAsMember($input: MarkAsMemberInput!) {
    markAsMember(input: $input) {
      checkedUserId
    }
  }
`;

const GET_MEMBERS_BELONGED = gql`
  query GetMembersBelonged($artistId: String!, $userId: String) {
    getMembersBelongedToArtist(artistId: $artistId, userId: $userId) {
      id
      name
      realname
      imageUrl
    }
  }
`;

function AccessControlDialog() {
  const { user } = useUserStore();
  const [isOpen, setIsOpen] = useState(false);
  const [selectedArtist, setSelectedArtist] = useState<string>(
    user?.belongsToArtists[0]?.artistId || "",
  );
  console.log(`user?.isSuperAdmin: ${user?.isSuperAdmin}`);

  const { data, loading, error, refetch } = useQuery(GET_MEMBERS_BELONGED, {
    variables: {
      artistId: selectedArtist,
      userId: user?.id,
    },
    skip: !selectedArtist || !isOpen,
  });

  const [markAsMember] = useMutation(MARK_AS_MEMBER, {
    refetchQueries: [
      {
        query: GET_MEMBERS_BELONGED,
        variables: {
          artistId: selectedArtist,
          userId: user?.id,
        },
      },
    ],
  });

  const handleClose = () => {
    setIsOpen(false);
  };

  const handleApprove = async (userId: string) => {
    console.log(
      `userId: ${userId}, selectedArtist: ${selectedArtist}, "Accept"`,
    );
    try {
      await markAsMember({
        variables: {
          input: {
            member: user?.id,
            artistId: selectedArtist,
            mapping: [
              {
                userId: userId,
                status: "Accept",
              },
            ],
          },
        },
      });
      refetch();
    } catch (error) {
      console.error("Error approving user:", error);
      // ここでエラーハンドリングを実装（例：トースト通知など）
    }
  };

  const handleDeny = async (userId: string) => {
    try {
      console.log(userId, selectedArtist, "Reject");
      await markAsMember({
        variables: {
          input: {
            member: user?.id,
            artistId: selectedArtist,
            mapping: [
              {
                userId: userId,
                status: "Reject",
              },
            ],
          },
        },
      });
      refetch();
    } catch (error) {
      console.error("Error denying user:", error);
      // ここでエラーハンドリングを実装（例：トースト通知など）
    }
  };

  return (
    <>
      <Button onClick={() => setIsOpen(true)} variant="outline" size="sm">
        <Settings className="mr-2 h-4 w-4" />
        アクセス管理
      </Button>

      <Dialog open={isOpen} onOpenChange={handleClose}>
        <DialogContent className="w-4/5 max-w-5xl h-[80vh] max-h-[80vh] flex flex-col p-0 gap-0">
          <DialogHeader className="p-6 pb-2">
            <DialogTitle>アクセスリクエスト管理</DialogTitle>
          </DialogHeader>
          {!user?.belongsToArtists?.length ? (
            <div className="flex items-center justify-center flex-grow p-6">
              <p className="text-muted-foreground">
                アクセス管理できるアーティストがありません
              </p>
            </div>
          ) : (
            <Tabs
              value={selectedArtist}
              onValueChange={setSelectedArtist}
              className="flex flex-col flex-grow overflow-hidden"
            >
              <TabsList className="flex justify-start px-6 pt-2 pb-0 overflow-x-auto">
                {user?.belongsToArtists.map((artist) => (
                  <TabsTrigger
                    key={artist.artistId}
                    value={artist.artistId}
                    className="px-4 py-2 shrink-0"
                  >
                    {artist.name}
                  </TabsTrigger>
                ))}
              </TabsList>
              <div className="flex-grow overflow-hidden p-6 pt-2">
                {user?.belongsToArtists.map((artist) => (
                  <TabsContent
                    key={artist.artistId}
                    value={artist.artistId}
                    className="h-full m-0 overflow-hidden"
                  >
                    {error?.message === "not admin" ? (
                      <div className="flex items-center justify-center flex-grow p-6">
                        <p className="text-muted-foreground mt-24">
                          このアーティストの管理権限がありません
                        </p>
                      </div>
                    ) : (
                      <ScrollArea className="h-full border rounded-md">
                        <div className="p-4 space-y-4">
                          {data?.getMembersBelongedToArtist?.map(
                            (user: {
                              id: string;
                              name: string;
                              realname: string;
                            }) => (
                              <div
                                key={user.id}
                                className="flex items-center justify-between bg-secondary p-4 rounded-lg"
                              >
                                <div>
                                  <h3 className="font-semibold">{user.name}</h3>
                                </div>
                                <div>
                                  <p className="text-muted-foreground">
                                    {user.realname}
                                  </p>
                                </div>
                                <div className="space-x-2">
                                  <>
                                    <Button
                                      onClick={() => handleApprove(user.id)}
                                      size="sm"
                                      className="bg-green-500 hover:bg-green-600"
                                    >
                                      <Check className="mr-2 h-4 w-4" />
                                      許可
                                    </Button>
                                    <Button
                                      onClick={() => handleDeny(user.id)}
                                      size="sm"
                                      variant="destructive"
                                    >
                                      <X className="mr-2 h-4 w-4" />
                                      拒否
                                    </Button>
                                  </>
                                </div>
                              </div>
                            ),
                          )}
                        </div>
                      </ScrollArea>
                    )}
                  </TabsContent>
                ))}
              </div>
            </Tabs>
          )}
        </DialogContent>
      </Dialog>
    </>
  );
}

export default AccessControlDialog;
