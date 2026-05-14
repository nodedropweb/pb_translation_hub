import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import axios from 'axios';

// Contexts
import { AuthContext } from './context/AuthContext';
import { ThemeContext } from './context/ThemeContext';
import { LanguageContext } from './context/LanguageContext';
import { WorkflowContext } from './context/WorkflowContext';
import { ToastContext } from './context/ToastContext';

// Components
import AppContent from './components/layout/AppContent';
import ToastContainer from './components/ui/ToastContainer';

// Utils
import { API_BASE, THEMES } from './utils/constants';

/**
 * @file App.jsx
 * Root component of the PB Translation Hub.
 * Manages global state and context providers.
 */

// Axios defaults for authentication
axios.interceptors.request.use(config => {
  const token = localStorage.getItem('pb-token') || sessionStorage.getItem('pb-token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Axios response interceptor for global error handling
axios.interceptors.response.use(
  response => response,
  error => {
    if (error.response?.status === 401) {
      localStorage.removeItem('pb-token');
      sessionStorage.removeItem('pb-token');
      // We can't easily call logout() here because it's inside the component,
      // but clearing the token will make the next auth check fail.
      // For immediate effect, we'll let the component catch it or reload.
    }
    return Promise.reject(error);
  }
);

const App = () => {
  // --- Auth State ---
  const [user, setUser] = useState(null);

  // --- Language State ---
  const [targetLanguage, setTargetLanguage] = useState(() => {
    const saved = localStorage.getItem('targetLanguage');
    try {
      return saved ? JSON.parse(saved) : { code: 'de', name: 'German' };
    } catch (e) {
      return { code: 'de', name: 'German' };
    }
  });
  const [languages, setLanguages] = useState([]);

  // --- Theme State ---
  const [theme, setTheme] = useState(localStorage.getItem('pb-theme') || 'glassy');
  const [bgImage, setBgImage] = useState(localStorage.getItem('pb-bgImage') || '');
  const [bgPhotographer, setBgPhotographer] = useState(() => {
    const saved = localStorage.getItem('pb-bgPhotographer');
    try {
      return saved ? JSON.parse(saved) : null;
    } catch (e) {
      return null;
    }
  });
  const [isBgLoading, setIsBgLoading] = useState(false);

  // --- Workflow State ---
  const [priorityMode, setPriorityMode] = useState(() => localStorage.getItem('pb-priorityMode') === 'true');
  const [confettiEnabled, setConfettiEnabled] = useState(() => localStorage.getItem('pb-confettiEnabled') !== 'false');
  const [largeUi, setLargeUi] = useState(() => localStorage.getItem('pb-largeUi') === 'true');
  const [fontStyle, setFontStyle] = useState(localStorage.getItem('pb-fontStyle') || 'inter');

  // --- UI State ---
  const [toasts, setToasts] = useState([]);

  // --- Auth Logic ---
  async function login(username, password, remember = false) {
    const res = await axios.post(`${API_BASE}/auth/login`, { username, password });
    const { token, user: userData } = res.data;
    
    if (remember) {
      localStorage.setItem('pb-token', token);
      sessionStorage.removeItem('pb-token');
    } else {
      sessionStorage.setItem('pb-token', token);
      localStorage.removeItem('pb-token');
    }
    
    setUser(userData);
    return userData;
  }

  function logout() {
    localStorage.removeItem('pb-token');
    sessionStorage.removeItem('pb-token');
    setUser(null);
  }

  async function register(data) {
    const res = await axios.post(`${API_BASE}/auth/register`, data);
    return res.data;
  }

  // --- Persistence & Initialization ---
  useEffect(() => {
    const token = localStorage.getItem('pb-token') || sessionStorage.getItem('pb-token');
    if (token) {
      axios.get(`${API_BASE}/auth/me`)
        .then(res => setUser(res.data))
        .catch(() => logout());
    }
    
    axios.get(`${API_BASE}/languages`).then(res => setLanguages(res.data));
    
    if ((theme === 'glassy' || theme === 'nature') && !bgImage) {
      fetchNewBg();
    }
  }, []);

  useEffect(() => {
    localStorage.setItem('targetLanguage', JSON.stringify(targetLanguage));
  }, [targetLanguage]);

  useEffect(() => {
    localStorage.setItem('pb-theme', theme);
    localStorage.setItem('pb-fontStyle', fontStyle);
    document.documentElement.className = `theme-${theme} font-style-${fontStyle}`;
  }, [theme, fontStyle]);

  useEffect(() => {
    localStorage.setItem('pb-priorityMode', priorityMode);
  }, [priorityMode]);

  useEffect(() => {
    localStorage.setItem('pb-confettiEnabled', confettiEnabled);
  }, [confettiEnabled]);

  useEffect(() => {
    localStorage.setItem('pb-largeUi', largeUi);
  }, [largeUi]);

  // --- Dynamic Backgrounds ---
  async function fetchNewBg(overrideKeywords = null) {
    setIsBgLoading(true);
    try {
      const currentTheme = THEMES.find(t => t.id === theme) || THEMES[0];
      const keywords = overrideKeywords || currentTheme.keywords;
      const res = await axios.get(`${API_BASE}/unsplash/random-bg`, { params: { query: keywords } });
      
      const { url, photographer, download_location, source } = res.data;
      
      let finalUrl = url;
      if (source === 'picsum') {
        finalUrl = `${finalUrl}?cb=${Date.now()}`;
        setBgPhotographer(null);
        localStorage.removeItem('pb-bgPhotographer');
      } else if (source === 'unsplash') {
        setBgPhotographer(photographer);
        localStorage.setItem('pb-bgPhotographer', JSON.stringify(photographer));
        
        if (download_location) {
          axios.post(`${API_BASE}/unsplash/track-download`, { download_location }).catch(() => {});
        }
      }
      
      setBgImage(finalUrl);
      localStorage.setItem('pb-bgImage', finalUrl);
    } catch (err) {
      console.error('Failed to fetch background', err);
    } finally {
      setIsBgLoading(false);
    }
  }

  // --- Toast Logic ---
  function showToast(message, type = 'success') {
    const id = Date.now();
    setToasts(prev => [...prev, { id, message, type }]);
    setTimeout(() => {
      setToasts(prev => prev.filter(t => t.id !== id));
    }, 4000);
  }

  return (
    <AuthContext.Provider value={{ user, setUser, login, logout, register }}>
      <ThemeContext.Provider value={{ theme, setTheme, bgImage, bgPhotographer, fetchNewBg, isBgLoading }}>
        <LanguageContext.Provider value={{ targetLanguage, setTargetLanguage, languages }}>
          <WorkflowContext.Provider value={{ priorityMode, setPriorityMode, confettiEnabled, setConfettiEnabled, largeUi, setLargeUi, fontStyle, setFontStyle }}>
            <ToastContext.Provider value={{ showToast }}>
              <div 
                className={`theme-${theme} font-style-${fontStyle} min-h-screen relative overflow-hidden bg-unsplash transition-all duration-1000`} 
                style={{ backgroundImage: bgImage ? `url(${bgImage})` : 'none' }}
              >
                {/* Dynamic Theme Overlay */}
                <div 
                  className="absolute inset-0 z-0 transition-colors duration-1000" 
                  style={{ backgroundColor: 'var(--overlay-color)' }}
                />
                
                <div className="relative z-10 h-screen overflow-hidden">
                  <Router>
                    <AppContent />
                  </Router>
                </div>
                <ToastContainer toasts={toasts} />
              </div>
            </ToastContext.Provider>
          </WorkflowContext.Provider>
        </LanguageContext.Provider>
      </ThemeContext.Provider>
    </AuthContext.Provider>
  );
};

export default App;
