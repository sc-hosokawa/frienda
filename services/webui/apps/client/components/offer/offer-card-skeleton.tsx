import { Card } from "@ui/components/ui/card";
import { Skeleton } from "@ui/components/ui/skeleton";

export function OfferCardSkeleton() {
  return (
    <Card className="bg-zinc-900 border-none p-4">
      <div className="flex gap-4">
        <Skeleton className="w-[150px] h-[150px] rounded-lg" />
        <div className="flex-1">
          <div className="flex justify-between items-start mb-2">
            <Skeleton className="w-20 h-6" />
            <div className="flex gap-2">
              <Skeleton className="w-4 h-4" />
              <Skeleton className="w-4 h-4" />
            </div>
          </div>

          <Skeleton className="w-3/4 h-6 mb-1" />
          <Skeleton className="w-full h-4 mb-2" />
          <Skeleton className="w-1/2 h-4 mb-4" />

          <div className="flex justify-between items-center mb-4">
            <Skeleton className="w-32 h-8" />
            <Skeleton className="w-24 h-6" />
          </div>

          <div className="grid grid-cols-3 gap-4 mb-4">
            {[0, 1, 2].map((i) => (
              <div key={i}>
                <Skeleton className="w-full h-4 mb-1" />
                <Skeleton className="w-3/4 h-4" />
              </div>
            ))}
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Skeleton className="w-6 h-6 rounded-full" />
                <div>
                  <Skeleton className="w-24 h-4 mb-1" />
                  <Skeleton className="w-20 h-3" />
                </div>
              </div>
              <div className="flex items-center gap-1">
                <Skeleton className="w-4 h-4" />
                <Skeleton className="w-8 h-4" />
              </div>
            </div>
            <div className="flex gap-2">
              <Skeleton className="w-4 h-4" />
              <Skeleton className="w-4 h-4" />
            </div>
          </div>
        </div>
      </div>
    </Card>
  );
}
