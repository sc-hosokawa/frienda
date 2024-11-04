/*
"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@ui/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@ui/components/ui/form";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import { Input } from "@ui/components/ui/input";
import { Textarea } from "@ui/components/ui/textarea";
import { Switch } from "@ui/components/ui/switch";
import { UploadButton } from "@ui/components/upload-button";
import { useToast } from "@ui/hooks/use-toast";

const offerFormSchema = z.object({
  title: z.string().min(1, "タイトルを入力してください"),
  description: z.string().min(1, "説明を入力してください"),
  fee: z.string().min(1, "報酬を入力してください"),
  deadline: z.string().min(1, "締切日を入力してください"),
  place: z.string().min(1, "場所を入力してください"),
  category: z.enum(["Creation", "Event", "Promotion", "Other"]),
  attention: z.string().optional(),
  requiredSkill: z.string().optional(),
  targetRole: z.enum(["Musician", "Creator", "Curator", "Supporter"]),
  isPublic: z.boolean().default(true),
  imageUrl: z.string().optional(),
  attachedFiles: z.array(z.string()).optional(),
});

type OfferFormValues = z.infer<typeof offerFormSchema>;

export default function CreateOfferPage() {
  const router = useRouter();
  const { toast } = useToast();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const form = useForm<OfferFormValues>({
    resolver: zodResolver(offerFormSchema),
    defaultValues: {
      isPublic: true,
      attachedFiles: [],
    },
  });

  async function onSubmit(data: OfferFormValues) {
    setIsSubmitting(true);
    try {
      const response = await fetch("/api/offers", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data),
      });

      if (!response.ok) throw new Error("投稿に失敗しました");

      toast({
        title: "Success",
        description: "投稿が完了しました",
      });
      router.push("/offers");
    } catch (error) {
      toast({
        title: "Error",
        description: "エラーが発生しました",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <div className="container mx-auto py-10">
      <h1 className="text-2xl font-bold mb-8">新規Offer追加</h1>
      
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
          <FormField
            control={form.control}
            name="title"
            render={({ field }) => (
              <FormItem>
                <FormLabel>タイトル</FormLabel>
                <FormControl>
                  <Input {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          
          <FormField
            control={form.control}
            name="isPublic"
            render={({ field }) => (
              <FormItem className="flex items-center justify-between">
                <FormLabel>公開設定</FormLabel>
                <FormControl>
                  <Switch
                    checked={field.value}
                    onCheckedChange={field.onChange}
                  />
                </FormControl>
              </FormItem>
            )}
          />

          <Button type="submit" disabled={isSubmitting}>
            {isSubmitting ? "投稿中..." : "投稿する"}
          </Button>
        </form>
      </Form>
    </div>
  );
}
*/
