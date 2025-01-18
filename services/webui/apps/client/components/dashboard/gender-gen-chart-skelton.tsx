export function ChartSkeleton() {
  return (
    <div className="h-[300px] w-full flex items-center justify-center">
      <div className="w-full h-full animate-pulse bg-gradient-to-r from-zinc-800/30 via-zinc-700/50 to-zinc-800/30 rounded-lg" />
    </div>
  );
}
