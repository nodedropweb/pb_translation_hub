import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { RefreshCw, Save } from 'lucide-react';
import { LanguageContext } from '../context/LanguageContext';
import { ThemeContext } from '../context/ThemeContext';
import { ToastContext } from '../context/ToastContext';
import { API_BASE } from '../utils/constants';

/**
 * @file CategoriesView.jsx
 * Interface for translating Project Browser categories.
 */
const CategoriesView = ({ isGerman }) => {
  const { targetLanguage } = useContext(LanguageContext);
  const { theme } = useContext(ThemeContext);
  const [categories, setCategories] = useState([]);
  const [translations, setTranslations] = useState({});
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const { showToast } = useContext(ToastContext);

  async function fetchCategories() {
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
  }

  async function handleSave() {
    setSaving(true);
    try {
      await axios.post(`${API_BASE}/categories/translate`, {
        langcode: targetLanguage.code,
        translations: translations
      });
      showToast(isGerman ? 'Kategorien erfolgreich gespeichert.' : 'Categories saved successfully.');
    } catch (err) {
      console.error(err);
      showToast(isGerman ? 'Fehler beim Speichern.' : 'Failed to save.', 'error');
    } finally {
      setSaving(false);
    }
  }

  useEffect(() => {
    fetchCategories();
  }, [targetLanguage]);

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 animate-fade">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8 pb-8 border-b border-border-main">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">{isGerman ? 'Kategorien' : 'Categories'}</h1>
          <p className="text-text-muted mt-1">{isGerman ? 'Übersetzung für:' : 'Translating for:'} <span className="font-semibold text-brand-500">{targetLanguage.name}</span></p>
        </div>
        <div className="flex items-center gap-3">
          <button 
            className="flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-sm bg-bg-card border-border-main text-text-main hover:bg-bg-card-hover"
            onClick={async () => {
              try {
                const res = await axios.post(`${API_BASE}/categories/import-local`, { langcode: targetLanguage.code });
                showToast(isGerman ? `Erfolgreich ${res.data.count} Bezeichnungen importiert!` : `Successfully imported ${res.data.count} items!`);
                fetchCategories();
              } catch (err) {
                showToast(isGerman ? 'Keine Import-Datei gefunden.' : 'No import file found.', 'error');
              }
            }}
          >
            <RefreshCw size={18} className="text-brand-500" />
            {isGerman ? 'Aus Drupal importieren' : 'Import from Drupal'}
          </button>
          <button 
            className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white rounded-lg text-sm font-semibold hover:bg-brand-700 transition-all shadow-lg shadow-brand-600/20 disabled:opacity-50"
            onClick={handleSave} 
            disabled={saving}
          >
            <Save size={18} />
            {saving ? (isGerman ? 'Speichert...' : 'Saving...') : (isGerman ? 'Alle speichern' : 'Save All')}
          </button>
        </div>
      </div>

      <div className="border rounded-2xl shadow-sm overflow-hidden transition-all bg-bg-card border-border-main glass-blur">
        {loading ? (
          <div className="py-24 flex flex-col items-center justify-center">
            <RefreshCw className="animate-spin mb-4 text-brand-600 drop-shadow-[0_0_10px_rgba(127,86,217,0.5)]" size={40} />
            <p className="text-text-muted font-medium">{isGerman ? 'Lade Kategorien...' : 'Loading categories...'}</p>
          </div>
        ) : (
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b transition-all bg-bg-sidebar border-border-main">
                <th className="px-8 py-4 text-xs font-bold text-text-muted uppercase tracking-wider">{isGerman ? 'Original (EN)' : 'Original (EN)'}</th>
                <th className="px-8 py-4 text-xs font-bold text-text-muted uppercase tracking-wider">{isGerman ? `Übersetzung (${targetLanguage.code})` : `Translation (${targetLanguage.code})`}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border-muted">
              {categories.map(cat => (
                <tr key={cat.id} className="transition-colors group hover:bg-bg-card-hover">
                  <td className="px-8 py-5 text-sm font-semibold">{cat.attributes.name}</td>
                  <td className="px-8 py-5">
                    <input
                      type="text"
                      className="w-full px-4 py-2 rounded-lg text-sm focus:ring-4 focus:ring-brand-500/20 outline-none transition-all shadow-sm border bg-bg-input border-border-main text-text-main"
                      value={translations[cat.id] || ''}
                      onChange={e => setTranslations({ ...translations, [cat.id]: e.target.value })}
                      placeholder={isGerman ? `Übersetze "${cat.attributes.name}"...` : `Translate "${cat.attributes.name}"...`}
                    />
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
};

export default CategoriesView;
