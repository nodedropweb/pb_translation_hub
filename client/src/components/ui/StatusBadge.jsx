import React, { useContext } from 'react';
import { LanguageContext } from '../../context/LanguageContext';
import { ThemeContext } from '../../context/ThemeContext';

/**
 * @file StatusBadge.jsx
 * Displays a colorful badge indicating the translation status of a project.
 */
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

export default StatusBadge;
