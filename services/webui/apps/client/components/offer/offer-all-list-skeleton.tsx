import { Skeleton } from "@ui/components/ui/skeleton";
import { SkeletonCard } from "./offer-skeleton-card";

export const OfferAllListSkeleton = () => (
  <div className="min-h-screen bg-black text-white py-6">
    <div className="">
      <div className="flex justify-between items-center mb-6">
        <Skeleton className="h-8 w-32" /> {/* タイトルのスケルトン */}
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {Array(6)
          .fill(null)
          .map((_, index) => (
            <SkeletonCard key={index} />
          ))}
      </div>
    </div>
  </div>
);
