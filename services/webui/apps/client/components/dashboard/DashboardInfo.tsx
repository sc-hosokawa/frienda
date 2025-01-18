"use client";

import { useTranslation } from "~/i18n/client";
import { InfoDialog } from "../dialog/page-info";

export function DashboardInfo() {
  const { t } = useTranslation();
  return (
    <InfoDialog
      position="top-3"
      size={24}
      title="DASHBOARDについて"
      content={
        <>
          <p className="leading-relaxed text-gray-300">
            {t("dashboard.info.title")}
          </p>
          <p className="mt-4 font-semibold text-lg border-t border-gray-800 pt-4">
            {t("dashboard.info.about-overview")}
          </p>
          <p className="mt-4">
            {t("dashboard.info.about-overview-1")}
            <br />
            {t("dashboard.info.collection-rule")}
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>{t("dashboard.info.collection-rule-1")}</li>
            <li>{t("dashboard.info.collection-rule-2")}</li>
          </ul>

          <p className="mt-16 font-semibold text-lg">
            {t("dashboard.info.about-trending")}
          </p>
          <p className="mt-4">
            {t("dashboard.info.about-trending-1")}
            <br />
            {t("dashboard.info.collection-rule")}
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>{t("dashboard.info.collection-rule-1")}</li>
            <li>{t("dashboard.info.trending-rule")}</li>
          </ul>

          <p className="mt-16 font-semibold text-lg">
            {t("dashboard.info.about-chart")}
          </p>
          <p className="mt-4">
            {t("dashboard.info.about-chart-1")}
            <br />
            {t("dashboard.info.chart-rule")}
          </p>
          <ul className="list-disc list-inside mt-4 ml-8 space-y-2">
            <li>再生数の推移（Stacked Chart）</li>
            <li>世代別割合（Generation）</li>
            <li>性別割合（Gender）</li>
          </ul>
        </>
      }
    />
  );
}
