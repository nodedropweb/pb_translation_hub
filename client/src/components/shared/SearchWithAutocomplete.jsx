import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { Search, X } from 'lucide-react';
import { LanguageContext } from '../../context/LanguageContext';
import { ThemeContext } from '../../context/ThemeContext';
import { API_BASE } from '../../utils/constants';
import StatusBadge from '../ui/StatusBadge';

/**
 * @file SearchWithAutocomplete.jsx
 * A powerful search input with live autocomplete suggestions from the Hub API.
 */
const SearchWithAutocomplete = ({ value, onChange, isGerman, onSelect, placeholder, filter }) => {
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
        params: { q, langcode: targetLanguage.code, filter }
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
        <Search className="h-5 w-5 text-text-muted" />
      </div>
      <input
        type="text"
        placeholder={placeholder || (isGerman ? "Projekte suchen..." : "Search projects...")}
        className={`block w-full pl-10 pr-10 py-2.5 rounded-lg text-sm focus:ring-4 outline-none transition-all shadow-sm border glass-blur bg-bg-input border-border-main text-text-main placeholder:text-text-muted/50 focus:ring-brand-500/20`}
        value={inputValue}
        onChange={(e) => {
          const val = e.target.value;
          setInputValue(val);
          clearTimeout(window.autoTimeout);
          window.autoTimeout = setTimeout(() => fetchSuggestions(val), 300);
          
          clearTimeout(window.searchTimeout);
          window.searchTimeout = setTimeout(() => onChange(val), 800);
        }}
        onKeyDown={handleKeyDown}
        onFocus={() => { if (suggestions.length > 0) setShowDropdown(true); }}
      />

      {inputValue && (
        <button
          onClick={() => {
            setInputValue('');
            onChange('');
            setSuggestions([]);
            setShowDropdown(false);
          }}
          className="absolute inset-y-0 right-0 pr-3 flex items-center text-text-muted hover:text-brand-500 transition-colors"
          title={isGerman ? "Suche löschen" : "Clear search"}
        >
          <X size={18} />
        </button>
      )}

      {showDropdown && suggestions.length > 0 && (
        <div className="absolute top-full left-0 right-0 mt-2 rounded-xl shadow-lg z-50 overflow-hidden py-1 animate-in fade-in zoom-in-95 duration-100 border bg-bg-card border-border-main glass-blur text-text-main">
          {suggestions.map((s, i) => (
            <div
              key={s.machine_name}
              className={`px-4 py-2.5 cursor-pointer flex flex-col transition-colors ${
                i === selectedIndex ? 'bg-brand-500/20' : 'hover:bg-brand-500/10'
              }`}
              onClick={() => {
                onSelect(s.machine_name);
                setShowDropdown(false);
              }}
              onMouseEnter={() => setSelectedIndex(i)}
            >
              <div className="flex justify-between items-center">
                <span className={`text-sm font-semibold ${i === selectedIndex ? 'text-brand-600' : 'text-text-main'}`}>
                  {s.title}
                </span>
                <StatusBadge status={s.status} />
              </div>
              <span className="text-xs font-mono mt-0.5 text-text-muted">{s.machine_name}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default SearchWithAutocomplete;
