import React, { useState, useEffect, createContext, useContext } from 'react';
import { BrowserRouter as Router, Routes, Route, Link, useParams, useNavigate, useLocation } from 'react-router-dom';
import axios from 'axios';
import {
  LayoutDashboard,
  Languages,
  Search,
  ChevronRight,
  ChevronLeft,
  ChevronsLeft,
  ChevronsRight,
  Save,
  ArrowLeft,
  CheckCircle,
  AlertCircle,
  Clock,
  ExternalLink,
  RefreshCw,
  Info,
  XCircle,
  Globe,
  Zap,
  Filter,
  Code,
  Eye,
  Settings,
  Moon,
  Sun,
  Palette,
  Play,
  Download,
  Plus,
  HelpCircle,
  FileText,
  Square,
  Droplets,
  X
} from 'lucide-react';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import './App.css';

const API_BASE = import.meta.env.VITE_API_BASE_URL || '/api';

// --- Context ---
const LanguageContext = createContext();
const ToastContext = createContext();
const ThemeContext = createContext();

const THEMES = [
  { id: 'light', labelEn: 'Modern Light', labelDe: 'Modern Hell', icon: Sun },
  { id: 'dark', labelEn: 'Modern Dark', labelDe: 'Modern Dunkel', icon: Moon },
  { id: 'liquid', labelEn: 'Liquid Blue', labelDe: 'Flüssiges Blau', icon: Droplets },
  { id: 'glassy', labelEn: 'Glassy Nature', labelDe: 'Gläserne Natur', icon: Palette }
];

// --- Components ---

const ToastContainer = ({ toasts }) => {
  const { theme } = useContext(ThemeContext);
  return (
    <div className="fixed bottom-8 right-8 z-[100] flex flex-col gap-3 pointer-events-none">
      {toasts.map(toast => (
        <div 
          key={toast.id} 
          className={`pointer-events-auto flex items-center gap-3 px-5 py-3.5 rounded-xl border shadow-2xl animate-slide-in min-w-[320px] transition-all ${
            theme === 'glassy' ? 'bg-black/80 border-white/10 text-white glass-blur' : 'bg-bg-card border-border-main text-text-main'
          }`}
        >
          <div className="shrink-0">
            {toast.type === 'success' ? (
              <CheckCircle size={20} className="text-green-500" />
            ) : (
              <AlertCircle size={20} className={toast.type === 'error' ? 'text-red-500' : 'text-brand-500'} />
            )}
          </div>
          <span className="text-sm font-semibold tracking-tight">{toast.message}</span>
        </div>
      ))}
    </div>
  );
};

