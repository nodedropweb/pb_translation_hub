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
  Play
} from 'lucide-react';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import './App.css';

const API_BASE = `${window.location.protocol}//${window.location.hostname}:3001/api`;

// --- Context ---
const LanguageContext = createContext();
const ToastContext = createContext();

// --- Components ---

const ToastContainer = ({ toasts }) => (
  <div style={{ position: 'fixed', bottom: '2rem', right: '2rem', zIndex: 9999, display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
    {toasts.map(toast => (
      <div
        key={toast.id}
        className="animate-slideIn"
        style={{
          background: toast.type === 'error' ? '#ef4444' : '#10b981',
          color: '#fff',
          padding: '1rem 1.5rem',
          borderRadius: '0.75rem',
          boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)',
          display: 'flex',
          alignItems: 'center',
          gap: '0.75rem',
          minWidth: '300px',
          fontWeight: 500
        }}
      >
        {toast.type === 'error' ? <AlertCircle size={20} /> : <CheckCircle size={20} />}
        {toast.message}
      </div>
    ))}
  </div>
);

const StatusBadge = ({ status }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const isGerman = targetLanguage?.code === 'de';

  const configs = {
    missing: { icon: AlertCircle, class: 'status-missing', text: isGerman ? 'Fehlend' : 'Missing' },
    translated: { icon: CheckCircle, class: 'status-translated', text: isGerman ? 'Übersetzt' : 'Translated' },
    stale: { icon: Clock, class: 'status-stale', text: isGerman ? 'Veraltet' : 'Stale' }
  };
  const config = configs[status] || configs.missing;
  const Icon = config.icon;

  return (
    <span className={`status-badge ${config.class}`}>
      <Icon size={12} style={{ marginRight: '4px' }} />
      {config.text}
    </span>
  );
};

const SyncProgressBar = ({ status, onStop }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const isGerman = targetLanguage?.code === 'de';

  if (!status.active && status.current === 0) return null;

  const percentage = status.finished ? 100 : Math.min(Math.round((status.current / status.total) * 100), 100);

  return (
    <div className={`sync-progress-container animate-fade ${status.finished ? 'finished' : ''}`}>
      <div className="sync-progress-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
          {status.finished ? (
            <CheckCircle size={16} color="#10b981" />
          ) : (
            <RefreshCw size={16} className={status.active ? 'animate-spin' : ''} />
          )}
          <span style={{ fontWeight: 700 }}>
            {status.active 
              ? (isGerman ? 'Synchronisiere von Drupal.org...' : 'Syncing from Drupal.org...') 
              : status.finished 
                ? (isGerman ? 'Sync abgeschlossen!' : 'Sync Complete!') 
                : (isGerman ? 'Sync pausiert' : 'Sync Paused')}
          </span>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>
            {status.current.toLocaleString()} {isGerman ? 'Dateien' : 'Files'}
          </span>
          {status.active && (
            <button className="btn-icon" onClick={onStop} title={isGerman ? 'Sync stoppen' : 'Stop Sync'}>
              <XCircle size={18} />
            </button>
          )}
        </div>
      </div>
      <div className="progress-track">
        <div className={`progress-fill ${status.finished ? 'success' : ''}`} style={{ width: `${percentage}%` }}></div>
      </div>
      {status.lastMachineName && !status.finished && (
        <div style={{ marginTop: '0.5rem', fontSize: '0.7rem', color: 'var(--text-muted)' }}>
          {isGerman ? 'Verarbeite:' : 'Processing:'} <code>{status.lastMachineName}</code>
        </div>
      )}
    </div>
  );
};

const DrupalLogo = ({ size = 32, ...props }) => (
  <svg width={size} height={size} viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg" {...props}>
    <path d="M8.563 16.5c-3.718 0-7.062-2.926-7.062-6.906 0-3.974 3.098-5.813 3.672-6.114 0.684-0.364 1.176-0.556 1.95-1.175 0.383-0.301 0.702-0.739 0.803-1.805 0.555 0.665 1.221 1.439 1.694 1.759 0.775 0.51 1.55 0.711 2.36 1.221 0.492 0.301 3.518 2.15 3.518 6.241 0 4.082-3.226 6.779-6.935 6.779zM14.030 9.903c-0.729 0-2.205 1.513-2.979 1.522-0.901 0.018-2.149-1.787-3.954-1.77-1.422 0.010-2.542 1.14-2.561 2.343-0.009 0.675 0.21 1.176 0.675 1.494 0.31 0.209 0.592 0.337 1.512 0.337 1.531 0 3.472-1.896 4.365-1.867 0.71 0.026 1.812 1.768 2.369 1.804 0.437 0.036 0.665-0.164 1.038-0.701 0.364-0.547 0.52-1.404 0.52-1.887 0-0.473-0.21-1.275-0.985-1.275zM11.917 14.741c-0.31 0.228-1.003 0.511-1.987 0.511s-1.448-0.21-1.758-0.447c-0.045-0.036-0.027-0.036-0.119-0.036-0.1 0-0.154 0.046-0.236 0.109-0.073 0.064-0.109 0.219 0 0.328 0.674 0.619 1.804 0.565 2.633 0.491 0.839-0.082 1.55-0.573 1.622-0.646 0.109-0.108 0.082-0.2 0.063-0.264-0.018-0.064-0.073-0.154-0.218-0.046zM11.424 13.184c-0.182-0.118-0.445-0.137-0.691-0.137-0.247 0-0.383-0.018-0.646 0.091-0.266 0.109-0.539 0.355-0.711 0.511-0.174 0.154-0.201 0.273-0.11 0.401 0.092 0.117 0.192 0.044-0.447-0.174 0.264-0.21 0.438-0.401 0.975-0.401s0.629 0.201 0.737 0.401c0.11 0.2 0.119 0.228 0.228 0.174 0.128-0.064 0.192-0.156 0.128-0.312-0.065-0.154-0.174-0.427-0.357-0.554z" fill="currentColor" />
  </svg>
);

// --- Views ---

const Dashboard = ({ isGerman }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const [projects, setProjects] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [activeFilter, setActiveFilter] = useState('missing');
  const [currentPage, setCurrentPage] = useState(1);
  const [limit, setLimit] = useState(50);
  const [totalItems, setTotalItems] = useState(0);
  const [syncStatus, setSyncStatus] = useState({ active: false, current: 0, total: 50000 });
  const { showToast } = useContext(ToastContext);

  useEffect(() => {
    fetchProjects();
    const interval = setInterval(fetchSyncStatus, 2000);
    return () => clearInterval(interval);
  }, [targetLanguage, activeFilter, currentPage, limit]);

  const fetchProjects = async (searchTerm = search) => {
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
    } catch (err) {
      console.error(err);
      setLoading(false);
    }
  };

  const fetchSyncStatus = async () => {
    try {
      const res = await axios.get(`${API_BASE}/sync/status`);
      setSyncStatus(res.data);
      if (!res.data.active && syncStatus.active) {
        fetchProjects(search);
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleSyncStart = async () => {
    try {
      await axios.post(`${API_BASE}/sync/start`);
    } catch (err) {
      showToast('Failed to start sync', 'error');
    }
  };

  const handleQuickUpdate = async () => {
    try {
      await axios.post(`${API_BASE}/sync/quick`, { days: 7 });
    } catch (err) {
      showToast('Failed to start quick update', 'error');
    }
  };

  const handleSyncStop = async () => {
    try {
      await axios.post(`${API_BASE}/sync/stop`);
    } catch (err) {
      console.error(err);
    }
  };

  const handleImportLocal = async () => {
    try {
      const res = await axios.post(`${API_BASE}/import-local`);
      showToast(isGerman ? `Erfolgreich ${res.data.count} Dateien aus Drupal importiert.` : `Imported ${res.data.count} files from Drupal.`);
      fetchProjects();
    } catch (err) {
      showToast(isGerman ? 'Import fehlgeschlagen.' : 'Import failed.', 'error');
    }
  };

  return (
    <div className="animate-fade">
      <div className="header">
        <div>
          <h1>Project Browser</h1>
          <div style={{ display: 'flex', gap: '0.5rem', marginTop: '0.5rem' }}>
            <button
              className={`filter-chip ${activeFilter === 'all' ? 'active' : ''}`}
              onClick={() => setActiveFilter('all')}
            >{isGerman ? 'Alle' : 'All'}</button>
            <button
              className={`filter-chip ${activeFilter === 'missing' ? 'active' : ''}`}
              onClick={() => setActiveFilter('missing')}
            >{isGerman ? 'Fehlend' : 'Missing'}</button>
            <button
              className={`filter-chip ${activeFilter === 'stale' ? 'active' : ''}`}
              onClick={() => setActiveFilter('stale')}
            >{isGerman ? 'Veraltet' : 'Stale'}</button>
            <button
              className={`filter-chip ${activeFilter === 'translated' ? 'active' : ''}`}
              onClick={() => setActiveFilter('translated')}
            >{isGerman ? 'Übersetzt' : 'Translated'}</button>
          </div>
        </div>
        <div style={{ display: 'flex', gap: '1rem' }}>
          <div style={{ position: 'relative' }}>
            <Search style={{ position: 'absolute', left: '1rem', top: '50%', transform: 'translateY(-50%)', color: 'var(--text-muted)' }} size={18} />
            <input
              type="text"
              placeholder={isGerman ? "Projekte suchen..." : "Search projects..."}
              className="search-bar"
              style={{ paddingLeft: '3rem' }}
              value={search}
              onChange={(e) => {
                setSearch(e.target.value);
                clearTimeout(window.searchTimeout);
                window.searchTimeout = setTimeout(() => fetchProjects(e.target.value), 500);
              }}
            />
          </div>
          <button className="btn btn-outline" onClick={handleQuickUpdate} disabled={syncStatus.active}>
            <Zap size={18} />
            {isGerman ? 'Schnell-Update' : 'Quick Update'}
          </button>
          <button className="btn btn-primary" onClick={handleSyncStart} disabled={syncStatus.active}>
            <RefreshCw size={18} className={syncStatus.active ? 'animate-spin' : ''} />
            {isGerman ? 'Full Sync' : 'Full Sync'}
          </button>
        </div>
      </div>

      <SyncProgressBar status={syncStatus} onStop={handleSyncStop} />

      <div className="dashboard-controls" style={{ marginBottom: '2rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>
          {isGerman ? 'Gefunden:' : 'Found:'} <strong>{totalItems.toLocaleString()}</strong> {isGerman ? 'Module' : 'Modules'}
        </div>
        <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
          <label style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>{isGerman ? 'Pro Seite:' : 'Per page:'}</label>
          <select
            value={limit}
            onChange={(e) => {
              setLimit(parseInt(e.target.value));
              setCurrentPage(1);
            }}
            style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', color: 'white', padding: '0.25rem 0.5rem', borderRadius: '0.4rem', outline: 'none' }}
          >
            <option value="50">50</option>
            <option value="100">100</option>
            <option value="250">250</option>
            <option value="500">500</option>
          </select>
        </div>
      </div>

      {loading ? (
        <div style={{ textAlign: 'center', padding: '4rem' }}>
          <RefreshCw size={48} className="animate-spin" style={{ color: 'var(--primary)', marginBottom: '1rem' }} />
          <p>{isGerman ? 'Projekte werden geladen...' : 'Fetching project data...'}</p>
        </div>
      ) : (
        <div className="project-grid">
          {projects.map(project => (
            <Link
              to={`/edit/${project.attributes.field_project_machine_name}`}
              key={project.id}
              className="project-card"
              style={{ textDecoration: 'none', color: 'inherit' }}
            >
              <div style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }}>
                <div className="project-logo">
                  {project.meta?.logo_url ? (
                    <img src={project.meta.logo_url} alt="" />
                  ) : (
                    <Zap size={24} color="var(--primary)" />
                  )}
                </div>
                <div style={{ flex: 1 }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.25rem' }}>
                    <StatusBadge status={project.meta?.translation_status} />
                    <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>{project.attributes.field_project_machine_name}</span>
                  </div>
                  <h3 style={{ margin: 0 }}>{project.attributes.title}</h3>
                </div>
              </div>
              <p className="card-summary">{project.attributes.body?.summary || (isGerman ? 'Keine Zusammenfassung verfügbar.' : 'No summary available.')}</p>
              <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
                <ChevronRight size={20} color="var(--primary)" />
              </div>
            </Link>
          ))}
        </div>
      )}

      {!loading && totalItems > limit && (
        <div className="pagination" style={{ marginTop: '3rem', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '0.75rem' }}>
          <button
            className="btn btn-outline"
            disabled={currentPage === 1}
            onClick={() => {
              setCurrentPage(1);
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
            title={isGerman ? 'Erste Seite' : 'First Page'}
            style={{ padding: '0.5rem' }}
          >
            <ChevronsLeft size={20} />
          </button>

          <button
            className="btn btn-outline"
            disabled={currentPage === 1}
            onClick={() => {
              setCurrentPage(prev => Math.max(1, prev - 1));
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
            style={{ padding: '0.5rem' }}
          >
            <ChevronLeft size={20} />
          </button>

          <div style={{ fontSize: '0.9rem', color: 'var(--text-muted)', margin: '0 0.5rem' }}>
            {isGerman ? 'Seite' : 'Page'} <strong>{currentPage}</strong> {isGerman ? 'von' : 'of'} <strong>{Math.ceil(totalItems / limit)}</strong>
          </div>

          <button
            className="btn btn-outline"
            disabled={currentPage >= Math.ceil(totalItems / limit)}
            onClick={() => {
              setCurrentPage(prev => prev + 1);
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
            style={{ padding: '0.5rem' }}
          >
            <ChevronRight size={20} />
          </button>

          <button
            className="btn btn-outline"
            disabled={currentPage >= Math.ceil(totalItems / limit)}
            onClick={() => {
              setCurrentPage(Math.ceil(totalItems / limit));
              window.scrollTo({ top: 0, behavior: 'smooth' });
            }}
            title={isGerman ? 'Letzte Seite' : 'Last Page'}
            style={{ padding: '0.5rem' }}
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
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [translations, setTranslations] = useState({});
  const [saving, setSaving] = useState(false);
  const { showToast } = useContext(ToastContext);

  useEffect(() => {
    fetchCategories();
  }, [targetLanguage]);

  const fetchCategories = async () => {
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
  };

  const handleSave = async () => {
    setSaving(true);
    try {
      await axios.post(`${API_BASE}/categories/translate`, {
        langcode: targetLanguage.code,
        translations: translations
      });
      showToast(isGerman ? 'Kategorien erfolgreich gespeichert.' : 'Categories saved successfully.');
    } catch (err) {
      showToast(isGerman ? 'Fehler beim Speichern.' : 'Failed to save categories.', 'error');
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="animate-fade">
      <div className="header">
        <div>
          <h1>{isGerman ? 'Kategorien' : 'Categories'}</h1>
          <p style={{ color: 'var(--text-muted)' }}>{isGerman ? 'Übersetzung für:' : 'Translating for:'} <strong>{targetLanguage.name}</strong></p>
        </div>
        <div style={{ display: 'flex', gap: '1rem' }}>
          <button className="btn btn-outline" onClick={async () => {
            try {
              const res = await axios.post(`${API_BASE}/categories/import-local`, { langcode: targetLanguage.code });
              showToast(isGerman ? `Erfolgreich ${res.data.count} Bezeichnungen importiert!` : `Successfully imported ${res.data.count} items!`);
              fetchCategories();
            } catch (err) {
              showToast(isGerman ? 'Keine Import-Datei gefunden.' : 'No import file found.', 'error');
            }
          }}>
            <RefreshCw size={18} />
            {isGerman ? 'Aus Drupal importieren' : 'Import from Drupal'}
          </button>
          <button className="btn btn-primary" onClick={handleSave} disabled={saving}>
            <Save size={18} />
            {saving ? (isGerman ? 'Speichert...' : 'Saving...') : (isGerman ? 'Alle Kategorien speichern' : 'Save All Categories')}
          </button>
        </div>
      </div>

      <div className="editor-pane" style={{ maxHeight: 'calc(100vh - 200px)' }}>
        <div className="pane-header">
          <span>{isGerman ? 'Modul-Kategorien' : 'Module Categories'}</span>
          <span style={{ color: 'var(--text-muted)', fontSize: '0.8rem' }}>{categories.length} {isGerman ? 'Einträge' : 'items'}</span>
        </div>
        {loading ? (
          <div style={{ padding: '4rem', textAlign: 'center' }}><RefreshCw className="animate-spin" /></div>
        ) : (
          <div className="pane-content" style={{ padding: '0' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead style={{ background: 'var(--glass)', position: 'sticky', top: 0, zIndex: 1 }}>
                <tr>
                  <th style={{ textAlign: 'left', padding: '1rem 2rem', color: 'var(--text-muted)', fontSize: '0.8rem' }}>{isGerman ? 'Original (EN)' : 'Original (EN)'}</th>
                  <th style={{ textAlign: 'left', padding: '1rem 2rem', color: 'var(--text-muted)', fontSize: '0.8rem' }}>{isGerman ? `Übersetzung (${targetLanguage.code})` : `Translation (${targetLanguage.code})`}</th>
                </tr>
              </thead>
              <tbody>
                {categories.map(cat => (
                  <tr key={cat.id} style={{ borderBottom: '1px solid var(--border)' }}>
                    <td style={{ padding: '1rem 2rem', fontWeight: '600' }}>{cat.attributes.name}</td>
                    <td style={{ padding: '1rem 2rem' }}>
                      <input
                        type="text"
                        className="search-bar"
                        style={{ width: '100%', padding: '0.5rem 1rem', fontSize: '0.9rem' }}
                        value={translations[cat.id] || ''}
                        onChange={e => setTranslations({ ...translations, [cat.id]: e.target.value })}
                        placeholder={isGerman ? `Übersetze "${cat.attributes.name}"...` : `Translate "${cat.attributes.name}"...`}
                      />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
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
  const { showToast } = useContext(ToastContext);


  useEffect(() => {
    fetchData();
  }, [machineName, targetLanguage]);

  const fetchData = async () => {
    setLoading(true);
    try {
      const projectRes = await axios.get(`${API_BASE}/projects/${machineName}`, {
        params: { langcode: targetLanguage.code }
      });
      const source = projectRes.data;
      setProject(source);

      try {
        const transRes = await axios.get(`${API_BASE}/translations/${targetLanguage.code}/${machineName}`);
        const t = transRes.data;
        setTranslation({
          title: t.title || machineName,
          summary: t.body?.summary || t.summary || '',
          body: t.body?.value || t.body || '',
          screenshot_alts: t.screenshot_alts || {},
          source_hash: t.source_hash || ''
        });
      } catch (err) {
        // Pre-fill with source data for new translations
        setTranslation({
          title: machineName,
          summary: source.attributes.body?.summary || '',
          body: source.attributes.body?.value || '',
          screenshot_alts: source.meta?.screenshot_urls?.reduce((acc, img) => ({ ...acc, [img.id]: img.alt }), {}) || {},
          source_hash: ''
        });
      }
      setLoading(false);
    } catch (err) {
      console.error(err);
      setLoading(false);
    }
  };

  const copyAiPrompt = () => {
    const prompt = `Übersetze die folgenden zwei HTML-Blöcke (Zusammenfassung und Hauptbeschreibung) aus dem Project Browser von Drupal nach ${targetLanguage.name}. Achte dabei darauf, Modulnamen englisch zu lassen und Links nicht zu verändern. Gib mir die Übersetzung als zwei separate HTML-Blöcke zurück:\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`;
    navigator.clipboard.writeText(prompt);
    showToast(isGerman ? 'KI-Prompt kopiert!' : 'AI Prompt copied!');
  };

  const copyHtml = () => {
    const raw = `${project.attributes.body?.summary || ''}\n\n${project.attributes.body?.value || ''}`;
    navigator.clipboard.writeText(raw);
    showToast(isGerman ? 'HTML kopieren' : 'Copy HTML');
  };

  const togglePreview = () => setShowPreview(!showPreview);

  useEffect(() => {
    const handleKeydown = (e) => {
      // Shortcuts only if Alt + Ctrl/Meta
      if (e.altKey && (e.ctrlKey || e.metaKey)) {
        const key = e.key.toLowerCase();
        
        if (key === 's') {
          e.preventDefault();
          handleSave(true);
        } else if (key === 'd') {
          e.preventDefault();
          goToNext();
        } else if (key === 'p') {
          e.preventDefault();
          togglePreview();
        } else if (key === 'k') {
          e.preventDefault();
          copyAiPrompt();
        } else if (key === 'h') {
          e.preventDefault();
          copyHtml();
        }
      }
    };
    window.addEventListener('keydown', handleKeydown);
    return () => window.removeEventListener('keydown', handleKeydown);
  }, [translation, machineName, targetLanguage, project, showPreview]);

  const handleSave = async (andNext = false) => {
    setSaving(true);
    try {
      await axios.post(`${API_BASE}/translations/${targetLanguage.code}/${machineName}`, {
        ...translation
      });
      showToast(isGerman ? 'Übersetzung erfolgreich gespeichert!' : 'Translation saved successfully!');
      if (andNext) {
        goToNext();
      }
    } catch (err) {
      showToast(isGerman ? 'Fehler beim Speichern.' : 'Failed to save translation', 'error');
    } finally {
      setSaving(false);
    }
  };

  if (loading) return (
    <div style={{ padding: '4rem', textAlign: 'center' }}>
      <RefreshCw size={48} className="animate-spin" style={{ color: 'var(--primary)', marginBottom: '1rem' }} />
      <p>{isGerman ? 'Projekt-Details werden geladen...' : 'Loading project details...'}</p>
    </div>
  );

  return (
    <div className="animate-fade">
      <div className="header">
        <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <button className="btn btn-outline" onClick={() => navigate('/')}>
            <ArrowLeft size={18} />
          </button>
          <div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
              <h1>{project.attributes.title}</h1>
              <StatusBadge status={project.meta?.translation_status} />
            </div>
            <p style={{ color: 'var(--text-muted)' }}>{isGerman ? 'Übersetze' : 'Translating'} <code>{machineName}</code> {isGerman ? 'nach' : 'to'} {targetLanguage.name}</p>
          </div>
        </div>
        <div style={{ display: 'flex', gap: '1rem' }}>
          <div style={{ display: 'flex', gap: '0.75rem' }}>
            <button
              onClick={togglePreview}
              className={`btn ${showPreview ? 'btn-primary' : 'btn-outline'}`}
              style={{ padding: '0.5rem 1rem', fontSize: '0.8rem' }}
              title={isGerman ? 'Vorschau umschalten (Strg+Alt+P)' : 'Toggle Preview (Ctrl+Alt+P)'}
            >
              <Info size={16} />
              {isGerman ? (showPreview ? 'Editor zeigen' : 'Vorschau') : (showPreview ? 'Show Editor' : 'Preview')}
            </button>
            <button
              onClick={copyAiPrompt}
              className="btn btn-outline"
              style={{ padding: '0.5rem 1rem', fontSize: '0.8rem', borderColor: 'var(--primary)', color: 'var(--primary)' }}
              title={isGerman ? 'KI-Prompt kopieren (Strg+Alt+K)' : 'Copy AI Prompt (Ctrl+Alt+K)'}
            >
              <Zap size={16} />
              {isGerman ? 'KI-Prompt kopieren' : 'Copy AI Prompt'}
            </button>
            <button
              onClick={copyHtml}
              className="btn btn-outline"
              style={{ padding: '0.5rem 1rem', fontSize: '0.8rem' }}
              title={isGerman ? 'HTML kopieren (Strg+Alt+H)' : 'Copy HTML (Ctrl+Alt+H)'}
            >
              <Code size={16} />
              {isGerman ? 'HTML kopieren' : 'Copy HTML'}
            </button>
            <button
              onClick={() => handleSave(false)}
              disabled={saving}
              className="btn btn-primary"
              style={{ padding: '0.5rem 1rem', fontSize: '0.8rem' }}
              title={isGerman ? 'Übersetzung speichern (Strg+Alt+S für Speichern & Weiter)' : 'Save Translation (Ctrl+Alt+S for Save & Next)'}
            >
              {saving ? <RefreshCw size={16} className="animate-spin" /> : <Save size={16} />}
              {isGerman ? 'Übersetzung speichern' : 'Save Translation'}
            </button>
          </div>
        </div>
      </div>

      <div className="editor-container">
        <div className="editor-pane">
          <div className="pane-header">
            <span>{isGerman ? 'Englisch (Quelle)' : 'English (Source)'}</span>
            <a href={`https://drupal.org/project/${machineName}`} target="_blank" rel="noreferrer" style={{ color: 'var(--primary)' }}>
              <ExternalLink size={14} />
            </a>
          </div>
          <div className="pane-content">
            {showSource ? (
              <div className="animate-fadeIn" style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                <h2 style={{ marginBottom: '0.5rem' }}>{isGerman ? 'Original Quellcode' : 'Original Source Code'}</h2>

                {project.attributes.body?.summary && (
                  <div>
                    <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem' }}>{isGerman ? 'Zusammenfassung (HTML)' : 'Summary (HTML)'}</label>
                    <textarea
                      readOnly
                      style={{ height: '100px', padding: '0.75rem', border: '1px solid var(--border)', borderRadius: '0.5rem', background: 'rgba(0,0,0,0.3)', color: '#94a3b8', width: '100%', fontFamily: 'monospace', fontSize: '0.8rem' }}
                      value={project.attributes.body.summary}
                    />
                  </div>
                )}

                <div>
                  <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem' }}>{isGerman ? 'Inhalt (HTML)' : 'Body (HTML)'}</label>
                  <textarea
                    readOnly
                    style={{ height: '400px', padding: '0.75rem', border: '1px solid var(--border)', borderRadius: '0.5rem', background: 'rgba(0,0,0,0.3)', color: '#94a3b8', width: '100%', fontFamily: 'monospace', fontSize: '0.8rem' }}
                    value={project.attributes.body?.value || ''}
                  />
                </div>
              </div>
            ) : (
              <>
                <h2 style={{ marginBottom: '1rem' }}>{project.attributes.title}</h2>
                {project.attributes.body?.summary && (
                  <div style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '1.5rem', borderLeft: '2px solid var(--border)', paddingLeft: '1rem' }}>
                    {project.attributes.body?.summary}
                  </div>
                )}
                <div className="source-body" dangerouslySetInnerHTML={{ __html: project.attributes.body?.value }} />

                {project.meta?.screenshot_urls && project.meta.screenshot_urls.length > 0 && (
                  <div style={{ marginTop: '2rem' }}>
                    <h4 style={{ marginBottom: '1rem' }}>{isGerman ? 'Screenshots' : 'Screenshots'}</h4>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                      {project.meta.screenshot_urls.map(img => (
                        <div key={img.id} style={{ background: 'rgba(0,0,0,0.1)', borderRadius: '0.5rem', overflow: 'hidden', border: '1px solid var(--border)' }}>
                          <img src={img.url} alt={img.alt} style={{ width: '100%', display: 'block' }} />
                          <div style={{ padding: '0.75rem', fontSize: '0.8rem', color: 'var(--text-muted)' }}>
                            <strong>ALT:</strong> {img.alt}
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </>
            )}
          </div>
        </div>

        <div className="editor-pane" style={{ padding: '1.5rem', gap: '1.5rem', overflowY: 'auto' }}>
          {/* Dynamic Workflow Tips */}
          <div className="workflow-tip animate-slideIn" style={{ marginBottom: '1.5rem', padding: '1rem', background: 'rgba(59, 130, 246, 0.1)', borderRadius: '0.75rem', border: '1px solid rgba(59, 130, 246, 0.2)', fontSize: '0.85rem', lineHeight: '1.5' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.5rem', color: 'var(--primary)', fontWeight: 700 }}>
              <Info size={16} />
              {isGerman ? 'Workflow-Tipp' : 'Workflow Tip'}
            </div>
            {!project.attributes.body?.value || project.attributes.body.value.length < 10 ? (
              <p style={{ margin: 0 }}>
                <Zap size={14} style={{ marginRight: '4px', verticalAlign: 'middle' }} />
                {isGerman ? (
                  <>Dieses Modul hat <strong>keinen Inhalt</strong>. Nutze <kbd>Strg+Alt+D</kbd> zum Überspringen.</>
                ) : (
                  <>This module has <strong>no content</strong>. Use <kbd>Ctrl+Alt+D</kbd> to skip.</>
                )}
              </p>
            ) : (
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                <p style={{ margin: 0 }}>
                  <span style={{ color: 'var(--primary)', fontWeight: 600 }}>1.</span> {isGerman ? 'Nutze' : 'Use'} <button onClick={copyAiPrompt} className="btn-link">{isGerman ? 'KI-Prompt kopieren' : 'Copy AI Prompt'}</button> (<kbd>Strg+Alt+K</kbd>) {isGerman ? 'oder' : 'or'} <button onClick={copyHtml} className="btn-link">{isGerman ? 'HTML kopieren' : 'Copy HTML'}</button> (<kbd>Strg+Alt+H</kbd>).
                </p>
                <p style={{ margin: 0 }}>
                  <span style={{ color: 'var(--primary)', fontWeight: 600 }}>2.</span> {isGerman ? 'Vorschau umschalten mit' : 'Toggle preview with'} <kbd>Strg+Alt+P</kbd>.
                </p>
                <p style={{ margin: 0 }}>
                  <span style={{ color: 'var(--primary)', fontWeight: 600 }}>3.</span> {isGerman ? 'Speichere & springe zum nächsten mit' : 'Save & jump to next with'} <kbd>Strg+Alt+S</kbd>.
                </p>
              </div>
            )}
          </div>

          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
            <h3 style={{ margin: 0 }}>{targetLanguage.name} ({isGerman ? 'Übersetzung' : 'Translation'})</h3>
            <span className="status-badge status-missing" style={{ fontSize: '0.6rem' }}>{isGerman ? 'Entwurf' : 'Draft'}</span>
          </div>

          {showPreview ? (
            <div className="preview-container animate-fadeIn">
              <div style={{ marginBottom: '2rem' }}>
                <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem', textTransform: 'uppercase' }}>
                  {isGerman ? 'Zusammenfassung Vorschau' : 'Summary Preview'}
                </label>
                <div
                  className="preview-content summary"
                  dangerouslySetInnerHTML={{ __html: translation.summary }}
                />
              </div>
              <div>
                <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem', textTransform: 'uppercase' }}>
                  {isGerman ? 'Inhalt Vorschau' : 'Body Preview'}
                </label>
                <div
                  className="preview-content body"
                  dangerouslySetInnerHTML={{ __html: translation.body }}
                />
              </div>
            </div>
          ) : (
            <>
              <div style={{ marginBottom: '1.5rem' }}>
                <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem' }}>{isGerman ? 'Titel (Maschinenname)' : 'Title (Machine Name)'}</label>
                <input
                  type="text"
                  readOnly
                  style={{ padding: '0.75rem', border: '1px solid var(--border)', borderRadius: '0.5rem', background: 'rgba(255,255,255,0.05)', color: '#94a3b8', width: '100%', cursor: 'not-allowed' }}
                  value={machineName}
                />
              </div>

              <div>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                  <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)' }}>{isGerman ? 'Zusammenfassung' : 'Summary'}</label>
                  <button
                    onClick={() => setShowSummaryHtml(!showSummaryHtml)}
                    className="btn-icon"
                    title={isGerman ? 'HTML bearbeiten' : 'Edit HTML'}
                  >
                    <Code size={14} style={{ color: showSummaryHtml ? 'var(--primary)' : 'inherit' }} />
                  </button>
                </div>
                {showSummaryHtml ? (
                  <textarea
                    style={{ height: '150px', padding: '0.75rem', border: '1px solid var(--primary)', borderRadius: '0.5rem', background: 'rgba(0,0,0,0.3)', color: '#fff', width: '100%', fontFamily: 'monospace' }}
                    value={translation.summary}
                    onChange={e => setTranslation({ ...translation, summary: e.target.value })}
                  />
                ) : (
                  <div className="ck-editor-wrapper">
                    <CKEditor
                      editor={ClassicEditor}
                      data={translation.summary}
                      config={{
                        toolbar: ['bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote'],
                        placeholder: isGerman ? "Übersetzte Zusammenfassung..." : "Enter summary..."
                      }}
                      onChange={(event, editor) => {
                        const data = editor.getData();
                        setTranslation({ ...translation, summary: data });
                      }}
                    />
                  </div>
                )}
              </div>

              <div style={{ flex: 1 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                  <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)' }}>{isGerman ? 'Inhalt' : 'Body'}</label>
                  <button
                    onClick={() => setShowBodyHtml(!showBodyHtml)}
                    className="btn-icon"
                    title={isGerman ? 'HTML bearbeiten' : 'Edit HTML'}
                  >
                    <Code size={14} style={{ color: showBodyHtml ? 'var(--primary)' : 'inherit' }} />
                  </button>
                </div>
                {showBodyHtml ? (
                  <textarea
                    style={{ height: '450px', padding: '0.75rem', border: '1px solid var(--primary)', borderRadius: '0.5rem', background: 'rgba(0,0,0,0.3)', color: '#fff', width: '100%', fontFamily: 'monospace' }}
                    value={translation.body}
                    onChange={e => setTranslation({ ...translation, body: e.target.value })}
                  />
                ) : (
                  <div className="ck-editor-wrapper content-editor">
                    <CKEditor
                      editor={ClassicEditor}
                      data={translation.body}
                      config={{
                        placeholder: isGerman ? "Übersetzten Inhalt eingeben..." : "Enter body content..."
                      }}
                      onChange={(event, editor) => {
                        const data = editor.getData();
                        setTranslation({ ...translation, body: data });
                      }}
                    />
                  </div>
                )}
              </div>
            </>
          )}

          {project.meta?.screenshot_urls && project.meta.screenshot_urls.length > 0 && (
            <div style={{ marginTop: '1rem', borderTop: '1px solid var(--border)', paddingTop: '1.5rem' }}>
              <h4 style={{ marginBottom: '1rem' }}>{isGerman ? 'Screenshot Alt-Texte' : 'Screenshot Alt Texts'}</h4>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {project.meta.screenshot_urls.map(img => (
                  <div key={img.id}>
                    <label style={{ display: 'block', fontSize: '0.75rem', color: 'var(--text-muted)', marginBottom: '0.25rem' }}>
                      Image ID: <code>{img.id.split('-')[0]}...</code>
                    </label>
                    <input
                      type="text"
                      className="search-bar"
                      style={{ width: '100%', padding: '0.5rem' }}
                      value={translation.screenshot_alts[img.id] || ''}
                      onChange={e => setTranslation({
                        ...translation,
                        screenshot_alts: { ...translation.screenshot_alts, [img.id]: e.target.value }
                      })}
                      placeholder={isGerman ? "Übersetzten Alt-Text eingeben..." : "Enter translated Alt text..."}
                    />
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

const PrivacyVideo = ({ youtubeId, isGerman }) => {
  const [load, setLoad] = useState(false);
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
    <div style={{
      aspectRatio: '16/9',
      background: 'linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.9)), url(https://img.youtube.com/vi/' + youtubeId + '/maxresdefault.jpg)',
      backgroundSize: 'cover',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '2rem',
      textAlign: 'center'
    }}>
      <div 
        onClick={() => setLoad(true)}
        className="play-button-overlay"
        style={{ 
          width: '80px', 
          height: '80px', 
          borderRadius: '50%', 
          background: 'rgba(255,255,255,0.2)', 
          backdropFilter: 'blur(4px)',
          display: 'flex', 
          alignItems: 'center', 
          justifyContent: 'center',
          marginBottom: '1.5rem',
          color: '#fff',
          cursor: 'pointer',
          transition: 'all 0.3s ease',
          border: '2px solid rgba(255,255,255,0.3)'
        }}
      >
        <Play size={32} fill="white" style={{ marginLeft: '4px' }} />
      </div>
      <p style={{ maxWidth: '450px', marginBottom: '1.5rem', fontSize: '0.9rem', color: '#cbd5e1' }}>
        {isGerman
          ? 'Durch das Laden des Videos akzeptieren Sie die Datenschutzerklärung von YouTube. Es werden Daten an Google übertragen.'
          : 'By loading the video, you accept YouTube\'s privacy policy. Data will be transferred to Google.'}
      </p>
      <button className="btn btn-primary" onClick={() => setLoad(true)}>
        <ExternalLink size={18} />
        {isGerman ? 'Video laden' : 'Load Video'}
      </button>
    </div>
  );
};

const HelpView = ({ isGerman }) => {
  return (
    <div className="animate-fade" style={{ maxWidth: '900px', margin: '0 auto' }}>
      <div className="header">
        <h1>{isGerman ? 'Hilfe & Hintergrund' : 'Help & Background'}</h1>
      </div>

      <div className="editor-pane" style={{ padding: '2rem' }}>
        <div style={{ marginBottom: '3rem' }}>
          <h2>{isGerman ? 'Was ist der Project Browser Localizer?' : 'What is Project Browser Localizer?'}</h2>
          <p style={{ fontSize: '1.1rem', color: 'var(--text-muted)', lineHeight: '1.6' }}>
            {isGerman
              ? 'Der Project Browser Localizer ist ein spezialisiertes Werkzeug, das darauf ausgelegt ist, das Drupal-Modul-Ökosystem nicht-englischsprachigen Website-Buildern näherzubringen. Während der Project Browser eine moderne Art bietet, Module zu entdecken, bleiben viele seiner Daten auf Englisch. Dieses Modul überbrückt diese Lücke.'
              : 'The Project Browser Localizer is a specialized tool designed to bring the Drupal module ecosystem closer to non-English speaking site builders. While the Project Browser provides a modern way to discover modules, much of its data remains in English. This module bridges that gap.'}
          </p>

          <div style={{ marginTop: '2rem', borderRadius: '1rem', overflow: 'hidden', boxShadow: '0 20px 25px -5px rgba(0,0,0,0.3)' }}>
            <PrivacyVideo youtubeId="34iOv0sa0Y4" isGerman={isGerman} />
          </div>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
          <div>
            <h3>{isGerman ? 'Die "Shadow API"' : 'The "Shadow API"'}</h3>
            <p style={{ color: 'var(--text-muted)' }}>
              {isGerman
                ? 'Der Project Browser ruft Moduldaten normalerweise direkt von Drupal.org ab. Da wir diese Daten dort nicht ändern können, nutzen wir einen "Shadow API"-Ansatz. Unser Modul fungiert als Proxy: Es fängt den Live-Datenstrom ab und überlagert spezifische Felder mit deinen lokalen Übersetzungen.'
                : 'The Project Browser traditionally fetches live module data directly from Drupal.org. Since we cannot modify the data on Drupal.org, we use a "Shadow API" approach. Our module acts as a proxy: it intercepts the live data stream and "shadows" specific fields with your local translations.'}
            </p>
          </div>
          <div>
            <h3>{isGerman ? 'Stale Detection' : 'Stale Detection'}</h3>
            <p style={{ color: 'var(--text-muted)' }}>
              {isGerman
                ? 'Wenn du ein Modul übersetzt, berechnet der PB Localizer einen digitalen Fingerabdruck (Hash) der englischen Quelle. Wenn der Maintainer die englische Beschreibung auf Drupal.org aktualisiert, ändert sich dieser Hash und das Modul markiert deine Übersetzung als "Veraltet".'
                : 'When you translate a module, the PB Localizer calculates a unique digital fingerprint (hash) of the English source. If the maintainer updates the English description on Drupal.org, the hash will change and the module flags your translation as "Stale".'}
            </p>
          </div>
        </div>

        <div style={{ marginTop: '2rem', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
          <div>
            <h3>{isGerman ? 'Tastaturkürzel' : 'Keyboard Shortcuts'}</h3>
            <ul style={{ color: 'var(--text-muted)', listStyle: 'none', padding: 0 }}>
              <li style={{ marginBottom: '0.5rem' }}><kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>S</kbd>: {isGerman ? 'Speichern & Weiter' : 'Save & Next'}</li>
              <li style={{ marginBottom: '0.5rem' }}><kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>D</kbd>: {isGerman ? 'Überspringen & Weiter' : 'Skip & Next'}</li>
              <li style={{ marginBottom: '0.5rem' }}><kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>P</kbd>: {isGerman ? 'Vorschau umschalten' : 'Toggle Preview'}</li>
              <li style={{ marginBottom: '0.5rem' }}><kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>K</kbd>: {isGerman ? 'KI-Prompt kopieren' : 'Copy AI Prompt'}</li>
              <li style={{ marginBottom: '0.5rem' }}><kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>H</kbd>: {isGerman ? 'HTML kopieren' : 'Copy HTML'}</li>
            </ul>
          </div>
          <div>
            <h3>{isGerman ? 'Pro-Tipp' : 'Pro-Tip'}</h3>
            <p style={{ color: 'var(--text-muted)' }}>
              {isGerman
                ? 'Nutze den "Schnell-Update" Button auf dem Dashboard, um Metadaten für die aktuell angezeigten Module ohne kompletten Sync zu aktualisieren.'
                : 'Use the "Quick Update" button on the dashboard to refresh metadata for the currently displayed modules without a full sync.'}
            </p>
          </div>
        </div>

        <hr style={{ margin: '3rem 0', border: '0', borderTop: '1px solid var(--border)' }} />

        <h3>{isGerman ? 'Kern-Philosophie: "Sprache ist Vertrauen"' : 'Core Philosophy: "Language is Trust"'}</h3>
        <p style={{ color: 'var(--text-muted)' }}>
          {isGerman
            ? 'Studien wie "Can\'t Read, Won\'t Buy" belegen, dass Sprache ein entscheidender Faktor für die Akzeptanz von Software ist. 72,4 % der Nutzer interagieren eher mit einem Produkt, wenn Informationen in ihrer Muttersprache verfügbar sind.'
            : 'Studies like "Can\'t Read, Won\'t Buy" prove that language is a pivotal factor in software adoption. 72.4% of users are more likely to engage with a product if information is available in their native language.'}
        </p>
      </div>
    </div>
  );
};

const AppContent = () => {
  const { targetLanguage, setTargetLanguage, languages } = useContext(LanguageContext);
  const location = useLocation();
  const [theme, setTheme] = useState(localStorage.getItem('pb-theme') || 'slate');
  const [bgImage, setBgImage] = useState('');

  const fetchRandomBg = async () => {
    try {
      const res = await axios.get(`${API_BASE}/unsplash/random-bg?t=${Date.now()}`);
      if (res.data.url) {
        setBgImage(res.data.url);
      }
    } catch (err) {
      console.error('Failed to fetch background from server:', err);
      // Fallback to static high-res image
      setBgImage('https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2560');
    }
  };

  useEffect(() => {
    const className = theme === 'slate' ? '' : `theme-${theme}`;
    document.body.className = className;
    document.documentElement.className = className;
    localStorage.setItem('pb-theme', theme);

    if (theme === 'liquid') {
      fetchRandomBg();
    } else {
      document.body.style.backgroundImage = '';
      document.body.style.backgroundColor = '';
      setBgImage('');
    }
  }, [theme]);

  useEffect(() => {
    if (theme === 'liquid' && bgImage) {
      document.body.style.backgroundColor = '#064e3b'; // Deep dark green fallback
      document.body.style.backgroundImage = `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)), url("${bgImage}")`;
      document.body.style.backgroundSize = 'cover';
      document.body.style.backgroundAttachment = 'fixed';
      document.body.style.backgroundPosition = 'center';
    }
  }, [bgImage, theme]);

  const themes = [
    { id: 'slate', name: 'Slate', color: '#0ea5e9' },
    { id: 'glassy', name: 'Glassy', color: '#f472b6' },
    { id: 'midnight', name: 'Midnight', color: '#8b5cf6' },
    { id: 'emerald', name: 'Emerald', color: '#10b981' },
    { id: 'nord', name: 'Nord', color: '#88c0d0' },
    { id: 'liquid', name: 'Liquid', color: '#ffffff' }
  ];

  const isGerman = targetLanguage.code === 'de';

  return (
    <div className="app-container">
      <aside className="sidebar">
        <div>
          <div className="logo" style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '2.5rem' }}>
            <DrupalLogo size={36} style={{ color: 'var(--primary)', filter: 'drop-shadow(0 0 8px rgba(14, 165, 233, 0.3))' }} />
            <div style={{ display: 'flex', flexDirection: 'column', lineHeight: 1.1 }}>
              <span style={{ fontSize: '0.65rem', fontWeight: 800, color: 'var(--text-muted)', letterSpacing: '0.05em', marginBottom: '0.1rem' }}>DRUPAL</span>
              <span style={{ fontSize: '1.1rem', fontWeight: 900, background: 'linear-gradient(135deg, var(--primary), #818cf8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', whiteSpace: 'nowrap' }}>Project Browser</span>
              <span style={{ fontSize: '0.65rem', fontWeight: 700, color: 'var(--text-muted)', letterSpacing: '0.05em', marginTop: '0.2rem' }}>TRANSLATION HUB</span>
            </div>
          </div>

          <div className="theme-switcher" style={{ marginBottom: '2rem', padding: '0.5rem', background: 'var(--glass)', borderRadius: '0.75rem', border: '1px solid var(--border)' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.7rem', color: 'var(--text-muted)', marginBottom: '0.5rem', fontWeight: '700', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
              <Palette size={12} />
              UI Theme
            </div>
            <div style={{ display: 'flex', gap: '0.4rem' }}>
              {themes.map(t => (
                <button
                  key={t.id}
                  onClick={() => setTheme(t.id)}
                  title={t.name}
                  style={{
                    width: '1.15rem',
                    height: '1.15rem',
                    borderRadius: '50%',
                    backgroundColor: t.color,
                    border: theme === t.id ? '2px solid white' : '2px solid transparent',
                    cursor: 'pointer',
                    transition: 'all 0.2s ease',
                    transform: theme === t.id ? 'scale(1.15)' : 'scale(1)',
                    boxShadow: theme === t.id ? `0 0 10px ${t.color}` : 'none'
                  }}
                />
              ))}
            </div>
          </div>

          <nav className="nav-links">
            <Link to="/" className={`nav-link ${location.pathname === '/' ? 'active' : ''}`}>
              <LayoutDashboard size={20} />
              {isGerman ? 'Dashboard' : 'Dashboard'}
            </Link>
            <Link to="/categories" className={`nav-link ${location.pathname === '/categories' ? 'active' : ''}`}>
              <Languages size={20} />
              {isGerman ? 'Kategorien' : 'Categories'}
            </Link>
            <Link to="/help" className={`nav-link ${location.pathname === '/help' ? 'active' : ''}`}>
              <Info size={20} />
              {isGerman ? 'Hilfe & Info' : 'Help & Info'}
            </Link>
          </nav>
        </div>

        <div style={{ marginTop: '2rem' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '1rem', color: 'var(--text-muted)', fontSize: '0.8rem', fontWeight: 700 }}>
            <Globe size={14} />
            {isGerman ? 'ZIELSPRACHE' : 'TARGET LANGUAGE'}
          </div>
          <select
            className="search-bar"
            style={{ width: '100%', padding: '0.5rem', fontSize: '0.85rem' }}
            value={targetLanguage.code}
            onChange={(e) => {
              const lang = languages.find(l => l.code === e.target.value);
              if (lang) setTargetLanguage(lang);
            }}
          >
            {languages.map(lang => (
              <option key={lang.code} value={lang.code}>{lang.name}</option>
            ))}
          </select>
        </div>

        <div style={{ marginTop: 'auto' }}>
          <div style={{ padding: '1.25rem', background: 'var(--glass)', borderRadius: '1rem', border: '1px solid var(--glass-border)' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.75rem', color: 'var(--primary)' }}>
              <Info size={16} />
              <span style={{ fontWeight: 700, fontSize: '0.85rem' }}>{isGerman ? 'Verbindungs-Info' : 'Connection Info'}</span>
            </div>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.75rem', marginBottom: '0.5rem' }}>{isGerman ? 'Mirror-URL für Drupal:' : 'Mirror URL for Drupal:'}</p>
            <code style={{ display: 'block', padding: '0.5rem', background: 'rgba(0,0,0,0.2)', borderRadius: '0.5rem', fontSize: '0.7rem', color: 'var(--primary)', wordBreak: 'break-all' }}>
              {window.location.origin.replace(':5173', ':3001')}
            </code>
          </div>
        </div>
      </aside>

      <main className="main-content">
        <Routes>
          <Route path="/" element={<Dashboard isGerman={isGerman} />} />
          <Route path="/edit/:machineName" element={<Editor isGerman={isGerman} />} />
          <Route path="/categories" element={<CategoriesView isGerman={isGerman} />} />
          <Route path="/help" element={<HelpView isGerman={isGerman} />} />
        </Routes>
      </main>
    </div>
  );
};

const App = () => {
  const [languages, setLanguages] = useState([]);
  const [targetLanguage, setTargetLanguage] = useState(() => {
    const saved = localStorage.getItem('targetLanguage');
    return saved ? JSON.parse(saved) : { code: 'de', name: 'German' };
  });

  const [toasts, setToasts] = useState([]);

  const showToast = (message, type = 'success') => {
    const id = Date.now();
    setToasts(prev => [...prev, { id, message, type }]);
    setTimeout(() => setToasts(prev => prev.filter(t => t.id !== id)), 4000);
  };

  useEffect(() => {
    axios.get(`${API_BASE}/languages`).then(res => setLanguages(res.data));
  }, []);

  useEffect(() => {
    localStorage.setItem('targetLanguage', JSON.stringify(targetLanguage));
  }, [targetLanguage]);

  return (
    <ToastContext.Provider value={{ showToast }}>
      <LanguageContext.Provider value={{ targetLanguage, setTargetLanguage, languages }}>
        <Router>
          <AppContent />
          <ToastContainer toasts={toasts} />
        </Router>
      </LanguageContext.Provider>
    </ToastContext.Provider>
  );
};

export default App;
