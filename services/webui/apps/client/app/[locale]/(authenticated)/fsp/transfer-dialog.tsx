"use client";

import { FormEvent, useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/ui/dialog";
import { Button } from "@ui/components/ui/button";
import { Label } from "@ui/components/ui/label";
import { Input } from "@ui/components/ui/input";
import { Textarea } from "@ui/components/ui/textarea";
import { Send } from "lucide-react";
import { useMutation, gql, useQuery } from "@apollo/client";
import useUserStore from "../../../../store/user";

type TransferFormData = {
  recipient: string;
  points: string;
  notes: string;
};

const CREATE_FSP_TX = gql`
  mutation CreateFspTx($input: CreateNewTransactionInput!) {
    createFspTx(input: $input) {
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

export function TransferDialog() {
  const { user, updateBalance } = useUserStore();
  const [showConfirm, setShowConfirm] = useState(false);
  const [showDialog, setShowDialog] = useState(false);
  const [formData, setFormData] = useState<TransferFormData>({
    recipient: "",
    points: "",
    notes: "",
  });

  // ミューテーションフックを追加
  const [createFspTx] = useMutation(CREATE_FSP_TX);

  // クエリフックを追加
  const { refetch } = useQuery(GET_USER_POINT_BALANCE, {
    variables: { userId: user?.id },
    skip: !user?.id,
    onCompleted: (data) => {
      updateBalance(data.getUserPointBalance.fspBalance);
    },
  });

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    setShowConfirm(true);
  };

  const handleTransfer = async () => {
    try {
      const result = await createFspTx({
        variables: {
          input: {
            from: user?.id,
            to: formData.recipient,
            amount: parseInt(formData.points),
            note: formData.notes,
          },
        },
      });

      if (result.errors) {
        throw new Error(result.errors[0]?.message || "送信に失敗しました");
      }

      console.log("refetch");
      const { data: newBalance } = await refetch();
      console.log("newBalance", newBalance);
      updateBalance(newBalance.getUserPointBalance.fspBalance);

      setShowConfirm(false);
      setShowDialog(false);

      setFormData({
        recipient: "",
        points: "",
        notes: "",
      });

      console.log("送信成功:", result.data);
    } catch (error) {
      console.error("送信エラー:", error);
    }
  };

  return (
    <>
      <Dialog open={showDialog} onOpenChange={setShowDialog}>
        <DialogTrigger asChild>
          <Button className="w-full">
            <Send className="mr-2 h-4 w-4" />
            送信
          </Button>
        </DialogTrigger>
        <DialogContent className="w-4/5 h-4/5 max-w-none">
          <DialogHeader>
            <DialogTitle>ポイント送信</DialogTitle>
          </DialogHeader>
          <div className="flex-1 overflow-auto p-4">
            <form className="space-y-4" onSubmit={handleSubmit}>
              <div className="space-y-2">
                <Label htmlFor="recipient">受取人のEmail</Label>
                <Input
                  id="recipient"
                  type="email"
                  placeholder="example@example.com"
                  required
                  value={formData.recipient}
                  onChange={(e) =>
                    setFormData({ ...formData, recipient: e.target.value })
                  }
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="points">送るポイント数</Label>
                <Input
                  id="points"
                  type="number"
                  min="1"
                  placeholder="0"
                  required
                  value={formData.points}
                  onChange={(e) =>
                    setFormData({ ...formData, points: e.target.value })
                  }
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="notes">メモ（任意）</Label>
                <Textarea
                  id="notes"
                  placeholder="メモを入力してください"
                  className="h-24"
                  value={formData.notes}
                  onChange={(e) =>
                    setFormData({ ...formData, notes: e.target.value })
                  }
                />
              </div>

              <Button type="submit" className="w-full">
                確認画面へ
              </Button>
            </form>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={showConfirm} onOpenChange={setShowConfirm}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>送信内容の確認</DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <div>
              <Label>受取人のEmail</Label>
              <p className="mt-1">{formData.recipient}</p>
            </div>
            <div>
              <Label>送るポイント数</Label>
              <p className="mt-1">{formData.points} pt</p>
            </div>
            {formData.notes && (
              <div>
                <Label>メモ</Label>
                <p className="mt-1 whitespace-pre-wrap">{formData.notes}</p>
              </div>
            )}
            <div className="flex space-x-2 justify-end">
              <Button variant="outline" onClick={() => setShowConfirm(false)}>
                戻る
              </Button>
              <Button onClick={handleTransfer}>送信する</Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}
