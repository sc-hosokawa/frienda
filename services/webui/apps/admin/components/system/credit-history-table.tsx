import { TableCell, TableRow } from "@ui/components/ui/table";
import React from "react";

export interface CreditHistoryTableProps {
  date: string;
  isrc: string;
  user: string;
  role: string;
  name: string;
  email: string;
}

export function CreditHistoryTable({
  date,
  isrc,
  user,
  role,
  name,
  email,
}: CreditHistoryTableProps) {
  return (
    <TableRow className="hover:cursor-pointer border-none">
      <TableCell className="text-sm text-left">{date}</TableCell>
      <TableCell className="text-sm text-left">{isrc}</TableCell>
      <TableCell className="text-sm text-left">{user}</TableCell>
      <TableCell className="text-sm text-left">{role}</TableCell>
      <TableCell className="text-sm text-left">{name}</TableCell>
      <TableCell className="text-sm text-left">{email}</TableCell>
    </TableRow>
  );
}
