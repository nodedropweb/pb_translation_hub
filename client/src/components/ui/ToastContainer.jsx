import React, { useContext } from 'react';
import { CheckCircle, AlertCircle } from 'lucide-react';
import { ThemeContext } from '../../context/ThemeContext';

/**
 * @file ToastContainer.jsx
 * Displays a stack of toast notifications in the bottom-right corner.
 */
const ToastContainer = ({ toasts }) => {
  const { theme } = useContext(ThemeContext);
  return (
    <div className="fixed bottom-8 right-8 z-[100] flex flex-col gap-3 pointer-events-none">
      {toasts.map(toast => (
        <div 
          key={toast.id} 
          className={`pointer-events-auto flex items-center gap-3 px-5 py-3.5 rounded-xl border shadow-2xl animate-slide-in min-w-[320px] transition-all ${
            theme === 'glassy' || theme === 'nature' || theme === 'dark' || theme === 'liquid' ? 'bg-black/80 border-white/10 text-white glass-blur' : 'bg-bg-card border-border-main text-text-main'
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

export default ToastContainer;
