import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { 
  Settings, 
  Lock, 
  UserPlus, 
  RefreshCw, 
  CheckCircle, 
  X, 
  Palette, 
  Database, 
  Zap, 
  HelpCircle,
  Sun,
  Moon,
  Droplets,
  Plus,
  Upload
} from 'lucide-react';

// Contexts
import { AuthContext } from '../context/AuthContext';
import { ThemeContext } from '../context/ThemeContext';
import { ToastContext } from '../context/ToastContext';
import { WorkflowContext } from '../context/WorkflowContext';

// Components
import Tooltip from '../components/ui/Tooltip';

// Utils
import { API_BASE, THEMES as THEME_LIST } from '../utils/constants';

/**
 * @file BackupUpload.jsx
 * Allows uploading large ZIP backups of the translation files.
 */
const BackupUpload = ({ isGerman }) => {
  const { theme } = useContext(ThemeContext);
  const { showToast } = useContext(ToastContext);
  const [uploading, setUploading] = useState(false);
  const [progress, setProgress] = useState(0);
  const fileInputRef = React.useRef();

  const handleUpload = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append('file', file);

    setUploading(true);
    setProgress(0);

    try {
      const res = await axios.post(`${API_BASE}/upload-backup`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
        onUploadProgress: (progressEvent) => {
          const p = Math.round((progressEvent.loaded * 100) / progressEvent.total);
          setProgress(p);
        }
      });
      showToast(isGerman ? `Backup erfolgreich: ${res.data.count} Dateien verarbeitet.` : `Backup successful: ${res.data.count} files processed.`);
    } catch (err) {
      showToast(isGerman ? 'Upload fehlgeschlagen.' : 'Upload failed.', 'error');
    } finally {
      setUploading(false);
      setProgress(0);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  };

  return (
    <div className="p-8 rounded-2xl border bg-bg-card border-border-main shadow-xl">
      <h3 className="text-xl font-bold mb-6 flex items-center gap-2">
        <Upload size={20} className="text-brand-500" />
        {isGerman ? 'Backup einspielen (.zip)' : 'Upload Backup (.zip)'}
      </h3>
      <div className="space-y-4">
        <input 
          type="file" 
          accept=".zip" 
          ref={fileInputRef}
          onChange={handleUpload}
          className="hidden"
          disabled={uploading}
        />
        {!uploading ? (
          <button 
            onClick={() => fileInputRef.current.click()}
            className="w-full py-4 rounded-xl font-bold flex items-center justify-center gap-3 transition-all border bg-bg-input border-border-main hover:bg-gray-100 dark:hover:bg-white/10"
          >
            <Plus size={20} />
            {isGerman ? 'ZIP Datei auswählen' : 'Select ZIP File'}
          </button>
        ) : (
          <div className="space-y-3">
            <div className="flex justify-between text-xs font-bold uppercase tracking-widest text-text-muted">
              <span>{isGerman ? 'Lade hoch...' : 'Uploading...'}</span>
              <span>{progress}%</span>
            </div>
            <div className="w-full h-2 bg-black/20 rounded-full overflow-hidden">
              <div className="h-full bg-brand-600 transition-all duration-300" style={{ width: `${progress}%` }}></div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

/**
 * @file SettingsView.jsx
 * Admin and user configuration page.
 */
const SettingsView = ({ isGerman }) => {
  const { theme, setTheme } = useContext(ThemeContext);
  const { showToast } = useContext(ToastContext);
  const { user } = useContext(AuthContext);
  const { confettiEnabled, setConfettiEnabled, largeUi, setLargeUi, fontStyle, setFontStyle } = useContext(WorkflowContext);
  
  const [syncing, setSyncing] = useState(false);
  const [pendingUsers, setPendingUsers] = useState([]);
  const [adminSettings, setAdminSettings] = useState({ registration_enabled: '1' });
  const [loadingAdmin, setLoadingAdmin] = useState(false);

  const ICON_MAP = { Sun, Moon, Palette, Droplets, Zap };

  useEffect(() => {
    if (user?.role === 'admin') {
      fetchAdminData();
    }
  }, [user]);

  const fetchAdminData = async () => {
    setLoadingAdmin(true);
    try {
      const [usersRes, settingsRes] = await Promise.all([
        axios.get(`${API_BASE}/admin/users/pending`),
        axios.get(`${API_BASE}/admin/settings`)
      ]);
      setPendingUsers(usersRes.data);
      setAdminSettings(settingsRes.data);
    } catch (err) {
      console.error('Failed to fetch admin data', err);
    } finally {
      setLoadingAdmin(false);
    }
  };

  const toggleRegistration = async () => {
    const newValue = adminSettings.registration_enabled === '1' ? '0' : '1';
    try {
      await axios.put(`${API_BASE}/admin/settings`, { registration_enabled: newValue });
      setAdminSettings({ ...adminSettings, registration_enabled: newValue });
      showToast(isGerman ? 'Registrierungseinstellung aktualisiert' : 'Registration setting updated');
    } catch (err) {
      showToast('Update failed', 'error');
    }
  };

  const handleUserAction = async (userId, action) => {
    try {
      if (action === 'approve') {
        await axios.post(`${API_BASE}/admin/users/${userId}/approve`);
        showToast(isGerman ? 'Nutzer freigeschaltet!' : 'User approved!');
      } else {
        await axios.delete(`${API_BASE}/admin/users/${userId}`);
        showToast(isGerman ? 'Nutzer gelöscht.' : 'User deleted.');
      }
      setPendingUsers(pendingUsers.filter(u => u.id !== userId));
    } catch (err) {
      showToast('Action failed', 'error');
    }
  };

  const handleSync = async () => {
    setSyncing(true);
    try {
      const res = await axios.post(`${API_BASE}/sync/translations`);
      showToast(isGerman ? `${res.data.count} Übersetzungen synchronisiert!` : `${res.data.count} translations synced!`, 'success');
    } catch (e) {
      showToast(isGerman ? 'Fehler bei der Synchronisation' : 'Error during sync', 'error');
    } finally {
      setSyncing(false);
    }
  };

  const handlePrioritySync = async () => {
    setSyncing(true);
    try {
      const res = await axios.post(`${API_BASE}/sync/priority`);
      showToast(isGerman ? `${res.data.count} Priority-Module synchronisiert!` : `${res.data.count} priority modules synced!`, 'success');
    } catch (e) {
      showToast(isGerman ? 'Fehler beim Synchronisieren der Priority-Liste. Wurde die Liste schon generiert?' : 'Error syncing priority list. Has it been generated yet?', 'error');
    } finally {
      setSyncing(false);
    }
  };

  return (
    <div className="p-12 max-w-5xl mx-auto animate-fade space-y-10">
      <div className="flex items-center gap-4 mb-2">
        <div className="p-3 rounded-2xl bg-brand-600 text-white shadow-lg shadow-brand-600/20">
          <Settings size={32} />
        </div>
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-text-main">{isGerman ? 'Einstellungen' : 'Settings'}</h1>
          <p className="text-text-muted mt-1 uppercase tracking-widest text-[10px] font-black">{isGerman ? 'System-Konfiguration' : 'System Configuration'}</p>
        </div>
      </div>

      {user?.role === 'admin' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="p-8 rounded-2xl border bg-bg-card border-border-main shadow-xl">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-xl font-bold flex items-center gap-2">
                <Lock size={20} className="text-brand-500" />
                {isGerman ? 'Registrierung' : 'Registration'}
              </h3>
              <button 
                onClick={toggleRegistration}
                className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none ${
                  adminSettings.registration_enabled === '1' ? 'bg-brand-600' : 'bg-gray-600'
                }`}
              >
                <span className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                  adminSettings.registration_enabled === '1' ? 'translate-x-6' : 'translate-x-1'
                }`} />
              </button>
            </div>
            <p className="text-sm text-text-muted">
              {isGerman ? 'Schalte das Registrierungsformular global an oder aus.' : 'Toggle the global registration form visibility.'}
            </p>
          </div>

        <div className="p-8 rounded-2xl border bg-bg-card border-border-main shadow-xl">
            <h3 className="text-xl font-bold mb-6 flex items-center gap-2">
              <UserPlus size={20} className="text-brand-500" />
              {isGerman ? 'Wartende Nutzer' : 'Pending Users'}
              {pendingUsers.length > 0 && <span className="text-xs bg-brand-600 text-white px-2 py-0.5 rounded-full">{pendingUsers.length}</span>}
            </h3>
            <div className="space-y-3 max-h-[150px] overflow-y-auto pr-2 custom-scrollbar">
              {pendingUsers.length === 0 ? (
                <p className="text-xs text-text-muted italic">{isGerman ? 'Keine neuen Anfragen.' : 'No new requests.'}</p>
              ) : (
                pendingUsers.map(u => (
                  <div key={u.id} className="flex items-center justify-between p-3 rounded-xl bg-white/5 border border-white/5 text-sm">
                    <span className="font-bold truncate max-w-[120px]">{u.username}</span>
                    <div className="flex gap-2">
                      <button onClick={() => handleUserAction(u.id, 'approve')} className="text-brand-500 hover:text-brand-400 p-1"><CheckCircle size={16} /></button>
                      <button onClick={() => handleUserAction(u.id, 'delete')} className="text-red-500 hover:text-red-400 p-1"><X size={16} /></button>
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="p-8 rounded-2xl border bg-bg-card border-border-main">
          <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
            <Palette size={20} className="text-brand-500" />
            {isGerman ? 'Erscheinungsbild' : 'Appearance'}
          </h2>
          <div className="space-y-4">
            {THEME_LIST.map(t => {
              const Icon = ICON_MAP[t.icon] || Palette;
              return (
                <button
                  key={t.id}
                  onClick={() => setTheme(t.id)}
                  className={`w-full flex items-center justify-between p-4 rounded-xl border transition-all ${
                    theme === t.id ? 'bg-brand-500/10 border-brand-500 text-brand-600' : 'bg-bg-input border-border-main text-text-muted hover:border-text-muted'
                  }`}
                >
                  <div className="flex items-center gap-3 font-bold">
                    <Icon size={18} />
                    {t.name}
                  </div>
                  {theme === t.id && <div className="w-2 h-2 rounded-full bg-brand-600" />}
                </button>
              );
            })}
          </div>
        </div>

        <div className="p-8 rounded-2xl border bg-bg-card border-border-main">
          <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
            <Zap size={20} className="text-brand-500" />
            {isGerman ? 'Workflow & Spaß' : 'Workflow & Fun'}
          </h2>
          <div className="flex items-center justify-between p-4 rounded-xl border bg-bg-input border-border-main">
            <div className="flex items-center gap-3 font-bold">
              <Plus size={18} className="text-brand-500" />
              {isGerman ? 'Erfolgs-Feier (Konfetti)' : 'Success Celebration (Confetti)'}
            </div>
            <button 
              onClick={() => setConfettiEnabled(!confettiEnabled)}
              className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none ${
                confettiEnabled ? 'bg-brand-600' : 'bg-gray-600'
              }`}
            >
              <span className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                confettiEnabled ? 'translate-x-6' : 'translate-x-1'
              }`} />
            </button>
          </div>
          <p className="text-xs text-text-muted mt-4 ml-1">
            {isGerman ? 'Zeigt eine kleine Animation beim erfolgreichen Speichern eines Moduls.' : 'Shows a small animation when successfully saving a module.'}
          </p>
        </div>

        <div className="p-8 rounded-2xl border bg-bg-card border-border-main">
          <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
            <Plus size={20} className="text-brand-500" />
            {isGerman ? 'Typografie & Sichtbarkeit' : 'Typography & Visibility'}
          </h2>
          <div className="flex items-center justify-between p-4 rounded-xl border bg-bg-input border-border-main">
            <div className="flex items-center gap-3 font-bold">
              <Plus size={18} className="text-brand-500" />
              {isGerman ? 'Verbesserte Lesbarkeit (Große Badges)' : 'Enhanced Visibility (Large Badges)'}
            </div>
            <button 
              onClick={() => setLargeUi(!largeUi)}
              className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none ${
                largeUi ? 'bg-brand-600' : 'bg-gray-600'
              }`}
            >
              <span className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                largeUi ? 'translate-x-6' : 'translate-x-1'
              }`} />
            </button>
          </div>
          <p className="text-xs text-text-muted mt-4 ml-1">
            {isGerman ? 'Vergrößert wichtige UI-Elemente wie Zähler und Status-Badges in der Topbar.' : 'Increases the size of important UI elements like counters and status badges in the topbar.'}
          </p>

          <div className="mt-8 pt-8 border-t border-white/5">
             <h4 className="text-xs font-bold text-text-muted uppercase tracking-widest mb-4 flex items-center gap-2">
               <HelpCircle size={14} className="text-brand-500" />
               {isGerman ? 'Schriftstil' : 'Font Style'}
             </h4>
             <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
               {[
                 { id: 'inter', name: 'Inter', desc: isGerman ? 'Modern & Klar' : 'Modern Clean' },
                 { id: 'outfit', name: 'Outfit', desc: isGerman ? 'Futuristisch' : 'Futuristic' },
                 { id: 'sora', name: 'Sora', desc: isGerman ? 'Tech & Soft' : 'Tech Soft' }
               ].map(f => (
                 <button
                   key={f.id}
                   onClick={() => setFontStyle(f.id)}
                   className={`flex flex-col items-start p-4 rounded-xl border transition-all ${
                     fontStyle === f.id ? 'bg-brand-500/10 border-brand-500 text-brand-500 shadow-lg shadow-brand-500/10' : 'bg-bg-input border-border-main text-text-muted hover:border-text-muted'
                   }`}
                 >
                   <span className={`text-base font-bold mb-1 font-${f.id}`}>{f.name}</span>
                   <span className="text-[10px] opacity-70 font-inter">{f.desc}</span>
                 </button>
               ))}
             </div>
          </div>
        </div>

        <div className="space-y-6">
          <div className="p-8 rounded-2xl border bg-bg-card border-border-main">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-xl font-bold flex items-center gap-2">
                <Database size={20} className="text-brand-500" />
                {isGerman ? 'Datenbank-Synchronisation' : 'Database Sync'}
              </h2>
              <Tooltip text={isGerman 
                ? "Diesen Button solltest du immer dann drücken, wenn du Dateien direkt auf dem Server geändert, gelöscht oder neu hochgeladen hast (z. B. via FTP oder Git). Er stellt sicher, dass die Suche genau weiß, welche Übersetzungen wirklich existieren."
                : "You should press this button whenever you have modified, deleted, or uploaded files directly on the server (e.g., via FTP or Git). It ensures the search knows exactly which translations exist."
              }>
                <HelpCircle size={18} className="text-text-muted hover:text-brand-500 transition-colors" />
              </Tooltip>
            </div>
            <p className="text-sm text-text-muted mb-6 leading-relaxed">
              {isGerman ? 'Gleicht die internen Datenbank-Einträge mit den .json-Dateien auf dem Server ab.' : 'Syncs internal database entries with .json files on the server.'}
            </p>
            <button 
              onClick={handleSync}
              disabled={syncing}
              className="w-full flex items-center justify-center gap-2 py-4 rounded-xl font-bold bg-brand-600 text-white hover:bg-brand-700 transition-all shadow-lg shadow-brand-600/20 disabled:opacity-50"
            >
              <RefreshCw size={18} className={syncing ? 'animate-spin' : ''} />
              {syncing ? (isGerman ? 'Synchronisiere...' : 'Syncing...') : (isGerman ? 'Jetzt synchronisieren' : 'Sync Now')}
            </button>
          </div>

          <div className="p-8 rounded-2xl border bg-bg-card border-border-main">
            <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
              <Zap size={20} className="text-amber-500" />
              {isGerman ? 'Priority-Steuerung' : 'Priority Control'}
            </h2>
            <p className="text-sm text-text-muted mb-6 leading-relaxed">
              {isGerman ? 'Synchronisiere die Liste der Drupal 11 kompatiblen Module, um den Fokus-Modus im Hub zu aktivieren.' : 'Sync the list of Drupal 11 compatible modules to enable the focus mode in the Hub.'}
            </p>
            <button 
              className={`flex items-center justify-center gap-2 w-full py-4 rounded-xl font-bold transition-all border ${
                syncing ? 'opacity-50 cursor-not-allowed' : 'hover:scale-[1.02]'
              } bg-amber-500/10 border-amber-500/30 text-amber-500`}
              onClick={handlePrioritySync}
              disabled={syncing}
            >
              {syncing ? <RefreshCw size={18} className="animate-spin" /> : <Zap size={18} />}
              {syncing ? (isGerman ? 'Synchronisiere...' : 'Syncing...') : (isGerman ? 'D11 Liste einlesen' : 'Sync D11 List')}
            </button>
          </div>

          <BackupUpload isGerman={isGerman} />
        </div>
      </div>
    </div>
  );
};

export default SettingsView;
