import React, { useContext } from 'react';
import { 
  HelpCircle, 
  Layers, 
  Globe, 
  Layout, 
  MessageSquare, 
  Info 
} from 'lucide-react';

// Contexts
import { ThemeContext } from '../context/ThemeContext';
import { LanguageContext } from '../context/LanguageContext';

// Components
import PrivacyVideo from '../components/shared/PrivacyVideo';

/**
 * @file HelpView.jsx
 * Documentation and help center for the Translation Hub.
 * Supports DE, EN, FR, PT (BR/PT), JA, and ZH-HANS.
 */
const HelpView = ({ isModal = false }) => {
  const { theme } = useContext(ThemeContext);
  const { targetLanguage } = useContext(LanguageContext);
  
  const lang = targetLanguage?.code || 'en';
  const isGerman = lang === 'de';
  const isFrench = lang === 'fr';
  const isPortuguese = lang.startsWith('pt');
  const isPtPt = lang === 'pt-pt';
  const isJapanese = lang === 'ja';
  const isChinese = lang === 'zh-hans';

  return (
    <div className={`${isModal ? 'p-8 md:p-12' : 'p-12'} space-y-16 animate-fade max-w-7xl mx-auto`}>
      {/* Header Panel */}
      <div className={`p-12 rounded-[3rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl flex flex-col items-center text-center`}>
        <div className="w-20 h-20 rounded-[2rem] bg-brand-600 flex items-center justify-center text-white mb-6 shadow-2xl shadow-brand-600/30">
          <HelpCircle size={40} />
        </div>
        <h1 className="text-5xl font-black tracking-tight text-text-main drop-shadow-sm">
          {isGerman ? 'Hilfe & Dokumentation' : isFrench ? 'Aide & Documentation' : isPortuguese ? 'Ajuda e Documentação' : isJapanese ? 'ヘルプとドキュメント' : isChinese ? '帮助与文档' : 'Help & Documentation'}
        </h1>
        <p className="text-text-muted mt-4 text-xl max-w-2xl leading-relaxed">
          {isGerman 
            ? 'Hier erfährst du, was das PB Translation Hub ist und warum wir die Beschreibungen der Projekte im Drupal Project Browser unbedingt übersetzen sollten.' 
            : isFrench
            ? 'Découvrez ce qu\'est le PB Translation Hub et pourquoi il est essentiel de traduire les descriptions des projets dans le Drupal Project Browser.'
            : isPortuguese
            ? 'Saiba o que é o PB Translation Hub e por que é essencial traduzir as descrições dos projetos no Drupal Project Browser.'
            : isJapanese
            ? 'PB Translation Hubとは何か、そしてなぜDrupal Project Browserのプロジェクト説明を翻訳することが不可欠なのかを学びましょう。'
            : isChinese
            ? '了解什么是 PB Translation Hub，以及为什么翻译 Drupal Project Browser 中的项目描述至关重要。'
            : 'Learn what the PB Translation Hub is and why it is essential to translate project descriptions in the Drupal Project Browser.'}
        </p>
      </div>

      {/* Philosophy Panel */}
      <div className={`p-12 rounded-[3rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl flex flex-col lg:flex-row gap-12 items-center`}>
        <div className="lg:w-1/3">
           <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-brand-500/10 border border-brand-500/20 text-brand-500 text-[10px] font-black uppercase tracking-widest mb-6">
             <Globe size={14} />
             {isGerman ? 'Unsere Mission' : isFrench ? 'Notre Mission' : isPortuguese ? 'Nossa Missão' : isJapanese ? '私たちの使命' : isChinese ? '我们的使命' : 'Our Mission'}
           </div>
           <h2 className="text-4xl font-black text-text-main leading-tight mb-4 italic">
             {isGerman ? '"Sprache ist Vertrauen"' : isFrench ? '"La langue est une question de confiance"' : isPortuguese ? '"Linguagem é Confiança"' : isJapanese ? '「言語は信頼である」' : isChinese ? '“语言即信任”' : '"Language is Trust"'}
           </h2>
           <p className="text-text-muted text-lg leading-relaxed">
             {isGerman 
               ? 'Warum wir tun, was wir tun: Simon Sineks "Why" für den Translation Hub.' 
               : isFrench
               ? 'Pourquoi nous faisons ce que nous faisons : le "Why" de Simon Sinek pour le Hub.'
               : isPortuguese
               ? 'Por que fazemos o que fazemos: O "Why" de Simon Sinek para o Translation Hub.'
               : isJapanese
               ? '私たちがこれを行う理由：Translation Hubのためのサイモン・シネックの「Why」。'
               : isChinese
               ? '我们为什么这么做：西蒙·斯涅克为翻译中心提出的“为什么”。'
               : 'Why we do what we do: Simon Sinek\'s "Why" for the Translation Hub.'}
           </p>
        </div>
        
        <div className="lg:w-2/3 space-y-8">
          <div className="text-text-main text-base leading-relaxed opacity-90">
            {isGerman ? (
              <>
                Stell dir vor, du stehst vor einem Regal voller Werkzeuge, aber alle Beschreibungen sind in einer Sprache verfasst, die du nur zur Hälfte verstehst. Würdest du diesem Werkzeug dein Projekt anvertrauen? 
                Genau dieses Szenario untersuchte die bahnbrechende Studie <strong>"Can't Read, Won't Buy"</strong>. Sie liefert den wissenschaftlichen Beweis dafür, dass Sprache nicht nur ein "Bonus" ist, sondern das Fundament für Vertrauen und Akzeptanz bildet. 
                Die Studie befragte tausende Nutzer in globalen Schlüsselmärkten:
              </>
            ) : isFrench ? (
              <>
                Imaginez-vous devant une étagère remplie d'outils, aber toutes les descriptions sont écrites dans une langue que vous ne comprenez qu'à moitié. Confieriez-vous votre projet à cet outil ? 
                C'est précisément le scénario exploré par l'étude révolutionnaire <strong>"Can't Read, Won't Buy"</strong>. Elle apporte la preuve scientifique que la langue n'est pas un simple "bonus", mais le fondement même de la confiance et de l'adoption. 
                L'étude a interrogé des milliers d'utilisateurs sur les principaux marchés mondiaux :
              </>
            ) : isPortuguese ? (
              <>
                Imagine estar diante de uma prateleira cheia de ferramentas, mas todas as descrições estão em um idioma que você entende apenas pela metade. Você confiaria seu projeto a essa ferramenta? 
                Este é exatamente o cenário explorado pelo estudo inovador <strong>"Can't Read, Won't Buy"</strong>. Ele fornece a prova científica de que o idioma não é apenas um "bônus", mas a base fundamental para a confiança e a adoção. 
                O estudo entrevistou milhares de usuários em mercados globais estratégicos:
              </>
            ) : isJapanese ? (
              <>
                棚に並んだたくさんのツールを想像してみてください。しかし、その説明書はすべて、あなたが半分しか理解できない言語で書かれています。あなたはそのツールに自分のプロジェクトを任せますか？ 
                これこそが、画期的な研究<strong>「Can't Read, Won't Buy」</strong>が調査したシナリオです。この研究は、言語が単なる「ボーナス」ではなく、信頼と採用の根幹であることを科学的に証明しています。 
                この調査は、主要なグローバル市場の数千人のユーザーを対象に行われました：
              </>
            ) : isChinese ? (
              <>
                想象一下，你站在一个摆满工具 craving 的货架前，但所有的说明书都是用你只懂一半的语言编写的。你会把你的项目托付给这些工具吗？ 
                这正是开创性研究 <strong>“Can't Read, Won't Buy”</strong> 所探讨的情景。它提供了科学证据，证明语言不仅仅是一个“加分项”，而是信任和采用的基石。 
                该研究调查了全球主要市场的数千名用户：
              </>
            ) : (
              <>
                Imagine standing in front of a shelf full of tools, but all the descriptions are written in a language you only half-understand. Would you trust these tools with your project? 
                This is exactly the scenario explored by the groundbreaking study <strong>"Can't Read, Won't Buy"</strong>. It provides scientific proof that language isn't just a "bonus"—it's the very foundation of trust and adoption. 
                The study surveyed thousands of users across major global markets:
              </>
            )}
          </div>

          <div className="flex flex-wrap gap-3">
            {[
              { code: 'de', name: { de: 'Deutschland', en: 'Germany', fr: 'Allemagne', pt: 'Alemanha', ja: 'ドイツ', zh: '德国' } },
              { code: 'fr', name: { de: 'Frankreich', en: 'France', fr: 'France', pt: 'França', ja: 'フランス', zh: '法国' } },
              { code: 'jp', name: { de: 'Japan', en: 'Japan', fr: 'Japon', pt: 'Japão', ja: '日本', zh: '日本' } },
              { code: 'br', name: { de: 'Brasilien', en: 'Brazil', fr: 'Brésil', pt: 'Brasil', ja: 'ブラジル', zh: '巴西' } },
              { code: 'cn', name: { de: 'China', en: 'China', fr: 'Chine', pt: 'China', ja: '中国', zh: '中国' } }
            ].map((c, i) => (
              <div key={i} className="flex items-center gap-2 px-3 py-1.5 rounded-xl bg-white/5 border border-white/10 text-xs font-bold text-text-main shadow-sm hover:bg-white/10 transition-all">
                <img 
                  src={`/flags/${c.code}.png`} 
                  alt={c.code}
                  className="w-6 h-auto rounded-sm shadow-sm"
                />
                <span>{c.name[lang] || (isPortuguese ? c.name.pt : isJapanese ? c.name.ja : isChinese ? c.name.zh : c.name.en)}</span>
              </div>
            ))}
          </div>

          <div className="text-text-muted text-sm leading-relaxed">
            {isGerman ? (
              <>
                Dies gilt besonders für den <strong>Project Browser</strong>, der direkt in Drupal integriert ist und als primäres Tor für neue Nutzer dient.
              </>
            ) : isFrench ? (
              <>
                C'est particulièrement vrai pour le <strong>Project Browser</strong>, qui vit à l'intérieur du site Drupal et sert de passerelle principale.
              </>
            ) : isPortuguese ? (
              <>
                Isso é especialmente verdade para o <strong>Project Browser</strong>, que vive dentro do site Drupal e serve como a principal porta de entrada para novos usuários explorarem o ecossistema.
              </>
            ) : isJapanese ? (
              <>
                これは、Drupalサイト内にあり、新しいユーザーがエコシステムを探索するための主要なゲートウェイとして機能する<strong>Project Browser</strong>において特に当てはまります。
              </>
            ) : isChinese ? (
              <>
                对于位于 Drupal 站点内部、作为新用户探索生态系统主要入口的 <strong>Project Browser</strong> 来说，这一点尤为真实。
              </>
            ) : (
              <>
                This is especially true for the <strong>Project Browser</strong>, which lives inside the Drupal site and serves as the primary gateway for new users to explore the ecosystem.
              </>
            )}
          </div>
          
          <div className="flex flex-wrap gap-4 items-center">
            <a 
              href="https://motsdici.be/wp-content/uploads/2019/04/Article-cant-read-wont-buy.pdf" 
              target="_blank" 
              rel="noopener noreferrer"
              className="text-xs font-bold text-brand-400 hover:text-brand-300 underline flex items-center gap-1.5"
            >
              <Info size={14} />
              {isGerman ? 'Originalstudie lesen (PDF)' : isFrench ? 'Lire l\'étude originale (PDF)' : isPortuguese ? 'Ler estudo original (PDF)' : isJapanese ? '元の研究を読む (PDF)' : isChinese ? '阅读原研究报告 (PDF)' : 'Read original study (PDF)'}
            </a>
          </div>
          
          <div className="grid grid-cols-1 gap-6">
             {[
               { 
                 val: '72.4%', 
                 label: { de: 'Präferenz (Komfortzone)', en: 'Preference (Comfort Zone)', fr: 'Préférence (Zone de confort)', pt: 'Preferência (Zona de Conforto)', ja: '嗜好（コンフォートゾーン）', zh: '偏好（舒适区）' },
                 desc: { 
                   de: 'Fast drei Viertel der Site-Builder bevorzugen Module in ihrer Sprache. Es fühlt sich sicherer und vertrauter an.',
                   en: 'Nearly three-quarters of site builders instinctively prefer modules with descriptions in their native language.',
                   fr: 'Près des trois quarts des créateurs de sites préfèrent instinctivement les modules avec des descriptions locales.',
                   pt: 'Quase três quartos dos site-builders preferem instintivamente módulos com descrições em seu idioma nativo.',
                   ja: 'サイト構築者の約4分の3が、本能的に母国語で説明されているモジュールを好みます。',
                   zh: '近四分之三的网站建设者本能地更喜欢具有母语描述的模块。'
                 }
               },
               { 
                 val: '52.4%', 
                 label: { de: 'Notwendigkeit (Die harte Grenze)', en: 'Necessity (The Hard Boundary)', fr: 'Nécessité (La limite stricte)', pt: 'Necessidade (A Fronteira Rígida)', ja: '必要性（超えられない壁）', zh: '必要性（硬性界限）' },
                 desc: { 
                   de: 'Über die Hälfte der Nutzer ignoriert ein Modul komplett, wenn die Beschreibung nur auf Englisch ist.',
                   en: 'Over half of global users won\'t even consider a module if it is presented exclusively in English.',
                   fr: 'Plus de la moitié des utilisateurs n\'envisagent même pas un module s\'il est exclusivement en anglais.',
                   pt: 'Mais da metade dos usuários globais nem sequer consideraria um módulo se ele for apresentado exclusivamente em inglês.',
                   ja: '世界のユーザーの半数以上は、英語だけで提供されているモジュールを検討すらしないでしょう。',
                   zh: '如果模块仅以英文呈现，超过一半的全球用户甚至不会考虑该模块。'
                 }
               },
               { 
                 val: '67%', 
                 label: { de: 'Vertrauen & Qualität', en: 'Trust & Quality', fr: 'Confiance & Qualité', pt: 'Confiança e Qualidade', ja: '信頼と品質', zh: '信任与质量' },
                 desc: { 
                   de: 'Sprache entscheidet über Vertrauen. Eine professionelle deutsche Präsentation wird mit Sorgfalt im Code assoziiert.',
                   en: 'Language determines trust. A professional localized presentation is associated with code quality.',
                   fr: 'La langue décide de la confiance. Une présentation locale professionnelle est associée à la qualité du code.',
                   pt: 'O idioma determina a confiança. Uma apresentação profissional localizada é associada à qualidade do código.',
                   ja: '言語が信頼を決定します。プロフェッショナルなローカライズ表現は、コードの品質と結び付けられます。',
                   zh: '语言决定信任。专业的本地化演示与代码质量息息相关。'
                 }
               },
               { 
                 val: '56.2%', 
                 label: { de: 'Sprache vor Features', en: 'Language over Features', fr: 'Langue avant les fonctionnalités', pt: 'Idioma acima de Recursos', ja: '機能より言語', zh: '语言优于功能' },
                 desc: { 
                   de: '„Preis“ bedeutet bei Drupal Zeit und Overhead. Über die Hälfte der Nutzer wählt lieber ein Modul mit weniger Features, solange sie das Interface zu 100% verstehen.',
                   en: '"Price" in Drupal means time and overhead. Over half of users prefer a module with fewer features, as long as they 100% understand the interface.',
                   fr: 'Le "prix" dans Drupal signifie temps et charge mentale. Plus de la moitié des utilisateurs préfèrent un module avec moins de fonctions, tant qu\'ils comprennent l\'interface à 100 %.',
                   pt: 'O "preço" no Drupal significa tempo e esforço técnico. Mais da metade dos usuários prefere um módulo com menos recursos, desde que entendam 100% da interface.',
                   ja: 'Drupalにおける「価格」とは、時間とオーバーヘッドを意味します。半数以上のユーザーは、インターフェースを100%理解できるのであれば、機能が少ないモジュールの方を好みます。',
                   zh: 'Drupal 中的“价格”意味着时间和开销。只要能 100% 理解界面，超过一半的用户更愿意选择功能较少的模块。'
                 }
               }
             ].map((stat, i) => (
               <div key={i} className="p-6 rounded-2xl bg-white/5 border border-white/10 hover:border-brand-500/30 transition-all group">
                 <div className="flex flex-col md:flex-row md:items-center gap-6">
                   <div className="text-3xl font-black text-brand-500 min-w-[180px] group-hover:scale-105 transition-transform origin-left">{stat.val}</div>
                   <div className="flex-1">
                     <div className="text-sm font-bold text-text-main uppercase tracking-widest mb-2">
                       {stat.label[lang] || (isPortuguese ? stat.label.pt : isJapanese ? stat.label.ja : isChinese ? stat.label.zh : stat.label.en)}
                     </div>
                     <div className="text-sm text-text-muted leading-relaxed">
                       {stat.desc[lang] || (isPortuguese ? stat.desc.pt : isJapanese ? stat.desc.ja : isChinese ? stat.desc.zh : stat.desc.en)}
                     </div>
                   </div>
                 </div>
               </div>
             ))}
          </div>

          <div className="mt-12 overflow-hidden rounded-3xl border border-white/10 bg-black/20">
             <table className="w-full text-left text-sm border-collapse">
               <thead className="bg-white/5 text-text-main font-bold uppercase tracking-widest text-[10px]">
                 <tr>
                   <th className="p-4 border-b border-white/10">{isGerman ? 'Metrik' : isFrench ? 'Métrique' : isPortuguese ? 'Métrica' : isJapanese ? '指標' : isChinese ? '指标' : 'Metric'}</th>
                   <th className="p-4 border-b border-white/10">{isGerman ? 'Drupal-Äquivalent' : isFrench ? 'Équivalent Drupal' : isPortuguese ? 'Equivalente Drupal' : isJapanese ? 'Drupalにおける対応' : isChinese ? 'Drupal 等效' : 'Drupal Equivalent'}</th>
                   <th className="p-4 border-b border-white/10">{isGerman ? 'Strategie' : isFrench ? 'Stratégie' : isPortuguese ? 'Estratégia' : isJapanese ? '戦略' : isChinese ? '策略' : 'Strategy'}</th>
                 </tr>
               </thead>
               <tbody className="text-text-muted">
                 <tr className="border-b border-white/5 hover:bg-white/5 transition-colors">
                   <td className="p-4 font-bold text-brand-400 text-base">72.4%</td>
                   <td className="p-4 text-text-main">{isGerman ? 'Sichtbarkeit' : isFrench ? 'Visibilité' : isPortuguese ? 'Visibilidade' : isJapanese ? '可視性' : isChinese ? '可见性' : 'Visibility'}</td>
                   <td className="p-4">{isGerman ? 'Modul-Summaries in Top-Sprachen' : isFrench ? 'Résumés dans les langues clés' : isPortuguese ? 'Resumos de módulos nos principais idiomas' : isJapanese ? '主要言語でのモジュール概要' : isChinese ? '热门语言的模块摘要' : 'Module summaries in top languages'}</td>
                 </tr>
                 <tr className="border-b border-white/5 hover:bg-white/5 transition-colors">
                   <td className="p-4 font-bold text-brand-400 text-base">67%</td>
                   <td className="p-4 text-text-main">{isGerman ? 'Vertrauen' : isFrench ? 'Confiance' : isPortuguese ? 'Confiança' : isJapanese ? '信頼' : isChinese ? '信任' : 'Trust'}</td>
                   <td className="p-4">{isGerman ? 'Klare Erklärungen zur Security' : isFrench ? 'Explications claires sur la sécurité' : isPortuguese ? 'Explicações claras sobre segurança' : isJapanese ? 'セキュリティと権限の明確な説明' : isChinese ? '明确的安全与权限说明' : 'Clear security & permissions explanations'}</td>
                 </tr>
                 <tr className="hover:bg-white/5 transition-colors">
                   <td className="p-4 font-bold text-brand-400 text-base">56.2%</td>
                   <td className="p-4 text-text-main">{isGerman ? 'Usability' : isFrench ? 'Utilisabilité' : isPortuguese ? 'Usabilidade' : isJapanese ? 'ユーザビリティ' : isChinese ? '可用性' : 'Usability'}</td>
                   <td className="p-4">{isGerman ? 'UI-Übersetzung schlägt Feature-Bloat' : isFrench ? 'L\'UI traduite bat le feature-bloat' : isPortuguese ? 'Tradução da UI supera excesso de recursos' : isJapanese ? 'UI翻訳は機能の肥大化に勝る' : isChinese ? 'UI 翻译胜过功能膨胀' : 'UI translation beats feature bloat'}</td>
                 </tr>
               </tbody>
             </table>
          </div>
          
          <div className="pt-6 border-t border-white/5 text-sm italic text-brand-400">
             {isGerman 
               ? 'Durch die Lokalisierung bauen wir Vertrauen auf und entfernen die "English-only" Barriere für die nächste Generation.' 
               : isFrench
               ? 'En localisant, nous instaurons la confiance et supprimons la barrière "English-only" pour la prochaine génération.'
               : isPortuguese
               ? 'Ao localizar, estamos construindo confiança e removendo a barreira "apenas inglês" para a próxima geração.'
               : isJapanese
               ? 'ローカライズすることで信頼を築き、次世代のために「英語のみ」の壁を取り除きます。'
               : isChinese
               ? '通过本地化，我们正在建立信任，并为下一代消除“仅限英文”的障碍。'
               : 'By localizing, we are building trust and removing the "English-only" barrier for the next generation.'}
          </div>
        </div>
      </div>

      {/* Keyboard Shortcuts Large Panel */}
      <div className={`p-12 rounded-[3rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl`}>
        <div className="flex flex-col md:flex-row gap-12 items-center">
          <div className="flex-1">
            <div className="w-16 h-16 rounded-2xl bg-brand-500/20 flex items-center justify-center text-brand-500 mb-6 shadow-lg shadow-brand-500/10">
              <Layout size={32} />
            </div>
            <h2 className="text-3xl font-black mb-4 text-text-main">
              {isGerman ? 'Produktivitäts-Shortcuts' : isFrench ? 'Raccourcis de productivité' : isPortuguese ? 'Atalhos de Produtividade' : isJapanese ? '生産性向上のためのショートカット' : isChinese ? '生产力快捷键' : 'Productivity Shortcuts'}
            </h2>
            <p className="text-text-muted text-lg leading-relaxed">
              {isGerman 
                ? 'Nutze diese Tastenkombinationen, um deine Übersetzungsgeschwindigkeit zu maximieren. Alle Shortcuts verwenden STRG + ALT, um Konflikte mit deinem Browser zu vermeiden.' 
                : isFrench
                ? 'Utilisez ces raccourcis clavier pour maximiser votre vitesse de traduction. Tous les raccourcis utilisent CTRL + ALT pour éviter les conflits avec votre navigateur.'
                : isPortuguese
                ? 'Use estes atalhos de teclado para maximizar sua velocidade de tradução. Todos os atalhos usam CTRL + ALT para evitar conflitos com seu navegador.'
                : isJapanese
                ? 'これらのキーボードショートカットを使用して、翻訳速度を最大限に高めます。ブラウザとの競合を避けるため、すべてのショートカットは CTRL + ALT を使用します。'
                : isChinese
                ? '使用这些键盘快捷键来最大化您的翻译速度。所有快捷键都使用 CTRL + ALT，以避免与您的浏览器发生冲突。'
                : 'Use these keyboard shortcuts to maximize your translation speed. All shortcuts use CTRL + ALT to avoid conflicts with your browser.'}
            </p>
          </div>
          <div className="flex-1 w-full max-w-md">
            <div className={`rounded-3xl p-6 border ${theme === 'light' ? 'bg-white/50 border-gray-100' : 'bg-black/20 border-white/5'}`}>
              <ul className="space-y-4">
                {[
                  { label: isGerman ? 'Speichern & Weiter' : isFrench ? 'Enregistrer et Suivant' : isPtPt ? 'Guardar e Próximo' : isPortuguese ? 'Salvar e Próximo' : isJapanese ? '保存して次へ' : isChinese ? '保存并下一步' : 'Save & Next', key: 'S' },
                  { label: isGerman ? 'Vorschau umschalten' : isFrench ? 'Basculer l\'aperçu' : isPortuguese ? 'Alternar Visualização' : isJapanese ? 'プレビューの切り替え' : isChinese ? '切换预览' : 'Toggle Preview', key: 'P' },
                  { label: isGerman ? 'KI-Prompt kopieren' : isFrench ? 'Copier le prompt IA' : isPortuguese ? 'Copiar Prompt da IA' : isJapanese ? 'AIプロンプトをコピー' : isChinese ? '复制 AI 提示词' : 'Copy AI Prompt', key: 'K' },
                  { label: isGerman ? 'Als HTML kopieren' : isFrench ? 'Copier en HTML' : isPortuguese ? 'Copiar como HTML' : isJapanese ? 'HTMLとしてコピー' : isChinese ? '复制为 HTML' : 'Copy as HTML', key: 'H' },
                  { label: isGerman ? 'Nächstes Projekt' : isFrench ? 'Projet suivant' : isPortuguese ? 'Próximo Projeto' : isJapanese ? '次のプロジェクト' : isChinese ? '下一个项目' : 'Next Project', key: 'D' },
                  { label: isGerman ? 'Auf Drupal.org öffnen' : isFrench ? 'Ouvrir sur Drupal.org' : isPortuguese ? 'Abrir no Drupal.org' : isJapanese ? 'Drupal.orgで開く' : isChinese ? '在 Drupal.org 上打开' : 'Open on Drupal.org', key: 'O' }
                ].map((item, i) => (
                  <li key={i} className="flex justify-between items-center group">
                    <span className="text-text-muted font-medium">{item.label}</span>
                    <div className="flex items-center gap-1">
                      <kbd className="bg-white/10 px-2 py-1 rounded border border-white/10 text-[10px] font-bold text-text-main shadow-sm">CTRL</kbd>
                      <span className="text-text-muted text-[10px]">+</span>
                      <kbd className="bg-white/10 px-2 py-1 rounded border border-white/10 text-[10px] font-bold text-text-main shadow-sm">ALT</kbd>
                      <span className="text-text-muted text-[10px]">+</span>
                      <kbd className="bg-brand-500/20 px-2 py-1 rounded border border-brand-500/30 text-[10px] font-bold text-brand-400 shadow-sm group-hover:bg-brand-500 group-hover:text-white transition-all">{item.key}</kbd>
                    </div>
                  </li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      </div>

      <div className={`rounded-[3rem] border transition-all glass-blur bg-bg-card border-border-main shadow-2xl overflow-hidden`}>
        <div className="grid grid-cols-1 lg:grid-cols-2">
          <div className="relative bg-black overflow-hidden min-h-[400px]">
             <PrivacyVideo youtubeId="SwIGkW8o_uE" theme={theme} />
          </div>
          <div className="p-16">
            <div className="flex items-center gap-3 mb-8">
              <span className="px-3 py-1 bg-brand-600 text-white text-[10px] font-black rounded-full uppercase tracking-widest">Tutorial</span>
              <span className="w-2 h-2 rounded-full bg-brand-500 animate-pulse"></span>
            </div>
            <h2 className="text-4xl font-black mb-6 text-text-main leading-tight">
              {isGerman ? 'Video-Anleitung: So funktionierts' : isFrench ? 'Tutoriel vidéo : Comment ça marche' : isPortuguese ? 'Tutorial em Vídeo: Como funciona' : isJapanese ? 'ビデオガイド：使い方' : isChinese ? '视频指南：如何运作' : 'Video Guide: How it works'}
            </h2>
            <p className="text-text-muted text-lg leading-relaxed mb-10">
              {isGerman 
                ? 'Schau dir an, wie du den Hub optimal nutzt, um Drupal 11 Module blitzschnell für den Project Browser zu lokalisieren.' 
                : isFrench
                ? 'Découvrez comment optimiser l\'utilisation du Hub pour localiser les modules Drupal 11 en un clin d\'œil pour le Project Browser.'
                : isPortuguese
                ? 'Veja como aproveitar ao máximo o hub para localizar módulos do Drupal 11 rapidamente para o Project Browser.'
                : isJapanese
                ? 'Hubを最適に使用して、Project Browser用にDrupal 11モジュールを瞬時にローカライズする方法をご覧ください。'
                : isChinese
                ? '观看如何以最佳方式使用 Hub，为 Project Browser 快速本地化 Drupal 11 模块。'
                : 'Watch how to optimally use the Hub to localize Drupal 11 modules for the Project Browser in no time.'}
            </p>
            <div className="space-y-4">
              {[
                { icon: Layers, text: isGerman ? 'Projekt-Listen-Filter effektiv nutzen' : isFrench ? 'Utiliser efficacement les filtres de la liste' : isPortuguese ? 'Usar filtros de lista de projetos de forma eficaz' : isJapanese ? 'プロジェクトリストフィルターの効果的な使用' : isChinese ? '有效使用项目列表过滤器' : 'Using project list filters effectively' },
                { icon: MessageSquare, text: isGerman ? 'KI-Übersetzungen verfeinern' : isFrench ? 'Affiner les traductions par IA' : isPortuguese ? 'Refinar traduções da IA' : isJapanese ? 'AI翻訳の微調整' : isChinese ? '完善 AI 翻译' : 'Refining AI translations' },
                { icon: Layout, text: isGerman ? 'Vorschau im Project Browser' : isFrench ? 'Aperçu dans le Project Browser' : isPortuguese ? 'Visualização no Project Browser' : isJapanese ? 'Project Browserでのプレビュー' : isChinese ? '在 Project Browser 中预览' : 'Preview in Project Browser' }
              ].map((item, i) => (
                <div key={i} className="flex items-center gap-4 text-text-main font-bold">
                  <div className="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center text-brand-500 border border-white/5">
                    <item.icon size={20} />
                  </div>
                  {item.text}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HelpView;
