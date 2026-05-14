import React, { useContext } from 'react';
import { Zap, X, RefreshCw, CheckCircle, AlertCircle, ExternalLink, XCircle } from 'lucide-react';
import { ThemeContext } from '../../context/ThemeContext';

/**
 * @file BulkAiModal.jsx
 * An interactive modal that shows progress and costs for AI-powered bulk translations.
 */
const BulkAiModal = ({ isOpen, onClose, results, progress, total, isGerman, phase, estimation, onConfirm }) => {
  const { theme } = useContext(ThemeContext);
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 animate-in fade-in duration-200">
      <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" onClick={(progress === total || phase === 'finished' || phase === 'estimating') ? onClose : null}></div>
      <div className="relative w-full max-w-lg rounded-[2.5rem] border shadow-2xl overflow-hidden transition-all bg-bg-card border-border-main text-text-main">
        <div className="p-8">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-bold flex items-center gap-3">
              <Zap className="text-amber-500" />
              {isGerman ? 'KI-Auto-Übersetzung' : 'AI Auto-Translation'}
            </h2>
            {progress === total && (
              <button onClick={onClose} className="p-2 rounded-full hover:bg-white/10 transition-all">
                <X size={20} />
              </button>
            )}
          </div>

          <div className="space-y-6">
            {phase === 'estimating' ? (
              <div className="flex flex-col items-center justify-center py-10 space-y-4 animate-in fade-in zoom-in duration-300">
                {!estimation ? (
                  <>
                    <RefreshCw size={40} className="text-amber-500 animate-spin" />
                    <p className="text-text-muted font-medium text-center">
                      {isGerman ? 'Berechne voraussichtliche Tokens und Kosten...' : 'Calculating estimated tokens and cost...'}
                    </p>
                  </>
                ) : (
                  <p className="text-text-muted font-medium text-center">
                    {isGerman ? 'Kostenschätzung bereit:' : 'Cost estimation ready:'}
                  </p>
                )}
                {estimation && (
                  <div className="w-full p-6 rounded-3xl border bg-bg-input border-border-main animate-in slide-in-from-bottom-4">
                    <div className="grid grid-cols-2 gap-4">
                      <div className="text-center p-3">
                        <div className="text-[10px] font-bold uppercase tracking-widest text-text-muted mb-1">{isGerman ? 'Tokens' : 'Tokens'}</div>
                        <div className="text-2xl font-black text-amber-500">{estimation.totalTokens.toLocaleString()}</div>
                      </div>
                      <div className="text-center p-3">
                        <div className="text-[10px] font-bold uppercase tracking-widest text-text-muted mb-1">{isGerman ? 'Gesch. Kosten' : 'Est. Cost'}</div>
                        <div className="text-2xl font-black text-amber-500">${estimation.estimatedCost}</div>
                      </div>
                    </div>
                    <div className="mt-4 pt-4 border-t border-white/5 text-[10px] text-text-muted text-center italic">
                      {isGerman ? 'Basierend auf Google Pricing ($0,25/1M). ' : 'Based on Google Pricing ($0.25/1M). '}
                      <a href="https://ai.google.dev/pricing" target="_blank" rel="noreferrer" className="text-amber-500 hover:underline inline-flex items-center gap-1">
                        {isGerman ? 'Preisliste' : 'Pricing Table'} <ExternalLink size={10} />
                      </a>
                    </div>
                    <div className="flex flex-col sm:flex-row gap-3 mt-6">
                      <button 
                        onClick={onClose}
                        className="flex-1 py-4 rounded-xl font-bold bg-bg-input border border-border-main text-text-muted hover:bg-bg-card-hover transition-all flex items-center justify-center gap-2"
                      >
                        <X size={18} />
                        {isGerman ? 'ABBRECHEN' : 'CANCEL'}
                      </button>
                      <button 
                        onClick={onConfirm}
                        className="flex-[2] py-4 rounded-xl bg-amber-500 text-white font-black hover:bg-amber-600 transition-all shadow-xl shadow-amber-500/20 flex items-center justify-center gap-3"
                      >
                        <Zap size={20} />
                        {isGerman ? 'STARTEN' : 'START'}
                      </button>
                    </div>
                  </div>
                )}
              </div>
            ) : (
              <div className="space-y-2">
                <div className="flex justify-between text-xs font-bold uppercase tracking-widest text-text-muted">
                  <span>{isGerman ? 'Fortschritt' : 'Progress'}</span>
                  <span>{progress} / {total}</span>
                </div>
                <div className="w-full h-3 bg-black/20 rounded-full overflow-hidden border border-white/5">
                  <div 
                    className="h-full bg-amber-500 transition-all duration-500 shadow-[0_0_15px_rgba(245,158,11,0.5)]" 
                    style={{ width: `${(progress / total) * 100}%` }}
                  ></div>
                </div>
              </div>
            )}

              {phase !== 'estimating' && (
                <div className="max-h-60 overflow-y-auto rounded-2xl p-4 font-mono text-[10px] space-y-2 bg-bg-input">
                  {results.length === 0 && <p className="text-text-muted italic">{isGerman ? 'Warte auf Start...' : 'Waiting to start...'}</p>}
                  {results.map((res, i) => (
                    <div key={i} className="flex items-start gap-2 animate-in slide-in-from-left-2">
                      {res.success ? (
                        <CheckCircle size={12} className="text-green-500 mt-0.5 shrink-0" />
                      ) : (
                        <AlertCircle size={12} className="text-red-500 mt-0.5 shrink-0" />
                      )}
                      <div className="flex-1">
                        <span className="font-bold">{res.machine_name}</span>: {res.success ? (isGerman ? 'Erfolgreich' : 'Success') : (isGerman ? 'Fehler: ' : 'Error: ') + res.error}
                      </div>
                    </div>
                  ))}
                  {progress < total && phase === 'translating' && (
                    <div className="flex items-center gap-2 text-amber-500 animate-pulse">
                      <RefreshCw size={12} className="animate-spin" />
                      <span>{isGerman ? 'Verarbeite...' : 'Processing...'}</span>
                    </div>
                  )}
                </div>
              )}
          </div>

          <div className="mt-8 flex justify-end">
            {phase === 'translating' && progress < total && (
              <button
                onClick={onClose}
                className="px-6 py-3 rounded-xl font-bold bg-red-600/10 text-red-500 border border-red-500/20 hover:bg-red-600 hover:text-white transition-all shadow-lg flex items-center gap-2 mr-auto"
              >
                <XCircle size={18} />
                {isGerman ? 'Stoppen' : 'Stop'}
              </button>
            )}
            <button
              onClick={onClose}
              disabled={phase !== 'finished' && progress < total}
              className={`px-8 py-3 rounded-xl font-bold transition-all ${
                (phase === 'finished' || progress === total) ? 'bg-brand-600 hover:bg-brand-700 shadow-xl shadow-brand-600/20' : 'hidden'
              } text-white`}
            >
              {isGerman ? 'Fertigstellen' : 'Finish'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default BulkAiModal;
