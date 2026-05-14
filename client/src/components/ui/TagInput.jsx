import React, { useState, useEffect } from 'react';
import { X, Plus } from 'lucide-react';

/**
 * @file TagInput.jsx
 * A tags input component that allows adding and removing search tags.
 */
const TagInput = ({ value, onChange, isGerman, placeholder }) => {
  const [inputValue, setInputValue] = useState('');
  const tags = Array.isArray(value) ? value : [];

  const handleAdd = () => {
    if (inputValue.trim() && !tags.includes(inputValue.trim())) {
      onChange([...tags, inputValue.trim()]);
      setInputValue('');
    }
  };

  const handleRemove = (tag) => {
    onChange(tags.filter(t => t !== tag));
  };

  return (
    <div className="space-y-3">
      <div className="flex gap-2">
        <input
          type="text"
          value={inputValue}
          onChange={e => setInputValue(e.target.value)}
          onKeyDown={e => e.key === 'Enter' && (e.preventDefault(), handleAdd())}
          placeholder={placeholder}
          className="flex-1 bg-white/5 border border-border-main rounded-lg px-4 py-2 text-sm text-white outline-none focus:border-brand-500 transition-all"
        />
        <button
          onClick={handleAdd}
          className="bg-brand-600 hover:bg-brand-500 text-white px-4 py-2 rounded-lg transition-all"
        >
          <Plus size={18} />
        </button>
      </div>
      <div className="flex flex-wrap gap-2">
        {tags.map(tag => (
          <span key={tag} className="bg-brand-600/20 border border-brand-600/30 text-brand-400 px-3 py-1 rounded-full text-xs flex items-center gap-2 animate-in zoom-in duration-200">
            {tag}
            <button onClick={() => handleRemove(tag)} className="hover:text-red-400 transition-colors">
              <X size={14} />
            </button>
          </span>
        ))}
      </div>
    </div>
  );
};

export default TagInput;
