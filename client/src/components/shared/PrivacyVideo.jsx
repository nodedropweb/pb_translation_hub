import React, { useState, useContext } from 'react';
import { MediaPlayer, MediaProvider } from '@vidstack/react';
import { defaultLayoutIcons, DefaultVideoLayout } from '@vidstack/react/player/layouts/default';
import '@vidstack/react/player/styles/default/theme.css';
import '@vidstack/react/player/styles/default/layouts/video.css';
import { XCircle, Play, Info, X } from 'lucide-react';
import { LanguageContext } from '../../context/LanguageContext';

/**
 * @file PrivacyVideo.jsx
 * A GDPR-compliant video embed using Vidstack for high performance.
 */
const PrivacyVideo = ({ youtubeId, theme }) => {
  const [load, setLoad] = useState(false);
  const [showDetails, setShowDetails] = useState(false);
  const { targetLanguage } = useContext(LanguageContext);
  const lang = targetLanguage?.code || 'en';

  if (load) {
    return (
      <div className="absolute inset-0 bg-black flex items-center justify-center">
        <MediaPlayer 
          title="PB Translation Hub Tutorial" 
          src={`youtube/${youtubeId}`}
          className="w-full h-full"
          autoplay
        >
          <MediaProvider />
          <DefaultVideoLayout 
            icons={defaultLayoutIcons} 
            noModal
          />
        </MediaPlayer>
      </div>
    );
  }

  const getNotice = () => {
    if (lang === 'de') {
      return (
        <div className="space-y-3">
          <p>
            <strong>Kategorien: Datenschutz und Tracking</strong><br/>
            Dieses Video wird von YouTube LLC bereitgestellt. Beim Laden werden Scripte ausgeführt, die personenbezogene Daten an Google (USA) übertragen. 
            Dies umfasst Cookies, LocalStorage und Tracker (z.B. DoubleClick), auch bei Verwendung der <em>youtube-nocookie.com</em> Domain.
          </p>
          <p className="italic opacity-80 text-[10px]">
            Gemäß Art. 44 DSGVO und § 25 TDDDG ist hierfür Ihre ausdrückliche Einwilligung erforderlich, 
            da YouTube-Nutzungsbedingungen Datentransfers in Drittstaaten vorsehen.
          </p>
        </div>
      );
    }
    if (lang === 'fr') {
      return (
        <div className="space-y-3">
          <p>
            <strong>Catégories : Confidentialité et Traçage</strong><br/>
            Cette vidéo est fournie par YouTube LLC. Le chargement exécute des scripts qui transmettent des données personnelles à Google (USA).
            Cela inclut les cookies, le LocalStorage et les traceurs (ex: DoubleClick), même via le domaine <em>youtube-nocookie.com</em>.
          </p>
          <p className="italic opacity-80 text-[10px]">
            Conformément à l'Art. 44 du RGPD, votre consentement explicite est requis car les conditions de YouTube prévoient des transferts vers des pays tiers.
          </p>
        </div>
      );
    }
    if (lang.startsWith('pt')) {
      return (
        <div className="space-y-3">
          <p>
            <strong>Categorias: Proteção de Dados e Rastreamento</strong><br/>
            Este vídeo é fornecido pelo YouTube LLC. Ao carregar, scripts são executados e transmitem dados pessoais ao Google (EUA). 
            Isso inclui cookies, LocalStorage e rastreadores (ex: DoubleClick), mesmo usando o domínio <em>youtube-nocookie.com</em>.
          </p>
          <p className="italic opacity-80 text-[10px]">
            De acordo com o Art. 44 do RGPD, seu consentimento explícito é necessário, pois os termos do YouTube preveem transferências de dados para países terceiros.
          </p>
        </div>
      );
    }
    if (lang === 'ja') {
      return (
        <div className="space-y-3">
          <p>
            <strong>カテゴリ：プライバシーとトラッキング</strong><br/>
            このビデオはYouTube LLCによって提供されています。読み込み時にスクリプトが実行され、個人データがGoogle（米国）に送信されます。
            これには、<em>youtube-nocookie.com</em>ドメインを使用している場合でも、Cookie、LocalStorage、およびトラッカー（例：DoubleClick）が含まれます。
          </p>
          <p className="italic opacity-80 text-[10px]">
            YouTubeの規約では第三国へのデータ転送が規定されているため、GDPR第44条に基づき、お客様の明示的な同意が必要です。
          </p>
        </div>
      );
    }
    if (lang === 'zh-hans') {
      return (
        <div className="space-y-3">
          <p>
            <strong>类别：隐私与追踪</strong><br/>
            此视频由 YouTube LLC 提供。加载时会执行脚本，将个人数据传输给 Google（美国）。
            这包括 Cookie、LocalStorage 和追踪器（如 DoubleClick），即使使用了 <em>youtube-nocookie.com</em> 域名也是如此。
          </p>
          <p className="italic opacity-80 text-[10px]">
            根据 GDPR 第 44 条，由于 YouTube 的条款涉及向第三方国家传输数据，因此需要您的明确同意。
          </p>
        </div>
      );
    }
    return (
      <p>
        By loading this video, you consent to the processing of personal data by YouTube and Google, including the use of cookies and data transfers to the USA (Art. 44 GDPR).
      </p>
    );
  };

  return (
    <div 
      className="absolute inset-0 overflow-hidden transition-all duration-700 flex flex-col items-center justify-center p-10 glass-blur border border-border-main shadow-2xl"
      style={{
        background: 'linear-gradient(135deg, var(--overlay-color) 0%, rgba(0,0,0,0.7) 100%)',
        textAlign: 'center'
      }}
    >
      <div className="absolute top-6 right-6 flex items-center gap-2 px-4 py-1.5 bg-black/60 rounded-full text-[10px] text-white/60 font-bold uppercase tracking-widest border border-white/10 shadow-lg">
        <XCircle size={14} className="text-brand-400" />
        {lang === 'de' ? 'Vorschau blockiert' : lang === 'fr' ? 'Aperçu bloqué' : lang.startsWith('pt') ? 'Visualização bloqueada' : lang === 'ja' ? 'プレビューがブロックされました' : lang === 'zh-hans' ? '预览已阻止' : 'Preview blocked'}
      </div>
      <div 
        onClick={() => setLoad(true)}
        className="play-button-overlay hover:scale-110 active:scale-95"
        style={{ 
          width: '80px', 
          height: '80px', 
          borderRadius: '50%', 
          background: 'rgba(255,255,255,0.1)', 
          backdropFilter: 'blur(8px)',
          display: 'flex', 
          alignItems: 'center', 
          justifyContent: 'center',
          marginBottom: '1.5rem',
          color: '#fff',
          cursor: 'pointer',
          transition: 'all 0.5s cubic-bezier(0.4, 0, 0.2, 1)',
          border: '2px solid rgba(255,255,255,0.3)',
          boxShadow: '0 0 30px rgba(127,86,217,0.3)'
        }}
      >
        <Play size={32} fill="white" style={{ marginLeft: '4px' }} />
      </div>
      <div className="max-w-xl mb-8 p-8 rounded-2xl border text-left text-[11px] leading-relaxed transition-all duration-500 bg-bg-card border-border-main text-text-muted shadow-2xl glass-blur">
        <h4 className="text-white font-bold mb-3 flex items-center gap-2 text-sm">
          <Info size={16} className="text-brand-400" />
          {lang === 'de' ? 'Datenschutz & Einwilligung' : lang === 'fr' ? 'Confidentialité & Consentement' : lang.startsWith('pt') ? 'Privacidade e Consentimento' : lang === 'ja' ? 'プライバシーと同意' : lang === 'zh-hans' ? '隐私与同意' : 'Privacy & Consent'}
        </h4>
        
        {getNotice()}

        <div className="flex flex-col sm:flex-row items-start sm:items-center gap-4 mt-6 pt-4 border-t border-white/5">
          <span className="opacity-70 text-[10px]">Policy: <a href="https://www.google.com/about/company/user-consent-policy/" target="_blank" className="text-brand-400 underline hover:text-brand-300 font-bold">Google Policy</a></span>
          <button 
            onClick={() => setShowDetails(true)}
            className="flex items-center gap-2 px-5 py-2.5 text-white rounded-xl font-black text-[11px] transition-all hover:scale-105 active:scale-95 bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/20"
          >
            <Info size={14} />
            {lang === 'de' ? 'MEHR INFORMATIONEN' : lang === 'fr' ? 'PLUS D\'INFORMATIONS' : lang.startsWith('pt') ? 'MOSTRAR MAIS INFORMAÇÕES' : lang === 'ja' ? '詳細情報' : lang === 'zh-hans' ? '更多信息' : 'MORE INFORMATION'}
          </button>
        </div>
      </div>

      {showDetails && (
        <div 
          className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-10 bg-black/40 backdrop-blur-sm animate-fade cursor-default"
          onClick={() => setShowDetails(false)}
        >
          <div 
            className="w-full max-w-4xl max-h-full flex flex-col rounded-[2.5rem] border shadow-2xl overflow-hidden transition-all duration-500 bg-bg-card border-border-main text-text-main shadow-[0_0_50px_rgba(0,0,0,0.5)] glass-blur"
            onClick={e => e.stopPropagation()}
          >
            <div className="px-8 py-6 flex justify-between items-center border-b border-border-main bg-bg-sidebar">
              <h3 className="text-2xl font-bold flex items-center gap-3">
                <Info className="text-brand-500 animate-pulse" size={28} />
                {lang === 'de' ? 'YouTube Datenschutz' : lang === 'fr' ? 'Confidentialité YouTube' : lang.startsWith('pt') ? 'Privacidade do YouTube' : lang === 'ja' ? 'YouTubeのプライバシー' : lang === 'zh-hans' ? 'YouTube 隐私' : 'YouTube Privacy'}
              </h3>
              <button 
                onClick={() => setShowDetails(false)} 
                className="p-2.5 rounded-full transition-all hover:bg-white/10 bg-white/5"
              >
                <X size={28} />
              </button>
            </div>
            
            <div className="flex-1 overflow-y-auto p-10 space-y-8 text-left custom-scrollbar">
              <div className="space-y-10 text-base leading-relaxed opacity-90 max-w-3xl">
                <section className="group">
                  <h4 className="font-bold text-xl mb-4 text-brand-400 flex items-center gap-2">
                    <span className="w-1.5 h-6 bg-brand-500 rounded-full inline-block group-hover:scale-y-125 transition-transform"></span>
                    {lang === 'de' ? 'Rechtsgrundlage & Zweck' : lang === 'fr' ? 'Base légale & Objectif' : lang.startsWith('pt') ? 'Base Legal e Propósito' : lang === 'ja' ? '法的根拠と目的' : lang === 'zh-hans' ? '法律依据与目的' : 'Legal Basis & Purpose'}
                  </h4>
                  <p>
                    {lang === 'de' ? (
                      'Die Einbettung erfolgt auf Grundlage Ihrer Einwilligung (Art. 6 Abs. 1 lit. a DSGVO). Zweck ist die Bereitstellung von anschaulichem Hilfematerial direkt in der Anwendung.'
                    ) : lang === 'fr' ? (
                      'L\'intégration se fait sur la base de votre consentement (Art. 6 par. 1 lit. a du RGPD). L\'objectif est de fournir du matériel d\'aide directement dans l\'application.'
                    ) : lang.startsWith('pt') ? (
                      'A incorporação é baseada no seu consentimento (Art. 6 Par. 1 lit. a do RGPD). O objetivo é fornecer material de ajuda ilustrativo diretamente na aplicação.'
                    ) : lang === 'ja' ? (
                      '埋め込みは、お客様の同意（GDPR第6条第1項a号）に基づいています。目的は、アプリケーション内で直接わかりやすいヘルプ資料を提供することです。'
                    ) : lang === 'zh-hans' ? (
                      '嵌入基于您的同意（GDPR 第 6 条第 1 款 a 项）。目的是直接在应用程序中提供说明性的帮助材料。'
                    ) : (
                      'The embedding is based on your consent (Art. 6 Para. 1 lit. a GDPR). The purpose is to provide illustrative help material directly in the application.'
                    )}
                  </p>
                </section>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default PrivacyVideo;
