export function BadgeList({
  className,
  title,
}: {
  className?: string;
  title: string;
}) {
  return (
    <div
      className={`inline-flex w-[90px] h-9 items-center justify-center rounded-full px-6 text-[12px] leading-[18px] text-center ${className}`}
    >
      {title}
    </div>
  );
}
