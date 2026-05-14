import { createContext } from 'react';

export const AuthContext = createContext({
  user: null,
  setUser: () => {},
  login: async () => {},
  logout: () => {},
  register: async () => {}
});
