"use client";

import React from "react";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, GET_ALL_USERS } from "../../../utils/query";
import {
  Table,
  TableBody,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import { UserListTable } from "../../../components/system/user-list-table";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@ui/components/ui/dropdown-menu";
import { MoreVertical } from "lucide-react";

export default function UserListPage() {
  const {
    data: userTable,
    isLoading: isLoadingUserTable,
    isError: isErrorUserTable,
  } = useQuery({
    queryKey: ["userTable"],
    queryFn: async () => {
      return await request(endpoint, GET_ALL_USERS).then(
        (data: any) => data.getAllUsersForAdmin,
      );
    },
  });

  const downloadUserListCSV = () => {
    if (!userTable) return;

    const headers = ["realname", "username", "email", "role", "createdAt"];
    const csvContent = [
      headers.join(","),
      ...userTable.map((user: any) =>
        [
          user.realname,
          user.username,
          user.email,
          user.role,
          user.createdAt,
        ].join(","),
      ),
    ].join("\n");

    const blob = new Blob([csvContent], { type: "text/csv" });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "user-list.csv";
    a.click();
    window.URL.revokeObjectURL(url);
  };

  return (
    <main className="p-6">
      <Card className="dark:border dark:border-white dark:border-opacity-10">
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle>ユーザー一覧</CardTitle>
          <DropdownMenu>
            <DropdownMenuTrigger>
              <MoreVertical className="h-5 w-5" />
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              <DropdownMenuItem onClick={downloadUserListCSV}>
                CSVダウンロード
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </CardHeader>
        <CardContent>
          <Table className="border-collapse">
            <TableHeader>
              <TableRow className="border-b border-[#FFFFFF73]">
                <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                  realname
                </TableHead>
                <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                  username
                </TableHead>
                <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                  email
                </TableHead>
                <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                  role
                </TableHead>
                <TableHead className="text-[15px] font-medium leading-[15px] text-left">
                  createdAt
                </TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoadingUserTable ? (
                <TableRow>
                  <td colSpan={5} className="text-center py-4">
                    Loading...
                  </td>
                </TableRow>
              ) : (
                userTable?.map((user: any) => (
                  <UserListTable
                    key={user.id}
                    realname={user.realname}
                    username={user.username}
                    email={user.email}
                    role={user.role}
                    createdAt={user.createdAt}
                  />
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </main>
  );
}