const StatusBadge = ({ status }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const { theme } = useContext(ThemeContext);
  const isGerman = targetLanguage?.code === 'de';

  const config = {
    translated: {
      label: isGerman ? 'Übersetzt' : 'Translated',
      dot: 'bg-green-500',
      classes: theme === 'glassy' ? 'bg-green-500/20 border-green-500/30 text-green-400' : 'bg-green-50 text-green-700 border-green-200'
    },
    stale: {
      label: isGerman ? 'Veraltet' : 'Stale',
      dot: 'bg-amber-500',
      classes: theme === 'glassy' ? 'bg-amber-500/20 border-amber-500/30 text-amber-400' : 'bg-amber-50 text-amber-700 border-amber-200'
    },
    missing: {
      label: isGerman ? 'Fehlend' : 'Missing',
      dot: 'bg-gray-400',
      classes: theme === 'glassy' ? 'bg-white/10 border-white/20 text-white/70' : 'bg-bg-input text-text-muted border-border-main'
    }
  };

  const s = config[status] || config.missing;

  return (
    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold border transition-all ${s.classes}`}>
      <span className={`w-1.5 h-1.5 rounded-full mr-1.5 ${s.dot}`}></span>
      {s.label}
    </span>
  );
};

const SyncProgressBar = ({ status, onStop }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const { theme } = useContext(ThemeContext);
  const isGerman = targetLanguage?.code === 'de';

  if (!status.active && status.current === 0) return null;

  const percentage = status.finished ? 100 : Math.min(Math.round((status.current / status.total) * 100), 100);

  const containerClasses = theme === 'glassy' 
    ? `border glass-blur p-6 mb-10 rounded-2xl shadow-xl transition-all ${status.finished ? 'bg-green-500/20 border-green-500/30' : 'bg-black/30 border-white/10'}`
    : `border p-6 mb-10 rounded-2xl shadow-sm transition-all ${status.finished ? 'bg-green-500/10 border-green-500/20' : 'bg-bg-card border-border-main'}`;

  return (
    <div className={`${containerClasses} animate-in slide-in-from-top duration-300`}>
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-5">
        <div className="flex items-center gap-4">
          {status.finished ? (
            <div className={`w-12 h-12 rounded-xl flex items-center justify-center shadow-sm ${theme === 'glassy' ? 'bg-green-500/20 text-green-400' : 'bg-green-50 text-green-600'}`}>
              <CheckCircle size={24} />
            </div>
          ) : (
            <div className={`w-12 h-12 rounded-xl flex items-center justify-center shadow-sm ${theme === 'glassy' ? 'bg-white/10 text-white' : 'bg-brand-50 text-brand-600'}`}>
              <RefreshCw size={24} className={`animate-spin ${theme === 'glassy' ? 'text-white' : ''}`} />
            </div>
          )}
          <div>
            <h4 className="font-bold text-lg leading-tight">
              {status.finished ? (isGerman ? 'Synchronisierung abgeschlossen' : 'Sync Complete') : (isGerman ? 'Synchronisierung läuft...' : 'Syncing Projects...')}
            </h4>
            <p className="text-sm text-text-muted mt-1 font-medium">
              {status.finished ? (isGerman ? `${status.current.toLocaleString()} Projekte auf dem neuesten Stand.` : `${status.current.toLocaleString()} projects up to date.`) : (isGerman ? `Verarbeite: ${status.lastMachineName}` : `Processing: ${status.lastMachineName}`)}
            </p>
          </div>
        </div>
        {!status.finished && status.active && (
          <button 
            onClick={onStop}
            className={`flex items-center gap-2 px-4 py-2 border rounded-xl text-xs font-bold transition-all ${
              theme === 'glassy' ? 'bg-white/10 border-white/20 text-white hover:bg-red-500/50 hover:border-red-500' : 'bg-bg-input border-border-main text-text-main hover:bg-red-50 hover:text-red-600 hover:border-red-200'
            }`}
          >
            <Square size={14} fill="currentColor" />
            {isGerman ? 'Stoppen' : 'Stop'}
          </button>
        )}
      </div>

      <div className="relative h-3 w-full bg-black/10 rounded-full overflow-hidden border border-white/5 shadow-inner">
        <div 
          className={`h-full transition-all duration-500 ease-out relative ${status.finished ? 'bg-green-500' : 'bg-brand-600'}`}
          style={{ width: `${percentage}%` }}
        >
          {!status.finished && (
            <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent animate-shimmer" style={{ backgroundSize: '200% 100%' }}></div>
          )}
        </div>
      </div>
      <div className="flex justify-between items-center mt-3">
        <span className="text-[10px] font-bold text-text-muted uppercase tracking-widest">{percentage}% {isGerman ? 'fertig' : 'complete'}</span>
        <span className="text-[10px] font-bold text-text-muted uppercase tracking-widest">{status.current.toLocaleString()} / {status.total.toLocaleString()}</span>
      </div>
    </div>
  );
};

const DrupalLogo = ({ size = 32, ...props }) => (
  <svg width={size} height={size} viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg" {...props}>
    <path d="M8.563 16.5c-3.718 0-7.062-2.926-7.062-6.906 0-3.974 3.098-5.813 3.672-6.114 0.684-0.364 1.176-0.556 1.95-1.175 0.383-0.301 0.702-0.739 0.803-1.805 0.555 0.665 1.221 1.439 1.694 1.759 0.775 0.51 1.55 0.711 2.36 1.221 0.492 0.301 3.518 2.15 3.518 6.241 0 4.082-3.226 6.779-6.935 6.779zM14.030 9.903c-0.729 0-2.205 1.513-2.979 1.522-0.901 0.018-2.149-1.787-3.954-1.77-1.422 0.010-2.542 1.14-2.561 2.343-0.009 0.675 0.21 1.176 0.675 1.494 0.31 0.209 0.592 0.337 1.512 0.337 1.531 0 3.472-1.896 4.365-1.867 0.71 0.026 1.812 1.768 2.369 1.804 0.437 0.036 0.665-0.164 1.038-0.701 0.364-0.547 0.52-1.404 0.52-1.887 0-0.473-0.21-1.275-0.985-1.275zM11.917 14.741c-0.31 0.228-1.003 0.511-1.987 0.511s-1.448-0.21-1.758-0.447c-0.045-0.036-0.027-0.036-0.119-0.036-0.1 0-0.154 0.046-0.236 0.109-0.073 0.064-0.109 0.219 0 0.328 0.674 0.619 1.804 0.565 2.633 0.491 0.839-0.082 1.55-0.573 1.622-0.646 0.109-0.108 0.082-0.2 0.063-0.264-0.018-0.064-0.073-0.154-0.218-0.046zM11.424 13.184c-0.182-0.118-0.445-0.137-0.691-0.137-0.247 0-0.383-0.018-0.646 0.091-0.266 0.109-0.539 0.355-0.711 0.511-0.174 0.154-0.201 0.273-0.11 0.401 0.092 0.117 0.192 0.044-0.447-0.174 0.264-0.21 0.438-0.401 0.975-0.401s0.629 0.201 0.737 0.401c0.11 0.2 0.119 0.228 0.228 0.174 0.128-0.064 0.192-0.156 0.128-0.312-0.065-0.154-0.174-0.427-0.357-0.554z" fill="currentColor" />
  </svg>
);

// --- Views ---

const SearchWithAutocomplete = ({ value, onChange, isGerman, onSelect }) => {
  const [inputValue, setInputValue] = useState(value);
  const [suggestions, setSuggestions] = useState([]);
  const [selectedIndex, setSelectedIndex] = useState(-1);
  const [showDropdown, setShowDropdown] = useState(false);
  const { targetLanguage } = useContext(LanguageContext);
  const { theme } = useContext(ThemeContext);
  const dropdownRef = React.useRef(null);

  useEffect(() => {
    setInputValue(value);
  }, [value]);

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setShowDropdown(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const fetchSuggestions = async (q) => {
    if (q.length < 2) {
      setSuggestions([]);
      return;
    }
    try {
      const res = await axios.get(`${API_BASE}/autocomplete`, {
        params: { q, langcode: targetLanguage.code }
      });
      setSuggestions(res.data);
      setShowDropdown(true);
      setSelectedIndex(-1);
    } catch (err) {
      console.error(err);
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      setSelectedIndex(prev => (prev < suggestions.length - 1 ? prev + 1 : prev));
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      setSelectedIndex(prev => (prev > 0 ? prev - 1 : -1));
    } else if (e.key === 'Enter') {
      if (selectedIndex >= 0 && suggestions[selectedIndex]) {
        e.preventDefault();
        const selected = suggestions[selectedIndex];
        onSelect(selected.machine_name);
        setShowDropdown(false);
      } else {
        onChange(inputValue);
        setShowDropdown(false);
      }
    } else if (e.key === 'Escape') {
      setShowDropdown(false);
    }
  };

  return (
    <div className="relative" ref={dropdownRef}>
      <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none">
        <Search className="h-5 w-5 text-gray-400" />
      </div>
      <input
        type="text"
        placeholder={isGerman ? "Projekte suchen..." : "Search projects..."}
        className={`block w-full md:w-80 pl-10 pr-3 py-2.5 rounded-lg text-sm focus:ring-4 outline-none transition-all shadow-sm border ${
          theme === 'glassy' ? 'bg-white/10 border-white/20 text-white placeholder-white/50 focus:ring-brand-500/20' : 'bg-white border-gray-300 text-gray-900 focus:ring-brand-100 focus:border-brand-300'
        }`}
        value={inputValue}
        onChange={(e) => {
          setInputValue(e.target.value);
          clearTimeout(window.autoTimeout);
          window.autoTimeout = setTimeout(() => fetchSuggestions(e.target.value), 300);
          
          clearTimeout(window.searchTimeout);
          window.searchTimeout = setTimeout(() => onChange(e.target.value), 800);
        }}
        onKeyDown={handleKeyDown}
        onFocus={() => { if (suggestions.length > 0) setShowDropdown(true); }}
      />

      {showDropdown && suggestions.length > 0 && (
        <div className={`absolute top-full left-0 right-0 mt-2 rounded-xl shadow-lg z-50 overflow-hidden py-1 animate-in fade-in zoom-in-95 duration-100 border ${
          theme === 'glassy' ? 'bg-black/80 border-white/10 glass-blur text-white' : 'bg-white border-gray-200'
        }`}>
          {suggestions.map((s, i) => (
            <div
              key={s.machine_name}
              className={`px-4 py-2.5 cursor-pointer flex flex-col transition-colors ${
                theme === 'glassy' 
                  ? (i === selectedIndex ? 'bg-white/20' : 'hover:bg-white/10') 
                  : (i === selectedIndex ? 'bg-brand-50' : 'hover:bg-gray-50')
              }`}
              onClick={() => {
                onSelect(s.machine_name);
                setShowDropdown(false);
              }}
              onMouseEnter={() => setSelectedIndex(i)}
            >
              <div className="flex justify-between items-center">
                <span className={`text-sm font-semibold ${
                  theme === 'glassy' 
                    ? (i === selectedIndex ? 'text-white' : 'text-white/90')
                    : (i === selectedIndex ? 'text-brand-700' : 'text-gray-900')
                }`}>
                  {s.title}
                </span>
                <StatusBadge status={s.translation_status} />
              </div>
              <span className={`text-xs font-mono mt-0.5 ${theme === 'glassy' ? 'text-white/50' : 'text-gray-500'}`}>{s.machine_name}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

const Dashboard = ({ isGerman }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const { theme } = useContext(ThemeContext);
  const navigate = useNavigate();
  const [projects, setProjects] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState(localStorage.getItem('pb-search') || '');
  const [activeFilter, setActiveFilter] = useState(localStorage.getItem('pb-activeFilter') || 'missing');
  const [currentPage, setCurrentPage] = useState(1);
  const [limit, setLimit] = useState(50);
  const [totalItems, setTotalItems] = useState(0);
  const [syncStatus, setSyncStatus] = useState({ active: false, current: 0, total: 50000 });
  const [manualMachineName, setManualMachineName] = useState('');
  const [syncingManual, setSyncingManual] = useState(false);
  const { showToast } = useContext(ToastContext);

  async function fetchProjects(searchTerm = search) {
    setLoading(true);
    try {
      const offset = (currentPage - 1) * limit;
      const res = await axios.get(`${API_BASE}/projects`, {
        params: {
          search: searchTerm,
          langcode: targetLanguage.code,
          filter: activeFilter === 'all' ? undefined : activeFilter,
          offset,
          limit
        }
      });
      setProjects(res.data.data);
      setTotalItems(res.data.meta.count || 0);
      setLoading(false);
      localStorage.setItem('pb-activeFilter', activeFilter);
      localStorage.setItem('pb-search', searchTerm || '');
    } catch (err) {
      console.error(err);
      setLoading(false);
    }
  }

  async function fetchSyncStatus() {
    try {
      const res = await axios.get(`${API_BASE}/sync/status`);
      setSyncStatus(res.data);
      if (!res.data.active && syncStatus.active) {
        fetchProjects(search);
      }
    } catch (err) {
      console.error(err);
    }
  }

  async function handleSyncStart() {
    try {
      await axios.post(`${API_BASE}/sync/start`);
    } catch (err) {
      showToast('Failed to start sync', 'error');
    }
  }

  async function handleQuickUpdate() {
    try {
      await axios.post(`${API_BASE}/sync/quick`, { days: 7 });
    } catch (err) {
      showToast('Failed to start quick update', 'error');
    }
  }

  async function handleSyncStop() {
    try {
      await axios.post(`${API_BASE}/sync/stop`);
    } catch (err) {
      console.error(err);
    }
  }

  async function handleImportLocal() {
    try {
      const res = await axios.post(`${API_BASE}/import-local`);
      showToast(isGerman ? `Erfolgreich ${res.data.count} Dateien aus Drupal importiert.` : `Imported ${res.data.count} files from Drupal.`);
      fetchProjects();
    } catch (err) {
      showToast(isGerman ? 'Import fehlgeschlagen.' : 'Import failed.', 'error');
    }
  }

  async function handleManualSync(e) {
    e.preventDefault();
    if (!manualMachineName.trim()) return;
    
    setSyncingManual(true);
    try {
      const res = await axios.post(`${API_BASE}/sync/project/${manualMachineName.trim()}`);
      showToast(isGerman ? `Erfolgreich synchronisiert: ${res.data.title}` : `Successfully synced: ${res.data.title}`, 'success');
      setManualMachineName('');
      fetchProjects();
    } catch (err) {
      showToast(isGerman ? 'Modul nicht auf Drupal.org gefunden.' : 'Module not found on Drupal.org.', 'error');
    } finally {
      setSyncingManual(false);
    }
  }

  useEffect(() => {
    fetchProjects();
    const interval = setInterval(fetchSyncStatus, 2000);
    return () => clearInterval(interval);
  }, [targetLanguage, activeFilter, currentPage, limit]);

  return (
    <div className="max-w-7xl mx-auto px-6 sm:px-10 lg:px-12 py-12 animate-fade">
      <div className={`flex flex-col lg:flex-row lg:items-end justify-between gap-8 mb-12 pb-10 border-b ${theme === 'glassy' ? 'border-white/10' : 'border-border-main'}`}>
        <div className="max-w-2xl">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-10 h-10 rounded-xl bg-brand-600/10 flex items-center justify-center text-brand-600 shadow-sm border border-brand-600/20">
              <DrupalLogo size={24} />
            </div>
            <h1 className="text-4xl font-bold tracking-tight">{isGerman ? 'Projekt-Beschreibungen' : 'Project Descriptions'}</h1>
          </div>
          <p className="text-lg text-text-muted font-medium leading-relaxed">
            {isGerman ? 'Übersetzung von Drupal Modulen in das Deutsche. Hilf mit, das Ökosystem zugänglicher zu machen.' : 'Localizing Drupal modules. Help make the ecosystem more accessible to non-English speakers.'}
          </p>
          <div className="flex flex-wrap gap-2.5 mt-8">
            {[
              { id: 'all', label: isGerman ? 'Alle Projekte' : 'All Projects' },
              { id: 'missing', label: isGerman ? 'Fehlend' : 'Missing' },
              { id: 'stale', label: isGerman ? 'Veraltet' : 'Stale' },
              { id: 'translated', label: isGerman ? 'Übersetzt' : 'Translated' }
            ].map(filter => (
              <button
                key={filter.id}
                className={`px-4 py-2 rounded-lg text-sm font-bold transition-all border shadow-sm ${
                  activeFilter === filter.id 
                    ? (theme === 'glassy' ? 'bg-brand-500/30 text-white border-brand-400/50 ring-4 ring-brand-500/20 shadow-[0_0_20px_rgba(127,86,217,0.3)]' : 'bg-brand-600 text-white border-brand-600 ring-4 ring-brand-500/10')
                    : (theme === 'glassy' ? 'bg-white/5 text-white border-white/10 hover:bg-white/10' : 'bg-bg-card text-text-main border-border-main hover:bg-bg-card-hover')
                }`}
                onClick={() => {
                  setActiveFilter(filter.id);
                  setCurrentPage(1);
                }}
              >
                {filter.label}
              </button>
            ))}
          </div>
        </div>
        <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 shrink-0">
          <SearchWithAutocomplete 
            value={search} 
            isGerman={isGerman} 
            onChange={(val) => {
              setSearch(val);
              fetchProjects(val);
            }}
            onSelect={(machineName) => {
              navigate(`/edit/${machineName}`);
            }}
          />
          <button 
            className={`flex items-center justify-center gap-2 px-5 py-2.5 border rounded-lg text-sm font-bold transition-all shadow-sm group ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white hover:bg-white/10' : 'bg-bg-card border-border-main text-text-main hover:bg-bg-card-hover'
            }`} 
            onClick={handleQuickUpdate} 
            disabled={syncStatus.active}
          >
            <Zap size={18} className="text-brand-500 group-hover:scale-110 transition-transform" />
            {isGerman ? 'Schnell-Update' : 'Quick Update'}
          </button>
          <button 
            className={`flex items-center justify-center gap-2 px-6 py-2.5 rounded-lg text-sm font-bold transition-all disabled:opacity-50 border ${
              theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white hover:bg-brand-500/60 shadow-lg shadow-brand-500/20' : 'bg-brand-600 border-brand-600 text-white hover:bg-brand-700 shadow-xl shadow-brand-600/20'
            }`} 
            onClick={handleSyncStart} 
            disabled={syncStatus.active}
          >
            <RefreshCw size={18} className={syncStatus.active ? 'animate-spin' : ''} />
            {isGerman ? 'Full Sync' : 'Full Sync'}
          </button>
        </div>
      </div>

      <SyncProgressBar status={syncStatus} onStop={handleSyncStop} />

      <div className={`border rounded-2xl p-8 mb-12 shadow-sm flex flex-col md:flex-row md:items-center gap-8 group ${
        theme === 'glassy' ? 'bg-black/20 border-white/10' : 'bg-bg-card border-border-main'
      }`}>
        <div className={`flex items-center justify-center w-14 h-14 rounded-xl shrink-0 shadow-sm transition-transform group-hover:scale-105 ${
          theme === 'glassy' ? 'bg-white/10 text-white' : 'bg-brand-50 text-brand-600'
        }`}>
          <Download size={28} />
        </div>
        <div className="flex-1">
          <h4 className="text-xl font-bold leading-tight">{isGerman ? 'Manuelles Hinzufügen' : 'Add Single Module'}</h4>
          <p className="text-sm text-text-muted font-medium mt-1">{isGerman ? 'Gib den Machine Name eines Drupal-Moduls ein.' : 'Enter the machine name from Drupal.org (e.g. "pathauto").'}</p>
        </div>
        <form onSubmit={handleManualSync} className="flex gap-3">
          <input 
            type="text" 
            placeholder="machine_name"
            value={manualMachineName}
            onChange={(e) => setManualMachineName(e.target.value)}
            className={`w-full md:w-72 px-4 py-3 rounded-xl text-sm font-bold focus:ring-4 focus:ring-brand-500/20 outline-none transition-all shadow-inner border ${
              theme === 'glassy' ? 'bg-white/10 border-white/20 text-white' : 'bg-bg-input border-border-main text-text-main'
            }`}
          />
          <button 
            className={`flex items-center gap-2 px-6 py-3 rounded-xl text-sm font-bold transition-all disabled:opacity-50 shrink-0 border ${
              theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white hover:bg-brand-500/60 shadow-lg shadow-brand-500/20' : 'bg-brand-600 border-brand-600 text-white hover:bg-brand-700 shadow-lg shadow-brand-600/20'
            }`} 
            disabled={syncingManual}
          >
            {syncingManual ? <RefreshCw size={18} className="animate-spin" /> : <Plus size={18} />}
            {isGerman ? 'Hinzufügen' : 'Add Module'}
          </button>
        </form>
      </div>

      <div className="flex justify-between items-center mb-6">
        <div className={`text-sm ${theme === 'glassy' ? 'text-white/70' : 'text-gray-600'}`}>
          {isGerman ? 'Gefunden:' : 'Found:'} <span className={`font-semibold ${theme === 'glassy' ? 'text-white' : 'text-gray-900'}`}>{totalItems.toLocaleString()}</span> {isGerman ? 'Module' : 'Modules'}
        </div>
        <div className="flex items-center gap-3">
          <label className={`text-sm ${theme === 'glassy' ? 'text-white/70' : 'text-gray-600'}`}>{isGerman ? 'Pro Seite:' : 'Per page:'}</label>
          <select
            value={limit}
            onChange={(e) => {
              setLimit(parseInt(e.target.value));
              setCurrentPage(1);
            }}
            className={`text-sm rounded-lg focus:ring-brand-500 focus:border-brand-500 block p-2 transition-all outline-none border ${
              theme === 'glassy' ? 'bg-white/10 border-white/20 text-white' : 'bg-white border-gray-300 text-gray-700'
            }`}
          >
            <option value="50" className={theme === 'glassy' ? 'bg-gray-900' : ''}>50</option>
            <option value="100" className={theme === 'glassy' ? 'bg-gray-900' : ''}>100</option>
            <option value="250" className={theme === 'glassy' ? 'bg-gray-900' : ''}>250</option>
            <option value="500" className={theme === 'glassy' ? 'bg-gray-900' : ''}>500</option>
          </select>
        </div>
      </div>

      {loading ? (
        <div className="flex flex-col items-center justify-center py-24">
          <RefreshCw size={48} className={`animate-spin mb-4 ${theme === 'glassy' ? 'text-white drop-shadow-[0_0_10px_rgba(255,255,255,0.5)]' : 'text-brand-600'}`} />
          <p className={theme === 'glassy' ? 'text-white/70 font-medium' : 'text-gray-600 font-medium'}>{isGerman ? 'Projekte werden geladen...' : 'Fetching project data...'}</p>
        </div>
      ) : (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {projects.map(project => (
          <Link 
            key={project.id}
            to={`/edit/${project.attributes.field_project_machine_name}`}
            className={`group relative flex flex-col p-8 rounded-2xl border transition-all no-underline overflow-hidden ${
              theme === 'glassy' ? 'bg-black/30 border-white/10 hover:bg-black/40 hover:border-white/20' : 'bg-bg-card border-border-main hover:bg-bg-card-hover'
            }`}
          >
            {/* Status Indicator Bar */}
            <div className={`absolute top-0 left-0 right-0 h-1.5 ${
              project.meta?.translation_status === 'translated' ? 'bg-green-500' :
              project.meta?.translation_status === 'stale' ? 'bg-amber-500' : 
              (theme === 'glassy' ? 'bg-white/10' : 'bg-border-main')
            }`}></div>

            <div className="flex gap-5 mb-6">
              <div className={`w-16 h-16 rounded-2xl flex items-center justify-center shrink-0 border overflow-hidden shadow-inner group-hover:scale-105 transition-transform duration-300 ${
                theme === 'glassy' ? 'bg-white/10 border-white/10' : 'bg-bg-input border-border-muted'
              }`}>
                {project.meta?.logo_url ? (
                  <img src={project.meta.logo_url} alt="" className="w-full h-full object-contain p-2" />
                ) : (
                  <Zap size={32} className="text-brand-600 opacity-20" />
                )}
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex justify-between items-start gap-2 mb-2">
                  <StatusBadge status={project.meta?.translation_status} />
                  <span className="text-[10px] font-bold text-text-muted uppercase tracking-widest font-mono truncate">{project.attributes.field_project_machine_name}</span>
                </div>
                <h3 className={`text-xl font-bold leading-tight transition-colors line-clamp-2 ${
                  theme === 'glassy' ? 'text-white' : 'text-text-main group-hover:text-brand-600'
                }`}>
                  {project.meta?.translation?.title || project.attributes.title}
                </h3>
              </div>
            </div>
            
            <div 
              className={`text-sm font-medium leading-relaxed line-clamp-3 mb-8 flex-1 ${theme === 'glassy' ? 'text-white/70' : 'text-text-muted'}`} 
              dangerouslySetInnerHTML={{ __html: project.meta?.translation?.summary || project.attributes.body?.summary || (isGerman ? 'Keine Zusammenfassung verfügbar.' : 'No summary available.') }}
            />

            <div className={`flex items-center justify-between pt-6 border-t ${theme === 'glassy' ? 'border-white/10' : 'border-border-muted'}`}>
              <div className="flex items-center gap-2 text-xs font-bold text-text-muted">
                <FileText size={14} />
                {project.attributes.title !== (project.meta?.translation?.title || project.attributes.title) ? (
                   <span className="truncate max-w-[120px]">{project.attributes.title}</span>
                ) : (
                   <span>{isGerman ? 'Quelle: Englisch' : 'Source: English'}</span>
                )}
              </div>
              <button className={`flex items-center gap-2 px-4 py-2 rounded-xl border text-xs font-bold transition-all shadow-sm whitespace-nowrap ${
                theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-input border-border-main text-text-main group-hover:bg-brand-600 group-hover:text-white group-hover:border-brand-600'
              }`}>
                {isGerman ? `${project.attributes.title} bearbeiten` : `Edit ${project.attributes.title}`}
                <ChevronRight size={14} />
              </button>
            </div>
          </Link>
        ))}
      </div>
      )}

      {!loading && totalItems > limit && (
        <div className="flex justify-center items-center gap-2 mt-12">
          <button
            className={`p-2 rounded-lg border transition-all disabled:opacity-20 ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover'
            }`}
            disabled={currentPage === 1}
            onClick={() => {
              setCurrentPage(1);
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
          >
            <ChevronsLeft size={20} />
          </button>

          <button
            className={`p-2 rounded-lg border transition-all disabled:opacity-20 ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover'
            }`}
            disabled={currentPage === 1}
            onClick={() => {
              setCurrentPage(prev => Math.max(1, prev - 1));
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
          >
            <ChevronLeft size={20} />
          </button>

          <div className="text-sm font-medium mx-4">
            {isGerman ? 'Seite' : 'Page'} <span className="text-brand-600 font-bold">{currentPage}</span> {isGerman ? 'von' : 'of'} <span className="font-bold">{Math.ceil(totalItems / limit)}</span>
          </div>

          <button
            className={`p-2 rounded-lg border transition-all disabled:opacity-20 ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover'
            }`}
            disabled={currentPage >= Math.ceil(totalItems / limit)}
            onClick={() => {
              setCurrentPage(prev => prev + 1);
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
          >
            <ChevronRight size={20} />
          </button>

          <button
            className={`p-2 rounded-lg border transition-all disabled:opacity-20 ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover'
            }`}
            disabled={currentPage >= Math.ceil(totalItems / limit)}
            onClick={() => {
              setCurrentPage(Math.ceil(totalItems / limit));
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
          >
            <ChevronsRight size={20} />
          </button>
        </div>
      )}
    </div>
  );
};

const CategoriesView = ({ isGerman }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const { theme } = useContext(ThemeContext);
  const [categories, setCategories] = useState([]);
  const [translations, setTranslations] = useState({});
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const { showToast } = useContext(ToastContext);

  async function fetchCategories() {
    setLoading(true);
    try {
      const res = await axios.get(`${API_BASE}/categories`, {
        params: { langcode: targetLanguage.code }
      });
      setCategories(res.data.data);
      const initialTrans = {};
      res.data.data.forEach(cat => {
        if (cat.meta?.translated_name) {
          initialTrans[cat.id] = cat.meta.translated_name;
        }
      });
      setTranslations(initialTrans);
      setLoading(false);
    } catch (err) {
      console.error(err);
      setLoading(false);
    }
  }

  async function handleSave() {
    setSaving(true);
    try {
      await axios.post(`${API_BASE}/categories/translate`, {
        langcode: targetLanguage.code,
        translations: translations
      });
      showToast(isGerman ? 'Kategorien erfolgreich gespeichert.' : 'Categories saved successfully.');
    } catch (err) {
      console.error(err);
      showToast(isGerman ? 'Fehler beim Speichern.' : 'Failed to save.', 'error');
    } finally {
      setSaving(false);
    }
  }

  useEffect(() => {
    fetchCategories();
  }, [targetLanguage]);

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 animate-fade">
      <div className={`flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8 pb-8 border-b ${theme === 'glassy' ? 'border-white/10' : 'border-border-main'}`}>
        <div>
          <h1 className="text-3xl font-bold tracking-tight">{isGerman ? 'Kategorien' : 'Categories'}</h1>
          <p className="text-text-muted mt-1">{isGerman ? 'Übersetzung für:' : 'Translating for:'} <span className="font-semibold text-brand-500">{targetLanguage.name}</span></p>
        </div>
        <div className="flex items-center gap-3">
          <button 
            className={`flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-sm ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white hover:bg-white/10' : 'bg-bg-card border-border-main text-text-main hover:bg-bg-card-hover'
            }`}
            onClick={async () => {
              try {
                const res = await axios.post(`${API_BASE}/categories/import-local`, { langcode: targetLanguage.code });
                showToast(isGerman ? `Erfolgreich ${res.data.count} Bezeichnungen importiert!` : `Successfully imported ${res.data.count} items!`);
                fetchCategories();
              } catch (err) {
                showToast(isGerman ? 'Keine Import-Datei gefunden.' : 'No import file found.', 'error');
              }
            }}
          >
            <RefreshCw size={18} className="text-brand-500" />
            {isGerman ? 'Aus Drupal importieren' : 'Import from Drupal'}
          </button>
          <button 
            className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white rounded-lg text-sm font-semibold hover:bg-brand-700 transition-all shadow-lg shadow-brand-600/20 disabled:opacity-50"
            onClick={handleSave} 
            disabled={saving}
          >
            <Save size={18} />
            {saving ? (isGerman ? 'Speichert...' : 'Saving...') : (isGerman ? 'Alle speichern' : 'Save All')}
          </button>
        </div>
      </div>

      <div className={`border rounded-2xl shadow-sm overflow-hidden transition-all ${
        theme === 'glassy' ? 'bg-black/40 border-white/10 glass-blur' : 'bg-bg-card border-border-main'
      }`}>
        {loading ? (
          <div className="py-24 flex flex-col items-center justify-center">
            <RefreshCw className={`animate-spin mb-4 ${theme === 'glassy' ? 'text-white drop-shadow-[0_0_10px_rgba(255,255,255,0.5)]' : 'text-brand-600'}`} size={40} />
            <p className="text-text-muted font-medium">{isGerman ? 'Lade Kategorien...' : 'Loading categories...'}</p>
          </div>
        ) : (
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className={`border-b transition-all ${theme === 'glassy' ? 'bg-white/5 border-white/10' : 'bg-bg-app border-border-main'}`}>
                <th className="px-8 py-4 text-xs font-bold text-text-muted uppercase tracking-wider">{isGerman ? 'Original (EN)' : 'Original (EN)'}</th>
                <th className="px-8 py-4 text-xs font-bold text-text-muted uppercase tracking-wider">{isGerman ? `Übersetzung (${targetLanguage.code})` : `Translation (${targetLanguage.code})`}</th>
              </tr>
            </thead>
            <tbody className={`divide-y ${theme === 'glassy' ? 'divide-white/5' : 'divide-border-muted'}`}>
              {categories.map(cat => (
                <tr key={cat.id} className={`transition-colors group ${theme === 'glassy' ? 'hover:bg-white/5' : 'hover:bg-bg-card-hover'}`}>
                  <td className="px-8 py-5 text-sm font-semibold">{cat.attributes.name}</td>
                  <td className="px-8 py-5">
                    <input
                      type="text"
                      className={`w-full px-4 py-2 rounded-lg text-sm focus:ring-4 focus:ring-brand-500/20 outline-none transition-all shadow-sm border ${
                        theme === 'glassy' ? 'bg-white/10 border-white/20 text-white' : 'bg-bg-input border-border-main text-text-main'
                      }`}
                      value={translations[cat.id] || ''}
                      onChange={e => setTranslations({ ...translations, [cat.id]: e.target.value })}
                      placeholder={isGerman ? `Übersetze "${cat.attributes.name}"...` : `Translate "${cat.attributes.name}"...`}
                    />
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
};

const Editor = ({ isGerman }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const { machineName } = useParams();
  const navigate = useNavigate();
  const [project, setProject] = useState(null);
  const [translation, setTranslation] = useState({ title: '', summary: '', body: '', screenshot_alts: {} });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [showSource, setShowSource] = useState(false);
  const [showPreview, setShowPreview] = useState(false);
  const [showSummaryHtml, setShowSummaryHtml] = useState(false);
  const [showBodyHtml, setShowBodyHtml] = useState(false);
  const [nextMachineName, setNextMachineName] = useState(null);
  const { theme } = useContext(ThemeContext);
  const { showToast } = useContext(ToastContext);

  async function fetchData() {
    setLoading(true);
    try {
      const savedFilter = localStorage.getItem('pb-activeFilter') || 'all';
      const savedSearch = localStorage.getItem('pb-search') || '';
      
      const projectRes = await axios.get(`${API_BASE}/projects/${machineName}`, {
        params: { 
          langcode: targetLanguage.code,
          filter: savedFilter,
          search: savedSearch
        }
      });
      const source = projectRes.data;
      
      const fallbackTitle = source.attributes?.title || machineName.charAt(0).toUpperCase() + machineName.slice(1);
      
      setProject(source);
      setNextMachineName(source.meta?.next_machine_name);

      try {
        const transRes = await axios.get(`${API_BASE}/translations/${targetLanguage.code}/${machineName}`);
        const t = transRes.data;
        setTranslation({
          title: t.title || fallbackTitle,
          summary: t.body?.summary || t.summary || '',
          body: t.body?.value || t.body || '',
          screenshot_alts: t.screenshot_alts || {},
          source_hash: t.source_hash || ''
        });
      } catch (err) {
        setTranslation({
          title: fallbackTitle,
          summary: source.attributes?.body?.summary || '',
          body: source.attributes?.body?.value || '',
          screenshot_alts: source.meta?.screenshot_urls?.reduce((acc, img) => ({ ...acc, [img.id]: img.alt }), {}) || {},
          source_hash: ''
        });
      }
      setLoading(false);
    } catch (err) {
      console.error(err);
      setLoading(false);
    }
  }

  function copyAiPrompt() {
    const prompt = `Übersetze die folgenden zwei HTML-Blöcke (Zusammenfassung und Hauptbeschreibung) aus dem Project Browser von Drupal nach ${targetLanguage.name}. Achte dabei darauf, Modulnamen englisch zu lassen und Links nicht zu verändern. Gib mir die Übersetzung als zwei separate HTML-Blöcke zurück:\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`;
    navigator.clipboard.writeText(prompt);
    showToast(isGerman ? 'KI-Prompt kopiert!' : 'AI Prompt copied!');
  }

  function copyHtml() {
    const raw = `${project.attributes.body?.summary || ''}\n\n${project.attributes.body?.value || ''}`;
    navigator.clipboard.writeText(raw);
    showToast(isGerman ? 'HTML kopiert' : 'HTML copied');
  }

  function togglePreview() {
    setShowPreview(!showPreview);
  }

  function goToNext() {
    if (nextMachineName) {
      navigate(`/edit/${nextMachineName}`);
    } else {
      showToast(isGerman ? 'Keine weiteren Projekte in der Liste.' : 'No more projects in the list.', 'info');
      navigate('/');
    }
  }

  async function handleSave(andNext = false) {
    setSaving(true);
    try {
      await axios.post(`${API_BASE}/translations/${targetLanguage.code}/${machineName}`, {
        ...translation
      });
      showToast(isGerman ? 'Erfolgreich gespeichert!' : 'Saved successfully!');
      if (andNext) {
        goToNext();
      }
    } catch (err) {
      console.error(err);
      showToast(isGerman ? 'Fehler beim Speichern.' : 'Failed to save translation', 'error');
    } finally {
      setSaving(false);
    }
  }

  useEffect(() => {
    fetchData();
  }, [machineName, targetLanguage]);

  useEffect(() => {
    const handleKeydown = (e) => {
      if (e.altKey && (e.ctrlKey || e.metaKey)) {
        const key = e.key.toLowerCase();
        if (key === 's') { e.preventDefault(); handleSave(true); }
        else if (key === 'd') { e.preventDefault(); goToNext(); }
        else if (key === 'p') { e.preventDefault(); togglePreview(); }
        else if (key === 'k') { e.preventDefault(); copyAiPrompt(); }
        else if (key === 'h') { e.preventDefault(); copyHtml(); }
      }
    };
    window.addEventListener('keydown', handleKeydown);
    return () => window.removeEventListener('keydown', handleKeydown);
  }, [translation, machineName, targetLanguage, project, showPreview, nextMachineName]);

  if (loading) return (
    <div className="flex flex-col items-center justify-center h-full">
      <RefreshCw size={48} className={`animate-spin mb-4 ${theme === 'glassy' ? 'text-white drop-shadow-[0_0_10px_rgba(255,255,255,0.5)]' : 'text-brand-600'}`} />
      <p className={theme === 'glassy' ? 'text-white/70 font-medium' : 'text-gray-600 font-medium'}>{isGerman ? 'Projekt-Details werden geladen...' : 'Loading project details...'}</p>
    </div>
  );

  return (
    <div className="flex flex-col h-full animate-fade">
      {/* Editor Header */}
      <header className={`border-b px-8 py-4 flex items-center justify-between sticky top-0 z-20 transition-all ${
        theme === 'glassy' ? 'bg-black/60 border-white/10 glass-blur' : 'bg-bg-card border-border-main'
      }`}>
        <div className="flex items-center gap-4">
          <button 
            onClick={() => navigate('/')}
            className={`p-2 rounded-lg border transition-all ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-input border-border-main text-text-muted hover:text-text-main'
            }`}
          >
            <ArrowLeft size={20} />
          </button>
          <div>
            <div className="flex items-center gap-3">
              <DrupalLogo size={20} className="text-brand-600 shrink-0" />
              <h1 className="text-xl font-bold tracking-tight leading-tight">{project.attributes.title}</h1>
              <StatusBadge status={project.meta?.translation_status} />
            </div>
            <p className="text-sm text-text-muted mt-0.5">
              {isGerman ? 'Übersetze' : 'Translating'} <code className="text-brand-500 font-bold">{machineName}</code> {isGerman ? 'nach' : 'to'} <span className="font-semibold text-text-main">{targetLanguage.name}</span>
            </p>
          </div>
        </div>
        
        <div className="flex items-center gap-3">
          <button
            onClick={copyAiPrompt}
            className={`flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-sm ${
              theme === 'glassy' ? 'bg-brand-500/20 border-brand-500/30 text-brand-200 hover:bg-brand-500/40' : 'border-brand-200 bg-brand-50 text-brand-700 hover:bg-brand-100'
            }`}
          >
            <Zap size={18} />
            {isGerman ? 'KI-Prompt kopieren' : 'Copy AI Prompt'}
          </button>
          <button
            onClick={copyHtml}
            className={`flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-sm ${
              theme === 'glassy' ? 'bg-white/5 border-white/10 text-white hover:bg-white/10' : 'border-gray-300 bg-white text-gray-700 hover:bg-gray-50'
            }`}
          >
            <Code size={18} />
            {isGerman ? 'Als HTML kopieren' : 'Copy HTML'}
          </button>
          <button
            onClick={() => handleSave(false)}
            disabled={saving}
            className={`flex items-center gap-2 px-5 py-2 rounded-lg text-sm font-semibold transition-all shadow-sm disabled:opacity-50 border ${
              theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white hover:bg-brand-500/60' : 'bg-brand-600 border-brand-600 text-white hover:bg-brand-700'
            }`}
          >
            {saving ? <RefreshCw size={18} className="animate-spin" /> : <Save size={18} />}
            {isGerman ? 'Speichern' : 'Save'}
          </button>
        </div>
      </header>

      {/* Editor Main Layout */}
      <div className="flex flex-1 overflow-hidden">
        {/* Source Pane - 40% */}
        <div className={`w-[40%] border-r overflow-y-auto transition-all ${
          theme === 'glassy' ? 'bg-black/20 border-white/10' : 'bg-bg-app border-border-main'
        }`}>
          <div className="p-8">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-sm font-bold text-text-muted uppercase tracking-wider flex items-center gap-2">
                <Globe size={14} />
                {isGerman ? 'Englische Quelle' : 'English Source'}
              </h3>
              <div className="flex gap-2">
                <button 
                  onClick={() => setShowSource(!showSource)}
                  className={`p-1.5 rounded border transition-all ${
                    showSource ? (theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white shadow-lg shadow-brand-500/20' : 'bg-brand-600 text-white border-brand-600') : 
                    (theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-card text-text-muted border-border-main')
                  }`}
                  title={isGerman ? 'Quellcode umschalten' : 'Toggle Source Code'}
                >
                  <Code size={16} />
                </button>
                <a 
                  href={`https://drupal.org/project/${machineName}`} 
                  target="_blank" 
                  rel="noreferrer"
                  className={`p-1.5 rounded border transition-all ${
                    theme === 'glassy' ? 'bg-white/5 border-white/10 text-white hover:text-brand-400' : 'bg-bg-card border-border-main text-text-muted hover:text-brand-600'
                  }`}
                >
                  <ExternalLink size={16} />
                </a>
              </div>
            </div>

            <div className={`border rounded-2xl p-10 shadow-sm prose prose-sm max-w-none prose-brand transition-all ${
              theme === 'glassy' ? 'bg-black/30 border-white/10 text-white prose-invert' : 
              (theme === 'light' ? 'bg-white border-border-main text-text-main' : 'bg-bg-card border-border-main text-text-main prose-invert')
            }`}>
              {showSource ? (
                <div className={`font-mono text-xs leading-relaxed p-8 rounded-xl border overflow-x-auto shadow-inner ${
                  theme === 'light' ? 'bg-gray-50 border-gray-200 text-brand-700' : 'bg-bg-input border-border-muted text-brand-300'
                }`}>
                  <div className={`mb-6 flex items-center gap-2 select-none font-bold uppercase tracking-widest text-[10px] ${theme === 'light' ? 'text-gray-400' : 'text-text-muted'}`}>
                    <Code size={12} />
                    Summary Source
                  </div>
                  {project.attributes.body?.summary || 'N/A'}
                  <div className={`my-10 border-t ${theme === 'light' ? 'border-gray-100' : 'border-border-muted'}`}></div>
                  <div className={`mb-6 flex items-center gap-2 select-none font-bold uppercase tracking-widest text-[10px] ${theme === 'light' ? 'text-gray-400' : 'text-text-muted'}`}>
                    <Code size={12} />
                    Body Source
                  </div>
                  {project.attributes.body?.value || ''}
                </div>
              ) : (
                <>
                  <h1 className={`text-3xl font-bold border-b pb-6 mb-8 ${theme === 'light' ? 'text-gray-900 border-gray-100' : 'text-white border-border-muted'}`}>{project.attributes.title}</h1>
                  {project.attributes.body?.summary && (
                    <div className={`text-lg italic mb-10 pb-10 border-b leading-relaxed ${theme === 'light' ? 'text-gray-500 border-gray-100' : 'text-text-muted border-border-muted'}`} dangerouslySetInnerHTML={{ __html: project.attributes.body.summary }} />
                  )}
                  <div className={`${theme === 'light' ? 'text-gray-700' : 'text-text-main'} leading-loose`} dangerouslySetInnerHTML={{ __html: project.attributes.body?.value }} />
                </>
              )}
            </div>

            {project.meta?.screenshot_urls && project.meta.screenshot_urls.length > 0 && (
              <div className="mt-8">
                <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-4">{isGerman ? 'Screenshots' : 'Screenshots'}</h4>
                <div className="grid grid-cols-1 gap-6">
                  {project.meta.screenshot_urls.map(img => (
                    <div key={img.id} className="bg-white border border-gray-200 rounded-xl overflow-hidden shadow-sm group">
                      <img src={img.url} alt={img.alt} className="w-full h-auto border-b border-gray-100" />
                      <div className="p-4 bg-gray-50 text-[11px] text-gray-500 flex items-center gap-2">
                        <Eye size={12} />
                        <strong>ALT:</strong> {img.alt}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Editor Pane - 60% */}
        <div className={`w-[60%] overflow-y-auto transition-all ${
          theme === 'glassy' ? 'bg-black/10' : 'bg-bg-card'
        }`}>
          <div className="p-8">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-sm font-bold text-text-muted uppercase tracking-wider flex items-center gap-2">
                <Languages size={14} />
                {targetLanguage.name} {isGerman ? 'Übersetzung' : 'Translation'}
              </h3>
              <button
                onClick={togglePreview}
                className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs font-bold transition-all border ${
                  showPreview ? (theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white shadow-lg shadow-brand-500/20' : 'bg-brand-600 text-white border-brand-600') : 
                  (theme === 'glassy' ? 'bg-white/5 border-white/10 text-white' : 'bg-bg-card text-text-main border-border-main hover:border-brand-300')
                }`}
              >
                <Eye size={14} />
                {isGerman ? (showPreview ? 'Editor' : 'Vorschau') : (showPreview ? 'Editor' : 'Preview')}
              </button>
            </div>

            {showPreview ? (
              <div className={`border-2 border-brand-500 rounded-2xl p-10 shadow-2xl min-h-[700px] prose prose-sm max-w-none prose-brand animate-in zoom-in-95 duration-300 ${
                theme === 'glassy' ? 'bg-black/40 text-white prose-invert' : 
                (theme === 'light' ? 'bg-white text-gray-900' : 'bg-bg-card text-white prose-invert')
              }`}>
                <div className={`flex items-center gap-2 mb-8 font-bold uppercase tracking-widest text-[10px] select-none border-b pb-4 ${
                  theme === 'light' ? 'text-brand-600 border-brand-100' : 'text-brand-400 border-white/10'
                }`}>
                  <Eye size={12} />
                  Live Preview
                </div>
                <h1 className={`text-3xl font-bold border-b pb-6 mb-8 ${theme === 'light' ? 'text-gray-900 border-gray-100' : 'text-white border-border-muted'}`}>{translation.title}</h1>
                <div className={`text-lg italic mb-10 pb-10 border-b leading-relaxed ${theme === 'light' ? 'text-gray-500 border-gray-100' : 'text-text-muted border-border-muted'}`} dangerouslySetInnerHTML={{ __html: translation.summary }} />
                <div className={`${theme === 'light' ? 'text-gray-700' : 'text-text-main'} leading-loose`} dangerouslySetInnerHTML={{ __html: translation.body }} />
              </div>
            ) : (
              <div className="space-y-8 animate-in fade-in duration-300">
                {/* Workflow Tips */}
                <div className={`rounded-xl p-4 flex items-start gap-3 border ${
                  theme === 'light' ? 'bg-brand-50 border-brand-100 text-brand-800' : 'bg-brand-50/10 border-brand-500/20 text-brand-200'
                }`}>
                  <div className="mt-0.5 text-brand-500 shrink-0"><Info size={18} /></div>
                  <div className="text-xs leading-relaxed font-medium">
                    <p className="mb-2"><strong>{isGerman ? 'Tipp:' : 'Tip:'}</strong> {isGerman ? 'Nutze Tastenkürzel für einen schnelleren Workflow.' : 'Use shortcuts for a faster workflow.'}</p>
                    <div className="flex flex-wrap gap-x-4 gap-y-1 opacity-80">
                      <span><kbd className="bg-black/20 border border-white/10 px-1 rounded shadow-sm text-[10px]">Alt+Ctrl+K</kbd> AI Prompt</span>
                      <span><kbd className="bg-black/20 border border-white/10 px-1 rounded shadow-sm text-[10px]">Alt+Ctrl+S</kbd> Save & Next</span>
                      <span><kbd className="bg-black/20 border border-white/10 px-1 rounded shadow-sm text-[10px]">Alt+Ctrl+P</kbd> Preview</span>
                    </div>
                  </div>
                </div>

                {/* Title field */}
                <div className="space-y-2">
                  <label className="text-sm font-semibold text-text-main">{isGerman ? 'Übersetzter Titel' : 'Translated Title'}</label>
                  <input
                    type="text"
                    className={`w-full px-4 py-2.5 rounded-lg text-sm focus:ring-4 outline-none transition-all shadow-sm ${
                      theme === 'light' ? 'bg-white border-gray-300 text-gray-900 focus:ring-brand-100 focus:border-brand-300' : 
                      'bg-bg-input border-border-main text-white focus:ring-brand-500/20 focus:border-brand-500'
                    }`}
                    value={translation.title}
                    onChange={e => setTranslation({ ...translation, title: e.target.value })}
                    placeholder={isGerman ? "Titel der Übersetzung..." : "Translation title..."}
                  />
                </div>

                {/* Summary field */}
                <div className="space-y-2">
                  <div className="flex justify-between items-center">
                    <label className="text-sm font-semibold text-text-main">{isGerman ? 'Zusammenfassung' : 'Summary'}</label>
                    <button 
                      onClick={() => setShowSummaryHtml(!showSummaryHtml)}
                      className={`text-[10px] font-bold uppercase tracking-widest px-2 py-1 rounded transition-all border ${
                        showSummaryHtml ? (theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white' : 'bg-brand-600 text-white border-brand-600') : (theme === 'light' ? 'bg-gray-100 border-gray-200 text-gray-500' : 'bg-white/10 border-white/5 text-text-muted')
                      }`}
                    >
                      {showSummaryHtml ? 'Visual' : 'HTML'}
                    </button>
                  </div>
                  {showSummaryHtml ? (
                    <textarea
                      className={`w-full h-32 px-4 py-3 font-mono text-xs rounded-lg border outline-none transition-all ${
                        theme === 'light' ? 'bg-gray-50 border-gray-200 text-gray-900' : 'bg-bg-input border-border-main text-brand-300'
                      }`}
                      value={translation.summary}
                      onChange={e => setTranslation({ ...translation, summary: e.target.value })}
                    />
                  ) : (
                    <div className="ck-editor-wrapper prose-sm shadow-sm themed-ckeditor">
                      <CKEditor
                        editor={ClassicEditor}
                        data={translation.summary}
                        config={{ toolbar: ['bold', 'italic', 'link'], placeholder: isGerman ? "Übersetze die Zusammenfassung..." : "Translate the summary..." }}
                        onChange={(event, editor) => setTranslation({ ...translation, summary: editor.getData() })}
                      />
                    </div>
                  )}
                </div>

                {/* Body field */}
                <div className="space-y-2">
                  <div className="flex justify-between items-center">
                    <label className="text-sm font-semibold text-text-main">{isGerman ? 'Hauptbeschreibung' : 'Main Body'}</label>
                    <button 
                      onClick={() => setShowBodyHtml(!showBodyHtml)}
                      className={`text-[10px] font-bold uppercase tracking-widest px-2 py-1 rounded transition-all border ${
                        showBodyHtml ? (theme === 'glassy' ? 'bg-brand-500/40 border-brand-400/50 text-white' : 'bg-brand-600 text-white border-brand-600') : (theme === 'light' ? 'bg-gray-100 border-gray-200 text-gray-500' : 'bg-white/10 border-white/5 text-text-muted')
                      }`}
                    >
                      {showBodyHtml ? 'Visual' : 'HTML'}
                    </button>
                  </div>
                  {showBodyHtml ? (
                    <textarea
                      className={`w-full h-[500px] px-4 py-3 font-mono text-xs rounded-lg border outline-none transition-all ${
                        theme === 'light' ? 'bg-gray-50 border-gray-200 text-gray-900' : 'bg-bg-input border-border-main text-brand-300'
                      }`}
                      value={translation.body}
                      onChange={e => setTranslation({ ...translation, body: e.target.value })}
                    />
                  ) : (
                    <div className="ck-editor-wrapper prose-sm shadow-sm themed-ckeditor">
                      <CKEditor
                        editor={ClassicEditor}
                        data={translation.body}
                        config={{ toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', 'undo', 'redo'], placeholder: isGerman ? "Übersetze die Beschreibung..." : "Translate the description..." }}
                        onChange={(event, editor) => setTranslation({ ...translation, body: editor.getData() })}
                      />
                    </div>
                  )}
                </div>

                {/* Screenshot Alt Texts */}
                {project.meta?.screenshot_urls && project.meta.screenshot_urls.length > 0 && (
                  <div className={`pt-8 border-t space-y-6 ${theme === 'light' ? 'border-gray-100' : 'border-white/10'}`}>
                    <h4 className={`text-sm font-bold ${theme === 'light' ? 'text-gray-900' : 'text-white'}`}>{isGerman ? 'Screenshot Alt-Texte' : 'Screenshot Alt Texts'}</h4>
                    <div className="space-y-4">
                      {project.meta.screenshot_urls.map(img => (
                        <div key={img.id} className="space-y-2">
                          <label className={`text-[10px] font-bold uppercase tracking-wider ${theme === 'light' ? 'text-gray-400' : 'text-text-muted'}`}>
                            ID: {img.id.split('-')[0]}
                          </label>
                          <input
                            type="text"
                            className={`w-full px-4 py-2 rounded-lg text-sm focus:ring-4 outline-none transition-all ${
                              theme === 'light' ? 'bg-gray-50 border-gray-200 text-gray-900 focus:ring-brand-100 focus:border-brand-300' : 
                              'bg-bg-input border-border-main text-white focus:ring-brand-500/20 focus:border-brand-500'
                            }`}
                            value={translation.screenshot_alts[img.id] || ''}
                            onChange={e => setTranslation({
                              ...translation,
                              screenshot_alts: { ...translation.screenshot_alts, [img.id]: e.target.value }
                            })}
                            placeholder={isGerman ? "Übersetzter Alt-Text..." : "Translated Alt text..."}
                          />
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

const PrivacyVideo = ({ youtubeId, isGerman, theme }) => {
  const [load, setLoad] = useState(false);
  const [showDetails, setShowDetails] = useState(false);
  const playerRef = React.useRef(null);

  useEffect(() => {
    if (load && window.Plyr) {
      playerRef.current = new window.Plyr('#plyr-player', {
        autoplay: true,
        youtube: { noCookie: true }
      });
    }
    return () => {
      if (playerRef.current) {
        playerRef.current.destroy();
      }
    };
  }, [load]);

  if (load) {
    return (
      <div style={{ aspectRatio: '16/9', background: '#000' }}>
        <div className="plyr__video-embed" id="plyr-player">
          <iframe
            src={`https://www.youtube-nocookie.com/embed/${youtubeId}?origin=${window.location.origin}&iv_load_policy=3&modestbranding=1&playsinline=1&showinfo=0&rel=0&enablejsapi=1`}
            allowFullScreen
            allow="autoplay"
          ></iframe>
        </div>
      </div>
    );
  }

  return (
    <div 
      className={`relative overflow-hidden transition-all duration-700 flex flex-col items-center justify-center py-20 px-10 ${
        theme === 'glassy' ? 'backdrop-blur-xl border border-white/10 shadow-2xl' : 'bg-gray-900'
      }`}
      style={{
        minHeight: '650px',
        background: theme === 'glassy' 
          ? 'linear-gradient(135deg, rgba(139, 92, 246, 0.05) 0%, rgba(0,0,0,0.7) 100%)' 
          : 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)',
        textAlign: 'center'
      }}
    >
      <div className="absolute top-6 right-6 flex items-center gap-2 px-4 py-1.5 bg-black/60 rounded-full text-[10px] text-white/60 font-bold uppercase tracking-widest border border-white/10 shadow-lg">
        <XCircle size={14} className="text-brand-400" />
        {isGerman ? 'Vorschau blockiert' : 'Preview blocked'}
      </div>
      <div 
        onClick={() => setLoad(true)}
        className="play-button-overlay hover:scale-110 active:scale-95"
        style={{ 
          width: '80px', 
          height: '80px', 
          borderRadius: '50%', 
          background: theme === 'glassy' ? 'rgba(255,255,255,0.1)' : 'rgba(255,255,255,0.2)', 
          backdropFilter: 'blur(8px)',
          display: 'flex', 
          alignItems: 'center', 
          justifyContent: 'center',
          marginBottom: '1.5rem',
          color: '#fff',
          cursor: 'pointer',
          transition: 'all 0.5s cubic-bezier(0.4, 0, 0.2, 1)',
          border: '2px solid rgba(255,255,255,0.3)',
          boxShadow: theme === 'glassy' ? '0 0 30px rgba(139,92,246,0.3)' : 'none'
        }}
      >
        <Play size={32} fill="white" style={{ marginLeft: '4px' }} />
      </div>
      <div className={`max-w-xl mb-8 p-8 rounded-2xl border text-left text-[11px] leading-relaxed transition-all duration-500 ${
        theme === 'glassy' ? 'bg-white/5 border-white/20 text-white shadow-2xl glass-blur' : 'bg-gray-950 border-gray-800 text-gray-400'
      }`}>
        <h4 className="text-white font-bold mb-3 flex items-center gap-2 text-sm">
          <Info size={16} className="text-brand-400" />
          {isGerman ? 'Datenschutz & Einwilligung' : 'Privacy & Consent'}
        </h4>
        {isGerman ? (
          <div className="space-y-3">
            <p>
              <strong>Kategorien: Datenschutz und Tracking</strong><br/>
              Dieses Video wird von YouTube LLC bereitgestellt. Beim Laden werden Scripte ausgeführt, die personenbezogene Daten an Google (USA) übertragen. 
              Dies umfasst Cookies, LocalStorage und Tracker (z.B. DoubleClick), auch bei Verwendung der <em>youtube-nocookie.com</em> Domain.
            </p>
            <p className="italic opacity-80">
              Gemäß Art. 44 DSGVO und § 25 TDDDG (vormals TTDSG) ist hierfür Ihre ausdrückliche Einwilligung erforderlich, 
              da YouTube-Nutzungsbedingungen Datentransfers in Drittstaaten vorsehen.
            </p>
            <div className="flex flex-col sm:flex-row items-start sm:items-center gap-4 mt-6 pt-4 border-t border-white/5">
              <span className="opacity-70 text-[10px]">Quelle & Details: <a href="https://www.google.com/about/company/user-consent-policy/" target="_blank" className="text-brand-400 underline hover:text-brand-300 font-bold">Google Policy</a></span>
              <button 
                onClick={() => setShowDetails(true)}
                className={`flex items-center gap-2 px-5 py-2.5 text-white rounded-xl font-black text-[11px] transition-all hover:scale-105 active:scale-95 ${
                  theme === 'glassy' 
                    ? 'bg-brand-500 shadow-[0_0_20px_rgba(139,92,246,0.4)] hover:shadow-[0_0_30px_rgba(139,92,246,0.6)]' 
                    : 'bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/20'
                }`}
              >
                <Info size={14} />
                {isGerman ? 'MEHR INFORMATIONEN ANZEIGEN' : 'SHOW MORE INFORMATION'}
              </button>
            </div>
          </div>
        ) : (
          <p>
            By loading this video, you consent to the processing of personal data by YouTube and Google, including the use of cookies and data transfers to the USA (Art. 44 GDPR).
            <button onClick={() => setShowDetails(true)} className="ml-2 text-brand-400 underline">Details</button>
          </p>
        )}
      </div>

      {showDetails && (
        <div 
          className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-10 bg-black/40 backdrop-blur-sm animate-fade cursor-default"
          onClick={() => setShowDetails(false)}
        >
          <div 
            className={`w-full max-w-4xl max-h-full flex flex-col rounded-[2.5rem] border shadow-2xl overflow-hidden transition-all duration-500 ${
              theme === 'glassy' ? 'bg-black/60 border-white/20 text-white shadow-[0_0_50px_rgba(0,0,0,0.5)] backdrop-blur-xl' : 'bg-white border-gray-200 text-gray-900 shadow-brand-100/20'
            }`}
            onClick={e => e.stopPropagation()}
          >
            {/* Modal Header - Fixed */}
            <div className={`px-8 py-6 flex justify-between items-center border-b ${theme === 'glassy' ? 'border-white/10 bg-white/5' : 'border-gray-100 bg-white'}`}>
              <h3 className="text-2xl font-bold flex items-center gap-3">
                <Info className="text-brand-500 animate-pulse" size={28} />
                {isGerman ? 'YouTube Datenschutz' : 'YouTube Privacy'}
              </h3>
              <button 
                onClick={() => setShowDetails(false)} 
                className={`p-2.5 rounded-full transition-all ${theme === 'glassy' ? 'hover:bg-white/10 bg-white/5' : 'hover:bg-gray-100 bg-gray-50'}`}
              >
                <X size={28} />
              </button>
            </div>
            
            {/* Modal Content - Scrollable */}
            <div className="flex-1 overflow-y-auto p-10 space-y-8 text-left custom-scrollbar">
              <div className="space-y-10 text-base leading-relaxed opacity-90 max-w-3xl">
                {isGerman ? (
                  <>
                    <section className="group">
                      <h4 className="font-bold text-xl mb-4 text-brand-400 flex items-center gap-2">
                        <span className="w-1.5 h-6 bg-brand-500 rounded-full inline-block group-hover:scale-y-125 transition-transform"></span>
                        1. Von YouTube verarbeitete Daten
                      </h4>
                      <p className="pl-4 border-l border-white/5">
                        Wir nutzen einen YouTube-Kanal der Google Ireland Limited, Gordon House, 4 Barrow St, Dublin, D04 E5W5, Irland. 
                        Wir weisen darauf hin, dass Sie den hier angebotenen YouTube-Kanal und dessen Funktionen in eigener Verantwortung nutzen. 
                        Dies gilt insbesondere für die Nutzung der Funktion „Diskussion“.
                      </p>
                      <p className="mt-4 pl-4">
                        Angaben darüber, welche Daten durch Google verarbeitet und zu welchen Zwecken genutzt werden, finden Sie in der Datenschutzerklärung von Google: 
                        <a href="https://policies.google.com/privacy?hl=de&gl=de#infocollect" target="_blank" className="text-brand-500 underline ml-1 font-black">Google Datenschutzerklärung</a>
                      </p>
                    </section>

                    <section className="group">
                      <h4 className="font-bold text-xl mb-4 text-brand-400 flex items-center gap-2">
                        <span className="w-1.5 h-6 bg-brand-500 rounded-full inline-block group-hover:scale-y-125 transition-transform"></span>
                        2. Umfang der Datenverarbeitung
                      </h4>
                      <div className="pl-4 border-l border-white/5 space-y-4">
                        <p>
                          Wir haben keinen Einfluss auf Art und Umfang der durch Google verarbeiteten Daten. Google erfasst Ihre personenbezogenen Daten (Name, E-Mail, Standort, IP-Adresse) 
                          unabhängig von Ihrem Wohnsitz und überträgt diese in die Vereinigten Staaten, Irland und jedes andere Land, in dem Google geschäftlich tätig ist. 
                        </p>
                        <p>
                          Google wertet Ihre Inhalte auf Themeninteressen aus, verarbeitet Direktnachrichten und kann Ihren Standort via GPS oder IP-Adresse bestimmen, um personalisierte Werbung anzuzeigen. 
                          Hierbei kommen auch Analyse-Tools wie Google Analytics zum Einsatz.
                        </p>
                      </div>
                    </section>

                    <section className="group">
                      <h4 className="font-bold text-lg mb-3 text-brand-400 flex items-center gap-2">
                        <span className="w-1.5 h-6 bg-brand-500 rounded-full inline-block group-hover:scale-y-125 transition-transform"></span>
                        3. Log-Daten und Cookies
                      </h4>
                      <p className="pl-4 border-l border-white/5">
                        Auch ohne Account erhebt Google sog. „Log-Daten“ (IP-Adresse, Browsertyp, Betriebssystem, zuvor besuchte Seiten, Geräte-ID, Suchbegriffe und Cookie-Informationen). 
                        Selbst bei der „nocookie“-Einbindung werden Daten übertragen und Cookies (z.B. „CONSENT“) gesetzt.
                      </p>
                    </section>

                    <section className="group pb-10">
                      <h4 className="font-bold text-lg mb-3 text-brand-400 flex items-center gap-2">
                        <span className="w-1.5 h-6 bg-brand-500 rounded-full inline-block group-hover:scale-y-125 transition-transform"></span>
                        4. Ihre Kontrollmöglichkeiten
                      </h4>
                      <div className="pl-4 border-l border-white/5 space-y-4">
                        <p>
                          Sie können die Datenverarbeitung in Ihren Google-Account-Einstellungen beschränken. Spezifische YouTube-Einstellungen finden Sie hier: 
                          <a href="https://policies.google.com/technologies/product-privacy?hl=de&gl=de" target="_blank" className="text-brand-500 underline ml-1 font-black">YouTube Datenschutz-Leitfaden</a>
                        </p>
                        <p>
                          Auskunftsersuche können Sie über das Google-Datenschutzformular stellen: 
                          <a href="https://support.google.com/policies/troubleshooter/7575787?hl=de" target="_blank" className="text-brand-500 underline ml-1 font-black">Support-Formular</a>
                        </p>
                      </div>
                    </section>
                  </>
                ) : (
                  <p>Detailed privacy information for YouTube and Google is currently being updated in English. Please refer to the official Google Privacy Policy for the most accurate details.</p>
                )}
              </div>
            </div>

            {/* Modal Footer - Fixed */}
            <div className={`px-10 py-8 border-t ${theme === 'glassy' ? 'border-white/10 bg-white/5' : 'border-gray-100 bg-gray-50'}`}>
              <button 
                onClick={() => setShowDetails(false)}
                className={`w-full py-5 text-white rounded-2xl font-black text-lg transition-all hover:scale-[1.02] active:scale-[0.98] ${
                  theme === 'glassy' 
                    ? 'bg-brand-500 shadow-[0_0_30px_rgba(139,92,246,0.5)] hover:shadow-[0_0_40px_rgba(139,92,246,0.7)]' 
                    : 'bg-brand-600 hover:bg-brand-700 shadow-xl shadow-brand-600/20'
                }`}
              >
                {isGerman ? 'ALLES GELESEN & SCHLIESSEN' : 'ALL READ & CLOSE'}
              </button>
            </div>
          </div>
        </div>
      )}

      <button 
        className={`flex items-center gap-3 px-10 py-4 text-white rounded-2xl font-black text-lg transition-all hover:scale-105 active:scale-95 ${
          theme === 'glassy' 
            ? 'bg-brand-500 shadow-[0_0_30px_rgba(139,92,246,0.5)] hover:shadow-[0_0_40px_rgba(139,92,246,0.7)]' 
            : 'bg-brand-600 hover:bg-brand-700 shadow-xl shadow-brand-600/30'
        }`} 
        onClick={() => setLoad(true)}
      >
        <Play size={24} fill="white" />
        {isGerman ? 'EINWILLIGEN & VIDEO LADEN' : 'CONSENT & LOAD VIDEO'}

      </button>
    </div>
  );
};

const SettingsView = ({ isGerman }) => {
  const { theme, setTheme, fetchNewBg } = useContext(ThemeContext);
  
  return (
    <div className="p-12 max-w-4xl mx-auto animate-fade">
      <div className="flex items-center gap-4 mb-10">
        <div className="p-3 rounded-2xl bg-brand-600 text-white shadow-lg shadow-brand-600/20">
          <Settings size={32} />
        </div>
        <div>
          <h1 className="text-3xl font-bold tracking-tight">{isGerman ? 'Einstellungen' : 'Settings'}</h1>
          <p className="text-text-muted mt-1">{isGerman ? 'Verwalte deine App-Konfiguration' : 'Manage your app configuration'}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className={`p-8 rounded-2xl border ${theme === 'glassy' ? 'bg-white/5 border-white/10' : 'bg-bg-card border-border-main'}`}>
          <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
            <Palette size={20} className="text-brand-500" />
            {isGerman ? 'Erscheinungsbild' : 'Appearance'}
          </h2>
          <div className="space-y-4">
            {THEMES.map(t => (
              <button
                key={t.id}
                onClick={() => setTheme(t.id)}
                className={`w-full flex items-center justify-between p-4 rounded-xl border transition-all ${
                  theme === t.id ? 'bg-brand-500/10 border-brand-500 text-brand-600' : 'bg-bg-input border-border-main text-text-muted hover:border-text-muted'
                }`}
              >
                <div className="flex items-center gap-3 font-bold">
                  <t.icon size={18} />
                  {isGerman ? t.labelDe : t.labelEn}
                </div>
                {theme === t.id && <div className="w-2 h-2 rounded-full bg-brand-600" />}
              </button>
            ))}
          </div>
        </div>

        <div className={`p-8 rounded-2xl border ${theme === 'glassy' ? 'bg-white/5 border-white/10' : 'bg-bg-card border-border-main'}`}>
          <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
            <Zap size={20} className="text-brand-500" />
            {isGerman ? 'Hintergrund' : 'Background'}
          </h2>
          <p className="text-sm text-text-muted mb-6 leading-relaxed">
            {isGerman ? 'Im "Glassy" Theme kannst du den Hintergrund aktualisieren.' : 'In the "Glassy" theme, you can refresh the background.'}
          </p>
          <button 
            onClick={fetchNewBg}
            disabled={theme !== 'glassy'}
            className="w-full flex items-center justify-center gap-2 py-4 rounded-xl font-bold bg-brand-600 text-white hover:bg-brand-700 transition-all shadow-lg shadow-brand-600/20 disabled:opacity-30"
          >
            <RefreshCw size={18} />
            {isGerman ? 'Neues Bild laden' : 'Fetch New Background'}
          </button>
        </div>
      </div>
    </div>
  );
};

const HelpView = ({ isGerman }) => {
  const { theme } = useContext(ThemeContext);
  return (
    <div className="max-w-4xl mx-auto px-8 py-16 animate-fade font-body">
      <div className="text-center mb-16">
        <div className={`inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold uppercase tracking-widest mb-6 ${
          theme === 'glassy' ? 'bg-brand-500/20 text-brand-200 border border-brand-500/30' : 'bg-brand-50 text-brand-700'
        }`}>
          <Info size={14} />
          {isGerman ? 'Info' : 'Information'}
        </div>
        <h1 className={`text-5xl font-black tracking-tighter mb-8 ${theme === 'glassy' ? 'text-white drop-shadow-xl' : 'text-gray-900'}`}>
          {isGerman ? 'Sprache ist Vertrauen' : 'Language is Trust'}
        </h1>
        
        <div className={`max-w-3xl mx-auto text-left space-y-10 ${theme === 'glassy' ? 'text-white/90' : 'text-gray-700'}`}>
          {isGerman ? (
            <>
              <div className="space-y-6">
                <h3 className="text-2xl font-bold text-brand-400">Project Description Browser: Die Zentrale für ein globales Drupal-Ökosystem</h3>
                <p className="text-lg leading-relaxed font-medium">
                  Der <strong>Project Description Browser</strong> fungiert als zentraler Übersetzungs-Hub, der das Kernerlebnis des <strong>Project Browsers</strong> in deine Muttersprache bringt. 
                  Während der Project Browser in Drupal ein fantastisches Werkzeug ist, das Echtzeit-Metadaten von Drupal.org abruft, liefert unsere Server-Komponente die nötigen Übersetzungen, um die Sprachbarriere für Website-Builder weltweit zu Fall zu bringen.
                </p>
                <p className="text-lg leading-relaxed">
                  Dieser Hub ermöglicht es dir, JSON-basierte Projektbeschreibungen zentral zu verwalten und zu übersetzen. 
                  Er bildet das Rückgrat für ein lokalisiertes, hochwertiges "App Store"-Erlebnis und stellt sicher, dass Nutzer weltweit die Drupal-Erweiterungen in ihrer eigenen Sprache verstehen und ihnen vertrauen können.
                </p>
              </div>

              <div className={`p-8 rounded-[2.5rem] border transition-all duration-500 ${theme === 'glassy' ? 'bg-white/5 border-white/10 shadow-2xl backdrop-blur-xl' : 'bg-brand-50 border-brand-100 shadow-xl shadow-brand-600/5'}`}>
                <h3 className="text-3xl font-black mb-6 flex items-center gap-3">
                  <CheckCircle className="text-brand-500" size={32} />
                  Kernphilosophie: "Sprache ist Vertrauen"
                </h3>
                <p className="mb-8 text-lg opacity-80 italic leading-relaxed">
                  Untersuchungen der einflussreichen Studie "Can't Read, Won't Buy: Why Language Matters on Global Websites" belegen, dass die Sprache ein entscheidender Faktor bei Adoptionsentscheidungen ist. 
                  Dies gilt insbesondere für den Project Browser, der als primäres Tor für neue Benutzer dient.
                </p>
                
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  {[
                    { label: 'Präferenz', val: '72.4%', desc: 'interagieren eher mit Produkten in ihrer Muttersprache.' },
                    { label: 'Notwendigkeit', val: '52.4%', desc: 'kaufen ausschließlich auf Websites in eigener Sprache.' },
                    { label: 'Vertrauen & Qualität', val: '67%', desc: 'halten lokalisierte Infos für eine wesentliche Entscheidungsgrundlage.' },
                    { label: 'Wert über Preis', val: '56.2%', desc: 'schätzen Muttersprache höher ein als einen niedrigen Preis.' },
                  ].map(stat => (
                    <div key={stat.label} className={`p-6 rounded-2xl border transition-all hover:scale-105 ${theme === 'glassy' ? 'bg-black/20 border-white/10 shadow-lg' : 'bg-white border-brand-100 shadow-sm'}`}>
                      <div className="text-3xl font-black text-brand-500 mb-2">{stat.val}</div>
                      <div className="font-bold mb-2 uppercase text-[10px] tracking-widest text-brand-400">{stat.label}</div>
                      <div className="opacity-70 text-xs leading-relaxed font-medium">{stat.desc}</div>
                    </div>
                  ))}
                </div>
                
                <div className="mt-10 flex flex-wrap justify-center items-center gap-x-6 gap-y-3 text-xs opacity-60 font-bold">
                  <a 
                    href="https://motsdici.be/wp-content/uploads/2019/04/Article-cant-read-wont-buy.pdf" 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="uppercase tracking-widest text-[10px] hover:text-brand-400 transition-all underline decoration-brand-500/30 underline-offset-4"
                  >
                    Studie von CSA Research
                  </a>
                  <div className="flex flex-wrap justify-center gap-4">
                    {[
                      { code: 'de', name: 'Deutschland' },
                      { code: 'fr', name: 'Frankreich' },
                      { code: 'jp', name: 'Japan' },
                      { code: 'br', name: 'Brasilien' },
                      { code: 'cn', name: 'China' }
                    ].map(c => (
                      <span key={c.code} className="flex items-center gap-2">
                        <img 
                          src={`https://flagcdn.com/w40/${c.code}.png`} 
                          className="w-5 h-3.5 object-cover rounded-sm border border-white/20 shadow-sm" 
                          alt={c.name} 
                        />
                        <span className="text-[11px]">{c.name}</span>
                      </span>
                    ))}
                  </div>
                </div>
              </div>
            </>
          ) : (
            <>
              <div className="space-y-6">
                <h3 className="text-2xl font-bold text-brand-400">Project Description Browser: The Central Hub for Global Drupal Adoption</h3>
                <p className="text-lg leading-relaxed font-medium">
                  The <strong>Project Description Browser</strong> serves as the central translation hub that brings the core experience of the <strong>Project Browser</strong> to your native language. 
                  While the Project Browser module is a fantastic tool that fetches metadata from Drupal.org, our server component provides the localized data needed to bridge the gap for non-English speakers.
                </p>
                <p className="text-lg leading-relaxed">
                  This hub empowers you to manage and translate JSON-based project descriptions independently. 
                  It forms the backbone for a localized, high-quality "App Store" experience, ensuring users feel confident and at home within the Drupal ecosystem.
                </p>
              </div>

              <div className={`p-8 rounded-[2.5rem] border transition-all duration-500 ${theme === 'glassy' ? 'bg-white/5 border-white/10 shadow-2xl backdrop-blur-xl' : 'bg-brand-50 border-brand-100 shadow-xl shadow-brand-600/5'}`}>
                <h3 className="text-3xl font-black mb-6 flex items-center gap-3">
                  <CheckCircle className="text-brand-500" size={32} />
                  Core Philosophy: "Language is Trust"
                </h3>
                <p className="mb-8 text-lg opacity-80 italic leading-relaxed">
                  Research from the influential study "Can't Read, Won't Buy: Why Language Matters on Global Websites" proves that language is a pivotal factor in adoption decisions.
                </p>
                
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  {[
                    { label: 'Preference', val: '72.4%', desc: 'are more likely to engage if info is in their native language.' },
                    { label: 'Necessity', val: '52.4%', desc: 'buy only at websites presented in their own language.' },
                    { label: 'Trust & Quality', val: '67%', desc: 'consider localized info essential when making decisions.' },
                    { label: 'Value over Price', val: '56.2%', desc: 'value language more than a lower price point.' },
                  ].map(stat => (
                    <div key={stat.label} className={`p-6 rounded-2xl border transition-all hover:scale-105 ${theme === 'glassy' ? 'bg-black/20 border-white/10 shadow-lg' : 'bg-white border-brand-100 shadow-sm'}`}>
                      <div className="text-3xl font-black text-brand-500 mb-2">{stat.val}</div>
                      <div className="font-bold mb-2 uppercase text-[10px] tracking-widest text-brand-400">{stat.label}</div>
                      <div className="opacity-70 text-xs leading-relaxed font-medium">{stat.desc}</div>
                    </div>
                  ))}
                </div>
                <div className="mt-10 flex flex-wrap justify-center items-center gap-x-6 gap-y-3 text-xs opacity-60 font-bold">
                  <a 
                    href="https://motsdici.be/wp-content/uploads/2019/04/Article-cant-read-wont-buy.pdf" 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="uppercase tracking-widest text-[10px] hover:text-brand-400 transition-all underline decoration-brand-500/30 underline-offset-4"
                  >
                    Source: CSA Research Study
                  </a>
                  <div className="flex flex-wrap justify-center gap-4">
                    {[
                      { code: 'de', name: 'Germany' },
                      { code: 'fr', name: 'France' },
                      { code: 'jp', name: 'Japan' },
                      { code: 'br', name: 'Brazil' },
                      { code: 'cn', name: 'China' }
                    ].map(c => (
                      <span key={c.code} className="flex items-center gap-2">
                        <img 
                          src={`https://flagcdn.com/w40/${c.code}.png`} 
                          className="w-5 h-3.5 object-cover rounded-sm border border-white/20 shadow-sm" 
                          alt={c.name} 
                        />
                        <span className="text-[11px]">{c.name}</span>
                      </span>
                    ))}
                  </div>
                </div>
              </div>
            </>
          )}
        </div>
      </div>

      <div className={`mb-16 rounded-2xl overflow-hidden shadow-2xl border transition-all ${
        theme === 'glassy' ? 'bg-black/30 border-white/10 glass-blur shadow-black/40' : 'bg-white border-gray-200 shadow-brand-100/50'
      }`}>
        <PrivacyVideo youtubeId="34iOv0sa0Y4" isGerman={isGerman} theme={theme} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-12 mb-16">
        <div className="space-y-4">
          <div className={`w-12 h-12 rounded-xl flex items-center justify-center border transition-all ${
            theme === 'glassy' ? 'bg-white/5 border-white/10 text-brand-400 shadow-lg shadow-brand-500/10' : 'bg-brand-50 border-brand-100 text-brand-600'
          }`}>
            <Globe size={24} />
          </div>
          <h3 className={`text-xl font-bold ${theme === 'glassy' ? 'text-white' : 'text-gray-900'}`}>{isGerman ? 'Die "Shadow API"' : 'The "Shadow API"'}</h3>
          <p className={`leading-relaxed ${theme === 'glassy' ? 'text-white/70' : 'text-gray-600'}`}>
            {isGerman
              ? 'Das Drupal Modul Projekt Browser Localizer dient innerhalb einer Drupal-Installation als Proxy für die auf diesem Server erstellten Übersetzungen. Es fängt den Live-Datenstrom von Drupal.org ab und überlagert spezifische Felder mit den auf diesem Server angefertigten Übersetzungen.'
              : 'The Drupal module Project Browser Localizer serves within a Drupal installation as a proxy for the translations created on this server. It intercepts the live data stream from Drupal.org and overlays specific fields with the translations produced on this server.'}
          </p>
        </div>
        <div className="space-y-4">
          <div className={`w-12 h-12 rounded-xl flex items-center justify-center border transition-all ${
            theme === 'glassy' ? 'bg-white/5 border-white/10 text-brand-400 shadow-lg shadow-brand-500/10' : 'bg-brand-50 border-brand-100 text-brand-600'
          }`}>
            <Zap size={24} />
          </div>
          <h3 className={`text-xl font-bold ${theme === 'glassy' ? 'text-white' : 'text-gray-900'}`}>{isGerman ? 'Stale Detection' : 'Stale Detection'}</h3>
          <p className={`leading-relaxed ${theme === 'glassy' ? 'text-white/70' : 'text-gray-600'}`}>
            {isGerman
              ? 'Wir berechnen einen Hash der englischen Quelle. Ändert sich das Original auf Drupal.org, wird deine Übersetzung automatisch als "Veraltet" markiert.'
              : 'We calculate a hash of the English source. If the original on Drupal.org changes, your translation is automatically marked as "Stale".'}
          </p>
        </div>
      </div>

      <div className={`rounded-2xl p-10 text-white shadow-xl border transition-all ${
        theme === 'glassy' ? 'bg-black/40 border-white/10 glass-blur shadow-black/40' : 'bg-gray-900 border-transparent'
      }`}>
        <h3 className="text-2xl font-bold mb-8 flex items-center gap-3 text-white">
          <Code className="text-brand-400" />
          {isGerman ? 'Tastaturkürzel' : 'Keyboard Shortcuts'}
        </h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
          {[
            { key: isGerman ? 'Alt+Strg+S' : 'Alt+Ctrl+S', label: isGerman ? 'Speichern & Weiter' : 'Save & Next' },
            { key: isGerman ? 'Alt+Strg+D' : 'Alt+Ctrl+D', label: isGerman ? 'Überspringen' : 'Skip & Next' },
            { key: isGerman ? 'Alt+Strg+P' : 'Alt+Ctrl+P', label: isGerman ? 'Vorschau' : 'Toggle Preview' },
            { key: isGerman ? 'Alt+Strg+K' : 'Alt+Ctrl+K', label: isGerman ? 'KI-Prompt kopieren' : 'Copy AI Prompt' },
            { key: isGerman ? 'Alt+Strg+H' : 'Alt+Ctrl+H', label: isGerman ? 'Als HTML kopieren' : 'Copy HTML' },
          ].map(item => (
            <div key={item.key} className={`flex items-center justify-between border-b pb-4 ${theme === 'glassy' ? 'border-white/10' : 'border-gray-800'}`}>
              <span className={`font-medium ${theme === 'glassy' ? 'text-white/60' : 'text-gray-400'}`}>{item.label}</span>
              <kbd className={`px-2 py-1 rounded text-xs font-mono border ${
                theme === 'glassy' ? 'bg-white/10 border-white/20 text-brand-300' : 'bg-gray-800 border-gray-700 text-brand-400'
              }`}>{item.key}</kbd>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

const AppContent = () => {
  const { targetLanguage, setTargetLanguage, languages } = useContext(LanguageContext);
  const { theme, setTheme, fetchNewBg } = useContext(ThemeContext);
  const isGerman = targetLanguage?.code === 'de';
  const location = useLocation();
  const navigate = useNavigate();

  const navItems = [
    { id: 'dashboard', path: '/', icon: LayoutDashboard, labelEn: 'Dashboard', labelDe: 'Dashboard' },
    { id: 'categories', path: '/categories', icon: Filter, labelEn: 'Categories', labelDe: 'Kategorien' },
    { id: 'help', path: '/help', icon: HelpCircle, labelEn: 'Help', labelDe: 'Hilfe' },
    { id: 'settings', path: '/settings', icon: Settings, labelEn: 'Settings', labelDe: 'Einstellungen' },
  ];

  return (
    <div className={`flex h-screen overflow-hidden font-body antialiased ${theme === 'glassy' ? 'text-white' : 'text-text-main'}`}>
      {/* Sidebar */}
      <aside className={`w-80 border-r flex flex-col shrink-0 z-30 transition-all ${
        theme === 'glassy' ? 'bg-black/40 border-white/10 glass-blur' : 'bg-bg-sidebar border-border-main'
      }`}>
        <div className="p-8 border-b border-white/5 mb-6">
          <Link to="/" className="flex items-center gap-4 group/logo no-underline">
            <div className={`w-12 h-12 rounded-xl flex items-center justify-center shadow-xl transition-all duration-500 animate-float animate-glow group-hover/logo:scale-110 border ${
              theme === 'glassy' ? 'bg-brand-500/20 border-brand-400/30 shadow-brand-500/30 text-white' : 'bg-brand-600 border-brand-600 shadow-brand-600/20 text-white'
            }`}>
              <DrupalLogo size={28} />
            </div>
            <div>
              <h2 className={`text-sm font-black tracking-tight leading-tight uppercase ${theme === 'glassy' ? 'text-white' : 'text-text-main'}`}>Project Description Browser</h2>
              <p className={`text-[10px] font-bold mt-0.5 uppercase tracking-widest ${theme === 'glassy' ? 'text-brand-400' : 'text-brand-600'}`}>Translation Suite</p>
            </div>
          </Link>
        </div>

        <nav className="flex-1 px-6 py-2 space-y-1.5 overflow-y-auto">
          {navItems.map((item) => {
            const isActive = location.pathname === item.path;
            const Icon = item.icon;
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
          <div className={`p-4 rounded-2xl border ${theme === 'glassy' ? 'bg-white/5 border-white/10' : 'bg-bg-card border-border-main'}`}>
             <div className="flex items-center justify-between mb-4">
               <div className="flex items-center gap-2">
                 <Palette size={14} className="text-brand-500" />
                 <span className="text-[10px] font-bold text-text-muted uppercase tracking-widest">{isGerman ? 'Design' : 'Theme'}</span>
               </div>
               {theme === 'glassy' && (
                 <button 
                  onClick={fetchNewBg} 
                  className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg bg-brand-600/10 text-brand-500 hover:bg-brand-600 hover:text-white transition-all text-[10px] font-bold border border-brand-500/20 group/refresh"
                  title={isGerman ? 'Hintergrundbild wechseln' : 'Change Background Image'}
                 >
                   <RefreshCw size={12} className="group-hover/refresh:rotate-180 transition-transform duration-500" />
                   {isGerman ? 'Hintergrundbild erneuern' : 'Refresh Background'}
                 </button>
               )}
             </div>
             <div className="grid grid-cols-2 gap-2">
               {THEMES.map(t => {
                 const TIcon = t.icon;
                 const isSelected = theme === t.id;
                 return (
                   <button
                     key={t.id}
                     onClick={() => setTheme(t.id)}
                     className={`flex flex-col items-center gap-1.5 p-2 rounded-xl border text-[10px] font-bold transition-all ${
                       isSelected 
                        ? 'bg-brand-600 border-brand-600 text-white shadow-sm' 
                        : 'bg-bg-input border-border-main text-text-muted hover:border-text-muted'
                     }`}
                   >
                     <TIcon size={16} />
                     {isGerman ? (t.labelDe.split(' ')[1] || t.labelDe) : (t.labelEn.split(' ')[1] || t.labelEn)}
                   </button>
                 );
               })}
             </div>
          </div>

          {/* Language Switcher */}
          <div className={`p-4 rounded-2xl border ${theme === 'glassy' ? 'bg-white/5 border-white/10' : 'bg-bg-card border-border-main'}`}>
            <div className="flex items-center gap-2 mb-3 text-[10px] font-bold text-text-muted uppercase tracking-widest">
              <Globe size={14} className="text-brand-500" />
              {isGerman ? 'Ziellsprache' : 'Target Language'}
            </div>
            <select
              className={`w-full border rounded-xl focus:ring-4 focus:ring-brand-500/20 outline-none transition-all cursor-pointer p-2.5 text-sm font-bold ${
                theme === 'glassy' ? 'bg-white/10 border-white/20 text-white' : 'bg-bg-input border-border-main text-text-main'
              }`}
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
      <main className={`flex-1 overflow-y-auto transition-all ${theme === 'glassy' ? 'glass-blur' : 'bg-bg-app'}`}>
        <div className="min-h-full flex flex-col">
          <Routes>
            <Route path="/" element={<Dashboard isGerman={isGerman} />} />
            <Route path="/edit/:machineName" element={<Editor isGerman={isGerman} />} />
            <Route path="/categories" element={<CategoriesView isGerman={isGerman} />} />
            <Route path="/settings" element={<SettingsView isGerman={isGerman} />} />
            <Route path="/help" element={<HelpView isGerman={isGerman} />} />
          </Routes>
        </div>
      </main>
    </div>
  );
};

const App = () => {
  const [targetLanguage, setTargetLanguage] = useState(() => {
    const saved = localStorage.getItem('targetLanguage');
    try {
      return saved ? JSON.parse(saved) : { code: 'de', name: 'German' };
    } catch (e) {
      return { code: 'de', name: 'German' };
    }
  });
  const [languages, setLanguages] = useState([]);
  const [toasts, setToasts] = useState([]);
  const [theme, setTheme] = useState(localStorage.getItem('pb-theme') || 'glassy');
  const [bgImage, setBgImage] = useState(localStorage.getItem('pb-bgImage') || '');

  async function fetchNewBg() {
    try {
      const res = await axios.get(`${API_BASE}/unsplash/random-bg`);
      setBgImage(res.data.url);
      localStorage.setItem('pb-bgImage', res.data.url);
    } catch (err) {
      console.error(err);
    }
  }

  function showToast(message, type = 'success') {
    const id = Date.now();
    setToasts(prev => [...prev, { id, message, type }]);
    setTimeout(() => {
      setToasts(prev => prev.filter(t => t.id !== id));
    }, 4000);
  }

  useEffect(() => {
    axios.get(`${API_BASE}/languages`).then(res => setLanguages(res.data));
    if (theme === 'glassy' && !bgImage) {
      fetchNewBg();
    }
  }, []);

  useEffect(() => {
    localStorage.setItem('targetLanguage', JSON.stringify(targetLanguage));
  }, [targetLanguage]);

  useEffect(() => {
    localStorage.setItem('pb-theme', theme);
    document.documentElement.className = `theme-${theme}`;
    if (theme === 'glassy' && !bgImage) {
      fetchNewBg();
    }
  }, [theme]);

  return (
    <ThemeContext.Provider value={{ theme, setTheme, bgImage, fetchNewBg }}>
      <LanguageContext.Provider value={{ targetLanguage, setTargetLanguage, languages }}>
        <ToastContext.Provider value={{ showToast }}>
          <div 
            className={`${theme === 'glassy' ? 'bg-unsplash' : 'bg-bg-app'} min-h-screen transition-colors duration-500`}
            style={theme === 'glassy' ? { backgroundImage: `linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url(${bgImage})` } : {}}
          >
            <Router>
              <AppContent />
              <ToastContainer toasts={toasts} />
            </Router>
          </div>
        </ToastContext.Provider>
      </LanguageContext.Provider>
    </ThemeContext.Provider>
  );
};

export default App;
