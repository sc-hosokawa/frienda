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

export default function CommunityPage() {
  return (
    <>
      <Tabs defaultValue="list" className="w-full">
        <div className="flex justify-between mb-6">
          <h2 className="text-[18px] font-[360] leading-[18px] text-left">
            {/* TODO: this should be correct number */}
            My Connections ({mockData.length})
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
          {mockData.length === 0 ? (
            <div className="text-center py-8 text-white">No Connection</div>
          ) : (
            /* TODO: add map view */
            <></>
          )}
        </TabsContent>
        <TabsContent value="list">
          {mockData.length === 0 ? (
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
                    Rate
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Type
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Comment
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Connection
                  </TableHead>
                  <TableHead className="text-white text-[15px] font-medium leading-[15px] text-left">
                    Last Logged in
                  </TableHead>
                  <TableHead className="w-24"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {mockData.length === 0 ? (
                  <TableRow>
                    <td colSpan={8} className="text-center py-8 text-white">
                      No Connection
                    </td>
                  </TableRow>
                ) : (
                  mockData.map((data) => (
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

// TODO: remove this mock data
export const mockData: CommunityListsRowProps[] = [];

/*
export const mockData: CommunityListsRowProps[] = [
   {
     id: "1",
    name: "taro_yoshida",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "artist",
      role: "Vocal",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "2",
    name: "sayaka_kyoda",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "artist",
      role: "Vocal",
    },
    comment: "イベントいつも最高",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "3",
    name: "photoone",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "promoter",
      role: "Photographer",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "4",
    name: "lisa_fukuda",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "curator",
      role: "manager",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "5",
    name: "minoru_kou",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "curator",
      role: "manager",
    },
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
  {
    id: "6",
    name: "john_john",
    friendCount: 4,
    rate: "4.5",
    type: {
      title: "artist",
      role: "Vocal",
    },
    comment: "次のMVの時きく!",
    connection: {
      offer: "Offer #123",
      date: "2024/10/23",
    },
    isOnline: true,
    description:
      "The Bandのjohn_johnです! よろしくお願いします! レコーディングやイベントのお誘い、または対バンやサポートベーシストのお誘いまでお待ちしております!",
    connectedSince: "2023/7/23",
    avatar: "",
    skill: "バンド、ベース（サポートもできます！）",
    members: [
      { title: "Tetsuo Yoshida", role: "Vocal" },
      { title: "Kei Minami", role: "Owner" },
      { title: "Shinya Fukuda", role: "Drums" },
    ],
    lastLogin: "20分前",
    offers: ["Event", "Live", "Recording", "Promoting", "Support Musician"],
    connections: ["artist", "curator", "producer", "designer", "filmMaker"],
  },
];
*/
