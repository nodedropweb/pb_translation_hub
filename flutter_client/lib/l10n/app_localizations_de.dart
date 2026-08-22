// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Projektdetails werden geladen...';

  @override
  String editorLoadError(String error) {
    return 'Fehler beim Laden der Projektdaten: $error';
  }

  @override
  String get editorGeminiSuccess => 'Übersetzung mit Gemini erfolgreich! ✨';

  @override
  String get editorUnknownError => 'Unbekannter Fehler';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini-Übersetzung fehlgeschlagen: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Bitte hinterlege deinen Google AI Key in deinem Benutzerprofil (nicht in den Admin-Einstellungen).';

  @override
  String get editorGeminiError =>
      'Fehler bei der Gemini-Übersetzung. Bitte deinen Google AI Key im Benutzerprofil prüfen.';

  @override
  String get editorDeeplSuccess => 'Übersetzung mit DeepL erfolgreich! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL Übersetzung fehlgeschlagen: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Fehler bei der DeepL Übersetzung. Bitte stelle sicher, dass dein DeepL API-Key im Profil hinterlegt ist.';

  @override
  String get editorDeeplInvalidKey =>
      'Ungültiger DeepL API-Key. Bitte im Profil prüfen.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL Kontingent erschöpft. Bitte Plan prüfen.';

  @override
  String get editorReviewReset =>
      'Übersetzung zurück in Review-Status gesetzt.';

  @override
  String editorResetError(String error) {
    return 'Fehler beim Zurücksetzen: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Modul wurde wieder in die aktive Liste aufgenommen.';

  @override
  String get editorUnignoreError => 'Fehler beim Einreihen des Moduls.';

  @override
  String get editorSaveSuccess =>
      'Übersetzung gespeichert – zurück in Review-Warteschlange.';

  @override
  String editorSaveError(String error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'Keine weiteren offenen Projekte in der Liste.';

  @override
  String get editorChangesDiscarded =>
      'Änderungen verworfen, lade nächstes Projekt...';

  @override
  String get editorEnglishSourceApplied =>
      'Englisches Original übernommen — bitte jetzt übersetzen.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Konnte URL nicht öffnen: $url';
  }

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonClose => 'Schließen';

  @override
  String get editorCloseEnglishSource => 'Englische Quelle schließen';

  @override
  String get editorShowEnglishSource => 'Englische Quelle einblenden';

  @override
  String get editorUnignoreShortTooltip => 'Modul wieder einreihen';

  @override
  String get editorBackToReviewTooltip => 'Zurück in Review setzen';

  @override
  String get editorAndNext => '& Weiter';

  @override
  String get editorBackToDashboard => 'Zurück zum Dashboard';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Übersetze nach $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count verbleibend';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Modul wieder in die aktive Liste aufnehmen';

  @override
  String get editorUnignoreLabel => 'Einreihen';

  @override
  String get editorUnpublishTooltip =>
      'Veröffentlichung zurücknehmen und zurück in Review setzen';

  @override
  String get editorBackToReview => 'Zurück in Review';

  @override
  String get editorSaveAndNext => 'Speichern & Weiter';

  @override
  String get editorEnglishSourceHeader => 'ENGLISCHE QUELLE';

  @override
  String get editorStaleTooltip =>
      'Erklärung anzeigen & englischen Text übernehmen';

  @override
  String get editorStaleDetailsLabel => 'Veraltet — Details';

  @override
  String get editorCopyPromptTooltip =>
      'Quelltext + Übersetzungsprompt kopieren';

  @override
  String get editorPromptCopied => 'Prompt in die Zwischenablage kopiert 📋';

  @override
  String get editorShowPreview => 'Vorschau anzeigen';

  @override
  String get editorShowHtmlSource => 'HTML-Quellcode anzeigen';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'ZUSAMMENFASSUNG:\n$summary\n\nHAUPTBESCHREIBUNG:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Zusammenfassung:';

  @override
  String get editorDescriptionLabelColon => 'Beschreibung:';

  @override
  String get editorStaleDialogTitle => 'Englische Quelle hat sich geändert';

  @override
  String get editorStaleExplanation =>
      'Die vorhandene Übersetzung basiert auf einem veralteten englischen Originaltext. Seit der letzten Übersetzung hat der Modulentwickler den englischen Text auf Drupal.org geändert — der Inhalt der alten Übersetzung ist daher möglicherweise nicht mehr korrekt oder vollständig.';

  @override
  String get editorStaleTip =>
      'Tipp: Klicke auf \"Englisch übernehmen\", um den aktuellen englischen Originaltext direkt in den Editor zu laden. Du kannst ihn dann als Ausgangspunkt für eine vollständige Neuübersetzung verwenden. Das englische Original ist zusätzlich im linken Panel sichtbar.';

  @override
  String get editorEnglishSourceShort => 'Englische Quelle';

  @override
  String get editorPreviousTranslation => 'Bisherige Übersetzung';

  @override
  String get editorWhatChangedTitle => 'Was hat sich geändert?';

  @override
  String get editorShowDiff => 'Diff anzeigen';

  @override
  String get editorUseEnglish => 'Englisch übernehmen';

  @override
  String get editorStaleBannerText =>
      'Englische Quelle hat sich geändert — Übersetzung veraltet';

  @override
  String get editorDetailsAndApply => 'Details & Übernehmen';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName ÜBERSETZUNG';
  }

  @override
  String get editorTranslatingEllipsis => 'Übersetze...';

  @override
  String get editorShowEditor => 'Editor anzeigen';

  @override
  String get editorModuleTitleLabel => 'Modul-Titel (Englisch)';

  @override
  String get editorSummaryFieldLabel => 'Zusammenfassung';

  @override
  String get editorBodyFieldLabel => 'Hauptbeschreibung';

  @override
  String get editorHtmlCleaned => 'HTML bereinigt';

  @override
  String get editorLivePreviewHeader => 'LIVE-VORSCHAU';

  @override
  String get editorTidyHtmlTooltip =>
      'HTML bereinigen (DeepL-Artefakte entfernen)';

  @override
  String get editorVisualMode => 'VISUELL';

  @override
  String get editorSourceCodeMode => 'QUELLCODE (HTML)';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get costDialogTitle => 'Kosten-Vorkalkulation (AI)';

  @override
  String get costDialogIntro =>
      'Das ausgewählte Modul wird mit Google Gemini AI übersetzt. Hier ist die geschätzte Kostenaufstellung für diesen Vorgang:';

  @override
  String get costRowModel => 'Modell';

  @override
  String get costRowInputTokens => 'Eingabe-Tokens';

  @override
  String get costRowOutputTokens => 'Ausgabe-Tokens (Schätzung)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars Zeichen)';
  }

  @override
  String get costRowPriceInput => 'Preis pro 1M Input';

  @override
  String get costRowPriceOutput => 'Preis pro 1M Output';

  @override
  String get costRowTotalEstimate => 'Geschätzte Gesamtkosten';

  @override
  String get costDialogFootnote =>
      '* Hinweis: Dies ist eine Schätzung basierend auf dem aktuellen Google Pay-as-you-go Preismodell. Der tatsächliche Verbrauch kann minimal variieren.';

  @override
  String get costDialogStartTranslation => 'Übersetzung starten';

  @override
  String get htmlToolbarInsertLink => 'Link einfügen';

  @override
  String get htmlToolbarLinkTooltip => 'Link einfügen (a)';

  @override
  String get htmlToolbarInsert => 'Einfügen';

  @override
  String get htmlToolbarHeading2 => 'Überschrift 2';

  @override
  String get htmlToolbarHeading3 => 'Überschrift 3';

  @override
  String get htmlToolbarBold => 'Fett (strong)';

  @override
  String get htmlToolbarItalic => 'Kursiv (em)';

  @override
  String get htmlToolbarBulletList => 'Aufzählung (ul)';

  @override
  String get htmlToolbarNumberedList => 'Nummerierung (ol)';

  @override
  String get htmlToolbarQuote => 'Zitat (blockquote)';

  @override
  String get screenshotAltsHeader => 'SCREENSHOT ALT-TEXTE';

  @override
  String get screenshotAltsIntro =>
      'Gib für jeden Screenshot einen beschreibenden Alt-Text in der Zielsprache ein.';

  @override
  String screenshotLabel(int number) {
    return 'Screenshot $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Vorschau nicht verfügbar';

  @override
  String get screenshotAltHint => 'Alt-Text in Zielsprache eingeben…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Alle ignorieren aufheben?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Alle ignorierten Module werden wieder in die aktive Liste aufgenommen und stehen erneut zur Übersetzung bereit.';

  @override
  String get dashUnignoreAllConfirmAction => 'Alle einreihen';

  @override
  String get dashUnignoreAllSuccess =>
      'Alle ignorierten Module wurden wieder eingereiht.';

  @override
  String get dashUnignoreAllError => 'Fehler beim Einreihen der Module.';

  @override
  String get dashUnignoreAllButton => 'Alle wieder einreihen';

  @override
  String dashSyncStartError(String error) {
    return 'Fehler beim Starten des Syncs: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Schnell-Update (7 Tage) gestartet ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Fehler beim Schnell-Update: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Erfolgreich synchronisiert: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modul nicht auf Drupal.org gefunden.';

  @override
  String get dashAiBulkTranslation => 'AI Massen-Übersetzung';

  @override
  String get dashHeaderTitle => 'Projekt-Beschreibungen';

  @override
  String get dashHeaderSubtitle =>
      'Übersetzung von Drupal-Modulbeschreibungen in die Zielsprache. Hilf mit, das Ökosystem zugänglicher zu machen.';

  @override
  String get dashHeaderSubtitleShort =>
      'Übersetzung von Drupal-Modulbeschreibungen.';

  @override
  String get dashLastLabel => 'Zuletzt: ';

  @override
  String get dashContinue => 'Weitermachen';

  @override
  String get dashContinueShort => 'Weiter';

  @override
  String get dashUnignoreAllButtonLong => 'Alle wieder einreihen';

  @override
  String get dashQuickUpdateTooltip => 'Schnelles Update (letzte 7 Tage)';

  @override
  String get dashFullSyncTooltip =>
      'Vollständiger Datenbank-Sync von Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Einzelnes Modul manuell von Drupal.org laden';

  @override
  String get dashQuickShort => 'Schnell';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Gefunden: ';

  @override
  String get dashModulesSuffix => ' Module';

  @override
  String dashPerPage(int count) {
    return '$count pro Seite';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / Seite';
  }

  @override
  String get dashFirstPage => 'Erste Seite';

  @override
  String get dashPrevPage => 'Vorherige Seite';

  @override
  String get dashNextPage => 'Nächste Seite';

  @override
  String get dashLastPage => 'Letzte Seite';

  @override
  String dashPageOf(int page, int total) {
    return 'Seite $page von $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (z. B. pathauto)';

  @override
  String get dashAddButton => 'Hinzufügen';

  @override
  String get dashAddModuleManually => 'Modul manuell hinzufügen';

  @override
  String get dashAddModuleSubtitle =>
      'Direkt von Drupal.org per Machine Name laden.';

  @override
  String get dashAddModuleShort => 'Modul hinzufügen';

  @override
  String get dashNoProjectsFound => 'Keine Projekte gefunden.';

  @override
  String get dashFilterAll => 'Alle Projekte';

  @override
  String get dashFilterMissing => 'Fehlende Übersetzungen';

  @override
  String get dashFilterReview => 'Review-Warteschlange';

  @override
  String get dashFilterTranslated => 'Übersetzte Projekte';

  @override
  String get dashFilterReleased => 'Freigegebene Projekte';

  @override
  String get dashBulkDialogIntro =>
      'Übersetze mehrere Module aus dem ausgewählten Filter automatisch mit Google Gemini.';

  @override
  String get dashActiveFilter => 'Aktiver Filter';

  @override
  String get dashModuleCount => 'Anzahl Module';

  @override
  String dashModulesCountItem(int count) {
    return '$count Module';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12 Module priorisieren';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Übersetzt bevorzugt Module ohne Drupal 12 Unterstützung zuerst';

  @override
  String get dashTotalModules => 'Module gesamt';

  @override
  String get dashInputTokensEst => 'Eingabe-Tokens (Schätzung)';

  @override
  String get dashOutputTokensEst => 'Ausgabe-Tokens (Schätzung)';

  @override
  String get dashBulkFootnote =>
      '* Die Übersetzung wird in ressourcenschonenden Batches ausgeführt, um Timeouts zu verhindern.';

  @override
  String get dashStartBulkTranslation => 'Massen-Übersetzung starten';

  @override
  String dashStaleLoadError(String error) {
    return 'Fehler beim Laden der veralteten Module: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Keine veralteten Module gefunden — alles aktuell! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Veraltete Module neu übersetzen';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Alle Übersetzungen, deren englische Quelle sich seit der letzten Übersetzung geändert hat, werden automatisch mit Google Gemini neu übersetzt. Kein manuelles Öffnen jedes Moduls nötig.';

  @override
  String get dashOutdatedModules => 'Veraltete Module';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Die Übersetzung ersetzt den bisherigen Text und setzt is_reviewed zurück. Ausführung in Batches à 4 Modulen.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Alle $count Module neu übersetzen';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Veraltete Module werden neu übersetzt…';

  @override
  String get dashFetchingProjects => 'Projekte werden vom Server abgerufen…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed von $total Modulen verarbeitet';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Keine übersetzbaren Projekte in diesem Filter gefunden.';

  @override
  String get dashStartingTranslation => 'Übersetzung wird gestartet…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Übersetze Modul $start–$end von $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end von $total Modulen abgeschlossen.';
  }

  @override
  String get dashTranslationCompleted =>
      'Übersetzung erfolgreich abgeschlossen! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Massen-Übersetzung von $count Modulen erfolgreich! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Fehler bei der Massen-Übersetzung: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Alle $count Module erfolgreich neu übersetzt! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count veraltete Module erfolgreich neu übersetzt! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Fehler bei der Stale-Übersetzung: $error';
  }

  @override
  String get filterAllShort => 'Alle';

  @override
  String get filterMissing => 'Fehlend';

  @override
  String get filterTranslated => 'Übersetzt';

  @override
  String get filterReviewQueue => 'Review';

  @override
  String get filterReleased => 'Freigegeben';

  @override
  String get filterOutdated => 'Veraltet';

  @override
  String get filterPriority => 'Priorität';

  @override
  String get filterIgnored => 'Ignoriert';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonReset => 'Zurücksetzen';

  @override
  String get commonRefresh => 'Aktualisieren';

  @override
  String commonErrorPrefix(String error) {
    return 'Fehler: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Alle veröffentlichten Übersetzungen zurücksetzen?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Alle als \"Veröffentlicht\" markierten Übersetzungen für $langcode werden auf den Review-Status zurückgesetzt. Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count Übersetzungen zurück in Review gesetzt.';
  }

  @override
  String get reviewPipelineTitle => 'Review-Warteschlange';

  @override
  String get reviewPipelineSubtitle =>
      'Menschliche Endabnahme für automatische Übersetzungen';

  @override
  String get reviewSearchHint => 'Projekt suchen...';

  @override
  String get reviewResetPublished => 'Freigaben zurücksetzen';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Treffer: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Wartend: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Keine Projekte ausstehend.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Alle Übersetzungen wurden bereits geprüft oder es sind keine Übersetzungen vorhanden.';

  @override
  String get reviewNoSummary => 'Keine Zusammenfassung.';

  @override
  String get reviewStartAudit => 'AUDIT STARTEN';

  @override
  String get reviewHtmlSourceShort => 'HTML-Quellcode';

  @override
  String get reviewCopySource => 'Quelltext kopieren';

  @override
  String get reviewModuleDetails => 'Modul Details';

  @override
  String get reviewOriginalTitle => 'Original-Titel';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org-Projekt';

  @override
  String get reviewSuggestions => 'Vorschläge';

  @override
  String get reviewNoSuggestions => 'Keine Vorschläge vorhanden.';

  @override
  String get reviewApply => 'Übernehmen';

  @override
  String get reviewNoChanges => 'Keine Änderungen';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (vor der Korrektur)';

  @override
  String get reviewCorrectedCurrentVersion => 'Korrigiert (aktuelle Version)';

  @override
  String get reviewBaseOriginal => 'Basis (Original)';

  @override
  String get reviewYourCorrection => 'Deine Korrektur';

  @override
  String get reviewChangesVisual => 'Änderungen prüfen (Visuell)';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonIgnore => 'Ignorieren';

  @override
  String get reviewEmptyProjectTitle => 'Leeres Projekt';

  @override
  String get reviewEmptyProjectBody =>
      'Dieses Projekt ist leer (kein Titel, Zusammenfassung oder Inhalt) und kann nicht freigegeben werden. Bitte überspringen Sie es.';

  @override
  String get reviewApprovedSuccess => 'Übersetzung freigegeben! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Freigabe von \"$machine\" fehlgeschlagen — bitte erneut versuchen.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Ignorieren aufgehoben. Modul ist wieder aktiv!';

  @override
  String get reviewActionFailed => 'Aktion fehlgeschlagen.';

  @override
  String get reviewIgnoreModuleTitle => 'Modul ignorieren?';

  @override
  String get reviewIgnoreModuleBody =>
      'Dieses Modul wird dauerhaft aus allen Listen ausgeblendet. Du bleibst nicht mehr daran hängen.';

  @override
  String get reviewModulePermanentlyIgnored => 'Modul dauerhaft ausgeblendet.';

  @override
  String get reviewIgnoreFailed => 'Ignorieren fehlgeschlagen.';

  @override
  String get reviewSuggestionSaved => 'Vorschlag gespeichert! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'Speichern fehlgeschlagen.';

  @override
  String get reviewSuggestionDeleted => 'Vorschlag gelöscht.';

  @override
  String get reviewDeleteFailed => 'Löschen fehlgeschlagen.';

  @override
  String get reviewSuggestionApplied => 'Vorschlag übernommen.';

  @override
  String get reviewPreparingData => 'Review-Daten werden vorbereitet...';

  @override
  String get reviewDirectEdit => 'Direkt-Editor';

  @override
  String get reviewLivePreview => 'Vorschau';

  @override
  String get reviewCompareWith => 'Vergleichen mit:';

  @override
  String get reviewProductionVersion => 'Produktions-Version';

  @override
  String get reviewEditorialReview => 'Redaktionelle Überarbeitung';

  @override
  String get reviewOpenQueue => 'Review-Warteschlange öffnen';

  @override
  String get reviewCopyPromptShort => 'Prompt kopieren';

  @override
  String get reviewUnignoreShort => 'Ignorieren aufheben';

  @override
  String get reviewApproveButton => 'FREIGEBEN';

  @override
  String get reviewHideDetails => 'Details ausblenden';

  @override
  String get reviewDetailsAndEnglishSource => 'Details & Englische Quelle';

  @override
  String reviewPendingCountShort(int count) {
    return '$count ausstehend';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Überprüfung von $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Übersetzung mit englischer Quelle vergleichen';

  @override
  String get reviewTranslationLabel => 'Übersetzung';

  @override
  String get reviewComparisonTitle => 'Vergleich';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Quelltext + Übersetzungsprompt in die Zwischenablage kopieren';

  @override
  String get reviewUnignoreCaps => 'IGNORIEREN AUFHEBEN';

  @override
  String get reviewIgnoreCaps => 'IGNORIEREN';

  @override
  String get reviewSkipShortcut => 'ÜBERSPRINGEN (Strg+→)';

  @override
  String get reviewEditorialReviewShort => 'Redakt. Überarbeitung';

  @override
  String get reviewUnignoreTablet => 'EINREIHEN';

  @override
  String get reviewApproveForProduction =>
      'FREIGEBEN FÜR PRODUKTION (Strg+Enter)';

  @override
  String get reviewDirectRefinement => 'Manuelle Korrektur';

  @override
  String get reviewTitleField => 'Titel';

  @override
  String get reviewSummaryField => 'Zusammenfassung (Summary)';

  @override
  String get reviewBodyField => 'Hauptinhalt (Body)';

  @override
  String get reviewSaveShortcut => 'SPEICHERN (Strg+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Live Vorschau (Rendering)';

  @override
  String get reviewVoiceFemale => 'Weiblich';

  @override
  String get reviewVoiceMale => 'Männlich';

  @override
  String get reviewStopListening => 'Stoppen';

  @override
  String get reviewListen => 'Anhören';

  @override
  String get reviewAutopTooltip =>
      'Absätze automatisch formatieren (Zeilenumbrüche → <p>)';

  @override
  String get reviewSourceCodeShort => 'QUELLCODE';

  @override
  String get reviewNoParagraphChange =>
      'Text enthält bereits <p>-Tags — keine Änderung';

  @override
  String get reviewParagraphsFormatted => 'Absätze formatiert ¶';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String categoriesLoadError(String error) {
    return 'Fehler beim Laden der Kategorien: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategorien erfolgreich gespeichert.';

  @override
  String get categoriesSaveFailed => 'Fehler beim Speichern.';

  @override
  String get categoriesFileEmpty => 'Datei ist leer.';

  @override
  String get categoriesInvalidJson => 'Ungültiges JSON-Format.';

  @override
  String get categoriesNoValidUuids => 'Keine gültigen UUID-Einträge gefunden.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count Kategorien aus Datei importiert.';
  }

  @override
  String get categoriesTitle => 'Kategorien';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Übersetzung für: $lang';
  }

  @override
  String get categoriesImportJson => 'JSON importieren';

  @override
  String get categoriesSaving => 'Speichert...';

  @override
  String get categoriesSaveAll => 'Alle speichern';

  @override
  String get categoriesLoading => 'Lade Kategorien...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Übersetzung ($code)';
  }

  @override
  String get categoriesNoneFound => 'Keine Kategorien gefunden.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Übersetze \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto von ';

  @override
  String get loginPhotoOn => ' auf ';

  @override
  String get loginPleaseSignIn => 'Bitte melde dich an';

  @override
  String get loginUsername => 'Benutzername';

  @override
  String get loginPassword => 'Passwort';

  @override
  String get loginRememberMe => 'Angemeldet bleiben';

  @override
  String get loginSignIn => 'ANMELDEN';

  @override
  String get loginNoAccount => 'Noch kein Account? ';

  @override
  String get loginRegisterNow => 'Jetzt registrieren';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonNext => 'Weiter';

  @override
  String get registerFillRequired => 'Bitte alle Pflichtfelder ausfüllen.';

  @override
  String get registerPasswordMismatch => 'Passwörter stimmen nicht überein.';

  @override
  String get registerPasswordTooShort =>
      'Passwort muss mindestens 8 Zeichen haben.';

  @override
  String get registerSelectLanguage => 'Bitte mindestens eine Sprache wählen.';

  @override
  String get registerFailed => 'Registrierung fehlgeschlagen.';

  @override
  String get registerHeaderTitle => 'REGISTRIERUNG';

  @override
  String get registerStepAccount => 'Account';

  @override
  String get registerStepRole => 'Rolle';

  @override
  String get registerStepLanguages => 'Sprachen';

  @override
  String get registerStepApiKeys => 'API-Keys';

  @override
  String get registerYourAccount => 'Dein Account';

  @override
  String get registerAvatarOptional => 'Avatar (optional)';

  @override
  String get registerUsernameRequired => 'Benutzername *';

  @override
  String get registerEmailRequired => 'E-Mail-Adresse *';

  @override
  String get registerPasswordRequired => 'Passwort *';

  @override
  String get registerPasswordRepeat => 'Passwort wiederholen *';

  @override
  String get registerYourRole => 'Deine Rolle';

  @override
  String get registerRoleExplanation =>
      'Übersetzer können Texte übersetzen, haben aber keinen Zugriff auf die Review-Warteschlange. Reviewer prüfen und geben übersetzte Inhalte frei.';

  @override
  String get registerRoleTranslator => 'Übersetzer';

  @override
  String get registerRoleTranslatorDesc =>
      'Erstelle und bearbeite Übersetzungen.';

  @override
  String get registerRoleReviewer => 'Reviewer';

  @override
  String get registerRoleReviewerDesc => 'Prüfe und gebe Übersetzungen frei.';

  @override
  String get registerTargetLanguages => 'Zielsprachen';

  @override
  String get registerLanguagesExplanation =>
      'Wähle alle Sprachen, für die du tätig sein möchtest.';

  @override
  String get registerNoLanguagesAvailable => 'Keine Sprachen verfügbar.';

  @override
  String get registerApiKeysTitle => 'API-Keys';

  @override
  String get registerApiKeysExplanation =>
      'Trage deine eigenen API-Keys ein. Jeder Nutzer verwendet ausschließlich seine eigenen Keys. Du kannst diese auch später in deinem Profil nachtragen.';

  @override
  String get registerKeysEncryptedNote =>
      'Keys werden verschlüsselt gespeichert und niemals mit anderen Nutzern geteilt.';

  @override
  String get registerOptionalSuffix => ' (optional)';

  @override
  String get registerSuccessTitle => 'Registrierung erfolgreich!';

  @override
  String get registerSuccessBody =>
      'Dein Account wurde angelegt und wartet auf die Freischaltung durch einen Administrator. Du wirst benachrichtigt, sobald dein Zugang aktiviert wurde.';

  @override
  String get registerGoToLogin => 'Zur Anmeldung';

  @override
  String get registerSubmit => 'Registrieren';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto von $name auf Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil erfolgreich aktualisiert!';

  @override
  String get profileUpdateFailed => 'Aktualisierung fehlgeschlagen.';

  @override
  String profileSaveError(String error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get profilePasswordMismatch => 'Passwörter stimmen nicht überein!';

  @override
  String get profilePasswordChangeSuccess => 'Passwort erfolgreich geändert!';

  @override
  String get profilePasswordChangeError =>
      'Fehler beim Ändern des Passworts: Falsches aktuelles Passwort.';

  @override
  String get profileAvatarUploadSuccess =>
      'Profilbild erfolgreich hochgeladen!';

  @override
  String get profileAvatarUploadError =>
      'Fehler beim Hochladen des Profilbildes.';

  @override
  String get profileTitle => 'Profil & Einstellungen';

  @override
  String get profileSubtitle =>
      'Verwalte dein Benutzerprofil, deine Übersetzungs-APIs (Gemini & DeepL) und deine Kontosicherheit.';

  @override
  String get profileRoleUser => 'Benutzer';

  @override
  String get profileNoEmail => 'Keine E-Mail angegeben';

  @override
  String get profileTabDetails => 'Profildetails';

  @override
  String get profileTabGemini => 'AI translation (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL Übersetzung';

  @override
  String get profileTabPassword => 'Passwort ändern';

  @override
  String get profileSectionInfo => 'PROFIL INFORMATIONEN';

  @override
  String get profileFieldName => 'Name';

  @override
  String get profileFieldNameHint => 'Dein voller Name';

  @override
  String get profileFieldEmail => 'E-Mail Adresse';

  @override
  String get profileFieldEmailHint => 'Deine E-Mail Adresse';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT EINSTELLUNGEN';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API Key';

  @override
  String get profileFieldGeminiKeyHint =>
      'Gib deinen gemini-3.1-flash API-Schlüssel ein';

  @override
  String get profileFieldAiPrompt => 'Individueller AI-Prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Optional: Passe den System-Prompt für Gemini an...';

  @override
  String get profileSectionDeepl => 'DEEPL ÜBERSETZUNGS-EINSTELLUNGEN';

  @override
  String get profileDeeplDescription =>
      'DeepL bietet hochwertige maschinelle Übersetzung mit HTML-Tag-Erhaltung. Kostenlose Accounts (500.000 Zeichen/Monat) erhalten einen Key mit dem Suffix \":fx\".';

  @override
  String get profileFieldDeeplKey => 'DeepL API Key';

  @override
  String get profileFieldDeeplKeyHint =>
      'z.B. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Free-Keys enden auf \":fx\" und verwenden api-free.deepl.com. Pro-Keys verwenden api.deepl.com. Die Unterscheidung erfolgt automatisch.';

  @override
  String get profileSectionSecurity => 'KONTOSICHERHEIT';

  @override
  String get profileFieldCurrentPassword => 'Aktuelles Passwort';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Gib dein aktuelles Passwort ein';

  @override
  String get profileFieldNewPassword => 'Neues Passwort';

  @override
  String get profileFieldNewPasswordHint => 'Mindestens 6 Zeichen';

  @override
  String get profileFieldConfirmPassword => 'Neues Passwort bestätigen';

  @override
  String get profileFieldConfirmPasswordHint => 'Passwort wiederholen';

  @override
  String get profileChangePasswordButton => 'Passwort ändern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get settingsRegistrationUpdated =>
      'Registrierungseinstellung aktualisiert';

  @override
  String get settingsUpdateFailed => 'Update fehlgeschlagen.';

  @override
  String get settingsUserApproved => 'Nutzer freigeschaltet!';

  @override
  String get settingsAccountDeactivated => 'Konto gesperrt.';

  @override
  String get settingsUserDeleted => 'Nutzer gelöscht.';

  @override
  String get settingsActionFailed => 'Aktion fehlgeschlagen.';

  @override
  String get settingsDeleteAccountTitle => 'Konto löschen?';

  @override
  String get settingsDeactivateAccountTitle => 'Konto sperren?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Das Konto von \"$username\" wird unwiderruflich gelöscht. Fortfahren?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Das Konto von \"$username\" wird gesperrt. Der Nutzer kann sich nicht mehr anmelden, das Konto bleibt aber erhalten.';
  }

  @override
  String get settingsDeactivate => 'Sperren';

  @override
  String settingsSyncSuccess(String count) {
    return '$count Übersetzungen synchronisiert!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Fehler bei der Synchronisation: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count Priority-Module synchronisiert!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Fehler beim Synchronisieren der Priority-Liste. Wurde die Liste schon generiert? ($error)';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup erfolgreich: $count Dateien verarbeitet.';
  }

  @override
  String get settingsUploadFailed => 'Upload fehlgeschlagen.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSystemConfig => 'SYSTEM-KONFIGURATION';

  @override
  String get settingsRegistration => 'Registrierung';

  @override
  String get settingsRegistrationHint =>
      'Schalte das Registrierungsformular global an oder aus.';

  @override
  String get settingsPendingUsers => 'Wartende Nutzer';

  @override
  String get settingsNoNewRequests => 'Keine neuen Anfragen.';

  @override
  String get settingsWantsReviewer => 'Möchte Reviewer werden';

  @override
  String get settingsAssignRole => 'Rolle zuweisen';

  @override
  String get settingsRoleTranslator => 'Übersetzer';

  @override
  String get settingsRoleReviewer => 'Reviewer';

  @override
  String get settingsApprove => 'Freischalten';

  @override
  String get settingsReject => 'Ablehnen';

  @override
  String get settingsActiveUsers => 'Aktive Benutzer';

  @override
  String get settingsNoActiveUsers => 'Keine aktiven Benutzer.';

  @override
  String get settingsDeactivateAccountTooltip => 'Konto sperren';

  @override
  String get settingsDeleteAccountAction => 'Konto löschen';

  @override
  String get settingsAppearance => 'Erscheinungsbild';

  @override
  String get settingsThemePearl => 'HELL (PERLE)';

  @override
  String get settingsThemeDark => 'DUNKEL';

  @override
  String get settingsThemeGlassy => 'GLASIG';

  @override
  String get settingsThemeNature => 'NATUR';

  @override
  String get settingsThemeLiquid => 'FLÜSSIG';

  @override
  String get settingsThemeStage => 'BÜHNE';

  @override
  String get settingsTypography => 'Typografie';

  @override
  String get settingsFontHint => 'Schriftstil der Benutzeroberfläche ändern.';

  @override
  String get settingsFontClean => 'Klar';

  @override
  String get settingsFontFuturistic => 'Futuristisch';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Workflow & Spaß';

  @override
  String get settingsConfettiTitle => 'Erfolgs-Feier (Konfetti)';

  @override
  String get settingsConfettiHint =>
      'Zeigt eine kleine Animation beim erfolgreichen Speichern.';

  @override
  String get settingsLargeUiTitle => 'Verbesserte Lesbarkeit (Große Schrift)';

  @override
  String get settingsLargeUiHint =>
      'Vergrößert die Schrift und Badges für bessere Sichtbarkeit.';

  @override
  String get settingsAutoPTitle => 'Automatische Absatzformatierung (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Wandelt einfachen Text automatisch in <p>-Absätze um, sobald ein Modul im Review-Screen geladen wird. Entspricht dem manuellen Klick auf den ¶-Button.';

  @override
  String get settingsDatabaseSync => 'Datenbank-Sync';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Gleicht die DB mit den JSON-Dateien auf dem Server ab.';

  @override
  String get settingsDatabaseSyncHint =>
      'Gleicht die internen Datenbank-Einträge mit den JSON-Dateien auf dem Server ab.';

  @override
  String get settingsSyncing => 'Synchronisiere...';

  @override
  String get settingsSyncNow => 'Jetzt synchronisieren';

  @override
  String get settingsSyncD11List => 'D11 Liste einlesen';

  @override
  String get settingsUploadBackup => 'Backup einspielen (.zip)';

  @override
  String get settingsSelectZipFile => 'ZIP Datei auswählen';

  @override
  String get settingsUploading => 'Lade hoch...';

  @override
  String get settingsErrorDiagnostics => 'Fehler-Diagnose & System-Logs';

  @override
  String get settingsLogsCopied => 'Logs in Zwischenablage kopiert! 📋';

  @override
  String get settingsCopyLogs => 'Kopieren';

  @override
  String get settingsLogsRotated => 'Logs archiviert und rotiert! 📁';

  @override
  String get settingsRotate => 'Rotieren';

  @override
  String get settingsClear => 'Löschen';

  @override
  String get settingsLogLimit => 'Loglimit: ';

  @override
  String get settingsNoLogs => 'Keine Logs vorhanden';

  @override
  String get layoutMenu => 'Navigation';

  @override
  String get layoutNavAnalytics => 'Statistik';

  @override
  String get layoutNavReviewQueue => 'Review Warteschlange';

  @override
  String get layoutNavGlossary => 'Glossar';

  @override
  String get layoutNavCategories => 'Kategorien';

  @override
  String get layoutNavHelp => 'Hilfe';

  @override
  String get layoutNavSettings => 'Einstellungen';

  @override
  String get layoutPhotoBy => 'Foto von ';

  @override
  String get layoutPhotoOn => ' auf ';

  @override
  String get layoutEditProfile => 'Profil bearbeiten';

  @override
  String get layoutLogout => 'Abmelden';

  @override
  String get layoutThemeLabel => 'DESIGN';

  @override
  String get layoutThemePearl => 'Hell';

  @override
  String get layoutThemeDark => 'Dunkel';

  @override
  String get layoutThemeGlassy => 'Glasig';

  @override
  String get layoutThemeNature => 'Natur';

  @override
  String get layoutThemeLiquid => 'Flüssig';

  @override
  String get layoutThemeStage => 'Bühne';

  @override
  String get layoutTargetLanguage => 'ZIELSPRACHE';

  @override
  String get layoutDeeplUsage => 'DEEPL VERBRAUCH';

  @override
  String get layoutUnavailable => 'Nicht verfügbar';

  @override
  String get layoutUnlimited => 'unbegrenzt';

  @override
  String get layoutUsed => 'verbraucht';

  @override
  String get layoutTranslate => 'Übersetzen';

  @override
  String get analyticsSubtitle =>
      'Kompatibilität, Übersetzungsbedarf und Wochen-Verlauf.';

  @override
  String get analyticsBacklog => 'Übersetzungsbedarf';

  @override
  String get analyticsMissing => 'Fehlend';

  @override
  String get analyticsStale => 'Veraltet';

  @override
  String get analyticsInReview => 'Im Review';

  @override
  String get analyticsReleased => 'Freigegeben';

  @override
  String get analyticsTranslated => 'Übersetzt';

  @override
  String get analyticsTotalModules => 'Module gesamt';

  @override
  String get analyticsCompatByVersion => 'Kompatibilität pro Drupal-Version';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Sprache: $lang · freigegeben / im Review / fehlend';
  }

  @override
  String get analyticsLoadingCounts => 'Lade Zähler …';

  @override
  String get analyticsWindow => 'Zeitraum:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks Wochen';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Neue Projektbeschreibungen pro Woche';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Als veraltet markiert pro Woche ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count Module';
  }

  @override
  String get analyticsReviewShort => 'Review';

  @override
  String get analyticsNoDataInWindow => 'Keine Daten im Zeitraum.';

  @override
  String get analyticsAndMore => '… und weitere';

  @override
  String glossaryLoadError(String error) {
    return 'Fehler beim Laden: $error';
  }

  @override
  String get glossaryNewTerm => 'Neuen Begriff anlegen';

  @override
  String get glossaryEditTerm => 'Begriff bearbeiten';

  @override
  String get glossaryFieldSourceWord =>
      'Quellwort (Grundform, erscheint im Text)';

  @override
  String get glossaryFieldSourceWordHint => 'z. B. Knoten';

  @override
  String get glossaryWordForms =>
      'Weitere Wortformen (Plural, Genitiv, Dativ …)';

  @override
  String get glossaryWordFormsHint => 'z. B. Inhalte — Enter zum Hinzufügen';

  @override
  String get glossaryAddForm => 'Form hinzufügen';

  @override
  String get glossaryFieldPreferredWord => 'Bevorzugte Übersetzung';

  @override
  String get glossaryFieldPreferredWordHint => 'z. B. Inhalt';

  @override
  String get glossaryFieldExplanation =>
      'Erklärung (wird im Tooltip angezeigt)';

  @override
  String get glossaryFieldExplanationHint =>
      'Warum soll dieses Wort anders übersetzt werden?';

  @override
  String get glossaryCreate => 'Anlegen';

  @override
  String get glossaryRequiredFields =>
      'Quellwort und bevorzugte Übersetzung sind Pflichtfelder.';

  @override
  String get glossaryCreated => 'Begriff angelegt ✓';

  @override
  String get glossaryUpdated => 'Begriff aktualisiert ✓';

  @override
  String glossaryError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Begriff löschen?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" wird dauerhaft aus dem Glossar entfernt.';
  }

  @override
  String get glossaryDeleted => 'Begriff gelöscht.';

  @override
  String get glossaryTitle => 'Übersetzungs-Glossar';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Sprache: $lang · $count Einträge';
  }

  @override
  String get glossaryNewShort => 'Neu';

  @override
  String get glossaryCreateTerm => 'Begriff anlegen';

  @override
  String get glossaryInfoBanner =>
      'Wörter aus diesem Glossar werden im Review-Editor farblich hervorgehoben. Ein Tooltip erklärt beim Überfahren warum eine andere Übersetzung besser passt.';

  @override
  String get glossaryNoEntries => 'Noch keine Einträge.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klicke auf „Begriff anlegen“ um den ersten Eintrag zu erstellen.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Noch keine Glossar-Einträge für diese Sprache.';

  @override
  String get diffNoChanges => 'Keine inhaltlichen Unterschiede erkannt.';

  @override
  String get diffRemoved => 'Entfernt';

  @override
  String get diffAdded => 'Hinzugefügt';

  @override
  String syncBarQuickSync(String count) {
    return 'Quick Sync: $count geänderte Module …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Full Sync: $current / $total Module';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Full Sync: $count Module …';
  }
}
