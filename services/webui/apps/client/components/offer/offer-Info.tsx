import { useTranslation } from "~/i18n/client";
import { InfoDialog } from "../dialog/page-info";

export function OfferInfo() {
  const { t } = useTranslation();
  return (
    <InfoDialog
      position="top-3"
      size={24}
      title={t("offer.about-offer")}
      content={
        <>
          <p className="text-lg leading-relaxed">{t("offer.offer-info")}</p>
          <p className="mt-4 font-semibold text-lg border-t border-gray-800 pt-4">
            {t("offer.find-offer")}
          </p>
          <p className="mt-4">{t("offer.find-offer-guide")}</p>

          <p className="mt-16 font-semibold text-lg">
            {t("offer.create-offer")}
          </p>
          <p className="mt-4">{t("offer.offer-creation-notion")}</p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>{t("common.category")}(Creation, Event, Promotion, Other)</li>
            <li>{t("offer.offer-title")}*</li>
            <li>{t("offer.offer-description")}*</li>
            <li>{t("offer.offer-deadline")}</li>
            <li>{t("offer.offer-place")}*</li>
            <li>{t("offer.offer-fee")}*</li>
            <li>{t("offer.offer-subject")}*</li>
            <li>{t("offer.additional-offer-items")}</li>
            <li>{t("offer.offer-skills")}</li>
            <li>{t("offer.cover-image")}*</li>
            <li>{t("offer.attached-image")}</li>
            <li>{t("offer.attached-media")}</li>
          </ul>
          <p className="mt-4 text-sm text-gray-400">{t("offer.required")}</p>
        </>
      }
    />
  );
}
