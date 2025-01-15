import "server-only";

import { RESOURCES, i18nKey, isSupportLocale } from "./settings";

export const getTranslation = (locale: string) => {
  if (!isSupportLocale(locale)) {
    throw new Error(`Unsupported locale: ${locale}`);
  }
  return { t: (key: i18nKey) => RESOURCES[locale][key] };
};
