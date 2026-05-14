import { createContext } from 'react';

/**
 * @file LanguageContext.js
 * Provides information about the target language and available languages.
 */
export const LanguageContext = createContext({
  targetLanguage: { code: 'de', name: 'German' },
  setTargetLanguage: () => {},
  languages: []
});
