'use client'

import CommunityListsRow, {
  CommunityListsRowProps,
} from "../../../components/community/community-lits-row";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@ui/components/ui/tabs";
import {
  Table,
  TableBody,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { ChevronDown } from "lucide-react";
import { gql, useQuery, useMutation } from "@apollo/client";
import useUserStore from "../../../store/user";

const GET_OWN_COMMUNITY = gql`
  query GetOwnCommunity($userId: String!) {
    getOwnCommunity(userId: $userId) {
      community {
        id
        name
        imageUrl
        category
        favoriteId
        shortNote
        lastLoggedIn
        connections
        weight
      }
    }
  }
`;

export default function CommunityPage() {
  const { user } = useUserStore();

  const { data, error, loading } = useQuery(GET_OWN_COMMUNITY, {
    variables: { userId: user?.id || "" },
    skip: !user?.id,
  });

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  console.log(user?.id);
  console.log(data);
  const communityData = data?.getOwnCommunity?.community || [];

  return (
    <>
      <Tabs defaultValue="list" className="w-full">
        <div className="flex justify-between mb-6">
          <h2 className="text-[18px] font-[360] leading-[18px] text-left">
            My Connections ({communityData.length})
          </h2>
          <TabsList className="bg-transparent border border-dashed border-white rounded-full p-1 w-[186px] h-[60px]">
            <TabsTrigger
              value="map"
              className="rounded-[60px] w-[90px] text-[15px] font-[360] leading-[18px] text-center h-[52.5px] text-white data-[state=active]:bg-white data-[state=active]:text-black"
            >
              Map View
            </TabsTrigger>
            <TabsTrigger
              value="list"
              className="rounded-[60px] w-[90px] text-[15px] font-[360] leading-[18px] text-center h-[52.5px] text-white data-[state=active]:bg-white data-[state=active]:text-black"
            >
              List View
            </TabsTrigger>
          </TabsList>
        </div>
        <TabsContent value="map">
          {communityData.length === 0 ? (
            <div className="text-center py-8 text-white">No Connection</div>
          ) : (
            /* TODO: add map view */
            <></>
          )}
        </TabsContent>
        <TabsContent value="list">
          {communityData.length === 0 ? (
            <div className="text-center py-8 text-white">No Connection</div>
          ) : (
            <Table className="border-collapse">
              <TableHeader>
                <TableRow className="border-b border-[#FFFFFF73]">
                  <TableHead></TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    <div className="flex items-center gap-1">
                      User
                      <ChevronDown className="w-4 h-4" />
                    </div>
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Category
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Weight
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Comment
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Connections
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Last Logged in
                  </TableHead>
                  <TableHead className="w-24"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {communityData.length === 0 ? (
                  <TableRow>
                    <td colSpan={8} className="text-center py-8 text-white">
                      No Connection
                    </td>
                  </TableRow>
                ) : (
                  communityData.map((data: any) => (
                    <CommunityListsRow key={data.id} {...data} />
                  ))
                )}
              </TableBody>
            </Table>
          )}
        </TabsContent>
      </Tabs>
    </>
  );
}
