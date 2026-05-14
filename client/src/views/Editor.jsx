import React, { useState, useEffect, useContext, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import confetti from 'canvas-confetti';
import { 
  ArrowLeft, 
  RefreshCw, 
  Save, 
  Zap, 
  Code, 
  Eye, 
  Globe, 
  ExternalLink, 
  Languages, 
  Info,
  Lock
} from 'lucide-react';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';

// Contexts
import { AuthContext } from '../context/AuthContext';
import { LanguageContext } from '../context/LanguageContext';
import { ThemeContext } from '../context/ThemeContext';
import { ToastContext } from '../context/ToastContext';
import { WorkflowContext } from '../context/WorkflowContext';

// Components
import DrupalLogo from '../components/ui/DrupalLogo';
import StatusBadge from '../components/ui/StatusBadge';
import TagInput from '../components/ui/TagInput';
import SearchWithAutocomplete from '../components/shared/SearchWithAutocomplete';
import BulkAiModal from '../components/shared/BulkAiModal';

// Utils
import { API_BASE } from '../utils/constants';
import { fixRelativeUrls, stripAbsoluteUrls } from '../utils/helpers';

/**
 * @file Editor.jsx
 * The main translation interface. Allows editing module metadata with live preview,
 * AI assistance, and HTML/Visual toggle.
 * Multi-language support for DE, FR, PT, JA, ZH-HANS.
 */
const Editor = () => {
  const { user, setUser } = useContext(AuthContext);
  const { targetLanguage } = useContext(LanguageContext);
  const { machineName } = useParams();
  const navigate = useNavigate();
  
  const [project, setProject] = useState(null);
  const [translation, setTranslation] = useState({ title: '', summary: '', body: '', screenshot_alts: {}, tags: '' });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [showSource, setShowSource] = useState(false);
  const [showPreview, setShowPreview] = useState(false);
  const [showSummaryHtml, setShowSummaryHtml] = useState(false);
  const [showBodyHtml, setShowBodyHtml] = useState(false);
  const [nextMachineName, setNextMachineName] = useState(null);
  const [reviewMode, setReviewMode] = useState(() => localStorage.getItem('pb-reviewMode') === 'true');
  const [aiModal, setAiModal] = useState({ 
    open: false, 
    phase: 'estimating', 
    progress: 0, 
    total: 0, 
    results: [], 
    estimation: null, 
    onConfirm: null 
  });

  const { theme } = useContext(ThemeContext);
  const { showToast } = useContext(ToastContext);
  const { priorityMode, setPriorityMode, confettiEnabled, largeUi } = useContext(WorkflowContext);

  const isCancelledRef = useRef(false);

  const lang = targetLanguage?.code || 'en';
  const isGerman = lang === 'de';
  const isFrench = lang === 'fr';
  const isPortuguese = lang.startsWith('pt');
  const isPtPt = lang === 'pt-pt';
  const isJapanese = lang === 'ja';
  const isChinese = lang === 'zh-hans';

  useEffect(() => {
    localStorage.setItem('pb-reviewMode', reviewMode);
  }, [reviewMode]);

  async function fetchData() {
    setLoading(true);
    try {
      const savedFilter = priorityMode ? 'priority' : (reviewMode ? 'review' : (localStorage.getItem('pb-activeFilter') || 'all'));
      const savedSearch = localStorage.getItem('pb-search') || '';
      
      const projectRes = await axios.get(`${API_BASE}/projects/${machineName}`, {
        params: { 
          langcode: lang,
          filter: savedFilter,
          search: savedSearch
        }
      });
      const source = projectRes.data.data;
      
      const fallbackTitle = source.attributes?.title || machineName.charAt(0).toUpperCase() + machineName.slice(1);
      
      setProject({
        ...source,
        attributes: {
          ...source.attributes,
          body: {
            ...source.attributes?.body,
            summary: fixRelativeUrls(source.attributes?.body?.summary || ''),
            value: fixRelativeUrls(source.attributes?.body?.value || '')
          }
        }
      });
      setNextMachineName(source.meta?.next_machine_name);

      try {
        const transRes = await axios.get(`${API_BASE}/translations/${lang}/${machineName}`);
        const t = transRes.data;
        setTranslation({
          title: t.title || fallbackTitle,
          summary: fixRelativeUrls(t.body?.summary || t.summary || ''),
          body: fixRelativeUrls(t.body?.value || t.body || ''),
          screenshot_alts: t.screenshot_alts || {},
          tags: t.tags || '',
          source_hash: t.source_hash || ''
        });
      } catch (err) {
        setTranslation({
          title: fallbackTitle,
          summary: fixRelativeUrls(source.attributes?.body?.summary || ''),
          body: fixRelativeUrls(source.attributes?.body?.value || ''),
          screenshot_alts: source.meta?.screenshot_urls?.reduce((acc, img) => ({ ...acc, [img.id]: img.alt }), {}) || {},
          tags: '',
          source_hash: ''
        });
      }
      setLoading(false);
    } catch (err) {
      console.error(err);
      setLoading(false);
    }
  }

  function copyAiPrompt() {
    const prompt = isGerman 
      ? `Übersetze die folgenden zwei HTML-Blöcke (Zusammenfassung und Hauptbeschreibung) aus dem Project Browser von Drupal nach ${targetLanguage.name}. Achte dabei darauf, Modulnamen englisch zu lassen und Links nicht zu verändern. Gib mir die Übersetzung als zwei separate HTML-Blöcke zurück:\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`
      : isFrench
      ? `Traduisez les deux blocs HTML suivants (résumé et description principale) du Project Browser de Drupal vers le ${targetLanguage.name}. Veillez à laisser les noms des modules en anglais et à ne pas modifier les liens. Donnez-moi la traduction sous forme de deux blocs HTML séparés :\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`
      : isPortuguese
      ? `Traduza os seguintes dois blocos HTML (resumo e descrição principal) do Project Browser do Drupal para o ${targetLanguage.name}. Certifique-se de deixar os nomes dos módulos em inglês e não alterar os links. Dê-me a tradução como dois blocos HTML separados:\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`
      : isJapanese
      ? `以下の2つのHTMLブロック（要約とメインの説明）をDrupalのProject Browserから${targetLanguage.name}に翻訳してください。モジュール名は英語のままにし、リンクは変更しないように注意してください。翻訳結果を2つの別々のHTMLブロックとして返してください：\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`
      : isChinese
      ? `请将以下两个 HTML 块（摘要和主描述）从 Drupal 的 Project Browser 翻译成${targetLanguage.name}。请注意保持模块名称为英文，并且不要更改链接。请以两个独立的 HTML 块形式返回翻译结果：\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`
      : `Translate the following two HTML blocks (summary and main description) from Drupal's Project Browser to ${targetLanguage.name}. Keep module names in English and do not change links. Give me the translation as two separate HTML blocks:\n\n---\n\n${project.attributes.body?.summary || ''}\n\n---\n\n${project.attributes.body?.value || ''}`;
      
    navigator.clipboard.writeText(prompt);
    showToast(isGerman ? 'KI-Prompt kopiert!' : isFrench ? 'Prompt IA copié !' : isPortuguese ? 'Prompt da IA copiado!' : isJapanese ? 'AIプロンプトをコピーしました！' : isChinese ? 'AI 提示词已复制！' : 'AI Prompt copied!');
  }

  function copyHtml() {
    const raw = `${project.attributes.body?.summary || ''}\n\n${project.attributes.body?.value || ''}`;
    navigator.clipboard.writeText(raw);
    showToast(isGerman ? 'HTML kopiert' : isFrench ? 'HTML copié' : isPortuguese ? 'HTML copiado' : isJapanese ? 'HTMLをコピーしました' : isChinese ? 'HTML 已复制' : 'HTML copied');
  }

  function togglePreview() {
    setShowPreview(!showPreview);
  }

  function goToNext() {
    if (nextMachineName) {
      navigate(`/edit/${nextMachineName}`);
    } else {
      showToast(isGerman ? 'Keine weiteren Projekte in der Liste.' : isFrench ? 'Plus aucun projet dans la liste.' : isPortuguese ? 'Sem mais projetos na lista.' : isJapanese ? 'リストにプロジェクトはもうありません。' : isChinese ? '列表中没有更多项目。' : 'No more projects in the list.', 'info');
      navigate('/');
    }
  }

  async function handleSave(andNext = false) {
    setSaving(true);
    try {
      const strippedTranslation = {
        ...translation,
        summary: stripAbsoluteUrls(translation.summary),
        body: stripAbsoluteUrls(translation.body),
        tags: translation.tags
      };
      await axios.post(`${API_BASE}/translations/${lang}/${machineName}`, {
        ...strippedTranslation,
        is_review: reviewMode
      });
      if (reviewMode) {
        setUser({ ...user, last_reviewed_project: machineName });
      }

      // Party Popper Celebration!
      if (confettiEnabled) {
        confetti({
          particleCount: 150,
          spread: 70,
          origin: { y: 0.6 },
          colors: ['#2563eb', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6'],
          disableForReducedMotion: true
        });
      }

      showToast(isGerman ? 'Erfolgreich gespeichert!' : isFrench ? 'Enregistré avec succès !' : isPortuguese ? 'Salvo com sucesso!' : isJapanese ? '正常に保存されました！' : isChinese ? '保存成功！' : 'Saved successfully!');
      
      if (andNext) {
        // Short delay to enjoy the confetti before jumping (only if enabled)
        setTimeout(() => {
          goToNext();
        }, confettiEnabled ? 800 : 100);
      }
    } catch (err) {
      console.error(err);
      if (err.response?.status === 401) {
        showToast(isGerman ? 'Sitzung abgelaufen. Bitte erneut anmelden.' : 'Session expired. Please login again.', 'error');
        navigate('/login');
      } else {
        showToast(isGerman ? 'Fehler beim Speichern.' : 'Failed to save translation', 'error');
      }
    } finally {
      setSaving(false);
    }
  }

  async function handleBulkAi() {
    if (!user.google_ai_key) {
      showToast(isGerman ? 'Bitte hinterlege erst einen API Key in deinem Profil.' : 'Please add an API Key in your profile first.', 'warning');
      navigate('/profile');
      return;
    }

    try {
      setLoading(true);
      const savedSearch = (localStorage.getItem('pb-search') || '').trim();
      
      const listRes = await axios.get(`${API_BASE}/projects`, {
        params: { 
          langcode: lang,
          filter: priorityMode ? 'priority' : 'missing',
          search: savedSearch,
          limit: user.ai_batch_limit || 5
        }
      });

      const missingProjects = listRes.data.data.map(p => p.attributes.field_project_machine_name);
      
      if (missingProjects.length === 0) {
        showToast(isGerman ? 'Keine fehlenden Übersetzungen gefunden.' : 'No missing translations found.', 'info');
        setLoading(false);
        return;
      }

      setAiModal({ 
        open: true, 
        phase: 'estimating',
        progress: 0, 
        total: missingProjects.length, 
        results: [],
        estimation: null,
        onConfirm: async () => {
          isCancelledRef.current = false;
          setAiModal(prev => ({ ...prev, phase: 'translating' }));
          const finalResults = [];
          
          for (let i = 0; i < missingProjects.length; i++) {
            if (isCancelledRef.current) break;
            
            const mName = missingProjects[i];
            try {
              const res = await axios.post(`${API_BASE}/ai/translate-bulk`, {
                machineNames: [mName],
                langcode: lang
              });
              finalResults.push(...res.data.results);
            } catch (err) {
              finalResults.push({ machine_name: mName, success: false, error: err.message });
            }
            
            setAiModal(prev => ({ 
              ...prev, 
              progress: i + 1, 
              results: [...finalResults] 
            }));
          }
          
          const wasCancelled = isCancelledRef.current;
          setAiModal(prev => ({ ...prev, phase: 'finished' }));
          
          if (!wasCancelled) {
            showToast(isGerman ? 'KI-Übersetzung abgeschlossen!' : 'AI Translation complete!');
          } else {
            showToast(isGerman ? 'KI-Übersetzung gestoppt.' : 'AI Translation stopped.', 'info');
          }
          
          if (missingProjects.includes(machineName)) fetchData();
        }
      });

      try {
        const estRes = await axios.post(`${API_BASE}/ai/estimate-cost`, {
          machineNames: missingProjects,
          langcode: lang
        });
        setAiModal(prev => ({ ...prev, estimation: estRes.data }));
      } catch (err) {
        showToast(isGerman ? 'Kostenschätzung fehlgeschlagen.' : 'Cost estimation failed.', 'error');
        setAiModal(prev => ({ ...prev, open: false }));
      }

      setLoading(false);
    } catch (err) {
      console.error(err);
      showToast(isGerman ? 'KI-Fehler.' : 'AI error.', 'error');
      setAiModal(prev => ({ ...prev, open: false }));
      setLoading(false);
    }
  }

  useEffect(() => {
    fetchData();
  }, [machineName, targetLanguage, reviewMode]);

  useEffect(() => {
    const handleKeydown = (e) => {
      const isMod = (e.ctrlKey || e.metaKey) && e.altKey;
      const key = e.key.toLowerCase();

      if (isMod) {
        if (key === 's') {
          e.preventDefault();
          handleSave(true); // User preference: Save & Next
        } else if (key === 'p') {
          e.preventDefault();
          togglePreview();
        } else if (key === 'k') {
          e.preventDefault();
          copyAiPrompt();
        } else if (key === 'h') {
          e.preventDefault();
          copyHtml();
        } else if (key === 'd') {
          e.preventDefault();
          goToNext();
        } else if (key === 'o') {
          e.preventDefault();
          window.open(`https://drupal.org/project/${machineName}`, '_blank');
        }
      }
    };
    
    // Use capture phase (true) to catch events before CKEditor swallows them
    window.addEventListener('keydown', handleKeydown, true);
    return () => window.removeEventListener('keydown', handleKeydown, true);
  }, [translation, machineName, targetLanguage, project, showPreview, nextMachineName, reviewMode]);

  if (loading) return (
    <div className="flex flex-col items-center justify-center h-full">
      <RefreshCw size={48} className="animate-spin mb-4 text-brand-600 drop-shadow-[0_0_10px_rgba(127,86,217,0.5)]" />
      <p className="text-text-main font-medium opacity-70">{isGerman ? 'Projekt-Details werden geladen...' : isJapanese ? 'プロジェクト詳細を読み込み中...' : isChinese ? '正在加载项目详情...' : 'Loading project details...'}</p>
    </div>
  );

  return (
    <div className="flex flex-col h-full animate-fade">
      {/* Editor Header */}
      <header className="border-b px-6 py-4 flex flex-col md:flex-row items-center justify-between gap-4 sticky top-0 z-20 transition-all bg-bg-card border-border-main glass-blur">
        <div className="flex items-center gap-4">
          <button 
            onClick={() => navigate('/')}
            className="p-2 rounded-lg border transition-all bg-bg-input border-border-main text-text-muted hover:text-text-main"
          >
            <ArrowLeft size={20} />
          </button>
          <div>
            <div className="flex items-center gap-3">
              <DrupalLogo size={20} className="text-brand-600 shrink-0" />
              <h1 className="text-xl font-bold tracking-tight leading-tight">{project.attributes.title}</h1>
              <StatusBadge status={project.meta?.translation_status} />
              
              <div className="ml-4 flex items-center gap-3 bg-black/20 px-3 py-1.5 rounded-full border border-white/5">
                <span className="text-[10px] font-bold uppercase tracking-widest text-text-muted">
                  {isGerman ? 'Review Modus' : isFrench ? 'Mode révision' : isPortuguese ? 'Modo de Revisão' : isJapanese ? 'レビューモード' : isChinese ? '审查模式' : 'Review Mode'}
                </span>
                <button 
                  onClick={() => setReviewMode(!reviewMode)}
                  className={`w-10 h-5 rounded-full transition-all relative ${reviewMode ? 'bg-brand-600' : 'bg-gray-600'}`}
                >
                  <div className={`absolute top-1 w-3 h-3 rounded-full bg-white transition-all ${reviewMode ? 'left-6' : 'left-1'}`} />
                </button>
              </div>

              <div className="ml-4 flex items-center gap-3 bg-black/20 px-3 py-1.5 rounded-full border border-white/5">
                <span className="text-[10px] font-bold uppercase tracking-widest text-text-muted">
                  {isGerman ? 'Drupal 11 Fokus' : isJapanese ? 'Drupal 11 フォーカス' : isChinese ? 'Drupal 11 聚焦' : 'Drupal 11 Focus'}
                </span>
                <button 
                  onClick={() => setPriorityMode(!priorityMode)}
                  className={`w-10 h-5 rounded-full transition-all relative ${priorityMode ? 'bg-amber-600' : 'bg-gray-600'}`}
                  title={isGerman ? 'Nur Drupal 11 kompatible Module anzeigen' : 'Show only Drupal 11 compatible modules'}
                >
                  <div className={`absolute top-1 w-3 h-3 rounded-full bg-white transition-all ${priorityMode ? 'left-6' : 'left-1'}`} />
                </button>
              </div>

              {priorityMode && project?.meta?.filter_count !== undefined && (
                <div className={`ml-4 flex items-center gap-2 rounded-full bg-amber-500/10 border border-amber-500/20 shadow-sm transition-all ${largeUi ? 'px-5 py-2' : 'px-3 py-1.5'}`}>
                  <span className={`font-black uppercase tracking-widest text-amber-500 transition-all ${largeUi ? 'text-sm' : 'text-[10px]'}`}>
                    {isGerman ? `${project.meta.filter_count} verbleibend` : `${project.meta.filter_count} remaining`}
                  </span>
                </div>
              )}
              
              {reviewMode && project?.meta?.review_count !== undefined && (
                <div className={`ml-4 flex items-center gap-2 rounded-full bg-brand-500/10 border border-brand-500/20 shadow-sm transition-all ${largeUi ? 'px-5 py-2' : 'px-3 py-1.5'}`}>
                  <span className={`font-black uppercase tracking-widest text-brand-500 transition-all ${largeUi ? 'text-sm' : 'text-[10px]'}`}>
                    {isGerman ? `${project.meta.review_count} verbleibend` : `${project.meta.review_count} remaining`}
                  </span>
                </div>
              )}
            </div>
            <p className="text-sm text-text-muted mt-0.5">
              {isGerman ? 'Übersetze' : isFrench ? 'Traduire' : isPortuguese ? 'Traduzindo' : isJapanese ? '翻訳中' : isChinese ? '正在翻译' : 'Translating'} <code className="text-brand-500 font-bold">{machineName}</code> {isGerman ? 'nach' : isFrench ? 'vers' : isPortuguese ? 'para' : isJapanese ? 'へ' : isChinese ? '至' : 'to'} <span className="font-semibold text-text-main">{targetLanguage.name}</span>
            </p>
          </div>
        </div>
        
        <div className="flex flex-wrap items-center justify-center md:justify-end gap-3 flex-1 w-full md:w-auto">
          <div className="w-full sm:w-64">
            <SearchWithAutocomplete 
              value="" 
              isGerman={isGerman} 
              onSelect={(m) => navigate(`/edit/${m}`)}
              onChange={() => {}} 
              placeholder={isGerman ? "Springe zu..." : isJapanese ? "ジャンプ..." : isChinese ? "跳转至..." : "Jump to..."}
              filter={reviewMode ? 'translated' : 'all'}
            />
          </div>
          <button
            onClick={handleBulkAi}
            className={`flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-lg bg-amber-500/20 border-amber-500/30 text-amber-500 hover:bg-amber-500/30 shadow-amber-500/10`}
            title={isGerman ? `Nächste ${user.ai_batch_limit || 5} fehlenden Projekte automatisch übersetzen` : `Automatically translate next ${user.ai_batch_limit || 5} missing projects`}
          >
            <Zap size={18} fill="currentColor" />
            {isGerman ? 'KI-Auto-Lauf' : isJapanese ? 'AI自動実行' : isChinese ? 'AI 自动运行' : 'AI Auto-Run'}
          </button>
          <button
            onClick={copyAiPrompt}
            className={`flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-sm bg-brand-500/20 border-brand-500/30 text-brand-400 hover:bg-brand-500/30`}
            title={isGerman ? 'KI-Prompt kopieren (CTRL + K)' : 'Copy AI Prompt (CTRL + K)'}
          >
            <Zap size={18} />
            {isGerman ? 'KI-Prompt kopieren' : isJapanese ? 'AIプロンプトをコピー' : isChinese ? '复制 AI 提示词' : 'Copy AI Prompt'}
          </button>
          <button
            onClick={copyHtml}
            className={`flex items-center gap-2 px-4 py-2 border rounded-lg text-sm font-semibold transition-all shadow-sm bg-white/5 border-border-main text-text-main hover:bg-white/10`}
          >
            <Code size={18} />
            {isGerman ? 'Als HTML kopieren' : isJapanese ? 'HTMLとしてコピー' : isChinese ? '复制为 HTML' : 'Copy HTML'}
          </button>
          <button
            onClick={() => handleSave(false)}
            disabled={saving}
            className={`flex items-center gap-2 px-5 py-2 rounded-lg text-sm font-semibold transition-all shadow-sm disabled:opacity-50 border bg-brand-600 border-brand-600 text-white hover:bg-brand-700 shadow-xl shadow-brand-600/20`}
            title={isGerman ? 'Speichern (Button) / Speichern & Weiter (STRG + ALT + S)' : 'Save (Button) / Save & Next (CTRL + ALT + S)'}
          >
            {saving ? <RefreshCw size={18} className="animate-spin" /> : <Save size={18} />}
            {isGerman ? 'Speichern' : isJapanese ? '保存' : isChinese ? '保存' : 'Save'}
          </button>
        </div>
      </header>

      {/* Editor Main Layout */}
      <div className="flex flex-col lg:flex-row flex-1 overflow-y-auto lg:overflow-hidden">
        {/* Source Pane */}
        <div className="w-full lg:w-[40%] lg:border-r overflow-y-auto transition-all bg-bg-app border-border-main">
          <div className="p-8">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-sm font-bold text-text-muted uppercase tracking-wider flex items-center gap-2">
                <Globe size={14} />
                {isGerman ? 'Englische Quelle' : isJapanese ? '英語のソース' : isChinese ? '英文原文' : 'English Source'}
              </h3>
              <div className="flex gap-2">
                <button 
                  onClick={() => setShowSource(!showSource)}
                  className={`p-1.5 rounded border transition-all ${
                    showSource ? 'bg-brand-600 text-white border-brand-600 shadow-lg shadow-brand-500/20' : 'bg-bg-card text-text-muted border-border-main'
                  }`}
                  title={isGerman ? 'Quellcode umschalten' : 'Toggle Source Code'}
                >
                  <Code size={16} />
                </button>
                <a 
                  href={`https://drupal.org/project/${machineName}`} 
                  target="_blank" 
                  rel="noreferrer"
                  className="p-1.5 rounded border transition-all bg-bg-card border-border-main text-text-muted hover:text-brand-600"
                >
                  <ExternalLink size={16} />
                </a>
              </div>
            </div>

            <div className="border rounded-2xl p-10 shadow-sm prose prose-sm max-w-none prose-brand transition-all bg-bg-card border-border-main text-text-main prose-invert">
              {showSource ? (
                <div className={`font-mono text-xs leading-relaxed p-8 rounded-xl border overflow-x-auto shadow-inner ${
                  theme === 'light' ? 'bg-gray-50 border-gray-200 text-brand-700' : 'bg-bg-input border-border-muted text-brand-300'
                }`}>
                  <div className={`mb-6 flex items-center gap-2 select-none font-bold uppercase tracking-widest text-[10px] ${theme === 'light' ? 'text-gray-400' : 'text-text-muted'}`}>
                    <Code size={12} />
                    Summary Source
                  </div>
                  {project.attributes.body?.summary || 'N/A'}
                  <div className={`my-10 border-t ${theme === 'light' ? 'border-gray-100' : 'border-border-muted'}`}></div>
                  <div className={`mb-6 flex items-center gap-2 select-none font-bold uppercase tracking-widest text-[10px] ${theme === 'light' ? 'text-gray-400' : 'text-text-muted'}`}>
                    <Code size={12} />
                    Body Source
                  </div>
                  {project.attributes.body?.value || ''}
                </div>
              ) : (
                <>
                  <h1 className={`text-3xl font-bold border-b pb-6 mb-8 ${theme === 'light' ? 'text-gray-900 border-gray-100' : 'text-white border-border-muted'}`}>{project.attributes.title}</h1>
                  {project.attributes.body?.summary && (
                    <div className={`text-lg italic mb-10 pb-10 border-b leading-relaxed ${theme === 'light' ? 'text-gray-500 border-gray-100' : 'text-text-muted border-border-muted'}`} dangerouslySetInnerHTML={{ __html: project.attributes.body.summary }} />
                  )}
                  <div className={`${theme === 'light' ? 'text-gray-700' : 'text-text-main'} leading-loose`} dangerouslySetInnerHTML={{ __html: project.attributes.body?.value }} />
                </>
              )}
            </div>

            {project.meta?.screenshot_urls && project.meta.screenshot_urls.length > 0 && (
              <div className="mt-8">
                <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-4">{isGerman ? 'Screenshots' : 'Screenshots'}</h4>
                <div className="grid grid-cols-1 gap-6">
                  {project.meta.screenshot_urls.map(img => (
                    <div key={img.id} className="bg-white border border-gray-200 rounded-xl overflow-hidden shadow-sm group">
                      <img src={img.url} alt={img.alt} className="w-full h-auto border-b border-gray-100" />
                      <div className="p-4 bg-gray-50 text-[11px] text-gray-500 flex items-center gap-2">
                        <Eye size={12} />
                        <strong>ALT:</strong> {img.alt}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Editor Pane */}
        <div className="w-full lg:w-[60%] overflow-y-auto transition-all bg-bg-card/40 glass-blur">
          <div className="p-8">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-sm font-bold text-text-muted uppercase tracking-wider flex items-center gap-2">
                <Languages size={14} />
                {targetLanguage.name} {isGerman ? 'Übersetzung' : isJapanese ? '翻訳' : isChinese ? '翻译' : 'Translation'}
              </h3>
              <button
                onClick={togglePreview}
                className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs font-bold transition-all border ${
                  showPreview ? 'bg-brand-600 text-white border-brand-600 shadow-lg shadow-brand-500/20' : 'bg-bg-card text-text-main border-border-main hover:border-brand-300'
                }`}
              >
                <Eye size={14} />
                {isGerman ? (showPreview ? 'Editor' : 'Vorschau') : (showPreview ? 'Editor' : 'Preview')}
              </button>
            </div>

            {showPreview ? (
              <div className="border-2 border-brand-500 rounded-2xl p-10 shadow-2xl min-h-[700px] prose prose-sm max-w-none prose-brand animate-in zoom-in-95 duration-300 bg-bg-card text-white prose-invert">
                <div className={`flex items-center gap-2 mb-8 font-bold uppercase tracking-widest text-[10px] select-none border-b pb-4 ${
                  theme === 'light' ? 'text-brand-600 border-brand-100' : 'text-brand-400 border-white/10'
                }`}>
                  <Eye size={12} />
                  Live Preview
                </div>
                <h1 className={`text-3xl font-bold border-b pb-6 mb-8 ${theme === 'light' ? 'text-gray-900 border-gray-100' : 'text-white border-border-muted'}`}>{translation.title}</h1>
                <div className={`text-lg italic mb-10 pb-10 border-b leading-relaxed ${theme === 'light' ? 'text-gray-500 border-gray-100' : 'text-text-muted border-border-muted'}`} dangerouslySetInnerHTML={{ __html: translation.summary }} />
                <div className={`${theme === 'light' ? 'text-gray-700' : 'text-text-main'} leading-loose`} dangerouslySetInnerHTML={{ __html: translation.body }} />
              </div>
            ) : (
              <div className="space-y-8 animate-in fade-in duration-300">
                {/* Workflow Tips */}
                <div className={`rounded-xl p-4 flex items-start gap-3 border ${
                  theme === 'light' ? 'bg-brand-50 border-brand-100 text-brand-800' : 'bg-brand-50/10 border-brand-500/20 text-brand-200'
                }`}>
                  <div className="mt-0.5 text-brand-500 shrink-0"><Info size={18} /></div>
                  <div className="text-xs leading-relaxed font-medium">
                    <p className="mb-2"><strong>{isGerman ? 'Tipp:' : isJapanese ? 'ヒント:' : isChinese ? '提示:' : 'Tip:'}</strong> {isGerman ? 'Nutze Tastenkürzel für einen schnelleren Workflow.' : 'Use shortcuts for a faster workflow.'}</p>
                    <div className="flex flex-wrap gap-x-4 gap-y-1 opacity-90">
                      <span><kbd className="bg-black/30 border border-white/20 px-1.5 rounded shadow-sm text-[10px] text-brand-300 font-mono">Alt+{isGerman ? 'Strg' : 'Ctrl'}+K</kbd> {isGerman ? 'AI Prompt kopieren' : 'AI Prompt'}</span>
                      <span><kbd className="bg-black/30 border border-white/20 px-1.5 rounded shadow-sm text-[10px] text-brand-300 font-mono">Alt+{isGerman ? 'Strg' : 'Ctrl'}+S</kbd> {isGerman ? 'Speichern & weiter' : 'Save & Next'}</span>
                      <span><kbd className="bg-black/30 border border-white/20 px-1.5 rounded shadow-sm text-[10px] text-brand-300 font-mono">Alt+{isGerman ? 'Strg' : 'Ctrl'}+P</kbd> {isGerman ? 'Vorschau' : 'Preview'}</span>
                      <span><kbd className="bg-black/30 border border-white/20 px-1.5 rounded shadow-sm text-[10px] text-brand-300 font-mono">Alt+{isGerman ? 'Strg' : 'Ctrl'}+O</kbd> {isGerman ? 'Projekt öffnen' : 'Open Project'}</span>
                    </div>
                  </div>
                </div>

                {/* Title field */}
                <div className="space-y-2">
                  <label className="text-sm font-semibold text-text-main flex items-center gap-2">
                    {isGerman ? 'Titel' : isJapanese ? 'タイトル' : isChinese ? '标题' : 'Title'}
                    <Lock size={14} className="text-text-muted opacity-50" />
                  </label>
                  <input
                    type="text"
                    readOnly
                    className={`w-full px-4 py-2.5 rounded-lg text-sm outline-none transition-all shadow-sm cursor-not-allowed opacity-80 ${
                      theme === 'light' ? 'bg-gray-100 border-gray-300 text-gray-500' : 
                      'bg-white/5 border-border-main text-text-muted'
                    }`}
                    value={translation.title}
                    placeholder={isGerman ? "Modul-Titel" : "Module Title"}
                  />
                </div>

                {/* Tags field */}
                <div className="space-y-2">
                  <label className="text-sm font-semibold text-text-main">{isGerman ? 'Such-Tags' : isJapanese ? '検索タグ' : isChinese ? '搜索标签' : 'Search Tags'}</label>
                  <TagInput
                    value={translation.tags}
                    onChange={val => setTranslation({ ...translation, tags: val })}
                    isGerman={isGerman}
                    placeholder={isGerman ? "z.B. Kalender, Veranstaltung, SEO..." : "e.g. calendar, event, seo..."}
                  />
                </div>

                {/* Summary field */}
                <div className="space-y-2">
                  <div className="flex justify-between items-center">
                    <label className="text-sm font-semibold text-text-main">{isGerman ? 'Zusammenfassung' : isJapanese ? '要約' : isChinese ? '摘要' : 'Summary'}</label>
                    <button 
                      onClick={() => setShowSummaryHtml(!showSummaryHtml)}
                      className={`text-[10px] font-bold uppercase tracking-widest px-2 py-1 rounded transition-all border ${
                        showSummaryHtml ? 'bg-brand-600 text-white border-brand-600' : 'bg-bg-input border-border-main text-text-muted'
                      }`}
                    >
                      {showSummaryHtml ? 'Visual' : 'HTML'}
                    </button>
                  </div>
                  {showSummaryHtml ? (
                    <textarea
                      className={`w-full h-32 px-4 py-3 font-mono text-xs rounded-lg border outline-none transition-all ${
                        theme === 'light' ? 'bg-gray-50 border-gray-200 text-gray-900' : 'bg-bg-input border-border-main text-brand-300'
                      }`}
                      value={translation.summary}
                      onChange={e => setTranslation({ ...translation, summary: e.target.value })}
                    />
                  ) : (
                    <div className="ck-editor-wrapper prose-sm shadow-sm themed-ckeditor">
                      <CKEditor
                        editor={ClassicEditor}
                        data={translation.summary}
                        config={{ toolbar: ['bold', 'italic', 'link'], placeholder: isGerman ? "Übersetze die Zusammenfassung..." : isJapanese ? "要約を翻訳..." : isChinese ? "翻译摘要..." : "Translate the summary..." }}
                        onChange={(event, editor) => setTranslation({ ...translation, summary: editor.getData() })}
                      />
                    </div>
                  )}
                </div>

                {/* Body field */}
                <div className="space-y-2">
                  <div className="flex justify-between items-center">
                    <label className="text-sm font-semibold text-text-main">{isGerman ? 'Hauptbeschreibung' : isJapanese ? 'メインの説明' : isChinese ? '正文描述' : 'Main Body'}</label>
                    <button 
                      onClick={() => setShowBodyHtml(!showBodyHtml)}
                      className={`text-[10px] font-bold uppercase tracking-widest px-2 py-1 rounded transition-all border ${
                        showBodyHtml ? 'bg-brand-600 text-white border-brand-600' : 'bg-bg-input border-border-main text-text-muted'
                      }`}
                    >
                      {showBodyHtml ? 'Visual' : 'HTML'}
                    </button>
                  </div>
                  {showBodyHtml ? (
                    <textarea
                      className={`w-full h-[500px] px-4 py-3 font-mono text-xs rounded-lg border outline-none transition-all ${
                        theme === 'light' ? 'bg-gray-50 border-gray-200 text-gray-900' : 'bg-bg-input border-border-main text-brand-300'
                      }`}
                      value={translation.body}
                      onChange={e => setTranslation({ ...translation, body: e.target.value })}
                    />
                  ) : (
                    <div className="ck-editor-wrapper prose-sm shadow-sm themed-ckeditor">
                      <CKEditor
                        editor={ClassicEditor}
                        data={translation.body}
                        config={{ toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', 'undo', 'redo'], placeholder: isGerman ? "Übersetze die Beschreibung..." : isJapanese ? "説明を翻訳..." : isChinese ? "翻译描述..." : "Translate the description..." }}
                        onChange={(event, editor) => setTranslation({ ...translation, body: editor.getData() })}
                      />
                    </div>
                  )}
                </div>

                {/* Screenshot Alt Texts */}
                {project.meta?.screenshot_urls && project.meta.screenshot_urls.length > 0 && (
                  <div className={`pt-8 border-t space-y-6 ${theme === 'light' ? 'border-gray-100' : 'border-white/10'}`}>
                    <h4 className={`text-sm font-bold ${theme === 'light' ? 'text-gray-900' : 'text-white'}`}>{isGerman ? 'Screenshot Alt-Texte' : isJapanese ? 'スクリーンショットの代替テキスト' : isChinese ? '屏幕截图替代文本' : 'Screenshot Alt Texts'}</h4>
                    <div className="space-y-4">
                      {project.meta.screenshot_urls.map(img => (
                        <div key={img.id} className="space-y-2">
                          <label className={`text-[10px] font-bold uppercase tracking-wider ${theme === 'light' ? 'text-gray-400' : 'text-text-muted'}`}>
                            ID: {img.id.split('-')[0]}
                          </label>
                          <input
                            type="text"
                            className="w-full px-4 py-2 rounded-lg text-sm focus:ring-4 outline-none transition-all bg-bg-input border-border-main text-white focus:ring-brand-500/20 focus:border-brand-500"
                            value={translation.screenshot_alts[img.id] || ''}
                            onChange={e => setTranslation({
                              ...translation,
                              screenshot_alts: { ...translation.screenshot_alts, [img.id]: e.target.value }
                            })}
                            placeholder={isGerman ? "Übersetzter Alt-Text..." : isJapanese ? "翻訳された代替テキスト..." : isChinese ? "已翻译的替代文本..." : "Translated Alt text..."}
                          />
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
      <BulkAiModal 
        isOpen={aiModal.open} 
        onClose={() => {
          if (aiModal.phase === 'translating') {
            isCancelledRef.current = true;
            return;
          }
          const finalPhase = aiModal.phase;
          setAiModal(prev => ({ ...prev, open: false }));
          if (finalPhase === 'finished') {
            navigate('/');
          }
        }} 
        results={aiModal.results} 
        progress={aiModal.progress} 
        total={aiModal.total} 
        isGerman={isGerman} 
        phase={aiModal.phase}
        estimation={aiModal.estimation}
        onConfirm={aiModal.onConfirm}
      />
    </div>
  );
};

export default Editor;
