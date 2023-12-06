import "ui/globals.css";
import { Badge } from "@ui/components/ui/badge";
import { ComboboxDemo } from "ui/components/combo";
import { ModeToggle } from "ui/components/mode-toggle";

export default function Page(): JSX.Element {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <h1>client</h1>
      <ComboboxDemo />
      <Badge>Badge</Badge>
      <ModeToggle />
    </main>
  );
}
