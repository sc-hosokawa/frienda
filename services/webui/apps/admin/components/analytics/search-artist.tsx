import { Check, ChevronsUpDown } from "lucide-react";

import { cn } from "@ui/lib/utils";
import { Button } from "@ui/components/ui/button";
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@ui/components/ui/command";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@ui/components/ui/popover";
import React from "react";
import { Skeleton } from "@ui/components/ui/skeleton";

interface Props {
  value: string;
  setValue: React.Dispatch<React.SetStateAction<string>>;
  artists: any;
  open: boolean;
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
  isLoading: boolean;
  isError: boolean;
}

export function SearchArtist({
  value,
  setValue,
  artists,
  open,
  setOpen,
  isLoading,
  isError,
}: Props) {
  if (isLoading || !artists) {
    return <Skeleton className="h-12 w-80" />;
  } else if (isError) {
    return <div>Error loading artists.</div>;
  }

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className="w-80 justify-between"
        >
          {value
            ? artists.find((artist: any) => artist.artistId === value)?.name
            : "Select artist..."}
          <ChevronsUpDown className="opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="p-0 w-80">
        <Command>
          <CommandInput placeholder="Search artist..." />
          <CommandList>
            <CommandEmpty>No artist found.</CommandEmpty>
            <CommandGroup>
              {artists.map((artist: any) => (
                <CommandItem
                  key={artist.artistId}
                  value={artist.name}
                  onSelect={() => {
                    setValue(artist.artistId);
                    setOpen(false);
                  }}
                >
                  {artist.name}
                  <Check
                    className={cn(
                      "ml-auto",
                      value === artist.artistId ? "opacity-100" : "opacity-0",
                    )}
                  />
                </CommandItem>
              ))}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
}
