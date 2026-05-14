import React, { useState, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { Lock, RefreshCw, LogIn } from 'lucide-react';
import { AuthContext } from '../context/AuthContext';
import { ToastContext } from '../context/ToastContext';
import { LanguageContext } from '../context/LanguageContext';

/**
 * @file LoginView.jsx
 * User authentication page.
 */
const LoginView = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [remember, setRemember] = useState(true);
  const { login } = useContext(AuthContext);
  const { showToast } = useContext(ToastContext);
  const { targetLanguage } = useContext(LanguageContext);
  const isGerman = targetLanguage?.code === 'de';
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await login(username, password, remember);
      showToast(isGerman ? 'Willkommen zurück!' : 'Welcome back!');
      navigate('/');
    } catch (err) {
      showToast(isGerman ? 'Login fehlgeschlagen. Bitte prüfe deine Daten.' : 'Login failed. Please check your credentials.', 'error');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center p-6 bg-transparent">
      <div className={`w-full max-w-md p-10 rounded-[2.5rem] border animate-fade transition-all glass-blur bg-bg-card border-border-main shadow-2xl`}>
        <div className="flex flex-col items-center mb-10">
          <div className="w-16 h-16 rounded-2xl bg-brand-600 flex items-center justify-center text-white mb-6 shadow-xl shadow-brand-600/20">
            <Lock size={32} />
          </div>
          <h1 className="text-3xl font-black tracking-tight text-text-main">{isGerman ? 'Anmelden' : 'Login'}</h1>
          <p className="text-text-muted mt-2 text-center">{isGerman ? 'Melde dich an, um Übersetzungen zu bearbeiten.' : 'Login to start editing translations.'}</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="space-y-2">
            <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Benutzername' : 'Username'}</label>
            <input 
              type="text" 
              required
              className={`w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500`}
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              placeholder="admin"
            />
          </div>
          <div className="space-y-2">
            <label className="text-xs font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Passwort' : 'Password'}</label>
            <input 
              type="password" 
              required
              className={`w-full px-5 py-4 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500`}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
            />
          </div>

          <div className="flex items-center justify-between px-1">
            <label className="flex items-center gap-3 cursor-pointer group">
              <div className="relative">
                <input 
                  type="checkbox" 
                  className="sr-only" 
                  checked={remember}
                  onChange={(e) => setRemember(e.target.checked)}
                />
                <div className={`w-10 h-5 rounded-full transition-colors ${remember ? 'bg-brand-600' : 'bg-gray-600'}`} />
                <div className={`absolute top-1 left-1 w-3 h-3 rounded-full bg-white transition-transform ${remember ? 'translate-x-5' : 'translate-x-0'}`} />
              </div>
              <span className="text-sm font-bold text-text-muted group-hover:text-text-main transition-colors">
                {isGerman ? 'Angemeldet bleiben' : 'Stay logged in'}
              </span>
            </label>
          </div>

          <button 
            type="submit"
            disabled={loading}
            className="w-full py-4 rounded-xl font-black bg-brand-600 text-white hover:bg-brand-700 transition-all shadow-xl shadow-brand-600/20 flex items-center justify-center gap-2"
          >
            {loading ? <RefreshCw className="animate-spin" size={20} /> : <LogIn size={20} />}
            {isGerman ? 'JETZT ANMELDEN' : 'LOGIN NOW'}
          </button>
        </form>

        <div className="mt-8 text-center">
          <p className="text-sm text-text-muted">
            {isGerman ? 'Noch kein Konto?' : "Don't have an account?"}{' '}
            <button onClick={() => navigate('/register')} className="text-brand-500 font-bold hover:underline">
              {isGerman ? 'Registrieren' : 'Register'}
            </button>
          </p>
        </div>
      </div>
    </div>
  );
};

export default LoginView;
