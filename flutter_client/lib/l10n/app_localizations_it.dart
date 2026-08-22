// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Caricamento dettagli del progetto...';

  @override
  String editorLoadError(String error) {
    return 'Impossibile caricare i dati del progetto: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Traduzione con Gemini completata con successo! ✨';

  @override
  String get editorUnknownError => 'Errore sconosciuto';

  @override
  String editorGeminiFailed(String detail) {
    return 'Traduzione con Gemini non riuscita: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Aggiungi la tua chiave Google AI nel tuo profilo utente (non nelle impostazioni di amministrazione).';

  @override
  String get editorGeminiError =>
      'Errore durante la traduzione con Gemini. Controlla la tua chiave Google AI nel profilo.';

  @override
  String get editorDeeplSuccess =>
      'Traduzione con DeepL completata con successo! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Traduzione con DeepL non riuscita: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Errore durante la traduzione con DeepL. Assicurati che la tua chiave API DeepL sia impostata nel profilo.';

  @override
  String get editorDeeplInvalidKey =>
      'Chiave API DeepL non valida. Controllala nel tuo profilo.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Quota DeepL esaurita. Controlla il tuo piano.';

  @override
  String get editorReviewReset =>
      'Traduzione riportata allo stato di revisione.';

  @override
  String editorResetError(String error) {
    return 'Impossibile reimpostare: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Il modulo è tornato nell\'elenco attivo.';

  @override
  String get editorUnignoreError => 'Impossibile riattivare il modulo.';

  @override
  String get editorSaveSuccess =>
      'Traduzione salvata — di nuovo nella coda di revisione.';

  @override
  String editorSaveError(String error) {
    return 'Impossibile salvare: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'Non ci sono più progetti aperti nell\'elenco.';

  @override
  String get editorChangesDiscarded =>
      'Modifiche annullate, caricamento del progetto successivo...';

  @override
  String get editorEnglishSourceApplied =>
      'Testo originale in inglese applicato — traducilo ora.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Impossibile aprire l\'URL: $url';
  }

  @override
  String get commonSave => 'Salva';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get editorCloseEnglishSource => 'Chiudi il testo originale in inglese';

  @override
  String get editorShowEnglishSource => 'Mostra il testo originale in inglese';

  @override
  String get editorUnignoreShortTooltip => 'Riattiva il modulo';

  @override
  String get editorBackToReviewTooltip => 'Riporta in revisione';

  @override
  String get editorAndNext => 'e successivo';

  @override
  String get editorBackToDashboard => 'Torna alla dashboard';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Traduzione in $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count rimanenti';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Riporta il modulo nell\'elenco attivo';

  @override
  String get editorUnignoreLabel => 'Riattiva';

  @override
  String get editorUnpublishTooltip =>
      'Revoca la pubblicazione e riporta in revisione';

  @override
  String get editorBackToReview => 'Torna alla revisione';

  @override
  String get editorSaveAndNext => 'Salva e vai al successivo';

  @override
  String get editorEnglishSourceHeader => 'TESTO ORIGINALE IN INGLESE';

  @override
  String get editorStaleTooltip =>
      'Mostra la spiegazione e applica il testo in inglese';

  @override
  String get editorStaleDetailsLabel => 'Non aggiornato — Dettagli';

  @override
  String get editorCopyPromptTooltip =>
      'Copia il testo originale e il prompt di traduzione';

  @override
  String get editorPromptCopied => 'Prompt copiato negli appunti 📋';

  @override
  String get editorShowPreview => 'Mostra anteprima';

  @override
  String get editorShowHtmlSource => 'Mostra codice sorgente HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RIEPILOGO:\n$summary\n\nTESTO:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Riepilogo:';

  @override
  String get editorDescriptionLabelColon => 'Descrizione:';

  @override
  String get editorStaleDialogTitle =>
      'Il testo originale in inglese è cambiato';

  @override
  String get editorStaleExplanation =>
      'La traduzione esistente si basa su un testo originale in inglese non più aggiornato. Dall\'ultima traduzione, il manutentore del modulo ha modificato il testo in inglese su Drupal.org — di conseguenza, il contenuto della traduzione esistente potrebbe non essere più accurato o completo.';

  @override
  String get editorStaleTip =>
      'Suggerimento: fai clic su \"Usa originale in inglese\" per caricare direttamente nell\'editor il testo originale in inglese attuale. Potrai poi usarlo come punto di partenza per una nuova traduzione. Il testo originale in inglese è visibile anche nel pannello a sinistra.';

  @override
  String get editorEnglishSourceShort => 'Testo originale in inglese';

  @override
  String get editorPreviousTranslation => 'Traduzione precedente';

  @override
  String get editorWhatChangedTitle => 'Cosa è cambiato?';

  @override
  String get editorShowDiff => 'Mostra le differenze';

  @override
  String get editorUseEnglish => 'Usa originale in inglese';

  @override
  String get editorStaleBannerText =>
      'Il testo originale in inglese è cambiato — la traduzione non è aggiornata';

  @override
  String get editorDetailsAndApply => 'Dettagli e applica';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUZIONE IN $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Traduzione in corso...';

  @override
  String get editorShowEditor => 'Mostra editor';

  @override
  String get editorModuleTitleLabel => 'Titolo del modulo (inglese)';

  @override
  String get editorSummaryFieldLabel => 'Riepilogo';

  @override
  String get editorBodyFieldLabel => 'Testo';

  @override
  String get editorHtmlCleaned => 'HTML ripulito';

  @override
  String get editorLivePreviewHeader => 'ANTEPRIMA IN TEMPO REALE';

  @override
  String get editorTidyHtmlTooltip =>
      'Ripulisci l\'HTML (rimuove gli artefatti di DeepL)';

  @override
  String get editorVisualMode => 'VISUALE';

  @override
  String get editorSourceCodeMode => 'SORGENTE (HTML)';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get costDialogTitle => 'Stima dei costi (IA)';

  @override
  String get costDialogIntro =>
      'Il modulo selezionato verrà tradotto con l\'IA Google Gemini. Ecco la ripartizione stimata dei costi per questa operazione:';

  @override
  String get costRowModel => 'Modello';

  @override
  String get costRowInputTokens => 'Token di input';

  @override
  String get costRowOutputTokens => 'Token di output (stima)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caratteri)';
  }

  @override
  String get costRowPriceInput => 'Prezzo per 1M di input';

  @override
  String get costRowPriceOutput => 'Prezzo per 1M di output';

  @override
  String get costRowTotalEstimate => 'Costo totale stimato';

  @override
  String get costDialogFootnote =>
      '* Nota: questa è una stima basata sull\'attuale modello di prezzo a consumo di Google. L\'utilizzo effettivo potrebbe variare leggermente.';

  @override
  String get costDialogStartTranslation => 'Avvia traduzione';

  @override
  String get htmlToolbarInsertLink => 'Inserisci link';

  @override
  String get htmlToolbarLinkTooltip => 'Inserisci link (a)';

  @override
  String get htmlToolbarInsert => 'Inserisci';

  @override
  String get htmlToolbarHeading2 => 'Titolo 2';

  @override
  String get htmlToolbarHeading3 => 'Titolo 3';

  @override
  String get htmlToolbarBold => 'Grassetto (strong)';

  @override
  String get htmlToolbarItalic => 'Corsivo (em)';

  @override
  String get htmlToolbarBulletList => 'Elenco puntato (ul)';

  @override
  String get htmlToolbarNumberedList => 'Elenco numerato (ol)';

  @override
  String get htmlToolbarQuote => 'Citazione (blockquote)';

  @override
  String get screenshotAltsHeader => 'TESTO ALTERNATIVO DEGLI SCREENSHOT';

  @override
  String get screenshotAltsIntro =>
      'Inserisci un testo alternativo descrittivo nella lingua di destinazione per ogni screenshot.';

  @override
  String screenshotLabel(int number) {
    return 'Screenshot $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Anteprima non disponibile';

  @override
  String get screenshotAltHint =>
      'Inserisci il testo alternativo nella lingua di destinazione…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Riattivare tutti i moduli?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Tutti i moduli ignorati torneranno nell\'elenco attivo e saranno di nuovo disponibili per la traduzione.';

  @override
  String get dashUnignoreAllConfirmAction => 'Riattiva tutti';

  @override
  String get dashUnignoreAllSuccess =>
      'Tutti i moduli ignorati sono stati riattivati.';

  @override
  String get dashUnignoreAllError => 'Impossibile riattivare i moduli.';

  @override
  String get dashUnignoreAllButton => 'Riattiva tutti i moduli';

  @override
  String dashSyncStartError(String error) {
    return 'Impossibile avviare la sincronizzazione: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'Aggiornamento rapido (7 giorni) avviato ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Errore nell\'aggiornamento rapido: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sincronizzazione riuscita: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modulo non trovato su Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Traduzione massiva con IA';

  @override
  String get dashHeaderTitle => 'Descrizioni dei progetti';

  @override
  String get dashHeaderSubtitle =>
      'Traduci le descrizioni dei moduli Drupal nella lingua di destinazione. Aiuta a rendere l\'ecosistema più accessibile.';

  @override
  String get dashHeaderSubtitleShort =>
      'Traduci le descrizioni dei moduli Drupal.';

  @override
  String get dashLastLabel => 'Ultimo: ';

  @override
  String get dashContinue => 'Continua';

  @override
  String get dashContinueShort => 'Continua';

  @override
  String get dashUnignoreAllButtonLong => 'Riattiva tutti i moduli';

  @override
  String get dashQuickUpdateTooltip => 'Aggiornamento rapido (ultimi 7 giorni)';

  @override
  String get dashFullSyncTooltip =>
      'Sincronizzazione completa del database da Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Carica manualmente un singolo modulo da Drupal.org';

  @override
  String get dashQuickShort => 'Rapido';

  @override
  String get dashModuleShort => 'Modulo';

  @override
  String get dashFoundLabel => 'Trovati: ';

  @override
  String get dashModulesSuffix => ' moduli';

  @override
  String dashPerPage(int count) {
    return '$count per pagina';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / pagina';
  }

  @override
  String get dashFirstPage => 'Prima pagina';

  @override
  String get dashPrevPage => 'Pagina precedente';

  @override
  String get dashNextPage => 'Pagina successiva';

  @override
  String get dashLastPage => 'Ultima pagina';

  @override
  String dashPageOf(int page, int total) {
    return 'Pagina $page di $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (es. pathauto)';

  @override
  String get dashAddButton => 'Aggiungi';

  @override
  String get dashAddModuleManually => 'Aggiungi modulo manualmente';

  @override
  String get dashAddModuleSubtitle =>
      'Carica direttamente da Drupal.org tramite machine name.';

  @override
  String get dashAddModuleShort => 'Aggiungi modulo';

  @override
  String get dashNoProjectsFound => 'Nessun progetto trovato.';

  @override
  String get dashFilterAll => 'Tutti i progetti';

  @override
  String get dashFilterMissing => 'Traduzioni mancanti';

  @override
  String get dashFilterReview => 'Coda di revisione';

  @override
  String get dashFilterTranslated => 'Progetti tradotti';

  @override
  String get dashFilterReleased => 'Progetti pubblicati';

  @override
  String get dashBulkDialogIntro =>
      'Traduci automaticamente più moduli dal filtro selezionato utilizzando Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtro attivo';

  @override
  String get dashModuleCount => 'Numero di moduli';

  @override
  String dashModulesCountItem(int count) {
    return '$count moduli';
  }

  @override
  String get dashPrioritizeD12Title => 'Dai priorità ai moduli Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Traduce prima i moduli senza supporto Drupal 12';

  @override
  String get dashTotalModules => 'Totale moduli';

  @override
  String get dashInputTokensEst => 'Token di input (stima)';

  @override
  String get dashOutputTokensEst => 'Token di output (stima)';

  @override
  String get dashBulkFootnote =>
      '* La traduzione viene eseguita in lotti ottimizzati per evitare timeout.';

  @override
  String get dashStartBulkTranslation => 'Avvia traduzione massiva';

  @override
  String dashStaleLoadError(String error) {
    return 'Errore nel caricamento dei moduli non aggiornati: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Nessun modulo non aggiornato trovato — tutto è aggiornato! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Ritraduci i moduli non aggiornati';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Tutte le traduzioni il cui testo originale in inglese è cambiato dall\'ultima traduzione verranno ritradotte automaticamente con Google Gemini. Non è necessario aprire ogni modulo manualmente.';

  @override
  String get dashOutdatedModules => 'Moduli non aggiornati';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* La traduzione sostituisce il testo esistente e reimposta is_reviewed. Eseguita in lotti di 4 moduli.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Ritraduci tutti i $count moduli';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Ritraduzione dei moduli non aggiornati in corso…';

  @override
  String get dashFetchingProjects => 'Recupero dei progetti dal server…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed di $total moduli elaborati';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Nessun progetto traducibile trovato per questo filtro.';

  @override
  String get dashStartingTranslation => 'Avvio della traduzione…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Traduzione modulo $start–$end di $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end di $total moduli completati.';
  }

  @override
  String get dashTranslationCompleted =>
      'Traduzione completata con successo! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Traduzione massiva di $count moduli completata con successo! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Errore nella traduzione massiva: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Tutti i $count moduli sono stati ritradotti con successo! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count moduli non aggiornati ritradotti con successo! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Errore durante la ritraduzione: $error';
  }

  @override
  String get filterAllShort => 'Tutti';

  @override
  String get filterMissing => 'Mancanti';

  @override
  String get filterTranslated => 'Tradotti';

  @override
  String get filterReviewQueue => 'Coda di revisione';

  @override
  String get filterReleased => 'Pubblicati';

  @override
  String get filterOutdated => 'Non aggiornati';

  @override
  String get filterPriority => 'Priorità';

  @override
  String get filterIgnored => 'Ignorati';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get commonReset => 'Reimposta';

  @override
  String get commonRefresh => 'Aggiorna';

  @override
  String commonErrorPrefix(String error) {
    return 'Errore: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Reimpostare tutte le traduzioni pubblicate?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Tutte le traduzioni contrassegnate come pubblicate per $langcode verranno reimpostate allo stato di revisione. Questa azione non può essere annullata.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traduzioni reimpostate allo stato di revisione.';
  }

  @override
  String get reviewPipelineTitle => 'Flusso di revisione';

  @override
  String get reviewPipelineSubtitle =>
      'Flusso di controllo qualità umano per le traduzioni con IA';

  @override
  String get reviewSearchHint => 'Cerca progetti...';

  @override
  String get reviewResetPublished => 'Reimposta pubblicate';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Risultati: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'In sospeso: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Nessun progetto in attesa di revisione.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Tutte le traduzioni sono già state verificate oppure non ne esiste nessuna in questo contesto linguistico.';

  @override
  String get reviewNoSummary => 'Nessun riepilogo.';

  @override
  String get reviewStartAudit => 'AVVIA VERIFICA';

  @override
  String get reviewHtmlSourceShort => 'Codice sorgente HTML';

  @override
  String get reviewCopySource => 'Copia sorgente';

  @override
  String get reviewModuleDetails => 'Dettagli del modulo';

  @override
  String get reviewOriginalTitle => 'Titolo originale';

  @override
  String get reviewDrupalOrgProject => 'Progetto su Drupal.org';

  @override
  String get reviewSuggestions => 'Suggerimenti';

  @override
  String get reviewNoSuggestions => 'Nessun suggerimento disponibile.';

  @override
  String get reviewApply => 'Applica';

  @override
  String get reviewNoChanges => 'Nessuna modifica';

  @override
  String get reviewOriginalBeforeCorrection =>
      'Originale (prima della correzione)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corretto (versione attuale)';

  @override
  String get reviewBaseOriginal => 'Base (originale)';

  @override
  String get reviewYourCorrection => 'La tua correzione';

  @override
  String get reviewChangesVisual => 'Rivedi le tue modifiche (visuale)';

  @override
  String get commonSkip => 'Salta';

  @override
  String get commonIgnore => 'Ignora';

  @override
  String get reviewEmptyProjectTitle => 'Progetto vuoto';

  @override
  String get reviewEmptyProjectBody =>
      'Questo progetto è vuoto (senza titolo, riepilogo o testo) e non può essere approvato. Saltalo.';

  @override
  String get reviewApprovedSuccess => 'Traduzione approvata! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Approvazione di \"$machine\" non riuscita — riprova.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Riattivato. Il modulo è di nuovo attivo!';

  @override
  String get reviewActionFailed => 'Azione non riuscita.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorare il modulo?';

  @override
  String get reviewIgnoreModuleBody =>
      'Questo modulo verrà nascosto permanentemente da tutti gli elenchi. Non ti troverai più bloccato su di esso.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modulo ignorato permanentemente.';

  @override
  String get reviewIgnoreFailed => 'Impossibile ignorare il modulo.';

  @override
  String get reviewSuggestionSaved => 'Bozza del suggerimento salvata! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Impossibile salvare la bozza del suggerimento.';

  @override
  String get reviewSuggestionDeleted => 'Suggerimento eliminato.';

  @override
  String get reviewDeleteFailed => 'Impossibile eliminare.';

  @override
  String get reviewSuggestionApplied => 'Suggerimento applicato.';

  @override
  String get reviewPreparingData => 'Preparazione dei dati di revisione...';

  @override
  String get reviewDirectEdit => 'Modifica diretta';

  @override
  String get reviewLivePreview => 'Anteprima in tempo reale';

  @override
  String get reviewCompareWith => 'Confronta con:';

  @override
  String get reviewProductionVersion => 'Versione di produzione';

  @override
  String get reviewEditorialReview => 'Revisione editoriale';

  @override
  String get reviewOpenQueue => 'Apri la coda di revisione';

  @override
  String get reviewCopyPromptShort => 'Copia prompt';

  @override
  String get reviewUnignoreShort => 'Riattiva';

  @override
  String get reviewApproveButton => 'APPROVA';

  @override
  String get reviewHideDetails => 'Nascondi dettagli';

  @override
  String get reviewDetailsAndEnglishSource =>
      'Dettagli e testo originale in inglese';

  @override
  String reviewPendingCountShort(int count) {
    return '$count in sospeso';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Revisione di $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Confronta la traduzione con il testo originale in inglese';

  @override
  String get reviewTranslationLabel => 'Traduzione';

  @override
  String get reviewComparisonTitle => 'Confronto';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copia il testo originale e il prompt di traduzione negli appunti';

  @override
  String get reviewUnignoreCaps => 'RIATTIVA';

  @override
  String get reviewIgnoreCaps => 'IGNORA';

  @override
  String get reviewSkipShortcut => 'SALTA (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Revisione editoriale';

  @override
  String get reviewUnignoreTablet => 'RIATTIVA';

  @override
  String get reviewApproveForProduction =>
      'APPROVA PER LA PRODUZIONE (Ctrl+Invio)';

  @override
  String get reviewDirectRefinement => 'Rifinitura diretta';

  @override
  String get reviewTitleField => 'Titolo';

  @override
  String get reviewSummaryField => 'Riepilogo';

  @override
  String get reviewBodyField => 'Contenuto del testo';

  @override
  String get reviewSaveShortcut => 'SALVA (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Anteprima in tempo reale (rendering)';

  @override
  String get reviewVoiceFemale => 'Femminile';

  @override
  String get reviewVoiceMale => 'Maschile';

  @override
  String get reviewStopListening => 'Interrompi';

  @override
  String get reviewListen => 'Ascolta';

  @override
  String get reviewAutopTooltip =>
      'Formatta automaticamente i paragrafi (a capo → <p>)';

  @override
  String get reviewSourceCodeShort => 'SORGENTE';

  @override
  String get reviewNoParagraphChange =>
      'Il testo contiene già i tag <p> — nessuna modifica';

  @override
  String get reviewParagraphsFormatted => 'Paragrafi formattati ¶';

  @override
  String get commonRetry => 'Riprova';

  @override
  String categoriesLoadError(String error) {
    return 'Impossibile caricare le categorie: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categorie salvate con successo.';

  @override
  String get categoriesSaveFailed => 'Impossibile salvare le traduzioni.';

  @override
  String get categoriesFileEmpty => 'Il file è vuoto.';

  @override
  String get categoriesInvalidJson => 'Formato JSON non valido.';

  @override
  String get categoriesNoValidUuids =>
      'Nessuna voce UUID valida trovata nel file.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categorie importate dal file.';
  }

  @override
  String get categoriesTitle => 'Categorie';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Traduzione per: $lang';
  }

  @override
  String get categoriesImportJson => 'Importa JSON';

  @override
  String get categoriesSaving => 'Salvataggio in corso...';

  @override
  String get categoriesSaveAll => 'Salva tutto';

  @override
  String get categoriesLoading => 'Caricamento categorie...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Traduzione ($code)';
  }

  @override
  String get categoriesNoneFound => 'Nessuna categoria trovata.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Traduci \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto di ';

  @override
  String get loginPhotoOn => ' su ';

  @override
  String get loginPleaseSignIn => 'Accedi';

  @override
  String get loginUsername => 'Nome utente';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginRememberMe => 'Ricordami';

  @override
  String get loginSignIn => 'ACCEDI';

  @override
  String get loginNoAccount => 'Non hai ancora un account? ';

  @override
  String get loginRegisterNow => 'Registrati ora';

  @override
  String get commonBack => 'Indietro';

  @override
  String get commonNext => 'Avanti';

  @override
  String get registerFillRequired => 'Compila tutti i campi obbligatori.';

  @override
  String get registerPasswordMismatch => 'Le password non corrispondono.';

  @override
  String get registerPasswordTooShort =>
      'La password deve contenere almeno 8 caratteri.';

  @override
  String get registerSelectLanguage => 'Seleziona almeno una lingua.';

  @override
  String get registerFailed => 'Registrazione non riuscita.';

  @override
  String get registerHeaderTitle => 'REGISTRAZIONE';

  @override
  String get registerStepAccount => 'Account';

  @override
  String get registerStepRole => 'Ruolo';

  @override
  String get registerStepLanguages => 'Lingue';

  @override
  String get registerStepApiKeys => 'Chiavi API';

  @override
  String get registerYourAccount => 'Il tuo account';

  @override
  String get registerAvatarOptional => 'Avatar (opzionale)';

  @override
  String get registerUsernameRequired => 'Nome utente *';

  @override
  String get registerEmailRequired => 'Indirizzo email *';

  @override
  String get registerPasswordRequired => 'Password *';

  @override
  String get registerPasswordRepeat => 'Ripeti password *';

  @override
  String get registerYourRole => 'Il tuo ruolo';

  @override
  String get registerRoleExplanation =>
      'I traduttori possono tradurre i testi ma non hanno accesso alla coda di revisione. I revisori controllano e approvano i contenuti tradotti.';

  @override
  String get registerRoleTranslator => 'Traduttore';

  @override
  String get registerRoleTranslatorDesc => 'Crea e modifica traduzioni.';

  @override
  String get registerRoleReviewer => 'Revisore';

  @override
  String get registerRoleReviewerDesc => 'Rivedi e approva le traduzioni.';

  @override
  String get registerTargetLanguages => 'Lingue di destinazione';

  @override
  String get registerLanguagesExplanation =>
      'Scegli tutte le lingue su cui vuoi lavorare.';

  @override
  String get registerNoLanguagesAvailable => 'Nessuna lingua disponibile.';

  @override
  String get registerApiKeysTitle => 'Chiavi API';

  @override
  String get registerApiKeysExplanation =>
      'Inserisci le tue chiavi API personali. Ogni utente utilizza esclusivamente le proprie chiavi. Puoi aggiungerle anche in seguito nel tuo profilo.';

  @override
  String get registerKeysEncryptedNote =>
      'Le chiavi vengono memorizzate in modo crittografato e non vengono mai condivise con altri utenti.';

  @override
  String get registerOptionalSuffix => ' (opzionale)';

  @override
  String get registerSuccessTitle => 'Registrazione completata!';

  @override
  String get registerSuccessBody =>
      'Il tuo account è stato creato ed è in attesa di approvazione da parte di un amministratore. Riceverai una notifica non appena il tuo accesso sarà attivato.';

  @override
  String get registerGoToLogin => 'Vai all\'accesso';

  @override
  String get registerSubmit => 'Registrati';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto di $name su Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profilo aggiornato con successo!';

  @override
  String get profileUpdateFailed => 'Aggiornamento non riuscito.';

  @override
  String profileSaveError(String error) {
    return 'Errore durante il salvataggio: $error';
  }

  @override
  String get profilePasswordMismatch => 'Le password non corrispondono!';

  @override
  String get profilePasswordChangeSuccess =>
      'Password modificata con successo!';

  @override
  String get profilePasswordChangeError =>
      'Errore durante la modifica della password: la password attuale non è corretta.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar caricato con successo!';

  @override
  String get profileAvatarUploadError =>
      'Errore durante il caricamento dell\'avatar.';

  @override
  String get profileTitle => 'Profilo e impostazioni';

  @override
  String get profileSubtitle =>
      'Gestisci il tuo profilo utente, le tue API di traduzione (Gemini e DeepL) e la sicurezza del tuo account.';

  @override
  String get profileRoleUser => 'Utente';

  @override
  String get profileNoEmail => 'Nessun indirizzo email fornito';

  @override
  String get profileTabDetails => 'Dettagli del profilo';

  @override
  String get profileTabGemini => 'Traduzione IA (Gemini)';

  @override
  String get profileTabDeepl => 'Traduzione DeepL';

  @override
  String get profileTabPassword => 'Cambia password';

  @override
  String get profileSectionInfo => 'INFORMAZIONI SUL PROFILO';

  @override
  String get profileFieldName => 'Nome';

  @override
  String get profileFieldNameHint => 'Il tuo nome completo';

  @override
  String get profileFieldEmail => 'Indirizzo email';

  @override
  String get profileFieldEmailHint => 'Il tuo indirizzo email';

  @override
  String get profileSectionGemini => 'IMPOSTAZIONI COPILOT GEMINI';

  @override
  String get profileFieldGeminiKey => 'Chiave API Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Inserisci la tua chiave API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Prompt IA personalizzato';

  @override
  String get profileFieldAiPromptHint =>
      'Opzionale: personalizza il prompt di sistema per Gemini...';

  @override
  String get profileSectionDeepl => 'IMPOSTAZIONI DI TRADUZIONE DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL offre traduzione automatica di alta qualità con conservazione dei tag HTML. Gli account gratuiti (500.000 caratteri/mese) ricevono una chiave con il suffisso \":fx\".';

  @override
  String get profileFieldDeeplKey => 'Chiave API DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'es. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Le chiavi gratuite terminano con \":fx\" e utilizzano api-free.deepl.com. Le chiavi Pro utilizzano api.deepl.com. La distinzione viene effettuata automaticamente.';

  @override
  String get profileSectionSecurity => 'SICUREZZA DELL\'ACCOUNT';

  @override
  String get profileFieldCurrentPassword => 'Password attuale';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Inserisci la tua password attuale';

  @override
  String get profileFieldNewPassword => 'Nuova password';

  @override
  String get profileFieldNewPasswordHint => 'Almeno 6 caratteri';

  @override
  String get profileFieldConfirmPassword => 'Conferma la nuova password';

  @override
  String get profileFieldConfirmPasswordHint => 'Ripeti la password';

  @override
  String get profileChangePasswordButton => 'Cambia password';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get settingsRegistrationUpdated =>
      'Impostazione di registrazione aggiornata';

  @override
  String get settingsUpdateFailed => 'Aggiornamento non riuscito.';

  @override
  String get settingsUserApproved => 'Utente approvato!';

  @override
  String get settingsAccountDeactivated => 'Account disattivato.';

  @override
  String get settingsUserDeleted => 'Utente eliminato.';

  @override
  String get settingsActionFailed => 'Azione non riuscita.';

  @override
  String get settingsDeleteAccountTitle => 'Eliminare l\'account?';

  @override
  String get settingsDeactivateAccountTitle => 'Disattivare l\'account?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'L\'account \"$username\" verrà eliminato permanentemente. Continuare?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'L\'account \"$username\" verrà bloccato. L\'utente non potrà più accedere, ma l\'account verrà conservato.';
  }

  @override
  String get settingsDeactivate => 'Disattiva';

  @override
  String settingsSyncSuccess(String count) {
    return '$count traduzioni sincronizzate!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Errore di sincronizzazione: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count moduli prioritari sincronizzati!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Errore nella sincronizzazione dell\'elenco prioritario: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup riuscito: $count file elaborati.';
  }

  @override
  String get settingsUploadFailed => 'Caricamento non riuscito.';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSystemConfig => 'CONFIGURAZIONE DI SISTEMA';

  @override
  String get settingsRegistration => 'Registrazione';

  @override
  String get settingsRegistrationHint =>
      'Attiva o disattiva la visibilità globale del modulo di registrazione.';

  @override
  String get settingsPendingUsers => 'Utenti in attesa';

  @override
  String get settingsNoNewRequests => 'Nessuna nuova richiesta.';

  @override
  String get settingsWantsReviewer => 'Vuole diventare revisore';

  @override
  String get settingsAssignRole => 'Assegna ruolo';

  @override
  String get settingsRoleTranslator => 'Traduttore';

  @override
  String get settingsRoleReviewer => 'Revisore';

  @override
  String get settingsApprove => 'Approva';

  @override
  String get settingsReject => 'Rifiuta';

  @override
  String get settingsActiveUsers => 'Utenti attivi';

  @override
  String get settingsNoActiveUsers => 'Nessun utente attivo.';

  @override
  String get settingsDeactivateAccountTooltip => 'Disattiva';

  @override
  String get settingsDeleteAccountAction => 'Elimina account';

  @override
  String get settingsAppearance => 'Aspetto';

  @override
  String get settingsThemePearl => 'CHIARO (PERLA)';

  @override
  String get settingsThemeDark => 'SCURO';

  @override
  String get settingsThemeGlassy => 'VETRO';

  @override
  String get settingsThemeNature => 'NATURA';

  @override
  String get settingsThemeLiquid => 'LIQUIDO';

  @override
  String get settingsThemeStage => 'PALCO';

  @override
  String get settingsTypography => 'Tipografia';

  @override
  String get settingsFontHint =>
      'Modifica il tipo di carattere dell\'interfaccia.';

  @override
  String get settingsFontClean => 'Pulito';

  @override
  String get settingsFontFuturistic => 'Futuristico';

  @override
  String get settingsFontTech => 'Tecnologico';

  @override
  String get settingsWorkflowFun => 'Flusso di lavoro e divertimento';

  @override
  String get settingsConfettiTitle => 'Celebrazione del successo (coriandoli)';

  @override
  String get settingsConfettiHint =>
      'Mostra una piccola animazione quando il salvataggio va a buon fine.';

  @override
  String get settingsLargeUiTitle => 'Leggibilità avanzata (carattere grande)';

  @override
  String get settingsLargeUiHint =>
      'Aumenta le dimensioni dei caratteri e dei badge per una migliore leggibilità.';

  @override
  String get settingsAutoPTitle =>
      'Formattazione automatica dei paragrafi (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Racchiude automaticamente il testo semplice in paragrafi <p> quando un modulo viene caricato nella schermata di revisione. Equivale a fare clic manualmente sul pulsante ¶.';

  @override
  String get settingsDatabaseSync => 'Sincronizzazione del database';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sincronizza le voci del database con i file di traduzione JSON.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sincronizza le voci interne del database con i file JSON di traduzione sul server.';

  @override
  String get settingsSyncing => 'Sincronizzazione in corso...';

  @override
  String get settingsSyncNow => 'Sincronizza ora';

  @override
  String get settingsSyncD11List => 'Sincronizza elenco D11';

  @override
  String get settingsUploadBackup => 'Carica backup (.zip)';

  @override
  String get settingsSelectZipFile => 'Seleziona file ZIP';

  @override
  String get settingsUploading => 'Caricamento in corso...';

  @override
  String get settingsErrorDiagnostics => 'Diagnostica errori e log di sistema';

  @override
  String get settingsLogsCopied => 'Log copiati negli appunti! 📋';

  @override
  String get settingsCopyLogs => 'Copia log';

  @override
  String get settingsLogsRotated => 'Log archiviati e ruotati! 📁';

  @override
  String get settingsRotate => 'Ruota';

  @override
  String get settingsClear => 'Cancella';

  @override
  String get settingsLogLimit => 'Limite log: ';

  @override
  String get settingsNoLogs => 'Nessun log registrato';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Statistiche';

  @override
  String get layoutNavReviewQueue => 'Coda di revisione';

  @override
  String get layoutNavGlossary => 'Glossario';

  @override
  String get layoutNavCategories => 'Categorie';

  @override
  String get layoutNavHelp => 'Aiuto';

  @override
  String get layoutNavSettings => 'Impostazioni';

  @override
  String get layoutPhotoBy => 'Foto di ';

  @override
  String get layoutPhotoOn => ' su ';

  @override
  String get layoutEditProfile => 'Modifica profilo';

  @override
  String get layoutLogout => 'Esci';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Chiaro';

  @override
  String get layoutThemeDark => 'Scuro';

  @override
  String get layoutThemeGlassy => 'Vetro';

  @override
  String get layoutThemeNature => 'Natura';

  @override
  String get layoutThemeLiquid => 'Liquido';

  @override
  String get layoutThemeStage => 'Palco';

  @override
  String get layoutTargetLanguage => 'LINGUA DI DESTINAZIONE';

  @override
  String get layoutDeeplUsage => 'UTILIZZO DEEPL';

  @override
  String get layoutUnavailable => 'Non disponibile';

  @override
  String get layoutUnlimited => 'illimitato';

  @override
  String get layoutUsed => 'utilizzato';

  @override
  String get layoutTranslate => 'Traduci';

  @override
  String get analyticsSubtitle =>
      'Compatibilità, arretrato di traduzioni e tendenze settimanali.';

  @override
  String get analyticsBacklog => 'Arretrato di traduzioni';

  @override
  String get analyticsMissing => 'Mancanti';

  @override
  String get analyticsStale => 'Non aggiornati';

  @override
  String get analyticsInReview => 'In revisione';

  @override
  String get analyticsReleased => 'Pubblicati';

  @override
  String get analyticsTranslated => 'Tradotti';

  @override
  String get analyticsTotalModules => 'Totale moduli';

  @override
  String get analyticsCompatByVersion => 'Compatibilità per versione di Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Lingua: $lang · pubblicati / in revisione / mancanti';
  }

  @override
  String get analyticsLoadingCounts => 'Caricamento dei conteggi …';

  @override
  String get analyticsWindow => 'Periodo:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks settimane';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nuove descrizioni di progetti per settimana';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Contrassegnati come non aggiornati per settimana ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count moduli';
  }

  @override
  String get analyticsReviewShort => 'Revisione';

  @override
  String get analyticsNoDataInWindow => 'Nessun dato nel periodo selezionato.';

  @override
  String get analyticsAndMore => '… e altro';

  @override
  String glossaryLoadError(String error) {
    return 'Errore durante il caricamento: $error';
  }

  @override
  String get glossaryNewTerm => 'Crea nuovo termine';

  @override
  String get glossaryEditTerm => 'Modifica termine';

  @override
  String get glossaryFieldSourceWord =>
      'Parola di origine (forma base, come appare nel testo)';

  @override
  String get glossaryFieldSourceWordHint => 'es. node';

  @override
  String get glossaryWordForms =>
      'Forme aggiuntive della parola (plurale, genitivo, dativo…)';

  @override
  String get glossaryWordFormsHint =>
      'es. content — premi Invio per aggiungerla';

  @override
  String get glossaryAddForm => 'Aggiungi forma';

  @override
  String get glossaryFieldPreferredWord => 'Traduzione preferita';

  @override
  String get glossaryFieldPreferredWordHint => 'es. contenuto';

  @override
  String get glossaryFieldExplanation => 'Spiegazione (mostrata nel tooltip)';

  @override
  String get glossaryFieldExplanationHint =>
      'Perché questa parola dovrebbe essere tradotta diversamente?';

  @override
  String get glossaryCreate => 'Crea';

  @override
  String get glossaryRequiredFields =>
      'La parola di origine e la traduzione preferita sono obbligatorie.';

  @override
  String get glossaryCreated => 'Termine creato ✓';

  @override
  String get glossaryUpdated => 'Termine aggiornato ✓';

  @override
  String glossaryError(String error) {
    return 'Errore: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Eliminare il termine?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" verrà rimosso permanentemente dal glossario.';
  }

  @override
  String get glossaryDeleted => 'Termine eliminato.';

  @override
  String get glossaryTitle => 'Glossario di traduzione';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Lingua: $lang · $count voci';
  }

  @override
  String get glossaryNewShort => 'Nuovo';

  @override
  String get glossaryCreateTerm => 'Crea termine';

  @override
  String get glossaryInfoBanner =>
      'Le parole di questo glossario vengono evidenziate nell\'editor di revisione. Un tooltip spiega, al passaggio del mouse, perché una traduzione diversa è più adatta.';

  @override
  String get glossaryNoEntries => 'Ancora nessuna voce.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Fai clic su \"Crea termine\" per creare la prima voce.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Ancora nessuna voce del glossario per questa lingua.';

  @override
  String get diffNoChanges => 'Nessuna differenza di contenuto rilevata.';

  @override
  String get diffRemoved => 'Rimosso';

  @override
  String get diffAdded => 'Aggiunto';

  @override
  String syncBarQuickSync(String count) {
    return 'Sincronizzazione rapida: $count moduli modificati …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sincronizzazione completa: $current / $total moduli';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sincronizzazione completa: $count moduli …';
  }
}
