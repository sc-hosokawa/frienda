import { TableCell, TableRow } from "@ui/components/ui/table";
import React from "react";

export interface PointHistoryTableProps {
  date: string;
  from: string;
  to: string;
  amount: string;
}

export function PointHistoryTable({
  date,
  from,
  to,
  amount,
}: PointHistoryTableProps) {
  return (
    <TableRow className="hover:cursor-pointer border-none">
      <TableCell className="text-sm text-left">{date}</TableCell>
      <TableCell className="text-sm text-left">{from}</TableCell>
      <TableCell className="text-sm text-left">{to}</TableCell>
      <TableCell className="text-sm text-left">{amount}</TableCell>
    </TableRow>
  );
}
