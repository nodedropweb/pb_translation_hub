import React, { useState, useContext } from 'react';
import axios from 'axios';
import { 
  Camera, 
  RefreshCw, 
  User, 
  Zap, 
  Lock, 
  LogOut 
} from 'lucide-react';

// Contexts
import { AuthContext } from '../context/AuthContext';
import { ToastContext } from '../context/ToastContext';
import { LanguageContext } from '../context/LanguageContext';

// Utils
import { API_BASE, BACKEND_URL } from '../utils/constants';

/**
 * @file ProfileView.jsx
 * User profile management, including AI settings and password updates.
 */
const ProfileView = () => {
  const { user, setUser, logout } = useContext(AuthContext);
  const { showToast } = useContext(ToastContext);
  const { targetLanguage } = useContext(LanguageContext);
  const isGerman = targetLanguage?.code === 'de';
  
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    name: user?.name || '',
    email: user?.email || '',
    google_ai_key: user?.google_ai_key || '',
    ai_batch_limit: user?.ai_batch_limit || 5,
    ai_prompt: user?.ai_prompt || ''
  });

  const [passData, setPassData] = useState({ currentPassword: '', newPassword: '', confirmPassword: '' });
  const [passLoading, setPassLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await axios.put(`${API_BASE}/auth/profile`, formData);
      setUser(res.data.user);
      showToast(isGerman ? 'Profil aktualisiert!' : 'Profile updated!');
    } catch (err) {
      showToast(isGerman ? 'Update fehlgeschlagen.' : 'Update failed.', 'error');
    } finally {
      setLoading(false);
    }
  };

  const handlePasswordChange = async (e) => {
    e.preventDefault();
    if (passData.newPassword !== passData.confirmPassword) {
      showToast(isGerman ? 'Passwörter stimmen nicht überein.' : 'Passwords do not match.', 'error');
      return;
    }
    setPassLoading(true);
    try {
      await axios.put(`${API_BASE}/auth/password`, {
        currentPassword: passData.currentPassword,
        newPassword: passData.newPassword
      });
      showToast(isGerman ? 'Passwort erfolgreich geändert!' : 'Password updated successfully!');
      setPassData({ currentPassword: '', newPassword: '', confirmPassword: '' });
    } catch (err) {
      showToast(err.response?.data?.error || (isGerman ? 'Passwortänderung fehlgeschlagen.' : 'Password update failed.'), 'error');
    } finally {
      setPassLoading(false);
    }
  };

  return (
    <div className="p-12 max-w-7xl mx-auto animate-fade space-y-12">
      <div className="flex items-center gap-6 mb-4">
        <div className="relative group">
          <div className="w-24 h-24 rounded-[2rem] bg-brand-600 flex items-center justify-center text-white shadow-2xl shadow-brand-600/30 overflow-hidden">
            {user?.avatar_url ? <img src={`${BACKEND_URL}${user.avatar_url}`} className="w-full h-full object-cover" /> : <User size={48} />}
          </div>
          <button className="absolute -bottom-2 -right-2 p-3 bg-white text-brand-600 rounded-2xl shadow-xl border border-brand-100 hover:scale-110 active:scale-95 transition-all">
            <Camera size={18} />
          </button>
        </div>
        <div>
          <h1 className="text-4xl font-black tracking-tight text-text-main">{user?.name || user?.username}</h1>
          <p className="text-text-muted mt-1 uppercase tracking-widest text-xs font-black flex items-center gap-2">
            <span className="w-2 h-2 rounded-full bg-green-500 animate-pulse" />
            {user?.role === 'admin' ? (isGerman ? 'Administrator' : 'Administrator') : (isGerman ? 'Übersetzer' : 'Translator')}
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">
        <div className="lg:col-span-2 space-y-10">
          <form onSubmit={handleSubmit} className="p-10 rounded-[2.5rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl grid grid-cols-1 md:grid-cols-2 gap-8">
            <div className="md:col-span-2">
              <h2 className="text-xl font-bold mb-2 flex items-center gap-3 text-text-main">
                <User size={20} className="text-brand-500" />
                {isGerman ? 'Persönliche Daten' : 'Personal Details'}
              </h2>
            </div>
            
            <div className="space-y-2">
              <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Anzeigename' : 'Display Name'}</label>
              <input 
                type="text" required
                className="w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'E-Mail Adresse' : 'Email Address'}</label>
              <input 
                type="email" required
                className="w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500"
                value={formData.email}
                onChange={(e) => setFormData({...formData, email: e.target.value})}
              />
            </div>

            <div className="md:col-span-2 pt-8 border-t border-white/5">
              <h2 className="text-xl font-bold mb-2 flex items-center gap-3 text-amber-500">
                <Zap size={20} fill="currentColor" />
                {isGerman ? 'KI-Konfiguration (Gemini)' : 'AI Configuration (Gemini)'}
              </h2>
            </div>

            <div className="space-y-2">
              <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Google AI API Key' : 'Google AI API Key'}</label>
              <input 
                type="password"
                className="w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-amber-500/20 focus:border-amber-500 font-mono"
                value={formData.google_ai_key}
                onChange={(e) => setFormData({...formData, google_ai_key: e.target.value})}
                placeholder="AIzaSy..."
              />
            </div>
            <div className="space-y-2">
              <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Batch-Limit' : 'Batch Limit'}</label>
              <input 
                type="number" min="1" max="50"
                className="w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-amber-500/20 focus:border-amber-500 font-bold"
                value={formData.ai_batch_limit}
                onChange={(e) => setFormData({...formData, ai_batch_limit: parseInt(e.target.value)})}
              />
              <p className="text-[10px] text-text-muted ml-1">
                {isGerman ? 'Maximale Anzahl an Projekten pro Automatisierungslauf.' : 'Maximum number of projects per automation run.'}
              </p>
            </div>
            <div className="md:col-span-2 space-y-2">
              <div className="flex items-center justify-between">
                <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">
                  {isGerman ? 'KI-System-Prompt' : 'AI System Prompt'}
                </label>
                <button 
                  type="button"
                  onClick={() => setFormData({...formData, ai_prompt: `Translate the following two HTML blocks (summary and main description) from the Drupal Project Browser to {{langcode}}.
IMPORTANT:
1. Return ONLY the translation.
2. Do NOT add any introduction, comments, or explanations (e.g., NO "Here is the translation").
3. Module names must stay in English.
4. Links and image URLs must remain unchanged.
5. Separate the two translated blocks EXACTLY by the string '---'.

Summary:
{{summary}}

---

Main Description:
{{body}}`})}
                  className="text-[10px] font-black text-amber-500 hover:text-amber-600 transition-all uppercase tracking-tighter"
                >
                  {isGerman ? 'ZURÜCKSETZEN' : 'RESET TO DEFAULT'}
                </button>
              </div>
              <textarea 
                rows="10"
                className="w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-amber-500/20 focus:border-amber-500 font-mono text-sm leading-relaxed"
                value={formData.ai_prompt}
                onChange={(e) => setFormData({...formData, ai_prompt: e.target.value})}
                placeholder="Translate to {{langcode}}..."
              />
              <div className="flex gap-4 mt-2">
                <span className="text-[10px] px-2 py-1 rounded bg-bg-app border border-border-main text-text-muted font-mono">{"{{langcode}}"}</span>
                <span className="text-[10px] px-2 py-1 rounded bg-bg-app border border-border-main text-text-muted font-mono">{"{{summary}}"}</span>
                <span className="text-[10px] px-2 py-1 rounded bg-bg-app border border-border-main text-text-muted font-mono">{"{{body}}"}</span>
              </div>
            </div>

            <div className="md:col-span-2 mt-4">
              <button 
                type="submit"
                disabled={loading}
                className="w-full md:w-auto px-10 py-4 rounded-xl font-black bg-amber-600 text-white hover:bg-amber-700 transition-all shadow-xl shadow-amber-600/20 flex items-center justify-center gap-3"
              >
                {loading ? <RefreshCw className="animate-spin" size={20} /> : <Zap size={20} />}
                {isGerman ? 'KI-EINSTELLUNGEN SPEICHERN' : 'SAVE AI SETTINGS'}
              </button>
            </div>
          </form>
        </div>

        <div className="space-y-8">
          <div className="p-10 rounded-[2.5rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl">
            <h2 className="text-xl font-bold mb-8 flex items-center gap-3 text-text-main">
              <Lock size={20} className="text-brand-500" />
              {isGerman ? 'Sicherheit' : 'Security'}
            </h2>
            <form onSubmit={handlePasswordChange} className="space-y-4">
              <div className="space-y-1">
                <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Aktuelles Passwort' : 'Current Password'}</label>
                <input 
                  type="password" required
                  className="w-full px-4 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500 text-sm"
                  value={passData.currentPassword}
                  onChange={(e) => setPassData({...passData, currentPassword: e.target.value})}
                />
              </div>
              <div className="space-y-1">
                <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Neues Passwort' : 'New Password'}</label>
                <input 
                  type="password" required
                  className="w-full px-4 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500 text-sm"
                  value={passData.newPassword}
                  onChange={(e) => setPassData({...passData, newPassword: e.target.value})}
                />
              </div>
              <div className="space-y-1">
                <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Bestätigen' : 'Confirm'}</label>
                <input 
                  type="password" required
                  className="w-full px-4 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500 text-sm"
                  value={passData.confirmPassword}
                  onChange={(e) => setPassData({...passData, confirmPassword: e.target.value})}
                />
              </div>
              <button 
                type="submit"
                disabled={passLoading}
                className="w-full py-4 mt-2 rounded-xl font-black bg-white/5 border border-white/10 text-text-main hover:bg-brand-600 hover:text-white transition-all shadow-lg flex items-center justify-center gap-2"
              >
                {passLoading ? <RefreshCw className="animate-spin" size={18} /> : <Lock size={18} />}
                {isGerman ? 'PASSWORT ÄNDERN' : 'UPDATE PASSWORD'}
              </button>
            </form>
          </div>

          <div className={`p-10 rounded-[2.5rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl`}>
            <button 
              onClick={logout}
              className="w-full py-4 rounded-xl font-black bg-red-600/10 text-red-500 border border-red-500/20 hover:bg-red-600 hover:text-white transition-all flex items-center justify-center gap-2 shadow-lg"
            >
              <LogOut size={20} />
              {isGerman ? 'ABMELDEN' : 'LOGOUT'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProfileView;
