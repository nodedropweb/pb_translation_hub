import React, { useEffect } from 'react';
import { X } from 'lucide-react';

/**
 * @file Modal.jsx
 * A premium, glassmorphic modal component.
 */
const Modal = ({ isOpen, onClose, title, children, theme }) => {
  // Handle ESC key to close
  useEffect(() => {
    const handleEsc = (e) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handleEsc);
    return () => window.removeEventListener('keydown', handleEsc);
  }, [onClose]);

  // Prevent scrolling when modal is open
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = 'unset';
    }
    return () => {
      document.body.style.overflow = 'unset';
    };
  }, [isOpen]);

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 md:p-8">
      {/* Backdrop */}
      <div 
        className="absolute inset-0 bg-black/60 backdrop-blur-md animate-backdrop-enter"
        onClick={onClose}
      />
      
      {/* Modal Container */}
      <div className={`relative w-full max-w-6xl max-h-[90vh] overflow-hidden rounded-[2.5rem] border shadow-2xl flex flex-col animate-modal-enter ${
        theme === 'glassy' 
          ? 'bg-black/60 border-white/10 glass-blur text-white' 
          : 'bg-bg-card border-border-main text-text-main shadow-brand-600/10'
      }`}>
        
        {/* Header */}
        <div className={`flex items-center ${title ? 'justify-between' : 'justify-end'} p-6 md:p-8 border-b border-white/5 shrink-0`}>
          {title && (
            <div className="flex items-center gap-4">
              <div className="w-10 h-10 rounded-xl bg-brand-600 flex items-center justify-center text-white shadow-lg shadow-brand-600/20">
                <X className="rotate-45" size={24} />
              </div>
              <div>
                <h2 className="text-xl font-black tracking-tight leading-none uppercase">{title}</h2>
                <div className="h-1 w-12 bg-brand-500 rounded-full mt-2"></div>
              </div>
            </div>
          )}
          
          <button 
            onClick={onClose}
            className="p-3 rounded-2xl bg-white/5 hover:bg-red-500/10 hover:text-red-500 border border-white/5 transition-all group"
          >
            <X size={24} className="group-hover:rotate-90 transition-transform duration-300" />
          </button>
        </div>
        
        {/* Content */}
        <div className="flex-1 overflow-y-auto custom-scrollbar p-0">
          {children}
        </div>
        
        {/* Footer / Gradient bottom indicator */}
        <div className="h-4 bg-gradient-to-t from-black/20 to-transparent shrink-0 pointer-events-none" />
      </div>
    </div>
  );
};

export default Modal;
