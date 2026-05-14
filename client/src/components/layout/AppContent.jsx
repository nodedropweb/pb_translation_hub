import React, { useContext, useState } from 'react';
import { Routes, Route, Navigate, Link, useLocation, useNavigate } from 'react-router-dom';
import { 
  LayoutDashboard, 
  Filter, 
  HelpCircle, 
  Settings, 
  LogIn, 
  ChevronRight, 
  Palette, 
  RefreshCw, 
  Camera, 
  Globe,
  Sun,
  Moon,
  Droplets,
  Zap
} from 'lucide-react';

const ICON_MAP = {
  Sun,
  Moon,
  Palette,
  Droplets,
  Zap
};

// Contexts
import { LanguageContext } from '../../context/LanguageContext';
import { ThemeContext } from '../../context/ThemeContext';
import { AuthContext } from '../../context/AuthContext';

// Components
import DrupalLogo from '../ui/DrupalLogo';
import Modal from '../ui/Modal';

// Views
import Dashboard from '../../views/Dashboard';
import Editor from '../../views/Editor';
import CategoriesView from '../../views/CategoriesView';
import SettingsView from '../../views/SettingsView';
import ProfileView from '../../views/ProfileView';
import HelpView from '../../views/HelpView';
import LoginView from '../../views/LoginView';
import RegisterView from '../../views/RegisterView';

// Utils
import { BACKEND_URL, THEMES } from '../../utils/constants';

/**
 * @file AppContent.jsx
 * Main application layout and routing.
 */
