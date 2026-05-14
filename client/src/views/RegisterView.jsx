import React, { useState, useEffect, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { Lock, RefreshCw, CheckCircle, UserPlus } from 'lucide-react';
import { AuthContext } from '../context/AuthContext';
import { ToastContext } from '../context/ToastContext';
import { LanguageContext } from '../context/LanguageContext';
import { API_BASE } from '../utils/constants';

/**
 * @file RegisterView.jsx
 * New user registration page with admin approval workflow.
 */
const RegisterView = () => {
  const [formData, setFormData] = useState({ username: '', password: '', name: '', email: '' });
  const [loading, setLoading] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [regEnabled, setRegEnabled] = useState(null); // null = loading, 0 = disabled, 1 = enabled
  const { register } = useContext(AuthContext);
  const { showToast } = useContext(ToastContext);
  const { targetLanguage } = useContext(LanguageContext);
  const isGerman = targetLanguage?.code === 'de';
  const navigate = useNavigate();

  useEffect(() => {
    axios.get(`${API_BASE}/auth/settings`)
      .then(res => setRegEnabled(res.data.registration_enabled === '0' ? 0 : 1))
      .catch(() => setRegEnabled(1)); // Fallback
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await register(formData);
      setIsSuccess(true);
      showToast(isGerman ? 'Konto erfolgreich erstellt!' : 'Account created successfully!');
    } catch (err) {
      showToast(err.response?.data?.error || (isGerman ? 'Registrierung fehlgeschlagen.' : 'Registration failed.'), 'error');
    } finally {
      setLoading(false);
    }
  };

  if (regEnabled === 0) {
    return (
      <div className="min-h-screen flex items-center justify-center p-6 bg-transparent">
        <div className="w-full max-w-md p-10 rounded-[2.5rem] border glass-blur bg-bg-card border-border-main shadow-2xl text-center">
          <div className="w-16 h-16 rounded-2xl bg-red-500/10 text-red-500 flex items-center justify-center mb-6 mx-auto">
            <Lock size={32} />
          </div>
          <h1 className="text-2xl font-black text-text-main mb-4">{isGerman ? 'Registrierung geschlossen' : 'Registration Closed'}</h1>
          <p className="text-text-muted text-sm leading-relaxed mb-8">
            {isGerman ? 'Die öffentliche Registrierung ist aktuell deaktiviert. Bitte kontaktiere einen Administrator.' : 'Public registration is currently disabled. Please contact an administrator.'}
          </p>
          <button onClick={() => navigate('/login')} className="w-full py-4 rounded-xl font-black bg-brand-600 text-white hover:bg-brand-700 transition-all shadow-xl shadow-brand-600/20">
            {isGerman ? 'ZURÜCK ZUM LOGIN' : 'BACK TO LOGIN'}
          </button>
        </div>
      </div>
    );
  }

  if (isSuccess) {
    return (
      <div className="min-h-screen flex items-center justify-center p-6 bg-transparent">
        <div className="w-full max-w-md p-10 rounded-[2.5rem] border glass-blur bg-bg-card border-border-main shadow-2xl text-center animate-fade">
          <div className="w-20 h-20 rounded-full bg-brand-500 text-white flex items-center justify-center mb-8 mx-auto shadow-2xl shadow-brand-500/30 animate-bounce">
            <CheckCircle size={40} />
          </div>
          <h1 className="text-3xl font-black text-text-main mb-4">{isGerman ? 'Fast geschafft!' : 'Almost there!'}</h1>
          <p className="text-text-muted text-sm leading-relaxed mb-10">
            {isGerman 
              ? 'Dein Konto wurde erstellt, muss aber noch von einem Administrator freigegeben werden. Du wirst benachrichtigt, sobald du dich einloggen kannst.' 
              : 'Your account has been created, but must be approved by an administrator before you can log in. You will be able to log in once approved.'}
          </p>
          <button onClick={() => navigate('/login')} className="w-full py-4 rounded-xl font-black bg-brand-600 text-white hover:bg-brand-700 transition-all shadow-xl shadow-brand-600/20">
            {isGerman ? 'ZURÜCK ZUM LOGIN' : 'BACK TO LOGIN'}
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex items-center justify-center p-6 bg-transparent">
      <div className={`w-full max-w-md p-10 rounded-[2.5rem] border animate-fade transition-all glass-blur bg-bg-card border-border-main shadow-2xl`}>
        <div className="flex flex-col items-center mb-10">
          <div className="w-16 h-16 rounded-2xl bg-brand-600 flex items-center justify-center text-white mb-6 shadow-xl shadow-brand-600/20">
            <UserPlus size={32} />
          </div>
          <h1 className="text-3xl font-black tracking-tight text-text-main">{isGerman ? 'Konto erstellen' : 'Register'}</h1>
          <p className="text-text-muted text-xs font-bold mt-2 uppercase tracking-widest">{isGerman ? 'Wartet auf Admin-Freigabe' : 'Requires admin approval'}</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1">
            <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Benutzername' : 'Username'}</label>
            <input 
              type="text" required
              className={`w-full px-5 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500`}
              value={formData.username}
              onChange={(e) => setFormData({...formData, username: e.target.value})}
            />
          </div>
          <div className="space-y-1">
            <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Anzeigename' : 'Display Name'}</label>
            <input 
              type="text"
              className={`w-full px-5 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500`}
              value={formData.name}
              onChange={(e) => setFormData({...formData, name: e.target.value})}
            />
          </div>
          <div className="space-y-1">
            <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'E-Mail' : 'Email'}</label>
            <input 
              type="email" required
              className={`w-full px-5 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500`}
              value={formData.email}
              onChange={(e) => setFormData({...formData, email: e.target.value})}
            />
          </div>
          <div className="space-y-1">
            <label className="text-[10px] font-bold uppercase tracking-widest text-text-muted ml-1">{isGerman ? 'Passwort' : 'Password'}</label>
            <input 
              type="password" required
              className={`w-full px-5 py-3 rounded-xl border focus:ring-4 outline-none transition-all glass-blur bg-bg-input border-border-main text-text-main focus:ring-brand-500/20 focus:border-brand-500`}
              value={formData.password}
              onChange={(e) => setFormData({...formData, password: e.target.value})}
            />
          </div>
          <button 
            type="submit"
            disabled={loading}
            className="w-full mt-4 py-4 rounded-xl font-black bg-brand-600 text-white hover:bg-brand-700 transition-all shadow-xl shadow-brand-600/20 flex items-center justify-center gap-2"
          >
            {loading ? <RefreshCw className="animate-spin" size={20} /> : <UserPlus size={20} />}
            {isGerman ? 'JETZT REGISTRIEREN' : 'REGISTER NOW'}
          </button>
        </form>

        <div className="mt-8 text-center">
          <p className="text-sm text-text-muted">
            {isGerman ? 'Bereits ein Konto?' : 'Already have an account?'}{' '}
            <button onClick={() => navigate('/login')} className="text-brand-500 font-bold hover:underline">
              {isGerman ? 'Anmelden' : 'Login'}
            </button>
          </p>
        </div>
      </div>
    </div>
  );
};

export default RegisterView;
