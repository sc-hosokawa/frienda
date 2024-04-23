import { ModeToggle } from "@ui/components/theme-button";

export default function Page(): JSX.Element {
  return (
    <main className="flex flex-col items-center justify-between min-h-screen p-24">
      <p>app_2 UI</p>
      <ModeToggle />
    </main>
  );
}
