"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@ui/components/ui/tabs";
import { PlusCircle, X } from "lucide-react";
import useUserStore from "~/store/user";
import { gql, useMutation, useQuery } from "@apollo/client";
import { useTranslation } from "~/i18n/client";

interface CreditFormData {
  role: string;
  name: string;
  email: string;
}

interface CreditFormDataWithId extends CreditFormData {
  id: number;
}

interface CreditDialogProps {
  isrc: string;
  trackName: string;
  artistId: string;
  onSubmit?: (credits: CreditFormData[]) => void;
}

const REGISTER_CREDIT = gql`
  mutation RegisterCredit($input: RegisterCreditInput!) {
    registerCredit(input: $input) {
      isSuccess
    }
  }
`;

const UPDATE_CREDIT = gql`
  mutation UpdateCredit($input: UpdateCreditInput!) {
    updateCredit(input: $input) {
      isSuccess
    }
  }
`;

const DELETE_CREDIT = gql`
  mutation DeleteCredit($input: DeleteCreditInput!) {
    deleteCredit(input: $input) {
      isSuccess
    }
  }
`;

const GET_CREDITS = gql`
  query GetCredits($userId: String!, $artistId: String!, $isrc: String!) {
    getCredits(userId: $userId, artistId: $artistId, isrc: $isrc) {
      id
      creditRole
      creditName
      email
    }
  }
`;

