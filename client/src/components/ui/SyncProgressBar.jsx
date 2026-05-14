import React, { useContext } from 'react';
import { RefreshCw, CheckCircle, Square } from 'lucide-react';
import { LanguageContext } from '../../context/LanguageContext';
import { ThemeContext } from '../../context/ThemeContext';

/**
 * @file SyncProgressBar.jsx
 * Visual indicator for the background database synchronization process.
 */
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

export default SyncProgressBar;
