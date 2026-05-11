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
import useUserStore from "~/store/user";
import { useState } from "react";
import { useTranslation } from "~/i18n/client";

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
      requestMessage
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
  requestMessage?: string | null;
};

export default function SuperAdminDialog() {
  const [open, setOpen] = useState(false);
  const { t } = useTranslation();
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
          {t("common.only-admin")}
        </Button>
      )}
      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="w-[92vw] max-w-6xl h-[90vh] max-h-[90vh] flex flex-col p-0 gap-0">
          <DialogHeader className="p-6 pb-2">
            <DialogTitle>{t("common.list-of-access-request")}</DialogTitle>
          </DialogHeader>
          <ScrollArea className="flex-grow p-6">
            <div className="space-y-4">
              {data?.getAllPendingMembers?.length === 0 ? (
                <div className="text-center text-muted-foreground py-8">
                  {t("common.no-access-request-to-handle")}
                </div>
              ) : (
                data?.getAllPendingMembers?.map((item: PendingMember) => (
                  <div
                    key={`${item.member.id}-${item.artistId}`}
                    className="grid grid-cols-1 gap-4 bg-secondary p-5 rounded-lg lg:grid-cols-[1.4fr_1.1fr_2fr_auto] lg:items-start"
                  >
                    <div className="flex min-w-0 flex-col gap-1">
                      <h3 className="font-semibold">{item.member.name}</h3>
                      <p className="text-muted-foreground">
                        {item.member.realname}
                      </p>
                      <p className="break-all text-muted-foreground">
                        {item.member.email}
                      </p>
                    </div>
                    <div className="min-w-0">
                      <p className="text-muted-foreground">{item.artistName}</p>
                    </div>
                    <div className="min-w-0">
                      <p className="whitespace-pre-wrap break-words text-sm leading-6">
                        {item.requestMessage || (
                          <span className="text-muted-foreground/60">
                            {t("common.none")}
                          </span>
                        )}
                      </p>
                    </div>
                    <div className="flex flex-col gap-2 lg:items-stretch">
                      <Button
                        onClick={() =>
                          handleApprove(item.member.id, item.artistId)
                        }
                        size="sm"
                        className="bg-green-500 hover:bg-green-600"
                      >
                        <Check className="mr-2 h-4 w-4" />
                        {t("common.admit")}
                      </Button>
                      <Button
                        onClick={() =>
                          handleAdminApprove(item.member.id, item.artistId)
                        }
                        size="sm"
                        className="bg-blue-500 hover:bg-blue-600"
                      >
                        <Check className="mr-2 h-4 w-4" />
                        {t("common.admit-as-admin")}
                      </Button>
                      <Button
                        onClick={() =>
                          handleDeny(item.member.id, item.artistId)
                        }
                        size="sm"
                        variant="destructive"
                      >
                        <X className="mr-2 h-4 w-4" />
                        {t("common.reject")}
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