export function CreditDialog({
  isrc,
  trackName,
  artistId,
  onSubmit,
}: CreditDialogProps) {
  const { t } = useTranslation();
  const [open, setOpen] = useState(false);
  const [newCredits, setNewCredits] = useState<CreditFormData[]>([
    { role: "", name: "", email: "" },
  ]);
  const [existingCredits, setExistingCredits] = useState<
    CreditFormDataWithId[]
  >([]);
  const { user } = useUserStore();
  const [loadingStates, setLoadingStates] = useState<{
    [key: string]: boolean;
  }>({});

  const [registerCredit] = useMutation(REGISTER_CREDIT);
  const [updateCredit] = useMutation(UPDATE_CREDIT);
  const [deleteCredit] = useMutation(DELETE_CREDIT);

  const { data: creditData, refetch } = useQuery(GET_CREDITS, {
    variables: {
      userId: user?.id || "",
      artistId,
      isrc,
    },
    skip: !open,
    fetchPolicy: "network-only",
  });

  const handleOpenChange = async (isOpen: boolean) => {
    setOpen(isOpen);
    if (isOpen) {
      const { data } = await refetch();
      if (data?.getCredits) {
        const credits = data.getCredits.map((credit: any) => ({
          id: credit.id,
          role: credit.creditRole,
          name: credit.creditName,
          email: credit.email,
        }));
        setExistingCredits(credits);
      }
    }
  };

  const handleCreditChange = (index: number, field: string, value: string) => {
    const credits = [...newCredits];
    const targetCredit = credits[index];

    if (targetCredit && field in targetCredit) {
      targetCredit[field as keyof CreditFormData] = value;
      setNewCredits(credits);
    } else {
      console.warn(`Credit at index ${index} or field ${field} not found`);
    }
  };

  const addNewCreditForm = () => {
    setNewCredits([...newCredits, { role: "", name: "", email: "" }]);
  };

  const removeNewCreditForm = (index: number) => {
    if (newCredits.length > 1) {
      const credits = newCredits.filter((_, i) => i !== index);
      setNewCredits(credits);
    }
  };

  const handleBulkSubmit = async () => {
    try {
      const registerInfo = newCredits.map((credit) => ({
        isrc,
        commitUser: user?.id || "",
        creditRole: credit.role,
        creditName: credit.name,
        email: credit.email,
        isInvite: true,
        memo: "",
      }));

      const result = await registerCredit({
        variables: {
          input: {
            registerInfo,
          },
        },
      });

      const { data } = await refetch();
      if (data?.getCredits) {
        const credits = data.getCredits.map((credit: any) => ({
          id: credit.id,
          role: credit.creditRole,
          name: credit.creditName,
          email: credit.email,
        }));
        setExistingCredits(credits);
      }

      setNewCredits([{ role: "", name: "", email: "" }]);
    } catch (error) {
      console.error("Failed to register credits:", error);
    }
  };

  const setLoading = (id: string, isLoading: boolean) => {
    setLoadingStates((prev) => ({ ...prev, [id]: isLoading }));
  };

  const handleExistingCreditUpdate = async (
    index: number,
    updatedCredit: CreditFormDataWithId,
  ) => {
    const loadingId = `update-${updatedCredit.id}`;
    setLoading(loadingId, true);
    try {
      await updateCredit({
        variables: {
          input: {
            creditId: updatedCredit.id,
            commitUser: user?.id || "",
            creditRole: updatedCredit.role,
            creditName: updatedCredit.name,
            email: updatedCredit.email,
          },
        },
      });
      const updatedCredits = [...existingCredits];
      updatedCredits[index] = updatedCredit;
      setExistingCredits(updatedCredits);
    } catch (error) {
      console.error("Failed to update credit:", error);
    } finally {
      setLoading(loadingId, false);
    }
  };

  const handleCreditDelete = async (index: number, creditId: number) => {
    const loadingId = `delete-${creditId}`;
    setLoading(loadingId, true);
    try {
      await deleteCredit({
        variables: {
          input: {
            creditId: creditId,
          },
        },
      });
      const updatedCredits = existingCredits.filter((_, i) => i !== index);
      setExistingCredits(updatedCredits);
    } catch (error) {
      console.error("Failed to delete credit:", error);
    } finally {
      setLoading(loadingId, false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button variant="outline">{t("common.edit-credit")}</Button>
      </DialogTrigger>
      <DialogContent className="w-4/5 max-w-4xl max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>
            {t("common.enter-credit")}: {trackName}
          </DialogTitle>
        </DialogHeader>

        <Tabs defaultValue="new">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="new">{t("common.new-credit")}</TabsTrigger>
            <TabsTrigger value="edit">{t("common.edit-credit")}</TabsTrigger>
          </TabsList>

          <TabsContent value="new" className="space-y-4">
            {newCredits.map((credit, index) => (
              <div key={index} className="flex items-end space-x-4">
                <div className="flex-1 space-y-2">
                  <Label htmlFor={`new-role-${index}`}>
                    {t("common.role")}
                  </Label>
                  <Input
                    id={`new-role-${index}`}
                    value={credit.role}
                    className="border-white"
                    onChange={(e) =>
                      handleCreditChange(index, "role", e.target.value)
                    }
                  />
                </div>
                <div className="flex-1 space-y-2">
                  <Label htmlFor={`new-name-${index}`}>
                    {t("common.name")}
                  </Label>
                  <Input
                    id={`new-name-${index}`}
                    value={credit.name}
                    className="border-white"
                    onChange={(e) =>
                      handleCreditChange(index, "name", e.target.value)
                    }
                  />
                </div>
                <div className="flex-1 space-y-2">
                  <Label htmlFor={`new-email-${index}`}>Email</Label>
                  <Input
                    id={`new-email-${index}`}
                    type="email"
                    value={credit.email}
                    className="border-white"
                    onChange={(e) =>
                      handleCreditChange(index, "email", e.target.value)
                    }
                  />
                </div>
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => removeNewCreditForm(index)}
                  disabled={newCredits.length === 1}
                >
                  <X className="h-4 w-4" />
                </Button>
              </div>
            ))}
            <div className="flex justify-end space-x-2">
              <Button onClick={addNewCreditForm} variant="outline">
                <PlusCircle className="h-4 w-4 mr-2" />
                {t("common.add-form")}
              </Button>
            </div>
            <Button onClick={handleBulkSubmit} className="w-full">
              {t("common.register-all")}
            </Button>
          </TabsContent>

          <TabsContent value="edit" className="space-y-4">
            {existingCredits.length === 0 ? (
              <div className="text-center py-4">
                {t("common.no-credits-yet")}
              </div>
            ) : (
              existingCredits.map((credit, index) => (
                <div
                  key={index}
                  className="flex items-end space-x-4 border p-4 rounded"
                >
                  <div className="flex-1 space-y-2">
                    <Label>{t("common.role")}</Label>
                    <Input
                      value={credit.role}
                      className="border-white"
                      onChange={(e) => {
                        const updatedCredits = [...existingCredits];
                        updatedCredits[index]!.role = e.target.value;
                        setExistingCredits(updatedCredits);
                      }}
                    />
                  </div>
                  <div className="flex-1 space-y-2">
                    <Label>{t("common.name")}</Label>
                    <Input
                      value={credit.name}
                      className="border-white"
                      onChange={(e) => {
                        const updatedCredits = [...existingCredits];
                        updatedCredits[index]!.name = e.target.value;
                        setExistingCredits(updatedCredits);
                      }}
                    />
                  </div>
                  <div className="flex-1 space-y-2">
                    <Label>Email</Label>
                    <Input
                      type="email"
                      value={credit.email}
                      className="border-white"
                      onChange={(e) => {
                        const updatedCredits = [...existingCredits];
                        updatedCredits[index]!.email = e.target.value;
                        setExistingCredits(updatedCredits);
                      }}
                    />
                  </div>
                  <div className="flex space-x-2 self-end">
                    <Button
                      className="border-white"
                      variant="outline"
                      disabled={loadingStates[`update-${credit.id}`]}
                      onClick={() => handleExistingCreditUpdate(index, credit)}
                    >
                      {loadingStates[`update-${credit.id}`] ? (
                        <span className="animate-spin">⟳</span>
                      ) : (
                        t("common.update")
                      )}
                    </Button>
                    <Button
                      variant="destructive"
                      disabled={loadingStates[`delete-${credit.id}`]}
                      onClick={() => handleCreditDelete(index, credit.id)}
                    >
                      {loadingStates[`delete-${credit.id}`] ? (
                        <span className="animate-spin">⟳</span>
                      ) : (
                        t("common.delete")
                      )}
                    </Button>
                  </div>
                </div>
              ))
            )}
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
}
