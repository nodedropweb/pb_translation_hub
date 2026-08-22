// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Carregant els detalls del projecte...';

  @override
  String editorLoadError(String error) {
    return 'No s\'han pogut carregar les dades del projecte: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Traducció amb Gemini completada correctament! ✨';

  @override
  String get editorUnknownError => 'Error desconegut';

  @override
  String editorGeminiFailed(String detail) {
    return 'La traducció amb Gemini ha fallat: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Afegeix la teva clau de Google AI al teu perfil d\'usuari (no a la configuració d\'administració).';

  @override
  String get editorGeminiError =>
      'S\'ha produït un error durant la traducció amb Gemini. Comprova la teva clau de Google AI al perfil.';

  @override
  String get editorDeeplSuccess =>
      'Traducció amb DeepL completada correctament! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'La traducció amb DeepL ha fallat: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'S\'ha produït un error durant la traducció amb DeepL. Assegura\'t que la teva clau API de DeepL està configurada al perfil.';

  @override
  String get editorDeeplInvalidKey =>
      'Clau API de DeepL no vàlida. Comprova-la al teu perfil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'S\'ha exhaurit la quota de DeepL. Comprova el teu pla.';

  @override
  String get editorReviewReset =>
      'La traducció s\'ha restablert a l\'estat de revisió.';

  @override
  String editorResetError(String error) {
    return 'No s\'ha pogut restablir: $error';
  }

  @override
  String get editorUnignoreSuccess => 'El mòdul ha tornat a la llista activa.';

  @override
  String get editorUnignoreError =>
      'No s\'ha pogut deixar d\'ignorar el mòdul.';

  @override
  String get editorSaveSuccess =>
      'Traducció desada — de tornada a la cua de revisió.';

  @override
  String editorSaveError(String error) {
    return 'No s\'ha pogut desar: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'No queden més projectes oberts a la llista.';

  @override
  String get editorChangesDiscarded =>
      'Canvis descartats, carregant el projecte següent...';

  @override
  String get editorEnglishSourceApplied =>
      'S\'ha aplicat l\'original en anglès — tradueix-lo ara.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'No s\'ha pogut obrir l\'URL: $url';
  }

  @override
  String get commonSave => 'Desa';

  @override
  String get commonClose => 'Tanca';

  @override
  String get editorCloseEnglishSource => 'Tanca el text font en anglès';

  @override
  String get editorShowEnglishSource => 'Mostra el text font en anglès';

  @override
  String get editorUnignoreShortTooltip => 'Deixa de ignorar el mòdul';

  @override
  String get editorBackToReviewTooltip => 'Torna a l\'estat de revisió';

  @override
  String get editorAndNext => 'I següent';

  @override
  String get editorBackToDashboard => 'Torna al tauler';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Traduint a $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count restants';
  }

  @override
  String get editorUnignoreLongTooltip => 'Retorna el mòdul a la llista activa';

  @override
  String get editorUnignoreLabel => 'Deixa de ignorar';

  @override
  String get editorUnpublishTooltip =>
      'Revoca la publicació i torna a l\'estat de revisió';

  @override
  String get editorBackToReview => 'Torna a revisió';

  @override
  String get editorSaveAndNext => 'Desa i següent';

  @override
  String get editorEnglishSourceHeader => 'TEXT FONT EN ANGLÈS';

  @override
  String get editorStaleTooltip =>
      'Mostra l\'explicació i aplica el text en anglès';

  @override
  String get editorStaleDetailsLabel => 'Desactualitzat — Detalls';

  @override
  String get editorCopyPromptTooltip =>
      'Copia el text font i l\'indicador de traducció';

  @override
  String get editorPromptCopied => 'Indicador copiat al porta-retalls 📋';

  @override
  String get editorShowPreview => 'Mostra la vista prèvia';

  @override
  String get editorShowHtmlSource => 'Mostra el codi font HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RESUM:\n$summary\n\nCOS:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Resum:';

  @override
  String get editorDescriptionLabelColon => 'Descripció:';

  @override
  String get editorStaleDialogTitle => 'El text font en anglès ha canviat';

  @override
  String get editorStaleExplanation =>
      'La traducció existent es basa en un text original en anglès desactualitzat. Des de l\'última traducció, la persona mantenidora del mòdul ha canviat el text en anglès a Drupal.org — per tant, el contingut de la traducció existent pot ja no ser exacte ni complet.';

  @override
  String get editorStaleTip =>
      'Consell: fes clic a \"Usa l\'original en anglès\" per carregar el text font en anglès actual directament a l\'editor. Després el pots fer servir com a punt de partida per a una traducció nova. L\'original en anglès també és visible al panell de l\'esquerra.';

  @override
  String get editorEnglishSourceShort => 'Text font en anglès';

  @override
  String get editorPreviousTranslation => 'Traducció anterior';

  @override
  String get editorWhatChangedTitle => 'Què ha canviat?';

  @override
  String get editorShowDiff => 'Mostra les diferències';

  @override
  String get editorUseEnglish => 'Usa l\'original en anglès';

  @override
  String get editorStaleBannerText =>
      'El text font en anglès ha canviat — la traducció està desactualitzada';

  @override
  String get editorDetailsAndApply => 'Detalls i aplica';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUCCIÓ AL $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Traduint...';

  @override
  String get editorShowEditor => 'Mostra l\'editor';

  @override
  String get editorModuleTitleLabel => 'Títol del mòdul (anglès)';

  @override
  String get editorSummaryFieldLabel => 'Resum';

  @override
  String get editorBodyFieldLabel => 'Cos';

  @override
  String get editorHtmlCleaned => 'HTML netejat';

  @override
  String get editorLivePreviewHeader => 'VISTA PRÈVIA EN DIRECTE';

  @override
  String get editorTidyHtmlTooltip =>
      'Neteja l\'HTML (elimina els artefactes de DeepL)';

  @override
  String get editorVisualMode => 'VISUAL';

  @override
  String get editorSourceCodeMode => 'FONT (HTML)';

  @override
  String get commonCancel => 'Cancel·la';

  @override
  String get costDialogTitle => 'Estimació de cost (IA)';

  @override
  String get costDialogIntro =>
      'El mòdul seleccionat es traduirà amb la IA de Google Gemini. Aquí tens el desglossament de cost estimat d\'aquesta operació:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Tokens d\'entrada';

  @override
  String get costRowOutputTokens => 'Tokens de sortida (estimació)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caràcters)';
  }

  @override
  String get costRowPriceInput => 'Preu per 1M d\'entrada';

  @override
  String get costRowPriceOutput => 'Preu per 1M de sortida';

  @override
  String get costRowTotalEstimate => 'Cost total estimat';

  @override
  String get costDialogFootnote =>
      '* Nota: aquesta és una estimació basada en el model de preus de pagament per ús actual de Google. L\'ús real pot variar lleugerament.';

  @override
  String get costDialogStartTranslation => 'Inicia la traducció';

  @override
  String get htmlToolbarInsertLink => 'Insereix enllaç';

  @override
  String get htmlToolbarLinkTooltip => 'Insereix enllaç (a)';

  @override
  String get htmlToolbarInsert => 'Insereix';

  @override
  String get htmlToolbarHeading2 => 'Encapçalament 2';

  @override
  String get htmlToolbarHeading3 => 'Encapçalament 3';

  @override
  String get htmlToolbarBold => 'Negreta (strong)';

  @override
  String get htmlToolbarItalic => 'Cursiva (em)';

  @override
  String get htmlToolbarBulletList => 'Llista amb pics (ul)';

  @override
  String get htmlToolbarNumberedList => 'Llista numerada (ol)';

  @override
  String get htmlToolbarQuote => 'Cita (blockquote)';

  @override
  String get screenshotAltsHeader =>
      'TEXT ALTERNATIU DE LES CAPTURES DE PANTALLA';

  @override
  String get screenshotAltsIntro =>
      'Introdueix un text alternatiu descriptiu en l\'idioma de destinació per a cada captura de pantalla.';

  @override
  String screenshotLabel(int number) {
    return 'Captura de pantalla $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Vista prèvia no disponible';

  @override
  String get screenshotAltHint =>
      'Introdueix el text alternatiu en l\'idioma de destinació…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Deixar d\'ignorar tots els mòduls?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Tots els mòduls ignorats tornaran a la llista activa i estaran disponibles per traduir de nou.';

  @override
  String get dashUnignoreAllConfirmAction => 'Deixa de ignorar-los tots';

  @override
  String get dashUnignoreAllSuccess =>
      'S\'ha deixat d\'ignorar tots els mòduls.';

  @override
  String get dashUnignoreAllError =>
      'No s\'ha pogut deixar d\'ignorar els mòduls.';

  @override
  String get dashUnignoreAllButton => 'Deixa d\'ignorar tots els mòduls';

  @override
  String dashSyncStartError(String error) {
    return 'No s\'ha pogut iniciar la sincronització: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'S\'ha iniciat l\'actualització ràpida (7 dies) ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Error d\'actualització ràpida: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sincronitzat correctament: $name';
  }

  @override
  String get dashManualSyncNotFound => 'No s\'ha trobat el mòdul a Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Traducció massiva amb IA';

  @override
  String get dashHeaderTitle => 'Descripcions de projectes';

  @override
  String get dashHeaderSubtitle =>
      'Tradueix les descripcions dels mòduls de Drupal a l\'idioma de destinació. Ajuda a fer l\'ecosistema més accessible.';

  @override
  String get dashHeaderSubtitleShort =>
      'Tradueix descripcions de mòduls de Drupal.';

  @override
  String get dashLastLabel => 'Últim: ';

  @override
  String get dashContinue => 'Continua';

  @override
  String get dashContinueShort => 'Continua';

  @override
  String get dashUnignoreAllButtonLong => 'Deixa d\'ignorar tots els mòduls';

  @override
  String get dashQuickUpdateTooltip => 'Actualització ràpida (últims 7 dies)';

  @override
  String get dashFullSyncTooltip =>
      'Sincronització completa de la base de dades des de Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Carrega manualment un sol mòdul des de Drupal.org';

  @override
  String get dashQuickShort => 'Ràpida';

  @override
  String get dashModuleShort => 'Mòdul';

  @override
  String get dashFoundLabel => 'Trobats: ';

  @override
  String get dashModulesSuffix => ' mòduls';

  @override
  String dashPerPage(int count) {
    return '$count per pàgina';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / pàgina';
  }

  @override
  String get dashFirstPage => 'Primera pàgina';

  @override
  String get dashPrevPage => 'Pàgina anterior';

  @override
  String get dashNextPage => 'Pàgina següent';

  @override
  String get dashLastPage => 'Última pàgina';

  @override
  String dashPageOf(int page, int total) {
    return 'Pàgina $page de $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (p. ex. pathauto)';

  @override
  String get dashAddButton => 'Afegeix';

  @override
  String get dashAddModuleManually => 'Afegeix un mòdul manualment';

  @override
  String get dashAddModuleSubtitle =>
      'Carrega directament des de Drupal.org pel nom de màquina.';

  @override
  String get dashAddModuleShort => 'Afegeix mòdul';

  @override
  String get dashNoProjectsFound => 'No s\'han trobat projectes.';

  @override
  String get dashFilterAll => 'Tots els projectes';

  @override
  String get dashFilterMissing => 'Traduccions pendents';

  @override
  String get dashFilterReview => 'Cua de revisió';

  @override
  String get dashFilterTranslated => 'Projectes traduïts';

  @override
  String get dashFilterReleased => 'Projectes publicats';

  @override
  String get dashBulkDialogIntro =>
      'Tradueix automàticament diversos mòduls del filtre seleccionat mitjançant Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtre actiu';

  @override
  String get dashModuleCount => 'Nombre de mòduls';

  @override
  String dashModulesCountItem(int count) {
    return '$count mòduls';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioritza els mòduls de Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Tradueix primer els mòduls sense compatibilitat amb Drupal 12';

  @override
  String get dashTotalModules => 'Total de mòduls';

  @override
  String get dashInputTokensEst => 'Tokens d\'entrada (est.)';

  @override
  String get dashOutputTokensEst => 'Tokens de sortida (est.)';

  @override
  String get dashBulkFootnote =>
      '* La traducció s\'executa en lots eficients per evitar temps d\'espera excedits.';

  @override
  String get dashStartBulkTranslation => 'Inicia la traducció massiva';

  @override
  String dashStaleLoadError(String error) {
    return 'Error en carregar els mòduls desactualitzats: $error';
  }

  @override
  String get dashNoStaleModules =>
      'No s\'ha trobat cap mòdul desactualitzat — tot està al dia! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Retradueix els mòduls desactualitzats';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Totes les traduccions el text font en anglès de les quals hagi canviat des de l\'última traducció es retraduiran automàticament amb Google Gemini. No cal obrir cada mòdul manualment.';

  @override
  String get dashOutdatedModules => 'Mòduls desactualitzats';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* La traducció substitueix el text existent i restableix is_reviewed. S\'executa en lots de 4 mòduls.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Retradueix els $count mòduls';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Retraduint els mòduls desactualitzats…';

  @override
  String get dashFetchingProjects => 'Obtenint els projectes del servidor…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed de $total mòduls processats';
  }

  @override
  String get dashNoTranslatableProjects =>
      'No s\'ha trobat cap projecte traduïble per a aquest filtre.';

  @override
  String get dashStartingTranslation => 'Iniciant la traducció…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Traduint el mòdul $start–$end de $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end de $total mòduls completats.';
  }

  @override
  String get dashTranslationCompleted => 'Traducció completada correctament! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Traducció massiva de $count mòduls completada correctament! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Error de traducció massiva: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Els $count mòduls s\'han retraduït correctament! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count mòduls desactualitzats s\'han retraduït correctament! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Error durant la retraducció: $error';
  }

  @override
  String get filterAllShort => 'Tots';

  @override
  String get filterMissing => 'Pendents';

  @override
  String get filterTranslated => 'Traduïts';

  @override
  String get filterReviewQueue => 'Cua de revisió';

  @override
  String get filterReleased => 'Publicats';

  @override
  String get filterOutdated => 'Desactualitzats';

  @override
  String get filterPriority => 'Prioritat';

  @override
  String get filterIgnored => 'Ignorats';

  @override
  String get commonEdit => 'Edita';

  @override
  String get commonReset => 'Restableix';

  @override
  String get commonRefresh => 'Actualitza';

  @override
  String commonErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Restablir totes les traduccions publicades?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Totes les traduccions marcades com a publicades per a $langcode es restabliran a l\'estat de revisió. Aquesta acció no es pot desfer.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traduccions restablertes a l\'estat de revisió.';
  }

  @override
  String get reviewPipelineTitle => 'Flux de revisió';

  @override
  String get reviewPipelineSubtitle =>
      'Flux de control de qualitat humà per a les traduccions amb IA';

  @override
  String get reviewSearchHint => 'Cerca projectes...';

  @override
  String get reviewResetPublished => 'Restableix les publicades';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultats: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Pendents: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'No hi ha projectes pendents de revisió.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Totes les traduccions ja s\'han verificat, o no n\'hi ha cap en aquest context d\'idioma.';

  @override
  String get reviewNoSummary => 'Sense resum.';

  @override
  String get reviewStartAudit => 'INICIA L\'AUDITORIA';

  @override
  String get reviewHtmlSourceShort => 'Codi font HTML';

  @override
  String get reviewCopySource => 'Copia el font';

  @override
  String get reviewModuleDetails => 'Detalls del mòdul';

  @override
  String get reviewOriginalTitle => 'Títol original';

  @override
  String get reviewDrupalOrgProject => 'Projecte a Drupal.org';

  @override
  String get reviewSuggestions => 'Suggeriments';

  @override
  String get reviewNoSuggestions => 'No hi ha suggeriments disponibles.';

  @override
  String get reviewApply => 'Aplica';

  @override
  String get reviewNoChanges => 'Sense canvis';

  @override
  String get reviewOriginalBeforeCorrection =>
      'Original (abans de la correcció)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corregit (versió actual)';

  @override
  String get reviewBaseOriginal => 'Base (original)';

  @override
  String get reviewYourCorrection => 'La teva correcció';

  @override
  String get reviewChangesVisual => 'Revisa els teus canvis (visual)';

  @override
  String get commonSkip => 'Omet';

  @override
  String get commonIgnore => 'Ignora';

  @override
  String get reviewEmptyProjectTitle => 'Projecte buit';

  @override
  String get reviewEmptyProjectBody =>
      'Aquest projecte és buit (sense títol, resum ni cos) i no es pot aprovar. Omet-lo.';

  @override
  String get reviewApprovedSuccess => 'Traducció aprovada! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ L\'aprovació de \"$machine\" ha fallat — torna-ho a intentar.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Deixat d\'ignorar. El mòdul torna a estar actiu!';

  @override
  String get reviewActionFailed => 'L\'acció ha fallat.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorar el mòdul?';

  @override
  String get reviewIgnoreModuleBody =>
      'Aquest mòdul quedarà ocult permanentment de totes les llistes. Ja no t\'hi quedaràs bloquejat.';

  @override
  String get reviewModulePermanentlyIgnored => 'Mòdul ignorat permanentment.';

  @override
  String get reviewIgnoreFailed => 'No s\'ha pogut ignorar el mòdul.';

  @override
  String get reviewSuggestionSaved => 'Esborrany de suggeriment desat! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'No s\'ha pogut desar l\'esborrany del suggeriment.';

  @override
  String get reviewSuggestionDeleted => 'Suggeriment eliminat.';

  @override
  String get reviewDeleteFailed => 'No s\'ha pogut eliminar.';

  @override
  String get reviewSuggestionApplied => 'Suggeriment aplicat.';

  @override
  String get reviewPreparingData => 'Preparant les dades de revisió...';

  @override
  String get reviewDirectEdit => 'Edició directa';

  @override
  String get reviewLivePreview => 'Vista prèvia en directe';

  @override
  String get reviewCompareWith => 'Compara amb:';

  @override
  String get reviewProductionVersion => 'Versió de producció';

  @override
  String get reviewEditorialReview => 'Revisió editorial';

  @override
  String get reviewOpenQueue => 'Obre la cua de revisió';

  @override
  String get reviewCopyPromptShort => 'Copia l\'indicador';

  @override
  String get reviewUnignoreShort => 'Deixa d\'ignorar';

  @override
  String get reviewApproveButton => 'APROVA';

  @override
  String get reviewHideDetails => 'Amaga els detalls';

  @override
  String get reviewDetailsAndEnglishSource => 'Detalls i text font en anglès';

  @override
  String reviewPendingCountShort(int count) {
    return '$count pendents';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Revisant $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Compara la traducció amb el text font en anglès';

  @override
  String get reviewTranslationLabel => 'Traducció';

  @override
  String get reviewComparisonTitle => 'Comparació';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copia el text font i l\'indicador de traducció al porta-retalls';

  @override
  String get reviewUnignoreCaps => 'DEIXA D\'IGNORAR';

  @override
  String get reviewIgnoreCaps => 'IGNORA';

  @override
  String get reviewSkipShortcut => 'OMET (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Revisió editorial';

  @override
  String get reviewUnignoreTablet => 'DEIXA D\'IGNORAR';

  @override
  String get reviewApproveForProduction =>
      'APROVA PER A PRODUCCIÓ (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Refinament directe';

  @override
  String get reviewTitleField => 'Títol';

  @override
  String get reviewSummaryField => 'Resum';

  @override
  String get reviewBodyField => 'Contingut del cos';

  @override
  String get reviewSaveShortcut => 'DESA (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Vista prèvia en directe (renderitzant)';

  @override
  String get reviewVoiceFemale => 'Femenina';

  @override
  String get reviewVoiceMale => 'Masculina';

  @override
  String get reviewStopListening => 'Atura';

  @override
  String get reviewListen => 'Escolta';

  @override
  String get reviewAutopTooltip =>
      'Formata els paràgrafs automàticament (salts de línia → <p>)';

  @override
  String get reviewSourceCodeShort => 'FONT';

  @override
  String get reviewNoParagraphChange =>
      'El text ja conté etiquetes <p> — sense canvis';

  @override
  String get reviewParagraphsFormatted => 'Paràgrafs formatats ¶';

  @override
  String get commonRetry => 'Reintenta';

  @override
  String categoriesLoadError(String error) {
    return 'No s\'han pogut carregar les categories: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categories desades correctament.';

  @override
  String get categoriesSaveFailed => 'No s\'han pogut desar les traduccions.';

  @override
  String get categoriesFileEmpty => 'El fitxer és buit.';

  @override
  String get categoriesInvalidJson => 'Format JSON no vàlid.';

  @override
  String get categoriesNoValidUuids =>
      'No s\'ha trobat cap entrada UUID vàlida al fitxer.';

  @override
  String categoriesImportSuccess(int count) {
    return 'S\'han importat $count categories del fitxer.';
  }

  @override
  String get categoriesTitle => 'Categories';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Traduint per a: $lang';
  }

  @override
  String get categoriesImportJson => 'Importa JSON';

  @override
  String get categoriesSaving => 'Desant...';

  @override
  String get categoriesSaveAll => 'Desa-ho tot';

  @override
  String get categoriesLoading => 'Carregant categories...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Traducció ($code)';
  }

  @override
  String get categoriesNoneFound => 'No s\'ha trobat cap categoria.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Tradueix \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Fotografia de ';

  @override
  String get loginPhotoOn => ' a ';

  @override
  String get loginPleaseSignIn => 'Inicia sessió';

  @override
  String get loginUsername => 'Nom d\'usuari';

  @override
  String get loginPassword => 'Contrasenya';

  @override
  String get loginRememberMe => 'Recorda\'m';

  @override
  String get loginSignIn => 'INICIA SESSIÓ';

  @override
  String get loginNoAccount => 'Encara no tens compte? ';

  @override
  String get loginRegisterNow => 'Registra\'t ara';

  @override
  String get commonBack => 'Enrere';

  @override
  String get commonNext => 'Següent';

  @override
  String get registerFillRequired => 'Omple tots els camps obligatoris.';

  @override
  String get registerPasswordMismatch => 'Les contrasenyes no coincideixen.';

  @override
  String get registerPasswordTooShort =>
      'La contrasenya ha de tenir com a mínim 8 caràcters.';

  @override
  String get registerSelectLanguage => 'Selecciona com a mínim un idioma.';

  @override
  String get registerFailed => 'El registre ha fallat.';

  @override
  String get registerHeaderTitle => 'REGISTRE';

  @override
  String get registerStepAccount => 'Compte';

  @override
  String get registerStepRole => 'Rol';

  @override
  String get registerStepLanguages => 'Idiomes';

  @override
  String get registerStepApiKeys => 'Claus API';

  @override
  String get registerYourAccount => 'El teu compte';

  @override
  String get registerAvatarOptional => 'Avatar (opcional)';

  @override
  String get registerUsernameRequired => 'Nom d\'usuari *';

  @override
  String get registerEmailRequired => 'Adreça electrònica *';

  @override
  String get registerPasswordRequired => 'Contrasenya *';

  @override
  String get registerPasswordRepeat => 'Repeteix la contrasenya *';

  @override
  String get registerYourRole => 'El teu rol';

  @override
  String get registerRoleExplanation =>
      'Els traductors poden traduir textos, però no tenen accés a la cua de revisió. Els revisors comproven i aproven el contingut traduït.';

  @override
  String get registerRoleTranslator => 'Traductor';

  @override
  String get registerRoleTranslatorDesc => 'Crea i edita traduccions.';

  @override
  String get registerRoleReviewer => 'Revisor';

  @override
  String get registerRoleReviewerDesc => 'Revisa i aprova traduccions.';

  @override
  String get registerTargetLanguages => 'Idiomes de destinació';

  @override
  String get registerLanguagesExplanation =>
      'Tria tots els idiomes amb què vols treballar.';

  @override
  String get registerNoLanguagesAvailable => 'No hi ha idiomes disponibles.';

  @override
  String get registerApiKeysTitle => 'Claus API';

  @override
  String get registerApiKeysExplanation =>
      'Introdueix les teves pròpies claus API. Cada usuari fa servir exclusivament les seves pròpies claus. També les pots afegir més endavant al teu perfil.';

  @override
  String get registerKeysEncryptedNote =>
      'Les claus es desen xifrades i mai es comparteixen amb altres usuaris.';

  @override
  String get registerOptionalSuffix => ' (opcional)';

  @override
  String get registerSuccessTitle => 'Registre completat correctament!';

  @override
  String get registerSuccessBody =>
      'El teu compte s\'ha creat i està a l\'espera de l\'aprovació d\'un administrador. Se\'t notificarà quan s\'activi el teu accés.';

  @override
  String get registerGoToLogin => 'Vés a l\'inici de sessió';

  @override
  String get registerSubmit => 'Registra\'t';

  @override
  String registerPhotoCredit(String name) {
    return 'Fotografia de $name a Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Perfil actualitzat correctament!';

  @override
  String get profileUpdateFailed => 'L\'actualització ha fallat.';

  @override
  String profileSaveError(String error) {
    return 'Error en desar: $error';
  }

  @override
  String get profilePasswordMismatch => 'Les contrasenyes no coincideixen!';

  @override
  String get profilePasswordChangeSuccess =>
      'Contrasenya canviada correctament!';

  @override
  String get profilePasswordChangeError =>
      'Error en canviar la contrasenya: la contrasenya actual no és correcta.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar pujat correctament!';

  @override
  String get profileAvatarUploadError => 'Error en pujar l\'avatar.';

  @override
  String get profileTitle => 'Perfil i configuració';

  @override
  String get profileSubtitle =>
      'Gestiona el teu perfil d\'usuari, les teves API de traducció (Gemini i DeepL) i la seguretat del teu compte.';

  @override
  String get profileRoleUser => 'Usuari';

  @override
  String get profileNoEmail => 'No s\'ha proporcionat cap adreça electrònica';

  @override
  String get profileTabDetails => 'Detalls del perfil';

  @override
  String get profileTabGemini => 'Traducció amb IA (Gemini)';

  @override
  String get profileTabDeepl => 'Traducció amb DeepL';

  @override
  String get profileTabPassword => 'Canvia la contrasenya';

  @override
  String get profileSectionInfo => 'INFORMACIÓ DEL PERFIL';

  @override
  String get profileFieldName => 'Nom';

  @override
  String get profileFieldNameHint => 'El teu nom complet';

  @override
  String get profileFieldEmail => 'Adreça electrònica';

  @override
  String get profileFieldEmailHint => 'La teva adreça electrònica';

  @override
  String get profileSectionGemini => 'CONFIGURACIÓ DEL COPILOT GEMINI';

  @override
  String get profileFieldGeminiKey => 'Clau API de Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Introdueix la teva clau API de gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Indicador d\'IA personalitzat';

  @override
  String get profileFieldAiPromptHint =>
      'Opcional: personalitza l\'indicador de sistema per a Gemini...';

  @override
  String get profileSectionDeepl => 'CONFIGURACIÓ DE TRADUCCIÓ DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL ofereix traducció automàtica d\'alta qualitat amb conservació de les etiquetes HTML. Els comptes gratuïts (500.000 caràcters/mes) obtenen una clau amb el sufix \":fx\".';

  @override
  String get profileFieldDeeplKey => 'Clau API de DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'p. ex. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Les claus gratuïtes acaben en \":fx\" i fan servir api-free.deepl.com. Les claus Pro fan servir api.deepl.com. La distinció es fa automàticament.';

  @override
  String get profileSectionSecurity => 'SEGURETAT DEL COMPTE';

  @override
  String get profileFieldCurrentPassword => 'Contrasenya actual';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Introdueix la teva contrasenya actual';

  @override
  String get profileFieldNewPassword => 'Contrasenya nova';

  @override
  String get profileFieldNewPasswordHint => 'Com a mínim 6 caràcters';

  @override
  String get profileFieldConfirmPassword => 'Confirma la contrasenya nova';

  @override
  String get profileFieldConfirmPasswordHint => 'Repeteix la contrasenya';

  @override
  String get profileChangePasswordButton => 'Canvia la contrasenya';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get settingsRegistrationUpdated =>
      'Configuració de registre actualitzada';

  @override
  String get settingsUpdateFailed => 'L\'actualització ha fallat.';

  @override
  String get settingsUserApproved => 'Usuari aprovat!';

  @override
  String get settingsAccountDeactivated => 'Compte desactivat.';

  @override
  String get settingsUserDeleted => 'Usuari eliminat.';

  @override
  String get settingsActionFailed => 'L\'acció ha fallat.';

  @override
  String get settingsDeleteAccountTitle => 'Eliminar el compte?';

  @override
  String get settingsDeactivateAccountTitle => 'Desactivar el compte?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'El compte \"$username\" s\'eliminarà permanentment. Vols continuar?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'El compte \"$username\" quedarà bloquejat. L\'usuari ja no podrà iniciar sessió, però el compte es conservarà.';
  }

  @override
  String get settingsDeactivate => 'Desactiva';

  @override
  String settingsSyncSuccess(String count) {
    return '$count traduccions sincronitzades!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Error de sincronització: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count mòduls prioritaris sincronitzats!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Error en sincronitzar la llista de prioritats: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Còpia de seguretat completada: $count fitxers processats.';
  }

  @override
  String get settingsUploadFailed => 'La pujada ha fallat.';

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get settingsSystemConfig => 'CONFIGURACIÓ DEL SISTEMA';

  @override
  String get settingsRegistration => 'Registre';

  @override
  String get settingsRegistrationHint =>
      'Activa o desactiva la visibilitat global del formulari de registre.';

  @override
  String get settingsPendingUsers => 'Usuaris pendents';

  @override
  String get settingsNoNewRequests => 'No hi ha sol·licituds noves.';

  @override
  String get settingsWantsReviewer => 'Vol ser revisor';

  @override
  String get settingsAssignRole => 'Assigna un rol';

  @override
  String get settingsRoleTranslator => 'Traductor';

  @override
  String get settingsRoleReviewer => 'Revisor';

  @override
  String get settingsApprove => 'Aprova';

  @override
  String get settingsReject => 'Rebutja';

  @override
  String get settingsActiveUsers => 'Usuaris actius';

  @override
  String get settingsNoActiveUsers => 'No hi ha usuaris actius.';

  @override
  String get settingsDeactivateAccountTooltip => 'Desactiva';

  @override
  String get settingsDeleteAccountAction => 'Elimina el compte';

  @override
  String get settingsAppearance => 'Aparença';

  @override
  String get settingsThemePearl => 'CLAR (PERLA)';

  @override
  String get settingsThemeDark => 'FOSC';

  @override
  String get settingsThemeGlassy => 'VIDRE';

  @override
  String get settingsThemeNature => 'NATURA';

  @override
  String get settingsThemeLiquid => 'LÍQUID';

  @override
  String get settingsThemeStage => 'ESCENARI';

  @override
  String get settingsTypography => 'Tipografia';

  @override
  String get settingsFontHint =>
      'Modifica la família de la lletra de la interfície.';

  @override
  String get settingsFontClean => 'Neta';

  @override
  String get settingsFontFuturistic => 'Futurista';

  @override
  String get settingsFontTech => 'Tecnològica';

  @override
  String get settingsWorkflowFun => 'Flux de treball i diversió';

  @override
  String get settingsConfettiTitle => 'Celebració d\'èxit (confeti)';

  @override
  String get settingsConfettiHint =>
      'Mostra una petita animació en desar correctament.';

  @override
  String get settingsLargeUiTitle => 'Llegibilitat millorada (lletra gran)';

  @override
  String get settingsLargeUiHint =>
      'Augmenta la mida de la lletra i dels distintius per millorar la llegibilitat.';

  @override
  String get settingsAutoPTitle => 'Format automàtic de paràgrafs (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Envolta automàticament el text sense format en paràgrafs <p> en carregar un mòdul a la pantalla de revisió. Equival a fer clic manualment al botó ¶.';

  @override
  String get settingsDatabaseSync => 'Sincronització de la base de dades';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sincronitza les entrades de la base de dades amb els fitxers de traducció JSON.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sincronitza les entrades internes de la base de dades amb els JSON de traducció al servidor.';

  @override
  String get settingsSyncing => 'Sincronitzant...';

  @override
  String get settingsSyncNow => 'Sincronitza ara';

  @override
  String get settingsSyncD11List => 'Sincronitza la llista D11';

  @override
  String get settingsUploadBackup => 'Puja una còpia de seguretat (.zip)';

  @override
  String get settingsSelectZipFile => 'Selecciona un fitxer ZIP';

  @override
  String get settingsUploading => 'Pujant...';

  @override
  String get settingsErrorDiagnostics =>
      'Diagnòstic d\'errors i registres del sistema';

  @override
  String get settingsLogsCopied => 'Registres copiats al porta-retalls! 📋';

  @override
  String get settingsCopyLogs => 'Copia els registres';

  @override
  String get settingsLogsRotated => 'Registres arxivats i rotats! 📁';

  @override
  String get settingsRotate => 'Rota';

  @override
  String get settingsClear => 'Neteja';

  @override
  String get settingsLogLimit => 'Límit de registres: ';

  @override
  String get settingsNoLogs => 'No hi ha registres enregistrats';

  @override
  String get layoutMenu => 'Menú';

  @override
  String get layoutNavAnalytics => 'Analítica';

  @override
  String get layoutNavReviewQueue => 'Cua de revisió';

  @override
  String get layoutNavGlossary => 'Glossari';

  @override
  String get layoutNavCategories => 'Categories';

  @override
  String get layoutNavHelp => 'Ajuda';

  @override
  String get layoutNavSettings => 'Configuració';

  @override
  String get layoutPhotoBy => 'Fotografia de ';

  @override
  String get layoutPhotoOn => ' a ';

  @override
  String get layoutEditProfile => 'Edita el perfil';

  @override
  String get layoutLogout => 'Tanca la sessió';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Clar';

  @override
  String get layoutThemeDark => 'Fosc';

  @override
  String get layoutThemeGlassy => 'Vidre';

  @override
  String get layoutThemeNature => 'Natura';

  @override
  String get layoutThemeLiquid => 'Líquid';

  @override
  String get layoutThemeStage => 'Escenari';

  @override
  String get layoutTargetLanguage => 'IDIOMA DE DESTINACIÓ';

  @override
  String get layoutDeeplUsage => 'ÚS DE DEEPL';

  @override
  String get layoutUnavailable => 'No disponible';

  @override
  String get layoutUnlimited => 'il·limitat';

  @override
  String get layoutUsed => 'utilitzat';

  @override
  String get layoutTranslate => 'Tradueix';

  @override
  String get analyticsSubtitle =>
      'Compatibilitat, treball pendent de traducció i tendències setmanals.';

  @override
  String get analyticsBacklog => 'Treball de traducció pendent';

  @override
  String get analyticsMissing => 'Pendents';

  @override
  String get analyticsStale => 'Desactualitzats';

  @override
  String get analyticsInReview => 'En revisió';

  @override
  String get analyticsReleased => 'Publicats';

  @override
  String get analyticsTranslated => 'Traduïts';

  @override
  String get analyticsTotalModules => 'Total de mòduls';

  @override
  String get analyticsCompatByVersion => 'Compatibilitat per versió de Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Idioma: $lang · publicats / en revisió / pendents';
  }

  @override
  String get analyticsLoadingCounts => 'Carregant els recomptes …';

  @override
  String get analyticsWindow => 'Període:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks setmanes';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Descripcions de projectes noves per setmana';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marcats com a desactualitzats per setmana ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count mòduls';
  }

  @override
  String get analyticsReviewShort => 'Revisió';

  @override
  String get analyticsNoDataInWindow => 'No hi ha dades en aquest període.';

  @override
  String get analyticsAndMore => '… i més';

  @override
  String glossaryLoadError(String error) {
    return 'Error en carregar: $error';
  }

  @override
  String get glossaryNewTerm => 'Crea un terme nou';

  @override
  String get glossaryEditTerm => 'Edita el terme';

  @override
  String get glossaryFieldSourceWord =>
      'Paraula font (forma base, tal com apareix al text)';

  @override
  String get glossaryFieldSourceWordHint => 'p. ex. node';

  @override
  String get glossaryWordForms =>
      'Formes addicionals de la paraula (plural, genitiu, datiu…)';

  @override
  String get glossaryWordFormsHint =>
      'p. ex. content — prem Retorn per afegir-la';

  @override
  String get glossaryAddForm => 'Afegeix una forma';

  @override
  String get glossaryFieldPreferredWord => 'Traducció preferida';

  @override
  String get glossaryFieldPreferredWordHint => 'p. ex. contingut';

  @override
  String get glossaryFieldExplanation =>
      'Explicació (es mostra a l\'indicador de context)';

  @override
  String get glossaryFieldExplanationHint =>
      'Per què s\'hauria de traduir aquesta paraula d\'una altra manera?';

  @override
  String get glossaryCreate => 'Crea';

  @override
  String get glossaryRequiredFields =>
      'La paraula font i la traducció preferida són obligatòries.';

  @override
  String get glossaryCreated => 'Terme creat ✓';

  @override
  String get glossaryUpdated => 'Terme actualitzat ✓';

  @override
  String glossaryError(String error) {
    return 'Error: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Eliminar el terme?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" s\'eliminarà permanentment del glossari.';
  }

  @override
  String get glossaryDeleted => 'Terme eliminat.';

  @override
  String get glossaryTitle => 'Glossari de traducció';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Idioma: $lang · $count entrades';
  }

  @override
  String get glossaryNewShort => 'Nou';

  @override
  String get glossaryCreateTerm => 'Crea un terme';

  @override
  String get glossaryInfoBanner =>
      'Les paraules d\'aquest glossari es ressalten a l\'editor de revisió. Un indicador de context explica, en passar-hi per sobre, per què una traducció diferent s\'ajusta millor.';

  @override
  String get glossaryNoEntries => 'Encara no hi ha cap entrada.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Fes clic a \"Crea un terme\" per crear la primera entrada.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Encara no hi ha entrades del glossari per a aquest idioma.';

  @override
  String get diffNoChanges => 'No s\'ha detectat cap diferència de contingut.';

  @override
  String get diffRemoved => 'Eliminat';

  @override
  String get diffAdded => 'Afegit';

  @override
  String syncBarQuickSync(String count) {
    return 'Sincronització ràpida: $count mòduls modificats …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sincronització completa: $current / $total mòduls';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sincronització completa: $count mòduls …';
  }
}
