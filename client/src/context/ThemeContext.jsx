import { createContext } from 'react';

export const ThemeContext = createContext({
  theme: 'glassy',
  setTheme: () => {},
  bgImage: '',
  bgPhotographer: null,
  fetchNewBg: () => {},
  isBgLoading: false
});
