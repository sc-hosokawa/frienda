import { Card, CardContent } from "@ui/components/ui/card";
import { Skeleton } from "@ui/components/ui/skeleton";

export default function OfferListSkeleton() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {[1, 2].map((i) => (
        <Card
          key={i}
          className="bg-zinc-900 border border-zinc-800 relative overflow-hidden"
        >
          <CardContent className="p-6">
            <Skeleton className="h-4 w-1/4 bg-zinc-800 mb-4" />
            <Skeleton className="h-6 w-3/4 bg-zinc-800 mb-2" />
            <Skeleton className="h-4 w-1/2 bg-zinc-800 mb-4" />
            <div className="flex gap-1 mb-6">
              <Skeleton className="h-8 w-8 rounded-full bg-zinc-800" />
              <Skeleton className="h-8 w-8 rounded-full bg-zinc-800" />
              <Skeleton className="h-8 w-8 rounded-full bg-zinc-800" />
            </div>
            <Skeleton className="h-20 w-full bg-zinc-800" />
          </CardContent>
        </Card>
      ))}
    </div>
  );
}