const AppContent = () => {
  const { targetLanguage, setTargetLanguage, languages } = useContext(LanguageContext);
  const { theme, setTheme, fetchNewBg, isBgLoading, bgPhotographer } = useContext(ThemeContext);
  const { user } = useContext(AuthContext);
  const isGerman = targetLanguage?.code === 'de';
  const location = useLocation();
  const [isHelpModalOpen, setIsHelpModalOpen] = useState(false);

  const navItems = [
    { id: 'dashboard', path: '/', icon: LayoutDashboard, labelEn: 'Dashboard', labelDe: 'Dashboard' },
    { id: 'categories', path: '/categories', icon: Filter, labelEn: 'Categories', labelDe: 'Kategorien' },
    { id: 'help', path: '#', icon: HelpCircle, labelEn: 'Help', labelDe: 'Hilfe', isAction: true },
    { id: 'settings', path: '/settings', icon: Settings, labelEn: 'Settings', labelDe: 'Einstellungen' },
  ];

  return (
    <div className="flex h-screen overflow-hidden font-body antialiased text-text-main">
      {/* Sidebar */}
      <aside className="w-80 border-r border-border-main flex flex-col shrink-0 z-30 transition-all bg-bg-sidebar glass-blur">
        <div className="p-8 border-b border-white/5 mb-6">
          <Link to="/" className="flex items-center gap-4 group/logo no-underline">
            <div className="w-12 h-12 rounded-xl flex items-center justify-center shadow-xl transition-all duration-500 animate-float animate-glow group/logo:scale-110 border bg-brand-600 border-brand-600 shadow-brand-600/20 text-white">
              <DrupalLogo size={28} />
            </div>
            <div>
              <h2 className="text-sm font-black tracking-tight leading-tight uppercase text-text-main">Project Description Browser</h2>
              <p className="text-[10px] font-bold mt-0.5 uppercase tracking-widest text-brand-600">Translation Suite</p>
            </div>
          </Link>
        </div>

        {/* User Profile Section */}
        {user ? (
          <div className="px-6 mb-6">
            <Link to="/profile" className="flex items-center gap-3 p-3 rounded-2xl bg-white/5 border border-white/10 hover:bg-brand-500/10 hover:border-brand-500/50 transition-all no-underline group">
              <div className="w-10 h-10 rounded-xl overflow-hidden border-2 border-brand-500/30 flex-shrink-0 group-hover:scale-110 transition-transform">
                {user.avatar_url ? (
                  <img src={`${BACKEND_URL}${user.avatar_url}`} alt="Avatar" className="w-full h-full object-cover" />
                ) : (
                  <div className="w-full h-full bg-brand-600 flex items-center justify-center text-white text-xs font-black font-mono">
                    {user.username.substring(0, 2).toUpperCase()}
                  </div>
                )}
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-black truncate text-text-main mb-0.5">{user.name || user.username}</p>
                <p className="text-[9px] text-text-muted truncate uppercase tracking-widest font-bold">{isGerman ? 'Profil bearbeiten' : 'Edit Profile'}</p>
              </div>
              <ChevronRight size={14} className="text-text-muted group-hover:text-brand-500 transition-colors shrink-0" />
            </Link>
          </div>
        ) : (
          <div className="px-6 mb-6">
            <Link to="/login" className="flex items-center justify-center gap-2 py-3.5 rounded-xl bg-brand-600 text-white font-black text-xs shadow-lg shadow-brand-600/20 hover:scale-[1.02] active:scale-95 transition-all no-underline">
              <LogIn size={16} />
              {isGerman ? 'ANMELDEN' : 'LOGIN'}
            </Link>
          </div>
        )}

        <nav className="flex-1 px-6 py-2 space-y-1.5 overflow-y-auto">
          {navItems.map((item) => {
            const isActive = location.pathname === item.path;
            const Icon = item.icon;
            
            if (item.isAction) {
              const isActive = item.id === 'help' && isHelpModalOpen;
              return (
                <button
                  key={item.id}
                  onClick={() => {
                    if (item.id === 'help') setIsHelpModalOpen(true);
                  }}
                  className={`w-full flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-bold transition-all group no-underline ${
                    isActive 
                      ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                      : 'text-text-muted hover:bg-white/5 hover:text-text-main'
                  }`}
                >
                  <Icon size={20} className={isActive ? 'text-white' : 'text-text-muted group-hover:text-text-main'} />
                  {isGerman ? item.labelDe : item.labelEn}
                </button>
              );
            }

            return (
              <Link
                key={item.id}
                to={item.path}
                className={`flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-bold transition-all group no-underline ${
                  isActive 
                    ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                    : 'text-text-muted hover:bg-white/5 hover:text-text-main'
                }`}
              >
                <Icon size={20} className={isActive ? 'text-white' : 'text-text-muted group-hover:text-text-main'} />
                {isGerman ? item.labelDe : item.labelEn}
              </Link>
            );
          })}
        </nav>

        <div className="p-6 mt-auto space-y-4 border-t border-white/5 bg-black/5">
          {/* Theme Switcher */}
          <div className="p-4 rounded-2xl border bg-bg-card border-border-main">
             <div className="flex items-center justify-between mb-4">
               <div className="flex items-center gap-2">
                 <Palette size={16} className="text-brand-500" />
                 <span className="text-[11px] xl:text-xs font-black text-text-muted uppercase tracking-widest">{isGerman ? 'Design' : 'Theme'}</span>
               </div>
               <button 
                onClick={() => fetchNewBg()} 
                disabled={isBgLoading}
                className={`flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg bg-white/5 text-text-muted hover:bg-brand-600 hover:text-white transition-all text-[10px] xl:text-xs font-bold border border-border-main group/refresh ${isBgLoading ? 'opacity-50 cursor-wait' : ''}`}
                title={isGerman ? 'Hintergrundbild wechseln' : 'Change Background Image'}
               >
                 <RefreshCw size={12} className={`${isBgLoading ? 'animate-spin' : 'group-hover/refresh:rotate-180'} transition-transform duration-500`} />
                 {isGerman ? (isBgLoading ? 'Lädt...' : 'Bild') : (isBgLoading ? 'Loading...' : 'Refresh')}
               </button>
              </div>
              {bgPhotographer && (
                <div className="mb-4 px-3 py-2.5 rounded-xl bg-white/5 border border-white/10 text-[11px] xl:text-xs 2xl:text-sm text-text-muted leading-relaxed opacity-90 hover:opacity-100 transition-all flex flex-wrap items-center gap-2 shadow-inner">
                  <Camera size={14} className="text-brand-500 shrink-0" />
                  <span className="font-medium">{isGerman ? 'Foto von' : 'Photo by'}</span>
                  <a 
                    href={bgPhotographer.link}
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="underline decoration-brand-500/30 hover:decoration-brand-500 hover:text-brand-500 font-black transition-all"
                  >
                    {bgPhotographer.name}
                  </a>
                  <span className="font-medium">{isGerman ? 'auf' : 'on'}</span>
                  <a 
                    href="https://unsplash.com/?utm_source=pb_translation_hub&utm_medium=referral"
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="underline decoration-brand-500/30 hover:decoration-brand-500 hover:text-brand-500 font-black transition-all"
                  >
                    Unsplash
                  </a>
                </div>
              )}
             <div className="grid grid-cols-2 gap-2">
               {THEMES.map(t => {
                 const TIcon = ICON_MAP[t.icon] || Palette;
                 const isSelected = theme === t.id;
                 return (
                   <button
                     key={t.id}
                     onClick={() => setTheme(t.id)}
                     className={`flex flex-col items-center gap-1.5 p-2 rounded-xl border text-[11px] xl:text-xs font-bold transition-all ${
                       isSelected 
                        ? 'bg-brand-600 border-brand-600 text-white shadow-sm' 
                        : 'bg-bg-input border-border-main text-text-muted hover:border-text-muted'
                     }`}
                   >
                     <TIcon size={18} />
                     {isGerman ? (t.nameDe) : (t.name)}
                   </button>
                 );
               })}
             </div>
          </div>

          {/* Language Switcher */}
          <div className="p-4 rounded-2xl border bg-bg-card border-border-main">
            <div className="flex items-center gap-2 mb-3 text-[11px] xl:text-xs font-black text-text-muted uppercase tracking-widest">
              <Globe size={16} className="text-brand-500" />
              {isGerman ? 'Zielsprache' : 'Target Language'}
            </div>
            <select
              className="w-full border rounded-xl focus:ring-4 focus:ring-brand-500/20 outline-none transition-all cursor-pointer p-2.5 text-sm font-bold bg-bg-input border-border-main text-text-main"
              value={targetLanguage.code}
              onChange={(e) => {
                const lang = languages.find(l => l.code === e.target.value);
                if (lang) setTargetLanguage(lang);
              }}
            >
              {languages.map(lang => (
                <option key={lang.code} value={lang.code} className="bg-bg-card">{lang.name}</option>
              ))}
            </select>
          </div>
        </div>
      </aside>

      {/* Main Content Area */}
      <main className="flex-1 overflow-y-auto transition-all bg-bg-app glass-blur">
        <div className="min-h-full flex flex-col">
          <Routes>
            <Route path="/login" element={<LoginView />} />
            <Route path="/register" element={<RegisterView />} />
            <Route path="/" element={<Dashboard isGerman={isGerman} />} />
            <Route path="/edit/:machineName" element={user ? <Editor isGerman={isGerman} /> : <Navigate to="/login" />} />
            <Route path="/categories" element={<CategoriesView isGerman={isGerman} />} />
            <Route path="/settings" element={user ? <SettingsView isGerman={isGerman} /> : <Navigate to="/login" />} />
            <Route path="/profile" element={user ? <ProfileView isGerman={isGerman} /> : <Navigate to="/login" />} />
            <Route path="/help" element={<HelpView isGerman={isGerman} />} />
          </Routes>
          
          <Modal 
            isOpen={isHelpModalOpen} 
            onClose={() => setIsHelpModalOpen(false)}
            theme={theme}
          >
            <HelpView isModal={true} />
          </Modal>
        </div>
      </main>
    </div>
  );
};

export default AppContent;
