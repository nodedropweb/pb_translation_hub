import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import './App.css'
import "@fontsource/inter/400.css";
import "@fontsource/inter/700.css";
import "@fontsource/outfit/400.css";
import "@fontsource/outfit/700.css";
import "@fontsource/sora/400.css";
import "@fontsource/sora/700.css";
import "@fontsource/jetbrains-mono/400.css";
import App from './App.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
