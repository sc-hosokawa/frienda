"use client";

import Link from "next/link";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@ui/components/ui/accordion";
import { Button } from "@ui/components/ui/button";
import { useTranslation } from "~/i18n/client";

const faqItems = [
  {
    id: "login",
    questionKey: "faq.items.login.question",
    answerKey: "faq.items.login.answer",
  },
  {
    id: "invitation",
    questionKey: "faq.items.invitation.question",
    answerKey: "faq.items.invitation.answer",
  },
  {
    id: "profile",
    questionKey: "faq.items.profile.question",
    answerKey: "faq.items.profile.answer",
  },
  {
    id: "offer",
    questionKey: "faq.items.offer.question",
    answerKey: "faq.items.offer.answer",
  },
  {
    id: "dashboard",
    questionKey: "faq.items.dashboard.question",
    answerKey: "faq.items.dashboard.answer",
  },
  {
    id: "fsp",
    questionKey: "faq.items.fsp.question",
    answerKey: "faq.items.fsp.answer",
  },
  {
    id: "contact",
    questionKey: "faq.items.contact.question",
    answerKey: "faq.items.contact.answer",
  },
] as const;

export default function FAQ({
  params: { locale },
}: {
  params: { locale: string };
}) {
  const { t } = useTranslation();

  return (
    <main className="w-full max-w-5xl mx-auto px-4 py-10 sm:px-6 sm:py-16">
      <section className="space-y-8">
        <div className="space-y-2">
          <h1 className="text-[72px] sm:text-[90px] font-light tracking-wider leading-none">
            {t("faq.title")}
          </h1>
          <p className="text-sm text-white/70">{t("faq.subtitle")}</p>
        </div>

        <hr className="border-white/20" />

        <Accordion type="single" collapsible className="w-full">
          {faqItems.map((item) => (
            <AccordionItem
              key={item.id}
              value={item.id}
              className="border-white/20"
            >
              <AccordionTrigger className="py-6 text-left text-base sm:text-lg font-light hover:no-underline">
                {t(item.questionKey)}
              </AccordionTrigger>
              <AccordionContent className="pb-6 text-sm sm:text-base leading-7 text-white/70">
                {t(item.answerKey)}
              </AccordionContent>
            </AccordionItem>
          ))}
        </Accordion>
      </section>

      <section className="mt-16 space-y-6 border border-white/20 rounded-2xl p-6 sm:p-8 bg-white/5">
        <div className="space-y-2">
          <h2 className="text-2xl sm:text-3xl font-light">
            {t("faq.contact-title")}
          </h2>
          <p className="text-sm leading-6 text-white/70">
            {t("faq.contact-description")}
          </p>
          <a
            href="mailto:info@friendshipdao.xyz"
            className="inline-block text-sm text-white underline underline-offset-4"
          >
            info@friendshipdao.xyz
          </a>
        </div>

        <div className="flex flex-col sm:flex-row gap-4 pt-2">
          <Button
            asChild
            className="bg-white text-black hover:bg-white/90 h-[56px] w-full sm:w-[180px] rounded-full"
          >
            <Link href={`/${locale}/login`}>{t("faq.login")}</Link>
          </Button>
          <Button
            asChild
            variant="outline"
            className="bg-black text-white border-gray-500 hover:bg-white/90 hover:text-black transition-colors h-[56px] w-full sm:w-[180px] rounded-full border-dashed"
          >
            <Link href={`/${locale}/signin`}>{t("faq.signup")}</Link>
          </Button>
        </div>
      </section>
    </main>
  );
}
