import { TableCell, TableRow } from "@ui/components/ui/table";

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
  const formatDate = (dateString: string) => {
    const utcDate = new Date(dateString);

    const jpDate = new Date(utcDate.getTime() + 9 * 60 * 60 * 1000);

    const year = jpDate.getUTCFullYear();
    const month = String(jpDate.getUTCMonth() + 1).padStart(2, "0");
    const day = String(jpDate.getUTCDate()).padStart(2, "0");
    const hours = String(jpDate.getUTCHours()).padStart(2, "0");
    const minutes = String(jpDate.getUTCMinutes()).padStart(2, "0");
    const seconds = String(jpDate.getUTCSeconds()).padStart(2, "0");

    return `${year}/${month}/${day} ${hours}:${minutes}:${seconds}`;
  };

  return (
    <TableRow>
      <TableCell className="text-sm text-left">{formatDate(date)}</TableCell>
      <TableCell className="text-sm text-left">{from}</TableCell>
      <TableCell className="text-sm text-left">{to}</TableCell>
      <TableCell className="text-sm text-left">{amount}</TableCell>
    </TableRow>
  );
}
