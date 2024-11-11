"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { Input } from "@ui/components/ui/input";
import { Label } from "@ui/components/ui/label";
import { PlusCircle, X } from "lucide-react";
import useUserStore from "../../store/user";
import { gql, useMutation } from "@apollo/client";

interface CreditFormData {
  role: string;
  name: string;
  email: string;
}

interface CreditDialogProps {
  isrc: string;
  onSubmit?: (credits: CreditFormData[]) => void;
}

const REGISTER_CREDIT = gql`
  mutation RegisterCredit($input: RegisterCreditInput!) {
    registerCredit(input: $input) {
      isSuccess
    }
  }
`;

export function CreditDialog({ isrc, onSubmit }: CreditDialogProps) {
  const [open, setOpen] = useState(false);
  const [credits, setCredits] = useState<CreditFormData[]>([
    { role: "", name: "", email: "" },
  ]);
  const { user } = useUserStore();
  const [registerCredit] = useMutation(REGISTER_CREDIT);

  const handleInputChange = (
    index: number,
    field: keyof CreditFormData,
    value: string,
  ) => {
    const newCredits = [...credits];
    if (newCredits[index]) {
      newCredits[index][field] = value;
      setCredits(newCredits);
    }
  };

  const addCreditForm = () => {
    setCredits([...credits, { role: "", name: "", email: "" }]);
  };

  const removeCreditForm = (index: number) => {
    const newCredits = credits.filter((_, i) => i !== index);
    setCredits(newCredits);
  };

  const handleSubmit = async () => {
    try {
      const registerInfo = credits.map((credit) => ({
        isrc,
        commitUser: user?.id || "",
        creditRole: credit.role,
        creditName: credit.name,
        email: credit.email,
        isInvite: true,
        memo: "",
      }));

      await registerCredit({
        variables: {
          input: {
            registerInfo,
          },
        },
      });

      if (onSubmit) {
        onSubmit(credits);
      }
      setOpen(false);
      setCredits([{ role: "", name: "", email: "" }]);
    } catch (error) {
      console.error("Failed to register credits:", error);
      // エラーハンドリングを追加（必要に応じて）
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="outline">クレジットを編集</Button>
      </DialogTrigger>
      <DialogContent className="w-4/5 max-w-4xl max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>クレジット入力: {isrc}</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          {credits.map((credit, index) => (
            <div key={index} className="flex items-end space-x-4">
              <div className="flex-1 space-y-2">
                <Label htmlFor={`role-${index}`}>ロール</Label>
                <Input
                  id={`role-${index}`}
                  value={credit.role}
                  onChange={(e) =>
                    handleInputChange(index, "role", e.target.value)
                  }
                />
              </div>
              <div className="flex-1 space-y-2">
                <Label htmlFor={`name-${index}`}>名前</Label>
                <Input
                  id={`name-${index}`}
                  value={credit.name}
                  onChange={(e) =>
                    handleInputChange(index, "name", e.target.value)
                  }
                />
              </div>
              <div className="flex-1 space-y-2">
                <Label htmlFor={`email-${index}`}>Email</Label>
                <Input
                  id={`email-${index}`}
                  type="email"
                  value={credit.email}
                  onChange={(e) =>
                    handleInputChange(index, "email", e.target.value)
                  }
                />
              </div>
              {index > 0 && (
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => removeCreditForm(index)}
                >
                  <X className="h-4 w-4" />
                </Button>
              )}
            </div>
          ))}
        </div>
        <Button onClick={addCreditForm} variant="outline" className="mt-4">
          <PlusCircle className="h-4 w-4 mr-2" />
          フォームを追加
        </Button>
        <DialogFooter>
          <Button onClick={handleSubmit}>登録</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
