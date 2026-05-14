import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
  resolve: {
    conditions: ['production', 'development', 'default', 'browser', 'import', 'module'],
  },
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:9901',
        changeOrigin: true,
      },
    },
  },
})
