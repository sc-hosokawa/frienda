import { createContext, useContext, useCallback } from "react";

import {
  RESOURCES,
  DEFAULT_LOCALE,
  i18nKey,
  isSupportLocale,
} from "./settings";

export const LocaleContext = createContext<string>(DEFAULT_LOCALE);

export const useTranslation = (): {
  t: (key: i18nKey) => string;
} => {
  const currentLocale = useContext(LocaleContext);
  if (!isSupportLocale(currentLocale)) {
    throw new Error(`Unsupported locale: ${currentLocale}`);
  }

  const translate = useCallback(
    (key: i18nKey) => {
      return RESOURCES[currentLocale][key];
    },
    [currentLocale],
  );
  return { t: translate };
};

export const useLocale = (): string => {
  const currentLocale = useContext(LocaleContext);
  if (!isSupportLocale(currentLocale)) {
    throw new Error(`Unsupported locale: ${currentLocale}`);
  }
  return currentLocale;
};
