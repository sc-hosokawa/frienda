import { Card, CardContent } from "@ui/components/ui/card";
import { Avatar, AvatarFallback } from "@ui/components/ui/avatar";
import { MoreHorizontal } from "lucide-react";

async function getOffers() {
  // Simulate a slow API call
  await new Promise((resolve) => setTimeout(resolve, 2000));

  return [
    {
      id: "123",
      status: "In-Progress",
      statusColor: "bg-blue-500",
      borderColor: "border-blue-500/20",
      title: "イベントに参加してくれるアーティスト募集中！",
      lastUpdated: "2024/10/10",
      avatars: ["A", "B", "C"],
      deadline: "2024/11/10",
      location: "東京都",
      target: "2 Artists",
    },
    {
      id: "124",
      status: "Offer Applied",
      statusColor: "bg-emerald-500",
      borderColor: "border-emerald-500/20",
      title: "イベントに参加してくれるアーティスト募集中！",
      lastUpdated: "2024/10/10",
      avatars: ["D", "E", "F"],
      deadline: "2024/11/10",
      location: "東京都",
      target: "2 Artists",
    },
  ];
}

export default async function OfferList() {
  const offers = await getOffers();

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {offers.map((offer) => (
        <Card
          key={offer.id}
          className={`bg-zinc-900 border ${offer.borderColor} relative overflow-hidden`}
        >
          <CardContent className="p-6">
            <div className="flex items-center gap-2 mb-4">
              <div className={`w-2 h-2 rounded-full ${offer.statusColor}`} />
              <span className="text-sm text-zinc-300">{offer.status}</span>
            </div>

            <div className="flex justify-between items-start mb-2">
              <div>
                <div className="text-sm text-zinc-500 mb-1">
                  Offer# {offer.id}
                </div>
                <h3 className="text-base text-zinc-100 font-medium">
                  {offer.title}
                </h3>
              </div>
              <button className="text-zinc-400 hover:text-zinc-300">
                <MoreHorizontal className="w-5 h-5" />
              </button>
            </div>

            <div className="text-xs text-zinc-500 mb-4">
              Last Updated: {offer.lastUpdated}
            </div>

            <div className="flex -space-x-2 mb-6">
              {offer.avatars.map((avatar, index) => (
                <Avatar
                  key={index}
                  className="border-2 border-zinc-900 w-8 h-8 bg-zinc-800"
                >
                  <AvatarFallback className="text-xs text-zinc-300">
                    {avatar}
                  </AvatarFallback>
                </Avatar>
              ))}
            </div>

            <div className="grid grid-cols-3 gap-4 pt-4 border-t border-zinc-800">
              <div>
                <div className="text-xs text-zinc-500 mb-1">期限</div>
                <div className="text-sm text-zinc-300">{offer.deadline}</div>
              </div>
              <div>
                <div className="text-xs text-zinc-500 mb-1">場所</div>
                <div className="text-sm text-zinc-300">{offer.location}</div>
              </div>
              <div>
                <div className="text-xs text-zinc-500 mb-1">対象</div>
                <div className="text-sm text-zinc-300">{offer.target}</div>
              </div>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}
