import { TableCell, TableRow } from "@ui/components/ui/table";
import React from "react";

export interface UserListTableProps {
  realname: string;
  username: string;
  email: string;
  role: string;
  createdAt: string;
}

export function UserListTable({
  realname,
  username,
  email,
  role,
  createdAt,
}: UserListTableProps) {
  const formatDate = (dateString: string) => {
    // UTCの日付文字列をDate型に変換
    const utcDate = new Date(dateString);

    // 日本時間に変換（UTCから+9時間）
    const jpDate = new Date(utcDate.getTime() + 9 * 60 * 60 * 1000);

    // 日付を指定のフォーマットに整形
    const year = jpDate.getUTCFullYear();
    const month = String(jpDate.getUTCMonth() + 1).padStart(2, "0");
    const day = String(jpDate.getUTCDate()).padStart(2, "0");
    const hours = String(jpDate.getUTCHours()).padStart(2, "0");
    const minutes = String(jpDate.getUTCMinutes()).padStart(2, "0");
    const seconds = String(jpDate.getUTCSeconds()).padStart(2, "0");

    return `${year}/${month}/${day} ${hours}:${minutes}:${seconds}`;
  };

  return (
    <TableRow className="hover:cursor-pointer border-none">
      <TableCell className="text-sm text-left">{realname}</TableCell>
      <TableCell className="text-sm text-left">{username}</TableCell>
      <TableCell className="text-sm text-left">{email}</TableCell>
      <TableCell className="text-sm text-left">{role}</TableCell>
      <TableCell className="text-sm text-left">
        {formatDate(createdAt)}
      </TableCell>
    </TableRow>
  );
}
