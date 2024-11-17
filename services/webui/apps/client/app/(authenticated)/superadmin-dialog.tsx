"use client";

import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@ui/components/ui/dialog";
import { useQuery, useMutation, gql } from "@apollo/client";
import { Button } from "@ui/components/ui/button";
import { ScrollArea } from "@ui/components/ui/scroll-area";
import { Check, X, ShieldCheck } from "lucide-react";
import useUserStore from "../../store/user";
import { useState } from "react";

const GET_PENDING_MEMBERS = gql`
  query GetPendingMembers($userId: String!) {
    getAllPendingMembers(userId: $userId) {
      member {
        id
        name
        realname
        email
        imageUrl
      }
      artistName
      artistId
    }
  }
`;

const MARK_AS_MEMBER = gql`
  mutation MarkAsMember($input: MarkAsMemberInput!) {
    markAsMember(input: $input) {
      checkedUserId
    }
  }
`;

const MARK_AS_ADMIN = gql`
  mutation MarkAsAdmin($input: MarkAsAdminInput!) {
    markAsAdmin(input: $input) {
      checkedUserId
    }
  }
`;

type PendingMember = {
  member: {
    id: string;
    name: string;
    realname: string;
    email: string;
    imageUrl?: string;
  };
  artistName: string;
  artistId: string;
};

export default function SuperAdminDialog() {
  const [open, setOpen] = useState(false);
  const { user } = useUserStore();

  const { data, loading, error, refetch } = useQuery(GET_PENDING_MEMBERS, {
    variables: { userId: user?.id },
    skip: !user?.id,
  });

  const [markAsMember] = useMutation(MARK_AS_MEMBER, {
    onCompleted: () => {
      refetch();
    },
  });

  const [markAsAdmin] = useMutation(MARK_AS_ADMIN, {
    onCompleted: () => {
      refetch();
    },
  });

  const handleApprove = async (memberId: string, artistName: string) => {
    try {
      await markAsMember({
        variables: {
          input: {
            member: user?.id,
            artistId: artistName,
            mapping: [
              {
                userId: memberId,
                status: "Accept",
              },
            ],
          },
        },
      });
    } catch (error) {
      console.error("Error approving member:", error);
    }
  };

  const handleAdminApprove = async (memberId: string, artistName: string) => {
    try {
      await markAsAdmin({
        variables: {
          input: {
            adminMember: user?.id,
            userId: memberId,
            artistId: artistName,
          },
        },
      });
    } catch (error) {
      console.error("Error approving admin:", error);
    }
  };

  const handleDeny = async (memberId: string, artistName: string) => {
    try {
      await markAsMember({
        variables: {
          input: {
            member: user?.id,
            artistId: artistName,
            mapping: [
              {
                userId: memberId,
                status: "Reject",
              },
            ],
          },
        },
      });
    } catch (error) {
      console.error("Error denying member:", error);
    }
  };

  if (loading) return null;
  if (error) return null;

  console.log(data?.getAllPendingMembers);

  return (
    <>
      {user?.isSuperAdmin && (
        <Button onClick={() => setOpen(true)} variant="outline" className="">
          <ShieldCheck className="mr-4 h-4 w-4" />
          管理者専用
        </Button>
      )}
      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="w-4/5 max-w-5xl h-[80vh] max-h-[80vh] flex flex-col p-0 gap-0">
          <DialogHeader className="p-6 pb-2">
            <DialogTitle>アクセス権限リクエスト一覧</DialogTitle>
          </DialogHeader>
          <ScrollArea className="flex-grow p-6">
            <div className="space-y-4">
              {data?.getAllPendingMembers?.length === 0 ? (
                <div className="text-center text-muted-foreground py-8">
                  処理すべきリクエストはありません
                </div>
              ) : (
                data?.getAllPendingMembers?.map((item: PendingMember) => (
                  <div
                    key={item.member.id}
                    className="flex items-center justify-between bg-secondary p-4 rounded-lg"
                  >
                    <div>
                      <h3 className="font-semibold">{item.member.name}</h3>
                    </div>
                    <div className="flex flex-col gap-1">
                      <p className="text-muted-foreground">
                        {item.member.realname}
                      </p>
                      <p className="text-muted-foreground">
                        {item.member.email}
                      </p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">{item.artistName}</p>
                    </div>
                    <div className="space-x-2">
                      <Button
                        onClick={() =>
                          handleApprove(item.member.id, item.artistId)
                        }
                        size="sm"
                        className="bg-green-500 hover:bg-green-600"
                      >
                        <Check className="mr-2 h-4 w-4" />
                        許可
                      </Button>
                      <Button
                        onClick={() =>
                          handleAdminApprove(item.member.id, item.artistId)
                        }
                        size="sm"
                        className="bg-blue-500 hover:bg-blue-600"
                      >
                        <Check className="mr-2 h-4 w-4" />
                        管理者として許可
                      </Button>
                      <Button
                        onClick={() =>
                          handleDeny(item.member.id, item.artistId)
                        }
                        size="sm"
                        variant="destructive"
                      >
                        <X className="mr-2 h-4 w-4" />
                        拒否
                      </Button>
                    </div>
                  </div>
                ))
              )}
            </div>
          </ScrollArea>
        </DialogContent>
      </Dialog>
    </>
  );
}
