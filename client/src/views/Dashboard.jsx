import React, { useState, useEffect, useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import axios from 'axios';
import { 
  RefreshCw, 
  Zap, 
  Plus, 
  Download, 
  ChevronRight, 
  Clock, 
  HelpCircle, 
  FileText,
  ChevronsLeft,
  ChevronLeft,
  ChevronsRight
} from 'lucide-react';

// Contexts
import { AuthContext } from '../context/AuthContext';
import { LanguageContext } from '../context/LanguageContext';
import { ThemeContext } from '../context/ThemeContext';
import { ToastContext } from '../context/ToastContext';
import { WorkflowContext } from '../context/WorkflowContext';

// Components
import DrupalLogo from '../components/ui/DrupalLogo';
import StatusBadge from '../components/ui/StatusBadge';
import SyncProgressBar from '../components/ui/SyncProgressBar';
import SearchWithAutocomplete from '../components/shared/SearchWithAutocomplete';
import Tooltip from '../components/ui/Tooltip';

// Utils
import { API_BASE } from '../utils/constants';

/**
 * @file Dashboard.jsx
 * The main landing page showing a searchable, filterable list of projects.
 */
const Dashboard = ({ isGerman }) => {
  const { user } = useContext(AuthContext);
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
  const [showManualAdd, setShowManualAdd] = useState(false);
  
  const { showToast } = useContext(ToastContext);
  const { priorityMode, setPriorityMode } = useContext(WorkflowContext);

  async function fetchProjects(searchTerm = search) {
    setLoading(true);
    try {
      const offset = (currentPage - 1) * limit;
      const res = await axios.get(`${API_BASE}/projects`, {
        params: {
          search: searchTerm,
          langcode: targetLanguage.code,
          filter: activeFilter === 'all' ? undefined : (activeFilter === 'priority' ? 'priority' : activeFilter),
          offset,
          limit
        }
      });
      setProjects(res.data.data);
      setTotalItems(res.data.meta.count || 0);
      setLoading(false);
      localStorage.setItem('pb-activeFilter', activeFilter);
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
      <div className={`w-full rounded-3xl p-6 sm:p-8 lg:p-10 mb-12 border shadow-2xl transition-all glass-blur bg-bg-card border-border-main overflow-hidden`}>
        <div className="flex flex-col gap-10">
          <div className="max-w-3xl">
            <div className="flex items-center gap-4 mb-5">
              <div className="w-12 h-12 rounded-2xl bg-brand-600 flex items-center justify-center text-white shadow-lg shadow-brand-600/30 border border-brand-500/20 shrink-0">
                <DrupalLogo size={28} />
              </div>
              <h1 className="text-4xl lg:text-5xl font-black tracking-tight drop-shadow-sm">{isGerman ? 'Projekt-Beschreibungen' : 'Project Descriptions'}</h1>
            </div>
            <p className="text-lg lg:text-xl text-text-main font-medium leading-relaxed opacity-90">
              {isGerman ? 'Übersetzung von Drupal Modulen in das Deutsche. Hilf mit, das Ökosystem zugänglicher zu machen.' : 'Localizing Drupal modules. Help make the ecosystem more accessible to non-English speakers.'}
            </p>
            {user?.last_reviewed_project && (
              <div className="mt-4 p-4 rounded-2xl border flex items-center justify-between bg-brand-500/10 border-brand-500/20">
                <div className="flex items-center gap-3">
                  <Clock size={18} className="text-brand-500" />
                  <span className="text-sm font-medium flex items-center gap-2">
                    {isGerman ? 'Zuletzt im Review-Prozess bearbeitet:' : 'Last project in review process:'} 
                    <code className="font-bold text-brand-600">{user.last_reviewed_project}</code>
                    <Tooltip text={isGerman 
                      ? "Setze deine Arbeit an dem Modul fort, das du zuletzt in dieser Sprache bearbeitet oder für das Review geöffnet hast." 
                      : "Continue working on the module you last edited or opened for review in this language."}>
                      <HelpCircle size={14} className="text-text-muted hover:text-brand-500 transition-colors cursor-help" />
                    </Tooltip>
                  </span>
                </div>
                <button 
                  onClick={() => navigate(`/edit/${user.last_reviewed_project}`)}
                  className="flex items-center gap-2 px-4 py-1.5 rounded-lg bg-brand-600 text-white text-xs font-bold hover:bg-brand-700 transition-all shadow-lg shadow-brand-600/20"
                >
                  {isGerman ? 'Weitermachen' : 'Continue'}
                  <ChevronRight size={14} />
                </button>
              </div>
            )}
          </div>

          <div className="flex flex-col xl:flex-row xl:items-center justify-between gap-6 pt-8 border-t border-white/5">
            <div className="flex flex-wrap gap-2.5">
              {[
                { id: 'all', label: isGerman ? 'Alle Projekte' : 'All Projects' },
                { id: 'priority', label: isGerman ? 'Drupal 11' : 'Drupal 11' },
                { id: 'missing', label: isGerman ? 'Fehlend' : 'Missing' },
                { id: 'review', label: isGerman ? 'Review' : 'Review' },
                { id: 'stale', label: isGerman ? 'Veraltet' : 'Stale' },
                { id: 'translated', label: isGerman ? 'Übersetzt' : 'Translated' }
              ].map(filter => (
                <button
                  key={filter.id}
                  className={`px-5 py-2.5 rounded-xl text-sm font-black transition-all border shadow-sm ${
                    activeFilter === filter.id 
                      ? 'bg-brand-600 text-white border-brand-600 ring-4 ring-brand-500/20 shadow-lg'
                      : 'bg-white/5 border-border-main text-text-main hover:bg-white/10'
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

            <div className="flex flex-wrap items-center gap-3">
              <div className="w-full sm:w-80">
                <SearchWithAutocomplete 
                  value={search} 
                  isGerman={isGerman} 
                  onChange={(val) => {
                    setSearch(val);
                    localStorage.setItem('pb-search', val);
                    fetchProjects(val);
                  }}
                  onSelect={(mName) => {
                    navigate(`/edit/${mName}`);
                  }}
                />
              </div>
              
              <div className="flex flex-wrap items-center gap-3">
                <div className="flex items-center gap-1.5">
                  <button 
                    className={`flex items-center justify-center gap-2 px-5 py-2.5 border rounded-lg text-sm font-bold transition-all shadow-sm group bg-white/5 border-border-main text-text-main hover:bg-white/10`} 
                    onClick={handleQuickUpdate} 
                    disabled={syncStatus.active}
                  >
                    <Zap size={18} className="text-brand-500 group-hover:scale-110 transition-transform" />
                    {isGerman ? 'Schnell' : 'Quick'}
                  </button>
                  <Tooltip text={isGerman ? "Schnelles Update (letzte 7 Tage)" : "Quick update (last 7 days)"}>
                    <HelpCircle size={16} className="text-text-muted hover:text-brand-500 transition-colors" />
                  </Tooltip>
                </div>

                <div className="flex items-center gap-1.5">
                  <button 
                    className={`flex items-center justify-center gap-2 px-5 py-2.5 rounded-lg text-sm font-bold transition-all disabled:opacity-50 border bg-brand-600 border-brand-600 text-white hover:bg-brand-700 shadow-xl shadow-brand-600/20`} 
                    onClick={handleSyncStart} 
                    disabled={syncStatus.active}
                  >
                    <RefreshCw size={18} className={syncStatus.active ? 'animate-spin' : ''} />
                    {isGerman ? 'Sync' : 'Sync'}
                  </button>
                  <Tooltip text={isGerman ? "Vollständiger Datenbank-Sync" : "Full database sync"}>
                    <HelpCircle size={16} className="text-text-muted hover:text-brand-500 transition-colors" />
                  </Tooltip>
                </div>

                <button 
                  className={`flex items-center justify-center gap-2 px-4 py-2.5 rounded-lg text-sm font-bold transition-all border ${
                    showManualAdd 
                      ? 'bg-white/20 border-white/30 text-white'
                      : 'bg-white/5 border-border-main text-text-main hover:bg-white/10'
                  }`} 
                  onClick={() => setShowManualAdd(!showManualAdd)}
                >
                  <Plus size={18} className={`transition-transform duration-300 ${showManualAdd ? 'rotate-45' : ''}`} />
                  {isGerman ? 'Modul' : 'Module'}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <SyncProgressBar status={syncStatus} onStop={handleSyncStop} />

      {showManualAdd && (
        <div className="border rounded-2xl p-6 mb-12 shadow-xl animate-in slide-in-from-top duration-300 flex flex-col md:flex-row md:items-center gap-6 bg-bg-card border-border-main glass-blur">
          <div className="flex-1">
            <h4 className="text-lg font-bold leading-tight flex items-center gap-2">
              <Download size={20} className="text-brand-500" />
              {isGerman ? 'Modul manuell hinzufügen' : 'Add Single Module'}
            </h4>
            <p className="text-xs text-text-muted font-medium mt-1">{isGerman ? 'Direkt von Drupal.org synchronisieren.' : 'Sync directly from Drupal.org via machine name.'}</p>
          </div>
          <form onSubmit={handleManualSync} className="flex gap-2">
            <input 
              type="text" 
              placeholder="machine_name (z.B. pathauto)"
              value={manualMachineName}
              onChange={(e) => setManualMachineName(e.target.value)}
              className="w-full md:w-64 px-4 py-2 rounded-xl text-sm font-bold focus:ring-4 focus:ring-brand-500/20 outline-none transition-all border bg-bg-input border-border-main text-text-main"
              autoFocus
            />
            <button 
              className="flex items-center gap-2 px-6 py-2 rounded-xl text-sm font-bold transition-all disabled:opacity-50 shrink-0 border bg-brand-600 border-brand-600 text-white hover:bg-brand-700 shadow-lg"
              disabled={syncingManual}
            >
              {syncingManual ? <RefreshCw size={16} className="animate-spin" /> : <Plus size={16} />}
              {isGerman ? 'Hinzufügen' : 'Add'}
            </button>
          </form>
        </div>
      )}

      <div className={`flex justify-between items-center mb-10 p-5 rounded-2xl border glass-blur bg-bg-card border-border-main shadow-lg`}>
        <div className={`text-sm font-bold text-text-main`}>
          {isGerman ? 'Gefunden:' : 'Found:'} <span className="text-brand-600 text-base ml-1">{totalItems.toLocaleString()}</span> {isGerman ? 'Module' : 'Modules'}
        </div>
        <div className="flex items-center gap-4">
          <label className={`text-xs font-black uppercase tracking-widest text-text-muted`}>{isGerman ? 'Pro Seite:' : 'Per page:'}</label>
          <select
            value={limit}
            onChange={(e) => {
              setLimit(parseInt(e.target.value));
              setCurrentPage(1);
            }}
            className={`text-sm rounded-xl focus:ring-brand-500 focus:border-brand-500 block p-2 transition-all outline-none border glass-blur bg-bg-input border-border-main text-text-main font-bold`}
          >
            <option value="50">50</option>
            <option value="100">100</option>
            <option value="250">250</option>
            <option value="500">500</option>
          </select>
        </div>
      </div>

      {loading ? (
        <div className="flex flex-col items-center justify-center py-24">
          <RefreshCw size={48} className="animate-spin mb-4 text-brand-600 drop-shadow-[0_0_10px_rgba(127,86,217,0.5)]" />
          <p className="text-text-main font-medium opacity-70">{isGerman ? 'Projekte werden geladen...' : 'Fetching project data...'}</p>
        </div>
      ) : (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {projects.map(project => (
          <Link 
            key={project.id}
            to={`/edit/${project.attributes.field_project_machine_name}`}
            className="group relative flex flex-col p-8 rounded-2xl border transition-all no-underline overflow-hidden bg-bg-card border-border-main hover:bg-bg-card-hover"
          >
            <div className={`absolute top-0 left-0 right-0 h-1.5 ${
              project.meta?.translation_status === 'translated' ? 'bg-green-500' :
              project.meta?.translation_status === 'stale' ? 'bg-amber-500' : 
              'bg-border-main'
            }`}></div>

            <div className="flex gap-5 mb-6">
              <div className="w-16 h-16 rounded-2xl flex items-center justify-center shrink-0 border overflow-hidden shadow-inner group-hover:scale-105 transition-transform duration-300 bg-bg-input border-border-muted">
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
                <h3 className="text-xl font-bold leading-tight transition-colors line-clamp-2 text-text-main group-hover:text-brand-600">
                  {project.meta?.translation?.title || project.attributes.title}
                </h3>
              </div>
            </div>
            
            <div 
              className="text-sm font-medium leading-relaxed line-clamp-3 mb-8 flex-1 text-text-muted" 
              dangerouslySetInnerHTML={{ __html: project.meta?.translation?.summary || project.attributes.body?.summary || (isGerman ? 'Keine Zusammenfassung verfügbar.' : 'No summary available.') }}
            />

            <div className="flex items-center justify-between pt-6 border-t border-border-muted">
              <div className="flex items-center gap-2 text-xs font-bold text-text-muted">
                <FileText size={14} />
                <span>{project.attributes.title !== (project.meta?.translation?.title || project.attributes.title) ? project.attributes.title : (isGerman ? 'Quelle: Englisch' : 'Source: English')}</span>
              </div>
              <div className="flex items-center gap-2 px-4 py-2 rounded-xl border text-xs font-bold transition-all shadow-sm whitespace-nowrap bg-bg-input border-border-main text-text-main group-hover:bg-brand-600 group-hover:text-white group-hover:border-brand-600">
                {isGerman ? 'Bearbeiten' : 'Edit'}
                <ChevronRight size={14} />
              </div>
            </div>
          </Link>
        ))}
      </div>
      )}

      {!loading && totalItems > limit && (
        <div className="flex justify-center items-center gap-2 mt-12">
          <button
            className="p-2 rounded-lg border transition-all disabled:opacity-20 bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover"
            disabled={currentPage === 1}
            onClick={() => {
              setCurrentPage(1);
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
          >
            <ChevronsLeft size={20} />
          </button>

          <button
            className="p-2 rounded-lg border transition-all disabled:opacity-20 bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover"
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
            className="p-2 rounded-lg border transition-all disabled:opacity-20 bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover"
            disabled={currentPage >= Math.ceil(totalItems / limit)}
            onClick={() => {
              setCurrentPage(prev => prev + 1);
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
          >
            <ChevronRight size={20} />
          </button>

          <button
            className="p-2 rounded-lg border transition-all disabled:opacity-20 bg-bg-card border-border-main text-text-muted hover:bg-bg-card-hover"
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

export default Dashboard;
