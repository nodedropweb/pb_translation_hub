import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('az'),
    Locale('ca'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('lt'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ro'),
    Locale('ru'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'PB Translation Hub'**
  String get appTitle;

  /// No description provided for @editorLoadingProject.
  ///
  /// In de, this message translates to:
  /// **'Projektdetails werden geladen...'**
  String get editorLoadingProject;

  /// No description provided for @editorLoadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden der Projektdaten: {error}'**
  String editorLoadError(String error);

  /// No description provided for @editorGeminiSuccess.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung mit Gemini erfolgreich! ✨'**
  String get editorGeminiSuccess;

  /// No description provided for @editorUnknownError.
  ///
  /// In de, this message translates to:
  /// **'Unbekannter Fehler'**
  String get editorUnknownError;

  /// No description provided for @editorGeminiFailed.
  ///
  /// In de, this message translates to:
  /// **'Gemini-Übersetzung fehlgeschlagen: {detail}'**
  String editorGeminiFailed(String detail);

  /// No description provided for @editorGeminiKeyMissing.
  ///
  /// In de, this message translates to:
  /// **'Bitte hinterlege deinen Google AI Key in deinem Benutzerprofil (nicht in den Admin-Einstellungen).'**
  String get editorGeminiKeyMissing;

  /// No description provided for @editorGeminiError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Gemini-Übersetzung. Bitte deinen Google AI Key im Benutzerprofil prüfen.'**
  String get editorGeminiError;

  /// No description provided for @editorDeeplSuccess.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung mit DeepL erfolgreich! 🔵'**
  String get editorDeeplSuccess;

  /// No description provided for @editorDeeplFailed.
  ///
  /// In de, this message translates to:
  /// **'DeepL Übersetzung fehlgeschlagen: {detail}'**
  String editorDeeplFailed(String detail);

  /// No description provided for @editorDeeplGenericError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der DeepL Übersetzung. Bitte stelle sicher, dass dein DeepL API-Key im Profil hinterlegt ist.'**
  String get editorDeeplGenericError;

  /// No description provided for @editorDeeplInvalidKey.
  ///
  /// In de, this message translates to:
  /// **'Ungültiger DeepL API-Key. Bitte im Profil prüfen.'**
  String get editorDeeplInvalidKey;

  /// No description provided for @editorDeeplQuotaExceeded.
  ///
  /// In de, this message translates to:
  /// **'DeepL Kontingent erschöpft. Bitte Plan prüfen.'**
  String get editorDeeplQuotaExceeded;

  /// No description provided for @editorReviewReset.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung zurück in Review-Status gesetzt.'**
  String get editorReviewReset;

  /// No description provided for @editorResetError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Zurücksetzen: {error}'**
  String editorResetError(String error);

  /// No description provided for @editorUnignoreSuccess.
  ///
  /// In de, this message translates to:
  /// **'Modul wurde wieder in die aktive Liste aufgenommen.'**
  String get editorUnignoreSuccess;

  /// No description provided for @editorUnignoreError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Einreihen des Moduls.'**
  String get editorUnignoreError;

  /// No description provided for @editorSaveSuccess.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung gespeichert – zurück in Review-Warteschlange.'**
  String get editorSaveSuccess;

  /// No description provided for @editorSaveError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern: {error}'**
  String editorSaveError(String error);

  /// No description provided for @editorNoMoreProjects.
  ///
  /// In de, this message translates to:
  /// **'Keine weiteren offenen Projekte in der Liste.'**
  String get editorNoMoreProjects;

  /// No description provided for @editorChangesDiscarded.
  ///
  /// In de, this message translates to:
  /// **'Änderungen verworfen, lade nächstes Projekt...'**
  String get editorChangesDiscarded;

  /// No description provided for @editorEnglishSourceApplied.
  ///
  /// In de, this message translates to:
  /// **'Englisches Original übernommen — bitte jetzt übersetzen.'**
  String get editorEnglishSourceApplied;

  /// No description provided for @editorCannotOpenUrl.
  ///
  /// In de, this message translates to:
  /// **'Konnte URL nicht öffnen: {url}'**
  String editorCannotOpenUrl(String url);

  /// No description provided for @commonSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get commonSave;

  /// No description provided for @commonClose.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get commonClose;

  /// No description provided for @editorCloseEnglishSource.
  ///
  /// In de, this message translates to:
  /// **'Englische Quelle schließen'**
  String get editorCloseEnglishSource;

  /// No description provided for @editorShowEnglishSource.
  ///
  /// In de, this message translates to:
  /// **'Englische Quelle einblenden'**
  String get editorShowEnglishSource;

  /// No description provided for @editorUnignoreShortTooltip.
  ///
  /// In de, this message translates to:
  /// **'Modul wieder einreihen'**
  String get editorUnignoreShortTooltip;

  /// No description provided for @editorBackToReviewTooltip.
  ///
  /// In de, this message translates to:
  /// **'Zurück in Review setzen'**
  String get editorBackToReviewTooltip;

  /// No description provided for @editorAndNext.
  ///
  /// In de, this message translates to:
  /// **'& Weiter'**
  String get editorAndNext;

  /// No description provided for @editorBackToDashboard.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Dashboard'**
  String get editorBackToDashboard;

  /// No description provided for @editorTranslatingInto.
  ///
  /// In de, this message translates to:
  /// **'Übersetze nach {langName} ({langCode})'**
  String editorTranslatingInto(String langName, String langCode);

  /// No description provided for @editorRemainingCount.
  ///
  /// In de, this message translates to:
  /// **'{count} verbleibend'**
  String editorRemainingCount(int count);

  /// No description provided for @editorUnignoreLongTooltip.
  ///
  /// In de, this message translates to:
  /// **'Modul wieder in die aktive Liste aufnehmen'**
  String get editorUnignoreLongTooltip;

  /// No description provided for @editorUnignoreLabel.
  ///
  /// In de, this message translates to:
  /// **'Einreihen'**
  String get editorUnignoreLabel;

  /// No description provided for @editorUnpublishTooltip.
  ///
  /// In de, this message translates to:
  /// **'Veröffentlichung zurücknehmen und zurück in Review setzen'**
  String get editorUnpublishTooltip;

  /// No description provided for @editorBackToReview.
  ///
  /// In de, this message translates to:
  /// **'Zurück in Review'**
  String get editorBackToReview;

  /// No description provided for @editorSaveAndNext.
  ///
  /// In de, this message translates to:
  /// **'Speichern & Weiter'**
  String get editorSaveAndNext;

  /// No description provided for @editorEnglishSourceHeader.
  ///
  /// In de, this message translates to:
  /// **'ENGLISCHE QUELLE'**
  String get editorEnglishSourceHeader;

  /// No description provided for @editorStaleTooltip.
  ///
  /// In de, this message translates to:
  /// **'Erklärung anzeigen & englischen Text übernehmen'**
  String get editorStaleTooltip;

  /// No description provided for @editorStaleDetailsLabel.
  ///
  /// In de, this message translates to:
  /// **'Veraltet — Details'**
  String get editorStaleDetailsLabel;

  /// No description provided for @editorCopyPromptTooltip.
  ///
  /// In de, this message translates to:
  /// **'Quelltext + Übersetzungsprompt kopieren'**
  String get editorCopyPromptTooltip;

  /// No description provided for @editorPromptCopied.
  ///
  /// In de, this message translates to:
  /// **'Prompt in die Zwischenablage kopiert 📋'**
  String get editorPromptCopied;

  /// No description provided for @editorShowPreview.
  ///
  /// In de, this message translates to:
  /// **'Vorschau anzeigen'**
  String get editorShowPreview;

  /// No description provided for @editorShowHtmlSource.
  ///
  /// In de, this message translates to:
  /// **'HTML-Quellcode anzeigen'**
  String get editorShowHtmlSource;

  /// No description provided for @editorSourceDumpTemplate.
  ///
  /// In de, this message translates to:
  /// **'ZUSAMMENFASSUNG:\n{summary}\n\nHAUPTBESCHREIBUNG:\n{body}'**
  String editorSourceDumpTemplate(String summary, String body);

  /// No description provided for @editorSummaryLabelColon.
  ///
  /// In de, this message translates to:
  /// **'Zusammenfassung:'**
  String get editorSummaryLabelColon;

  /// No description provided for @editorDescriptionLabelColon.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung:'**
  String get editorDescriptionLabelColon;

  /// No description provided for @editorStaleDialogTitle.
  ///
  /// In de, this message translates to:
  /// **'Englische Quelle hat sich geändert'**
  String get editorStaleDialogTitle;

  /// No description provided for @editorStaleExplanation.
  ///
  /// In de, this message translates to:
  /// **'Die vorhandene Übersetzung basiert auf einem veralteten englischen Originaltext. Seit der letzten Übersetzung hat der Modulentwickler den englischen Text auf Drupal.org geändert — der Inhalt der alten Übersetzung ist daher möglicherweise nicht mehr korrekt oder vollständig.'**
  String get editorStaleExplanation;

  /// No description provided for @editorStaleTip.
  ///
  /// In de, this message translates to:
  /// **'Tipp: Klicke auf \"Englisch übernehmen\", um den aktuellen englischen Originaltext direkt in den Editor zu laden. Du kannst ihn dann als Ausgangspunkt für eine vollständige Neuübersetzung verwenden. Das englische Original ist zusätzlich im linken Panel sichtbar.'**
  String get editorStaleTip;

  /// No description provided for @editorEnglishSourceShort.
  ///
  /// In de, this message translates to:
  /// **'Englische Quelle'**
  String get editorEnglishSourceShort;

  /// No description provided for @editorPreviousTranslation.
  ///
  /// In de, this message translates to:
  /// **'Bisherige Übersetzung'**
  String get editorPreviousTranslation;

  /// No description provided for @editorWhatChangedTitle.
  ///
  /// In de, this message translates to:
  /// **'Was hat sich geändert?'**
  String get editorWhatChangedTitle;

  /// No description provided for @editorShowDiff.
  ///
  /// In de, this message translates to:
  /// **'Diff anzeigen'**
  String get editorShowDiff;

  /// No description provided for @editorUseEnglish.
  ///
  /// In de, this message translates to:
  /// **'Englisch übernehmen'**
  String get editorUseEnglish;

  /// No description provided for @editorStaleBannerText.
  ///
  /// In de, this message translates to:
  /// **'Englische Quelle hat sich geändert — Übersetzung veraltet'**
  String get editorStaleBannerText;

  /// No description provided for @editorDetailsAndApply.
  ///
  /// In de, this message translates to:
  /// **'Details & Übernehmen'**
  String get editorDetailsAndApply;

  /// No description provided for @editorTranslationSectionHeader.
  ///
  /// In de, this message translates to:
  /// **'{langName} ÜBERSETZUNG'**
  String editorTranslationSectionHeader(String langName);

  /// No description provided for @editorTranslatingEllipsis.
  ///
  /// In de, this message translates to:
  /// **'Übersetze...'**
  String get editorTranslatingEllipsis;

  /// No description provided for @editorShowEditor.
  ///
  /// In de, this message translates to:
  /// **'Editor anzeigen'**
  String get editorShowEditor;

  /// No description provided for @editorModuleTitleLabel.
  ///
  /// In de, this message translates to:
  /// **'Modul-Titel (Englisch)'**
  String get editorModuleTitleLabel;

  /// No description provided for @editorSummaryFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Zusammenfassung'**
  String get editorSummaryFieldLabel;

  /// No description provided for @editorBodyFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Hauptbeschreibung'**
  String get editorBodyFieldLabel;

  /// No description provided for @editorHtmlCleaned.
  ///
  /// In de, this message translates to:
  /// **'HTML bereinigt'**
  String get editorHtmlCleaned;

  /// No description provided for @editorLivePreviewHeader.
  ///
  /// In de, this message translates to:
  /// **'LIVE-VORSCHAU'**
  String get editorLivePreviewHeader;

  /// No description provided for @editorTidyHtmlTooltip.
  ///
  /// In de, this message translates to:
  /// **'HTML bereinigen (DeepL-Artefakte entfernen)'**
  String get editorTidyHtmlTooltip;

  /// No description provided for @editorVisualMode.
  ///
  /// In de, this message translates to:
  /// **'VISUELL'**
  String get editorVisualMode;

  /// No description provided for @editorSourceCodeMode.
  ///
  /// In de, this message translates to:
  /// **'QUELLCODE (HTML)'**
  String get editorSourceCodeMode;

  /// No description provided for @commonCancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get commonCancel;

  /// No description provided for @costDialogTitle.
  ///
  /// In de, this message translates to:
  /// **'Kosten-Vorkalkulation (AI)'**
  String get costDialogTitle;

  /// No description provided for @costDialogIntro.
  ///
  /// In de, this message translates to:
  /// **'Das ausgewählte Modul wird mit Google Gemini AI übersetzt. Hier ist die geschätzte Kostenaufstellung für diesen Vorgang:'**
  String get costDialogIntro;

  /// No description provided for @costRowModel.
  ///
  /// In de, this message translates to:
  /// **'Modell'**
  String get costRowModel;

  /// No description provided for @costRowInputTokens.
  ///
  /// In de, this message translates to:
  /// **'Eingabe-Tokens'**
  String get costRowInputTokens;

  /// No description provided for @costRowOutputTokens.
  ///
  /// In de, this message translates to:
  /// **'Ausgabe-Tokens (Schätzung)'**
  String get costRowOutputTokens;

  /// No description provided for @costTokenChars.
  ///
  /// In de, this message translates to:
  /// **'{tokens} (~{chars} Zeichen)'**
  String costTokenChars(int tokens, int chars);

  /// No description provided for @costRowPriceInput.
  ///
  /// In de, this message translates to:
  /// **'Preis pro 1M Input'**
  String get costRowPriceInput;

  /// No description provided for @costRowPriceOutput.
  ///
  /// In de, this message translates to:
  /// **'Preis pro 1M Output'**
  String get costRowPriceOutput;

  /// No description provided for @costRowTotalEstimate.
  ///
  /// In de, this message translates to:
  /// **'Geschätzte Gesamtkosten'**
  String get costRowTotalEstimate;

  /// No description provided for @costDialogFootnote.
  ///
  /// In de, this message translates to:
  /// **'* Hinweis: Dies ist eine Schätzung basierend auf dem aktuellen Google Pay-as-you-go Preismodell. Der tatsächliche Verbrauch kann minimal variieren.'**
  String get costDialogFootnote;

  /// No description provided for @costDialogStartTranslation.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung starten'**
  String get costDialogStartTranslation;

  /// No description provided for @htmlToolbarInsertLink.
  ///
  /// In de, this message translates to:
  /// **'Link einfügen'**
  String get htmlToolbarInsertLink;

  /// No description provided for @htmlToolbarLinkTooltip.
  ///
  /// In de, this message translates to:
  /// **'Link einfügen (a)'**
  String get htmlToolbarLinkTooltip;

  /// No description provided for @htmlToolbarInsert.
  ///
  /// In de, this message translates to:
  /// **'Einfügen'**
  String get htmlToolbarInsert;

  /// No description provided for @htmlToolbarHeading2.
  ///
  /// In de, this message translates to:
  /// **'Überschrift 2'**
  String get htmlToolbarHeading2;

  /// No description provided for @htmlToolbarHeading3.
  ///
  /// In de, this message translates to:
  /// **'Überschrift 3'**
  String get htmlToolbarHeading3;

  /// No description provided for @htmlToolbarBold.
  ///
  /// In de, this message translates to:
  /// **'Fett (strong)'**
  String get htmlToolbarBold;

  /// No description provided for @htmlToolbarItalic.
  ///
  /// In de, this message translates to:
  /// **'Kursiv (em)'**
  String get htmlToolbarItalic;

  /// No description provided for @htmlToolbarBulletList.
  ///
  /// In de, this message translates to:
  /// **'Aufzählung (ul)'**
  String get htmlToolbarBulletList;

  /// No description provided for @htmlToolbarNumberedList.
  ///
  /// In de, this message translates to:
  /// **'Nummerierung (ol)'**
  String get htmlToolbarNumberedList;

  /// No description provided for @htmlToolbarQuote.
  ///
  /// In de, this message translates to:
  /// **'Zitat (blockquote)'**
  String get htmlToolbarQuote;

  /// No description provided for @screenshotAltsHeader.
  ///
  /// In de, this message translates to:
  /// **'SCREENSHOT ALT-TEXTE'**
  String get screenshotAltsHeader;

  /// No description provided for @screenshotAltsIntro.
  ///
  /// In de, this message translates to:
  /// **'Gib für jeden Screenshot einen beschreibenden Alt-Text in der Zielsprache ein.'**
  String get screenshotAltsIntro;

  /// No description provided for @screenshotLabel.
  ///
  /// In de, this message translates to:
  /// **'Screenshot {number}'**
  String screenshotLabel(int number);

  /// No description provided for @screenshotPreviewUnavailable.
  ///
  /// In de, this message translates to:
  /// **'Vorschau nicht verfügbar'**
  String get screenshotPreviewUnavailable;

  /// No description provided for @screenshotAltHint.
  ///
  /// In de, this message translates to:
  /// **'Alt-Text in Zielsprache eingeben…'**
  String get screenshotAltHint;

  /// No description provided for @dashUnignoreAllConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'Alle ignorieren aufheben?'**
  String get dashUnignoreAllConfirmTitle;

  /// No description provided for @dashUnignoreAllConfirmBody.
  ///
  /// In de, this message translates to:
  /// **'Alle ignorierten Module werden wieder in die aktive Liste aufgenommen und stehen erneut zur Übersetzung bereit.'**
  String get dashUnignoreAllConfirmBody;

  /// No description provided for @dashUnignoreAllConfirmAction.
  ///
  /// In de, this message translates to:
  /// **'Alle einreihen'**
  String get dashUnignoreAllConfirmAction;

  /// No description provided for @dashUnignoreAllSuccess.
  ///
  /// In de, this message translates to:
  /// **'Alle ignorierten Module wurden wieder eingereiht.'**
  String get dashUnignoreAllSuccess;

  /// No description provided for @dashUnignoreAllError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Einreihen der Module.'**
  String get dashUnignoreAllError;

  /// No description provided for @dashUnignoreAllButton.
  ///
  /// In de, this message translates to:
  /// **'Alle wieder einreihen'**
  String get dashUnignoreAllButton;

  /// No description provided for @dashSyncStartError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Starten des Syncs: {error}'**
  String dashSyncStartError(String error);

  /// No description provided for @dashQuickUpdateStarted.
  ///
  /// In de, this message translates to:
  /// **'Schnell-Update (7 Tage) gestartet ⚡'**
  String get dashQuickUpdateStarted;

  /// No description provided for @dashQuickUpdateError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Schnell-Update: {error}'**
  String dashQuickUpdateError(String error);

  /// No description provided for @dashManualSyncSuccess.
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich synchronisiert: {name}'**
  String dashManualSyncSuccess(String name);

  /// No description provided for @dashManualSyncNotFound.
  ///
  /// In de, this message translates to:
  /// **'Modul nicht auf Drupal.org gefunden.'**
  String get dashManualSyncNotFound;

  /// No description provided for @dashAiBulkTranslation.
  ///
  /// In de, this message translates to:
  /// **'AI Massen-Übersetzung'**
  String get dashAiBulkTranslation;

  /// No description provided for @dashHeaderTitle.
  ///
  /// In de, this message translates to:
  /// **'Projekt-Beschreibungen'**
  String get dashHeaderTitle;

  /// No description provided for @dashHeaderSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung von Drupal-Modulbeschreibungen in die Zielsprache. Hilf mit, das Ökosystem zugänglicher zu machen.'**
  String get dashHeaderSubtitle;

  /// No description provided for @dashHeaderSubtitleShort.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung von Drupal-Modulbeschreibungen.'**
  String get dashHeaderSubtitleShort;

  /// No description provided for @dashLastLabel.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt: '**
  String get dashLastLabel;

  /// No description provided for @dashContinue.
  ///
  /// In de, this message translates to:
  /// **'Weitermachen'**
  String get dashContinue;

  /// No description provided for @dashContinueShort.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get dashContinueShort;

  /// No description provided for @dashUnignoreAllButtonLong.
  ///
  /// In de, this message translates to:
  /// **'Alle wieder einreihen'**
  String get dashUnignoreAllButtonLong;

  /// No description provided for @dashQuickUpdateTooltip.
  ///
  /// In de, this message translates to:
  /// **'Schnelles Update (letzte 7 Tage)'**
  String get dashQuickUpdateTooltip;

  /// No description provided for @dashFullSyncTooltip.
  ///
  /// In de, this message translates to:
  /// **'Vollständiger Datenbank-Sync von Drupal.org'**
  String get dashFullSyncTooltip;

  /// No description provided for @dashManualLoadTooltip.
  ///
  /// In de, this message translates to:
  /// **'Einzelnes Modul manuell von Drupal.org laden'**
  String get dashManualLoadTooltip;

  /// No description provided for @dashQuickShort.
  ///
  /// In de, this message translates to:
  /// **'Schnell'**
  String get dashQuickShort;

  /// No description provided for @dashModuleShort.
  ///
  /// In de, this message translates to:
  /// **'Modul'**
  String get dashModuleShort;

  /// No description provided for @dashFoundLabel.
  ///
  /// In de, this message translates to:
  /// **'Gefunden: '**
  String get dashFoundLabel;

  /// No description provided for @dashModulesSuffix.
  ///
  /// In de, this message translates to:
  /// **' Module'**
  String get dashModulesSuffix;

  /// No description provided for @dashPerPage.
  ///
  /// In de, this message translates to:
  /// **'{count} pro Seite'**
  String dashPerPage(int count);

  /// No description provided for @dashPerPageShort.
  ///
  /// In de, this message translates to:
  /// **'{count} / Seite'**
  String dashPerPageShort(int count);

  /// No description provided for @dashFirstPage.
  ///
  /// In de, this message translates to:
  /// **'Erste Seite'**
  String get dashFirstPage;

  /// No description provided for @dashPrevPage.
  ///
  /// In de, this message translates to:
  /// **'Vorherige Seite'**
  String get dashPrevPage;

  /// No description provided for @dashNextPage.
  ///
  /// In de, this message translates to:
  /// **'Nächste Seite'**
  String get dashNextPage;

  /// No description provided for @dashLastPage.
  ///
  /// In de, this message translates to:
  /// **'Letzte Seite'**
  String get dashLastPage;

  /// No description provided for @dashPageOf.
  ///
  /// In de, this message translates to:
  /// **'Seite {page} von {total}'**
  String dashPageOf(int page, int total);

  /// No description provided for @dashMachineNameHint.
  ///
  /// In de, this message translates to:
  /// **'machine_name (z. B. pathauto)'**
  String get dashMachineNameHint;

  /// No description provided for @dashAddButton.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get dashAddButton;

  /// No description provided for @dashAddModuleManually.
  ///
  /// In de, this message translates to:
  /// **'Modul manuell hinzufügen'**
  String get dashAddModuleManually;

  /// No description provided for @dashAddModuleSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Direkt von Drupal.org per Machine Name laden.'**
  String get dashAddModuleSubtitle;

  /// No description provided for @dashAddModuleShort.
  ///
  /// In de, this message translates to:
  /// **'Modul hinzufügen'**
  String get dashAddModuleShort;

  /// No description provided for @dashNoProjectsFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Projekte gefunden.'**
  String get dashNoProjectsFound;

  /// No description provided for @dashFilterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle Projekte'**
  String get dashFilterAll;

  /// No description provided for @dashFilterMissing.
  ///
  /// In de, this message translates to:
  /// **'Fehlende Übersetzungen'**
  String get dashFilterMissing;

  /// No description provided for @dashFilterReview.
  ///
  /// In de, this message translates to:
  /// **'Review-Warteschlange'**
  String get dashFilterReview;

  /// No description provided for @dashFilterTranslated.
  ///
  /// In de, this message translates to:
  /// **'Übersetzte Projekte'**
  String get dashFilterTranslated;

  /// No description provided for @dashFilterReleased.
  ///
  /// In de, this message translates to:
  /// **'Freigegebene Projekte'**
  String get dashFilterReleased;

  /// No description provided for @dashBulkDialogIntro.
  ///
  /// In de, this message translates to:
  /// **'Übersetze mehrere Module aus dem ausgewählten Filter automatisch mit Google Gemini.'**
  String get dashBulkDialogIntro;

  /// No description provided for @dashActiveFilter.
  ///
  /// In de, this message translates to:
  /// **'Aktiver Filter'**
  String get dashActiveFilter;

  /// No description provided for @dashModuleCount.
  ///
  /// In de, this message translates to:
  /// **'Anzahl Module'**
  String get dashModuleCount;

  /// No description provided for @dashModulesCountItem.
  ///
  /// In de, this message translates to:
  /// **'{count} Module'**
  String dashModulesCountItem(int count);

  /// No description provided for @dashPrioritizeD12Title.
  ///
  /// In de, this message translates to:
  /// **'Drupal 12 Module priorisieren'**
  String get dashPrioritizeD12Title;

  /// No description provided for @dashPrioritizeD12Subtitle.
  ///
  /// In de, this message translates to:
  /// **'Übersetzt bevorzugt Module ohne Drupal 12 Unterstützung zuerst'**
  String get dashPrioritizeD12Subtitle;

  /// No description provided for @dashTotalModules.
  ///
  /// In de, this message translates to:
  /// **'Module gesamt'**
  String get dashTotalModules;

  /// No description provided for @dashInputTokensEst.
  ///
  /// In de, this message translates to:
  /// **'Eingabe-Tokens (Schätzung)'**
  String get dashInputTokensEst;

  /// No description provided for @dashOutputTokensEst.
  ///
  /// In de, this message translates to:
  /// **'Ausgabe-Tokens (Schätzung)'**
  String get dashOutputTokensEst;

  /// No description provided for @dashBulkFootnote.
  ///
  /// In de, this message translates to:
  /// **'* Die Übersetzung wird in ressourcenschonenden Batches ausgeführt, um Timeouts zu verhindern.'**
  String get dashBulkFootnote;

  /// No description provided for @dashStartBulkTranslation.
  ///
  /// In de, this message translates to:
  /// **'Massen-Übersetzung starten'**
  String get dashStartBulkTranslation;

  /// No description provided for @dashStaleLoadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden der veralteten Module: {error}'**
  String dashStaleLoadError(String error);

  /// No description provided for @dashNoStaleModules.
  ///
  /// In de, this message translates to:
  /// **'Keine veralteten Module gefunden — alles aktuell! ✨'**
  String get dashNoStaleModules;

  /// No description provided for @dashRetranslateOutdatedTitle.
  ///
  /// In de, this message translates to:
  /// **'Veraltete Module neu übersetzen'**
  String get dashRetranslateOutdatedTitle;

  /// No description provided for @dashRetranslateOutdatedIntro.
  ///
  /// In de, this message translates to:
  /// **'Alle Übersetzungen, deren englische Quelle sich seit der letzten Übersetzung geändert hat, werden automatisch mit Google Gemini neu übersetzt. Kein manuelles Öffnen jedes Moduls nötig.'**
  String get dashRetranslateOutdatedIntro;

  /// No description provided for @dashOutdatedModules.
  ///
  /// In de, this message translates to:
  /// **'Veraltete Module'**
  String get dashOutdatedModules;

  /// No description provided for @dashRetranslateOutdatedFootnote.
  ///
  /// In de, this message translates to:
  /// **'* Die Übersetzung ersetzt den bisherigen Text und setzt is_reviewed zurück. Ausführung in Batches à 4 Modulen.'**
  String get dashRetranslateOutdatedFootnote;

  /// No description provided for @dashRetranslateAllCount.
  ///
  /// In de, this message translates to:
  /// **'Alle {count} Module neu übersetzen'**
  String dashRetranslateAllCount(int count);

  /// No description provided for @dashRetranslatingOutdatedTitle.
  ///
  /// In de, this message translates to:
  /// **'Veraltete Module werden neu übersetzt…'**
  String get dashRetranslatingOutdatedTitle;

  /// No description provided for @dashFetchingProjects.
  ///
  /// In de, this message translates to:
  /// **'Projekte werden vom Server abgerufen…'**
  String get dashFetchingProjects;

  /// No description provided for @dashModulesProcessed.
  ///
  /// In de, this message translates to:
  /// **'{processed} von {total} Modulen verarbeitet'**
  String dashModulesProcessed(int processed, int total);

  /// No description provided for @dashNoTranslatableProjects.
  ///
  /// In de, this message translates to:
  /// **'Keine übersetzbaren Projekte in diesem Filter gefunden.'**
  String get dashNoTranslatableProjects;

  /// No description provided for @dashStartingTranslation.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung wird gestartet…'**
  String get dashStartingTranslation;

  /// No description provided for @dashTranslatingModuleRange.
  ///
  /// In de, this message translates to:
  /// **'Übersetze Modul {start}–{end} von {total} …'**
  String dashTranslatingModuleRange(int start, int end, int total);

  /// No description provided for @dashModulesCompleted.
  ///
  /// In de, this message translates to:
  /// **'{end} von {total} Modulen abgeschlossen.'**
  String dashModulesCompleted(int end, int total);

  /// No description provided for @dashTranslationCompleted.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung erfolgreich abgeschlossen! ✨'**
  String get dashTranslationCompleted;

  /// No description provided for @dashBulkTranslationSuccess.
  ///
  /// In de, this message translates to:
  /// **'Massen-Übersetzung von {count} Modulen erfolgreich! ✨'**
  String dashBulkTranslationSuccess(int count);

  /// No description provided for @dashBulkTranslationError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Massen-Übersetzung: {error}'**
  String dashBulkTranslationError(String error);

  /// No description provided for @dashAllModulesRetranslated.
  ///
  /// In de, this message translates to:
  /// **'Alle {count} Module erfolgreich neu übersetzt! ✨'**
  String dashAllModulesRetranslated(int count);

  /// No description provided for @dashOutdatedRetranslatedSuccess.
  ///
  /// In de, this message translates to:
  /// **'{count} veraltete Module erfolgreich neu übersetzt! ✨'**
  String dashOutdatedRetranslatedSuccess(int count);

  /// No description provided for @dashStaleTranslationError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Stale-Übersetzung: {error}'**
  String dashStaleTranslationError(String error);

  /// No description provided for @filterAllShort.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get filterAllShort;

  /// No description provided for @filterMissing.
  ///
  /// In de, this message translates to:
  /// **'Fehlend'**
  String get filterMissing;

  /// No description provided for @filterTranslated.
  ///
  /// In de, this message translates to:
  /// **'Übersetzt'**
  String get filterTranslated;

  /// No description provided for @filterReviewQueue.
  ///
  /// In de, this message translates to:
  /// **'Review'**
  String get filterReviewQueue;

  /// No description provided for @filterReleased.
  ///
  /// In de, this message translates to:
  /// **'Freigegeben'**
  String get filterReleased;

  /// No description provided for @filterOutdated.
  ///
  /// In de, this message translates to:
  /// **'Veraltet'**
  String get filterOutdated;

  /// No description provided for @filterPriority.
  ///
  /// In de, this message translates to:
  /// **'Priorität'**
  String get filterPriority;

  /// No description provided for @filterIgnored.
  ///
  /// In de, this message translates to:
  /// **'Ignoriert'**
  String get filterIgnored;

  /// No description provided for @commonEdit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get commonEdit;

  /// No description provided for @commonReset.
  ///
  /// In de, this message translates to:
  /// **'Zurücksetzen'**
  String get commonReset;

  /// No description provided for @commonRefresh.
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get commonRefresh;

  /// No description provided for @commonErrorPrefix.
  ///
  /// In de, this message translates to:
  /// **'Fehler: {error}'**
  String commonErrorPrefix(String error);

  /// No description provided for @reviewResetAllConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'Alle veröffentlichten Übersetzungen zurücksetzen?'**
  String get reviewResetAllConfirmTitle;

  /// No description provided for @reviewResetAllConfirmBody.
  ///
  /// In de, this message translates to:
  /// **'Alle als \"Veröffentlicht\" markierten Übersetzungen für {langcode} werden auf den Review-Status zurückgesetzt. Diese Aktion kann nicht rückgängig gemacht werden.'**
  String reviewResetAllConfirmBody(String langcode);

  /// No description provided for @reviewResetAllSuccess.
  ///
  /// In de, this message translates to:
  /// **'{count} Übersetzungen zurück in Review gesetzt.'**
  String reviewResetAllSuccess(int count);

  /// No description provided for @reviewPipelineTitle.
  ///
  /// In de, this message translates to:
  /// **'Review-Warteschlange'**
  String get reviewPipelineTitle;

  /// No description provided for @reviewPipelineSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Menschliche Endabnahme für automatische Übersetzungen'**
  String get reviewPipelineSubtitle;

  /// No description provided for @reviewSearchHint.
  ///
  /// In de, this message translates to:
  /// **'Projekt suchen...'**
  String get reviewSearchHint;

  /// No description provided for @reviewResetPublished.
  ///
  /// In de, this message translates to:
  /// **'Freigaben zurücksetzen'**
  String get reviewResetPublished;

  /// No description provided for @reviewResultsCount.
  ///
  /// In de, this message translates to:
  /// **'Treffer: {count} / {total}'**
  String reviewResultsCount(int count, int total);

  /// No description provided for @reviewPendingCount.
  ///
  /// In de, this message translates to:
  /// **'Wartend: {count}'**
  String reviewPendingCount(int count);

  /// No description provided for @reviewNoProjectsPending.
  ///
  /// In de, this message translates to:
  /// **'Keine Projekte ausstehend.'**
  String get reviewNoProjectsPending;

  /// No description provided for @reviewAllVerifiedOrNone.
  ///
  /// In de, this message translates to:
  /// **'Alle Übersetzungen wurden bereits geprüft oder es sind keine Übersetzungen vorhanden.'**
  String get reviewAllVerifiedOrNone;

  /// No description provided for @reviewNoSummary.
  ///
  /// In de, this message translates to:
  /// **'Keine Zusammenfassung.'**
  String get reviewNoSummary;

  /// No description provided for @reviewStartAudit.
  ///
  /// In de, this message translates to:
  /// **'AUDIT STARTEN'**
  String get reviewStartAudit;

  /// No description provided for @reviewHtmlSourceShort.
  ///
  /// In de, this message translates to:
  /// **'HTML-Quellcode'**
  String get reviewHtmlSourceShort;

  /// No description provided for @reviewCopySource.
  ///
  /// In de, this message translates to:
  /// **'Quelltext kopieren'**
  String get reviewCopySource;

  /// No description provided for @reviewModuleDetails.
  ///
  /// In de, this message translates to:
  /// **'Modul Details'**
  String get reviewModuleDetails;

  /// No description provided for @reviewOriginalTitle.
  ///
  /// In de, this message translates to:
  /// **'Original-Titel'**
  String get reviewOriginalTitle;

  /// No description provided for @reviewDrupalOrgProject.
  ///
  /// In de, this message translates to:
  /// **'Drupal.org-Projekt'**
  String get reviewDrupalOrgProject;

  /// No description provided for @reviewSuggestions.
  ///
  /// In de, this message translates to:
  /// **'Vorschläge'**
  String get reviewSuggestions;

  /// No description provided for @reviewNoSuggestions.
  ///
  /// In de, this message translates to:
  /// **'Keine Vorschläge vorhanden.'**
  String get reviewNoSuggestions;

  /// No description provided for @reviewApply.
  ///
  /// In de, this message translates to:
  /// **'Übernehmen'**
  String get reviewApply;

  /// No description provided for @reviewNoChanges.
  ///
  /// In de, this message translates to:
  /// **'Keine Änderungen'**
  String get reviewNoChanges;

  /// No description provided for @reviewOriginalBeforeCorrection.
  ///
  /// In de, this message translates to:
  /// **'Original (vor der Korrektur)'**
  String get reviewOriginalBeforeCorrection;

  /// No description provided for @reviewCorrectedCurrentVersion.
  ///
  /// In de, this message translates to:
  /// **'Korrigiert (aktuelle Version)'**
  String get reviewCorrectedCurrentVersion;

  /// No description provided for @reviewBaseOriginal.
  ///
  /// In de, this message translates to:
  /// **'Basis (Original)'**
  String get reviewBaseOriginal;

  /// No description provided for @reviewYourCorrection.
  ///
  /// In de, this message translates to:
  /// **'Deine Korrektur'**
  String get reviewYourCorrection;

  /// No description provided for @reviewChangesVisual.
  ///
  /// In de, this message translates to:
  /// **'Änderungen prüfen (Visuell)'**
  String get reviewChangesVisual;

  /// No description provided for @commonSkip.
  ///
  /// In de, this message translates to:
  /// **'Überspringen'**
  String get commonSkip;

  /// No description provided for @commonIgnore.
  ///
  /// In de, this message translates to:
  /// **'Ignorieren'**
  String get commonIgnore;

  /// No description provided for @reviewEmptyProjectTitle.
  ///
  /// In de, this message translates to:
  /// **'Leeres Projekt'**
  String get reviewEmptyProjectTitle;

  /// No description provided for @reviewEmptyProjectBody.
  ///
  /// In de, this message translates to:
  /// **'Dieses Projekt ist leer (kein Titel, Zusammenfassung oder Inhalt) und kann nicht freigegeben werden. Bitte überspringen Sie es.'**
  String get reviewEmptyProjectBody;

  /// No description provided for @reviewApprovedSuccess.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung freigegeben! 🎉'**
  String get reviewApprovedSuccess;

  /// No description provided for @reviewApprovalFailed.
  ///
  /// In de, this message translates to:
  /// **'⚠️ Freigabe von \"{machine}\" fehlgeschlagen — bitte erneut versuchen.'**
  String reviewApprovalFailed(String machine);

  /// No description provided for @reviewUnignoredSuccess.
  ///
  /// In de, this message translates to:
  /// **'Ignorieren aufgehoben. Modul ist wieder aktiv!'**
  String get reviewUnignoredSuccess;

  /// No description provided for @reviewActionFailed.
  ///
  /// In de, this message translates to:
  /// **'Aktion fehlgeschlagen.'**
  String get reviewActionFailed;

  /// No description provided for @reviewIgnoreModuleTitle.
  ///
  /// In de, this message translates to:
  /// **'Modul ignorieren?'**
  String get reviewIgnoreModuleTitle;

  /// No description provided for @reviewIgnoreModuleBody.
  ///
  /// In de, this message translates to:
  /// **'Dieses Modul wird dauerhaft aus allen Listen ausgeblendet. Du bleibst nicht mehr daran hängen.'**
  String get reviewIgnoreModuleBody;

  /// No description provided for @reviewModulePermanentlyIgnored.
  ///
  /// In de, this message translates to:
  /// **'Modul dauerhaft ausgeblendet.'**
  String get reviewModulePermanentlyIgnored;

  /// No description provided for @reviewIgnoreFailed.
  ///
  /// In de, this message translates to:
  /// **'Ignorieren fehlgeschlagen.'**
  String get reviewIgnoreFailed;

  /// No description provided for @reviewSuggestionSaved.
  ///
  /// In de, this message translates to:
  /// **'Vorschlag gespeichert! 💾'**
  String get reviewSuggestionSaved;

  /// No description provided for @reviewSaveSuggestionFailed.
  ///
  /// In de, this message translates to:
  /// **'Speichern fehlgeschlagen.'**
  String get reviewSaveSuggestionFailed;

  /// No description provided for @reviewSuggestionDeleted.
  ///
  /// In de, this message translates to:
  /// **'Vorschlag gelöscht.'**
  String get reviewSuggestionDeleted;

  /// No description provided for @reviewDeleteFailed.
  ///
  /// In de, this message translates to:
  /// **'Löschen fehlgeschlagen.'**
  String get reviewDeleteFailed;

  /// No description provided for @reviewSuggestionApplied.
  ///
  /// In de, this message translates to:
  /// **'Vorschlag übernommen.'**
  String get reviewSuggestionApplied;

  /// No description provided for @reviewPreparingData.
  ///
  /// In de, this message translates to:
  /// **'Review-Daten werden vorbereitet...'**
  String get reviewPreparingData;

  /// No description provided for @reviewDirectEdit.
  ///
  /// In de, this message translates to:
  /// **'Direkt-Editor'**
  String get reviewDirectEdit;

  /// No description provided for @reviewLivePreview.
  ///
  /// In de, this message translates to:
  /// **'Vorschau'**
  String get reviewLivePreview;

  /// No description provided for @reviewCompareWith.
  ///
  /// In de, this message translates to:
  /// **'Vergleichen mit:'**
  String get reviewCompareWith;

  /// No description provided for @reviewProductionVersion.
  ///
  /// In de, this message translates to:
  /// **'Produktions-Version'**
  String get reviewProductionVersion;

  /// No description provided for @reviewEditorialReview.
  ///
  /// In de, this message translates to:
  /// **'Redaktionelle Überarbeitung'**
  String get reviewEditorialReview;

  /// No description provided for @reviewOpenQueue.
  ///
  /// In de, this message translates to:
  /// **'Review-Warteschlange öffnen'**
  String get reviewOpenQueue;

  /// No description provided for @reviewCopyPromptShort.
  ///
  /// In de, this message translates to:
  /// **'Prompt kopieren'**
  String get reviewCopyPromptShort;

  /// No description provided for @reviewUnignoreShort.
  ///
  /// In de, this message translates to:
  /// **'Ignorieren aufheben'**
  String get reviewUnignoreShort;

  /// No description provided for @reviewApproveButton.
  ///
  /// In de, this message translates to:
  /// **'FREIGEBEN'**
  String get reviewApproveButton;

  /// No description provided for @reviewHideDetails.
  ///
  /// In de, this message translates to:
  /// **'Details ausblenden'**
  String get reviewHideDetails;

  /// No description provided for @reviewDetailsAndEnglishSource.
  ///
  /// In de, this message translates to:
  /// **'Details & Englische Quelle'**
  String get reviewDetailsAndEnglishSource;

  /// No description provided for @reviewPendingCountShort.
  ///
  /// In de, this message translates to:
  /// **'{count} ausstehend'**
  String reviewPendingCountShort(int count);

  /// No description provided for @reviewReviewingModule.
  ///
  /// In de, this message translates to:
  /// **'Überprüfung von {name}'**
  String reviewReviewingModule(String name);

  /// No description provided for @reviewCompareTranslationTooltip.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung mit englischer Quelle vergleichen'**
  String get reviewCompareTranslationTooltip;

  /// No description provided for @reviewTranslationLabel.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung'**
  String get reviewTranslationLabel;

  /// No description provided for @reviewComparisonTitle.
  ///
  /// In de, this message translates to:
  /// **'Vergleich'**
  String get reviewComparisonTitle;

  /// No description provided for @reviewCopyPromptLongTooltip.
  ///
  /// In de, this message translates to:
  /// **'Quelltext + Übersetzungsprompt in die Zwischenablage kopieren'**
  String get reviewCopyPromptLongTooltip;

  /// No description provided for @reviewUnignoreCaps.
  ///
  /// In de, this message translates to:
  /// **'IGNORIEREN AUFHEBEN'**
  String get reviewUnignoreCaps;

  /// No description provided for @reviewIgnoreCaps.
  ///
  /// In de, this message translates to:
  /// **'IGNORIEREN'**
  String get reviewIgnoreCaps;

  /// No description provided for @reviewSkipShortcut.
  ///
  /// In de, this message translates to:
  /// **'ÜBERSPRINGEN (Strg+→)'**
  String get reviewSkipShortcut;

  /// No description provided for @reviewEditorialReviewShort.
  ///
  /// In de, this message translates to:
  /// **'Redakt. Überarbeitung'**
  String get reviewEditorialReviewShort;

  /// No description provided for @reviewUnignoreTablet.
  ///
  /// In de, this message translates to:
  /// **'EINREIHEN'**
  String get reviewUnignoreTablet;

  /// No description provided for @reviewApproveForProduction.
  ///
  /// In de, this message translates to:
  /// **'FREIGEBEN FÜR PRODUKTION (Strg+Enter)'**
  String get reviewApproveForProduction;

  /// No description provided for @reviewDirectRefinement.
  ///
  /// In de, this message translates to:
  /// **'Manuelle Korrektur'**
  String get reviewDirectRefinement;

  /// No description provided for @reviewTitleField.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get reviewTitleField;

  /// No description provided for @reviewSummaryField.
  ///
  /// In de, this message translates to:
  /// **'Zusammenfassung (Summary)'**
  String get reviewSummaryField;

  /// No description provided for @reviewBodyField.
  ///
  /// In de, this message translates to:
  /// **'Hauptinhalt (Body)'**
  String get reviewBodyField;

  /// No description provided for @reviewSaveShortcut.
  ///
  /// In de, this message translates to:
  /// **'SPEICHERN (Strg+Alt+S)'**
  String get reviewSaveShortcut;

  /// No description provided for @reviewLivePreviewRendering.
  ///
  /// In de, this message translates to:
  /// **'Live Vorschau (Rendering)'**
  String get reviewLivePreviewRendering;

  /// No description provided for @reviewVoiceFemale.
  ///
  /// In de, this message translates to:
  /// **'Weiblich'**
  String get reviewVoiceFemale;

  /// No description provided for @reviewVoiceMale.
  ///
  /// In de, this message translates to:
  /// **'Männlich'**
  String get reviewVoiceMale;

  /// No description provided for @reviewStopListening.
  ///
  /// In de, this message translates to:
  /// **'Stoppen'**
  String get reviewStopListening;

  /// No description provided for @reviewListen.
  ///
  /// In de, this message translates to:
  /// **'Anhören'**
  String get reviewListen;

  /// No description provided for @reviewAutopTooltip.
  ///
  /// In de, this message translates to:
  /// **'Absätze automatisch formatieren (Zeilenumbrüche → <p>)'**
  String get reviewAutopTooltip;

  /// No description provided for @reviewSourceCodeShort.
  ///
  /// In de, this message translates to:
  /// **'QUELLCODE'**
  String get reviewSourceCodeShort;

  /// No description provided for @reviewNoParagraphChange.
  ///
  /// In de, this message translates to:
  /// **'Text enthält bereits <p>-Tags — keine Änderung'**
  String get reviewNoParagraphChange;

  /// No description provided for @reviewParagraphsFormatted.
  ///
  /// In de, this message translates to:
  /// **'Absätze formatiert ¶'**
  String get reviewParagraphsFormatted;

  /// No description provided for @commonRetry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get commonRetry;

  /// No description provided for @categoriesLoadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden der Kategorien: {error}'**
  String categoriesLoadError(String error);

  /// No description provided for @categoriesSaveSuccess.
  ///
  /// In de, this message translates to:
  /// **'Kategorien erfolgreich gespeichert.'**
  String get categoriesSaveSuccess;

  /// No description provided for @categoriesSaveFailed.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern.'**
  String get categoriesSaveFailed;

  /// No description provided for @categoriesFileEmpty.
  ///
  /// In de, this message translates to:
  /// **'Datei ist leer.'**
  String get categoriesFileEmpty;

  /// No description provided for @categoriesInvalidJson.
  ///
  /// In de, this message translates to:
  /// **'Ungültiges JSON-Format.'**
  String get categoriesInvalidJson;

  /// No description provided for @categoriesNoValidUuids.
  ///
  /// In de, this message translates to:
  /// **'Keine gültigen UUID-Einträge gefunden.'**
  String get categoriesNoValidUuids;

  /// No description provided for @categoriesImportSuccess.
  ///
  /// In de, this message translates to:
  /// **'{count} Kategorien aus Datei importiert.'**
  String categoriesImportSuccess(int count);

  /// No description provided for @categoriesTitle.
  ///
  /// In de, this message translates to:
  /// **'Kategorien'**
  String get categoriesTitle;

  /// No description provided for @categoriesTranslatingFor.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung für: {lang}'**
  String categoriesTranslatingFor(String lang);

  /// No description provided for @categoriesImportJson.
  ///
  /// In de, this message translates to:
  /// **'JSON importieren'**
  String get categoriesImportJson;

  /// No description provided for @categoriesSaving.
  ///
  /// In de, this message translates to:
  /// **'Speichert...'**
  String get categoriesSaving;

  /// No description provided for @categoriesSaveAll.
  ///
  /// In de, this message translates to:
  /// **'Alle speichern'**
  String get categoriesSaveAll;

  /// No description provided for @categoriesLoading.
  ///
  /// In de, this message translates to:
  /// **'Lade Kategorien...'**
  String get categoriesLoading;

  /// No description provided for @categoriesTranslationColumn.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung ({code})'**
  String categoriesTranslationColumn(String code);

  /// No description provided for @categoriesNoneFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Kategorien gefunden.'**
  String get categoriesNoneFound;

  /// No description provided for @categoriesTranslateHint.
  ///
  /// In de, this message translates to:
  /// **'Übersetze \"{name}\"...'**
  String categoriesTranslateHint(String name);

  /// No description provided for @loginPhotoBy.
  ///
  /// In de, this message translates to:
  /// **'Foto von '**
  String get loginPhotoBy;

  /// No description provided for @loginPhotoOn.
  ///
  /// In de, this message translates to:
  /// **' auf '**
  String get loginPhotoOn;

  /// No description provided for @loginPleaseSignIn.
  ///
  /// In de, this message translates to:
  /// **'Bitte melde dich an'**
  String get loginPleaseSignIn;

  /// No description provided for @loginUsername.
  ///
  /// In de, this message translates to:
  /// **'Benutzername'**
  String get loginUsername;

  /// No description provided for @loginPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get loginPassword;

  /// No description provided for @loginRememberMe.
  ///
  /// In de, this message translates to:
  /// **'Angemeldet bleiben'**
  String get loginRememberMe;

  /// No description provided for @loginSignIn.
  ///
  /// In de, this message translates to:
  /// **'ANMELDEN'**
  String get loginSignIn;

  /// No description provided for @loginNoAccount.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Account? '**
  String get loginNoAccount;

  /// No description provided for @loginRegisterNow.
  ///
  /// In de, this message translates to:
  /// **'Jetzt registrieren'**
  String get loginRegisterNow;

  /// No description provided for @commonBack.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get commonBack;

  /// No description provided for @commonNext.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get commonNext;

  /// No description provided for @registerFillRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte alle Pflichtfelder ausfüllen.'**
  String get registerFillRequired;

  /// No description provided for @registerPasswordMismatch.
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein.'**
  String get registerPasswordMismatch;

  /// No description provided for @registerPasswordTooShort.
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens 8 Zeichen haben.'**
  String get registerPasswordTooShort;

  /// No description provided for @registerSelectLanguage.
  ///
  /// In de, this message translates to:
  /// **'Bitte mindestens eine Sprache wählen.'**
  String get registerSelectLanguage;

  /// No description provided for @registerFailed.
  ///
  /// In de, this message translates to:
  /// **'Registrierung fehlgeschlagen.'**
  String get registerFailed;

  /// No description provided for @registerHeaderTitle.
  ///
  /// In de, this message translates to:
  /// **'REGISTRIERUNG'**
  String get registerHeaderTitle;

  /// No description provided for @registerStepAccount.
  ///
  /// In de, this message translates to:
  /// **'Account'**
  String get registerStepAccount;

  /// No description provided for @registerStepRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get registerStepRole;

  /// No description provided for @registerStepLanguages.
  ///
  /// In de, this message translates to:
  /// **'Sprachen'**
  String get registerStepLanguages;

  /// No description provided for @registerStepApiKeys.
  ///
  /// In de, this message translates to:
  /// **'API-Keys'**
  String get registerStepApiKeys;

  /// No description provided for @registerYourAccount.
  ///
  /// In de, this message translates to:
  /// **'Dein Account'**
  String get registerYourAccount;

  /// No description provided for @registerAvatarOptional.
  ///
  /// In de, this message translates to:
  /// **'Avatar (optional)'**
  String get registerAvatarOptional;

  /// No description provided for @registerUsernameRequired.
  ///
  /// In de, this message translates to:
  /// **'Benutzername *'**
  String get registerUsernameRequired;

  /// No description provided for @registerEmailRequired.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse *'**
  String get registerEmailRequired;

  /// No description provided for @registerPasswordRequired.
  ///
  /// In de, this message translates to:
  /// **'Passwort *'**
  String get registerPasswordRequired;

  /// No description provided for @registerPasswordRepeat.
  ///
  /// In de, this message translates to:
  /// **'Passwort wiederholen *'**
  String get registerPasswordRepeat;

  /// No description provided for @registerYourRole.
  ///
  /// In de, this message translates to:
  /// **'Deine Rolle'**
  String get registerYourRole;

  /// No description provided for @registerRoleExplanation.
  ///
  /// In de, this message translates to:
  /// **'Übersetzer können Texte übersetzen, haben aber keinen Zugriff auf die Review-Warteschlange. Reviewer prüfen und geben übersetzte Inhalte frei.'**
  String get registerRoleExplanation;

  /// No description provided for @registerRoleTranslator.
  ///
  /// In de, this message translates to:
  /// **'Übersetzer'**
  String get registerRoleTranslator;

  /// No description provided for @registerRoleTranslatorDesc.
  ///
  /// In de, this message translates to:
  /// **'Erstelle und bearbeite Übersetzungen.'**
  String get registerRoleTranslatorDesc;

  /// No description provided for @registerRoleReviewer.
  ///
  /// In de, this message translates to:
  /// **'Reviewer'**
  String get registerRoleReviewer;

  /// No description provided for @registerRoleReviewerDesc.
  ///
  /// In de, this message translates to:
  /// **'Prüfe und gebe Übersetzungen frei.'**
  String get registerRoleReviewerDesc;

  /// No description provided for @registerTargetLanguages.
  ///
  /// In de, this message translates to:
  /// **'Zielsprachen'**
  String get registerTargetLanguages;

  /// No description provided for @registerLanguagesExplanation.
  ///
  /// In de, this message translates to:
  /// **'Wähle alle Sprachen, für die du tätig sein möchtest.'**
  String get registerLanguagesExplanation;

  /// No description provided for @registerNoLanguagesAvailable.
  ///
  /// In de, this message translates to:
  /// **'Keine Sprachen verfügbar.'**
  String get registerNoLanguagesAvailable;

  /// No description provided for @registerApiKeysTitle.
  ///
  /// In de, this message translates to:
  /// **'API-Keys'**
  String get registerApiKeysTitle;

  /// No description provided for @registerApiKeysExplanation.
  ///
  /// In de, this message translates to:
  /// **'Trage deine eigenen API-Keys ein. Jeder Nutzer verwendet ausschließlich seine eigenen Keys. Du kannst diese auch später in deinem Profil nachtragen.'**
  String get registerApiKeysExplanation;

  /// No description provided for @registerKeysEncryptedNote.
  ///
  /// In de, this message translates to:
  /// **'Keys werden verschlüsselt gespeichert und niemals mit anderen Nutzern geteilt.'**
  String get registerKeysEncryptedNote;

  /// No description provided for @registerOptionalSuffix.
  ///
  /// In de, this message translates to:
  /// **' (optional)'**
  String get registerOptionalSuffix;

  /// No description provided for @registerSuccessTitle.
  ///
  /// In de, this message translates to:
  /// **'Registrierung erfolgreich!'**
  String get registerSuccessTitle;

  /// No description provided for @registerSuccessBody.
  ///
  /// In de, this message translates to:
  /// **'Dein Account wurde angelegt und wartet auf die Freischaltung durch einen Administrator. Du wirst benachrichtigt, sobald dein Zugang aktiviert wurde.'**
  String get registerSuccessBody;

  /// No description provided for @registerGoToLogin.
  ///
  /// In de, this message translates to:
  /// **'Zur Anmeldung'**
  String get registerGoToLogin;

  /// No description provided for @registerSubmit.
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get registerSubmit;

  /// No description provided for @registerPhotoCredit.
  ///
  /// In de, this message translates to:
  /// **'Foto von {name} auf Unsplash'**
  String registerPhotoCredit(String name);

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In de, this message translates to:
  /// **'Profil erfolgreich aktualisiert!'**
  String get profileUpdateSuccess;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In de, this message translates to:
  /// **'Aktualisierung fehlgeschlagen.'**
  String get profileUpdateFailed;

  /// No description provided for @profileSaveError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern: {error}'**
  String profileSaveError(String error);

  /// No description provided for @profilePasswordMismatch.
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein!'**
  String get profilePasswordMismatch;

  /// No description provided for @profilePasswordChangeSuccess.
  ///
  /// In de, this message translates to:
  /// **'Passwort erfolgreich geändert!'**
  String get profilePasswordChangeSuccess;

  /// No description provided for @profilePasswordChangeError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Ändern des Passworts: Falsches aktuelles Passwort.'**
  String get profilePasswordChangeError;

  /// No description provided for @profileAvatarUploadSuccess.
  ///
  /// In de, this message translates to:
  /// **'Profilbild erfolgreich hochgeladen!'**
  String get profileAvatarUploadSuccess;

  /// No description provided for @profileAvatarUploadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Hochladen des Profilbildes.'**
  String get profileAvatarUploadError;

  /// No description provided for @profileTitle.
  ///
  /// In de, this message translates to:
  /// **'Profil & Einstellungen'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Verwalte dein Benutzerprofil, deine Übersetzungs-APIs (Gemini & DeepL) und deine Kontosicherheit.'**
  String get profileSubtitle;

  /// No description provided for @profileRoleUser.
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get profileRoleUser;

  /// No description provided for @profileNoEmail.
  ///
  /// In de, this message translates to:
  /// **'Keine E-Mail angegeben'**
  String get profileNoEmail;

  /// No description provided for @profileTabDetails.
  ///
  /// In de, this message translates to:
  /// **'Profildetails'**
  String get profileTabDetails;

  /// No description provided for @profileTabGemini.
  ///
  /// In de, this message translates to:
  /// **'AI translation (Gemini)'**
  String get profileTabGemini;

  /// No description provided for @profileTabDeepl.
  ///
  /// In de, this message translates to:
  /// **'DeepL Übersetzung'**
  String get profileTabDeepl;

  /// No description provided for @profileTabPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get profileTabPassword;

  /// No description provided for @profileSectionInfo.
  ///
  /// In de, this message translates to:
  /// **'PROFIL INFORMATIONEN'**
  String get profileSectionInfo;

  /// No description provided for @profileFieldName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get profileFieldName;

  /// No description provided for @profileFieldNameHint.
  ///
  /// In de, this message translates to:
  /// **'Dein voller Name'**
  String get profileFieldNameHint;

  /// No description provided for @profileFieldEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail Adresse'**
  String get profileFieldEmail;

  /// No description provided for @profileFieldEmailHint.
  ///
  /// In de, this message translates to:
  /// **'Deine E-Mail Adresse'**
  String get profileFieldEmailHint;

  /// No description provided for @profileSectionGemini.
  ///
  /// In de, this message translates to:
  /// **'GEMINI CO-PILOT EINSTELLUNGEN'**
  String get profileSectionGemini;

  /// No description provided for @profileFieldGeminiKey.
  ///
  /// In de, this message translates to:
  /// **'Google Gemini API Key'**
  String get profileFieldGeminiKey;

  /// No description provided for @profileFieldGeminiKeyHint.
  ///
  /// In de, this message translates to:
  /// **'Gib deinen gemini-3.1-flash API-Schlüssel ein'**
  String get profileFieldGeminiKeyHint;

  /// No description provided for @profileFieldAiPrompt.
  ///
  /// In de, this message translates to:
  /// **'Individueller AI-Prompt'**
  String get profileFieldAiPrompt;

  /// No description provided for @profileFieldAiPromptHint.
  ///
  /// In de, this message translates to:
  /// **'Optional: Passe den System-Prompt für Gemini an...'**
  String get profileFieldAiPromptHint;

  /// No description provided for @profileSectionDeepl.
  ///
  /// In de, this message translates to:
  /// **'DEEPL ÜBERSETZUNGS-EINSTELLUNGEN'**
  String get profileSectionDeepl;

  /// No description provided for @profileDeeplDescription.
  ///
  /// In de, this message translates to:
  /// **'DeepL bietet hochwertige maschinelle Übersetzung mit HTML-Tag-Erhaltung. Kostenlose Accounts (500.000 Zeichen/Monat) erhalten einen Key mit dem Suffix \":fx\".'**
  String get profileDeeplDescription;

  /// No description provided for @profileFieldDeeplKey.
  ///
  /// In de, this message translates to:
  /// **'DeepL API Key'**
  String get profileFieldDeeplKey;

  /// No description provided for @profileFieldDeeplKeyHint.
  ///
  /// In de, this message translates to:
  /// **'z.B. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx'**
  String get profileFieldDeeplKeyHint;

  /// No description provided for @profileDeeplInfo.
  ///
  /// In de, this message translates to:
  /// **'Free-Keys enden auf \":fx\" und verwenden api-free.deepl.com. Pro-Keys verwenden api.deepl.com. Die Unterscheidung erfolgt automatisch.'**
  String get profileDeeplInfo;

  /// No description provided for @profileSectionSecurity.
  ///
  /// In de, this message translates to:
  /// **'KONTOSICHERHEIT'**
  String get profileSectionSecurity;

  /// No description provided for @profileFieldCurrentPassword.
  ///
  /// In de, this message translates to:
  /// **'Aktuelles Passwort'**
  String get profileFieldCurrentPassword;

  /// No description provided for @profileFieldCurrentPasswordHint.
  ///
  /// In de, this message translates to:
  /// **'Gib dein aktuelles Passwort ein'**
  String get profileFieldCurrentPasswordHint;

  /// No description provided for @profileFieldNewPassword.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get profileFieldNewPassword;

  /// No description provided for @profileFieldNewPasswordHint.
  ///
  /// In de, this message translates to:
  /// **'Mindestens 6 Zeichen'**
  String get profileFieldNewPasswordHint;

  /// No description provided for @profileFieldConfirmPassword.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort bestätigen'**
  String get profileFieldConfirmPassword;

  /// No description provided for @profileFieldConfirmPasswordHint.
  ///
  /// In de, this message translates to:
  /// **'Passwort wiederholen'**
  String get profileFieldConfirmPasswordHint;

  /// No description provided for @profileChangePasswordButton.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get profileChangePasswordButton;

  /// No description provided for @commonDelete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get commonDelete;

  /// No description provided for @settingsRegistrationUpdated.
  ///
  /// In de, this message translates to:
  /// **'Registrierungseinstellung aktualisiert'**
  String get settingsRegistrationUpdated;

  /// No description provided for @settingsUpdateFailed.
  ///
  /// In de, this message translates to:
  /// **'Update fehlgeschlagen.'**
  String get settingsUpdateFailed;

  /// No description provided for @settingsUserApproved.
  ///
  /// In de, this message translates to:
  /// **'Nutzer freigeschaltet!'**
  String get settingsUserApproved;

  /// No description provided for @settingsAccountDeactivated.
  ///
  /// In de, this message translates to:
  /// **'Konto gesperrt.'**
  String get settingsAccountDeactivated;

  /// No description provided for @settingsUserDeleted.
  ///
  /// In de, this message translates to:
  /// **'Nutzer gelöscht.'**
  String get settingsUserDeleted;

  /// No description provided for @settingsActionFailed.
  ///
  /// In de, this message translates to:
  /// **'Aktion fehlgeschlagen.'**
  String get settingsActionFailed;

  /// No description provided for @settingsDeleteAccountTitle.
  ///
  /// In de, this message translates to:
  /// **'Konto löschen?'**
  String get settingsDeleteAccountTitle;

  /// No description provided for @settingsDeactivateAccountTitle.
  ///
  /// In de, this message translates to:
  /// **'Konto sperren?'**
  String get settingsDeactivateAccountTitle;

  /// No description provided for @settingsDeleteAccountBody.
  ///
  /// In de, this message translates to:
  /// **'Das Konto von \"{username}\" wird unwiderruflich gelöscht. Fortfahren?'**
  String settingsDeleteAccountBody(String username);

  /// No description provided for @settingsDeactivateAccountBody.
  ///
  /// In de, this message translates to:
  /// **'Das Konto von \"{username}\" wird gesperrt. Der Nutzer kann sich nicht mehr anmelden, das Konto bleibt aber erhalten.'**
  String settingsDeactivateAccountBody(String username);

  /// No description provided for @settingsDeactivate.
  ///
  /// In de, this message translates to:
  /// **'Sperren'**
  String get settingsDeactivate;

  /// No description provided for @settingsSyncSuccess.
  ///
  /// In de, this message translates to:
  /// **'{count} Übersetzungen synchronisiert!'**
  String settingsSyncSuccess(String count);

  /// No description provided for @settingsSyncError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Synchronisation: {error}'**
  String settingsSyncError(String error);

  /// No description provided for @settingsPrioritySyncSuccess.
  ///
  /// In de, this message translates to:
  /// **'{count} Priority-Module synchronisiert!'**
  String settingsPrioritySyncSuccess(String count);

  /// No description provided for @settingsPrioritySyncError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Synchronisieren der Priority-Liste. Wurde die Liste schon generiert? ({error})'**
  String settingsPrioritySyncError(String error);

  /// No description provided for @settingsBackupSuccess.
  ///
  /// In de, this message translates to:
  /// **'Backup erfolgreich: {count} Dateien verarbeitet.'**
  String settingsBackupSuccess(String count);

  /// No description provided for @settingsUploadFailed.
  ///
  /// In de, this message translates to:
  /// **'Upload fehlgeschlagen.'**
  String get settingsUploadFailed;

  /// No description provided for @settingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// No description provided for @settingsSystemConfig.
  ///
  /// In de, this message translates to:
  /// **'SYSTEM-KONFIGURATION'**
  String get settingsSystemConfig;

  /// No description provided for @settingsRegistration.
  ///
  /// In de, this message translates to:
  /// **'Registrierung'**
  String get settingsRegistration;

  /// No description provided for @settingsRegistrationHint.
  ///
  /// In de, this message translates to:
  /// **'Schalte das Registrierungsformular global an oder aus.'**
  String get settingsRegistrationHint;

  /// No description provided for @settingsPendingUsers.
  ///
  /// In de, this message translates to:
  /// **'Wartende Nutzer'**
  String get settingsPendingUsers;

  /// No description provided for @settingsNoNewRequests.
  ///
  /// In de, this message translates to:
  /// **'Keine neuen Anfragen.'**
  String get settingsNoNewRequests;

  /// No description provided for @settingsWantsReviewer.
  ///
  /// In de, this message translates to:
  /// **'Möchte Reviewer werden'**
  String get settingsWantsReviewer;

  /// No description provided for @settingsAssignRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle zuweisen'**
  String get settingsAssignRole;

  /// No description provided for @settingsRoleTranslator.
  ///
  /// In de, this message translates to:
  /// **'Übersetzer'**
  String get settingsRoleTranslator;

  /// No description provided for @settingsRoleReviewer.
  ///
  /// In de, this message translates to:
  /// **'Reviewer'**
  String get settingsRoleReviewer;

  /// No description provided for @settingsApprove.
  ///
  /// In de, this message translates to:
  /// **'Freischalten'**
  String get settingsApprove;

  /// No description provided for @settingsReject.
  ///
  /// In de, this message translates to:
  /// **'Ablehnen'**
  String get settingsReject;

  /// No description provided for @settingsActiveUsers.
  ///
  /// In de, this message translates to:
  /// **'Aktive Benutzer'**
  String get settingsActiveUsers;

  /// No description provided for @settingsNoActiveUsers.
  ///
  /// In de, this message translates to:
  /// **'Keine aktiven Benutzer.'**
  String get settingsNoActiveUsers;

  /// No description provided for @settingsDeactivateAccountTooltip.
  ///
  /// In de, this message translates to:
  /// **'Konto sperren'**
  String get settingsDeactivateAccountTooltip;

  /// No description provided for @settingsDeleteAccountAction.
  ///
  /// In de, this message translates to:
  /// **'Konto löschen'**
  String get settingsDeleteAccountAction;

  /// No description provided for @settingsAppearance.
  ///
  /// In de, this message translates to:
  /// **'Erscheinungsbild'**
  String get settingsAppearance;

  /// No description provided for @settingsThemePearl.
  ///
  /// In de, this message translates to:
  /// **'HELL (PERLE)'**
  String get settingsThemePearl;

  /// No description provided for @settingsThemeDark.
  ///
  /// In de, this message translates to:
  /// **'DUNKEL'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeGlassy.
  ///
  /// In de, this message translates to:
  /// **'GLASIG'**
  String get settingsThemeGlassy;

  /// No description provided for @settingsThemeNature.
  ///
  /// In de, this message translates to:
  /// **'NATUR'**
  String get settingsThemeNature;

  /// No description provided for @settingsThemeLiquid.
  ///
  /// In de, this message translates to:
  /// **'FLÜSSIG'**
  String get settingsThemeLiquid;

  /// No description provided for @settingsThemeStage.
  ///
  /// In de, this message translates to:
  /// **'BÜHNE'**
  String get settingsThemeStage;

  /// No description provided for @settingsTypography.
  ///
  /// In de, this message translates to:
  /// **'Typografie'**
  String get settingsTypography;

  /// No description provided for @settingsFontHint.
  ///
  /// In de, this message translates to:
  /// **'Schriftstil der Benutzeroberfläche ändern.'**
  String get settingsFontHint;

  /// No description provided for @settingsFontClean.
  ///
  /// In de, this message translates to:
  /// **'Klar'**
  String get settingsFontClean;

  /// No description provided for @settingsFontFuturistic.
  ///
  /// In de, this message translates to:
  /// **'Futuristisch'**
  String get settingsFontFuturistic;

  /// No description provided for @settingsFontTech.
  ///
  /// In de, this message translates to:
  /// **'Tech'**
  String get settingsFontTech;

  /// No description provided for @settingsWorkflowFun.
  ///
  /// In de, this message translates to:
  /// **'Workflow & Spaß'**
  String get settingsWorkflowFun;

  /// No description provided for @settingsConfettiTitle.
  ///
  /// In de, this message translates to:
  /// **'Erfolgs-Feier (Konfetti)'**
  String get settingsConfettiTitle;

  /// No description provided for @settingsConfettiHint.
  ///
  /// In de, this message translates to:
  /// **'Zeigt eine kleine Animation beim erfolgreichen Speichern.'**
  String get settingsConfettiHint;

  /// No description provided for @settingsLargeUiTitle.
  ///
  /// In de, this message translates to:
  /// **'Verbesserte Lesbarkeit (Große Schrift)'**
  String get settingsLargeUiTitle;

  /// No description provided for @settingsLargeUiHint.
  ///
  /// In de, this message translates to:
  /// **'Vergrößert die Schrift und Badges für bessere Sichtbarkeit.'**
  String get settingsLargeUiHint;

  /// No description provided for @settingsAutoPTitle.
  ///
  /// In de, this message translates to:
  /// **'Automatische Absatzformatierung (¶ Auto-P)'**
  String get settingsAutoPTitle;

  /// No description provided for @settingsAutoPHint.
  ///
  /// In de, this message translates to:
  /// **'Wandelt einfachen Text automatisch in <p>-Absätze um, sobald ein Modul im Review-Screen geladen wird. Entspricht dem manuellen Klick auf den ¶-Button.'**
  String get settingsAutoPHint;

  /// No description provided for @settingsDatabaseSync.
  ///
  /// In de, this message translates to:
  /// **'Datenbank-Sync'**
  String get settingsDatabaseSync;

  /// No description provided for @settingsDatabaseSyncTooltip.
  ///
  /// In de, this message translates to:
  /// **'Gleicht die DB mit den JSON-Dateien auf dem Server ab.'**
  String get settingsDatabaseSyncTooltip;

  /// No description provided for @settingsDatabaseSyncHint.
  ///
  /// In de, this message translates to:
  /// **'Gleicht die internen Datenbank-Einträge mit den JSON-Dateien auf dem Server ab.'**
  String get settingsDatabaseSyncHint;

  /// No description provided for @settingsSyncing.
  ///
  /// In de, this message translates to:
  /// **'Synchronisiere...'**
  String get settingsSyncing;

  /// No description provided for @settingsSyncNow.
  ///
  /// In de, this message translates to:
  /// **'Jetzt synchronisieren'**
  String get settingsSyncNow;

  /// No description provided for @settingsSyncD11List.
  ///
  /// In de, this message translates to:
  /// **'D11 Liste einlesen'**
  String get settingsSyncD11List;

  /// No description provided for @settingsUploadBackup.
  ///
  /// In de, this message translates to:
  /// **'Backup einspielen (.zip)'**
  String get settingsUploadBackup;

  /// No description provided for @settingsSelectZipFile.
  ///
  /// In de, this message translates to:
  /// **'ZIP Datei auswählen'**
  String get settingsSelectZipFile;

  /// No description provided for @settingsUploading.
  ///
  /// In de, this message translates to:
  /// **'Lade hoch...'**
  String get settingsUploading;

  /// No description provided for @settingsErrorDiagnostics.
  ///
  /// In de, this message translates to:
  /// **'Fehler-Diagnose & System-Logs'**
  String get settingsErrorDiagnostics;

  /// No description provided for @settingsLogsCopied.
  ///
  /// In de, this message translates to:
  /// **'Logs in Zwischenablage kopiert! 📋'**
  String get settingsLogsCopied;

  /// No description provided for @settingsCopyLogs.
  ///
  /// In de, this message translates to:
  /// **'Kopieren'**
  String get settingsCopyLogs;

  /// No description provided for @settingsLogsRotated.
  ///
  /// In de, this message translates to:
  /// **'Logs archiviert und rotiert! 📁'**
  String get settingsLogsRotated;

  /// No description provided for @settingsRotate.
  ///
  /// In de, this message translates to:
  /// **'Rotieren'**
  String get settingsRotate;

  /// No description provided for @settingsClear.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get settingsClear;

  /// No description provided for @settingsLogLimit.
  ///
  /// In de, this message translates to:
  /// **'Loglimit: '**
  String get settingsLogLimit;

  /// No description provided for @settingsNoLogs.
  ///
  /// In de, this message translates to:
  /// **'Keine Logs vorhanden'**
  String get settingsNoLogs;

  /// No description provided for @layoutMenu.
  ///
  /// In de, this message translates to:
  /// **'Navigation'**
  String get layoutMenu;

  /// No description provided for @layoutNavAnalytics.
  ///
  /// In de, this message translates to:
  /// **'Statistik'**
  String get layoutNavAnalytics;

  /// No description provided for @layoutNavReviewQueue.
  ///
  /// In de, this message translates to:
  /// **'Review Warteschlange'**
  String get layoutNavReviewQueue;

  /// No description provided for @layoutNavGlossary.
  ///
  /// In de, this message translates to:
  /// **'Glossar'**
  String get layoutNavGlossary;

  /// No description provided for @layoutNavCategories.
  ///
  /// In de, this message translates to:
  /// **'Kategorien'**
  String get layoutNavCategories;

  /// No description provided for @layoutNavHelp.
  ///
  /// In de, this message translates to:
  /// **'Hilfe'**
  String get layoutNavHelp;

  /// No description provided for @layoutNavSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get layoutNavSettings;

  /// No description provided for @layoutPhotoBy.
  ///
  /// In de, this message translates to:
  /// **'Foto von '**
  String get layoutPhotoBy;

  /// No description provided for @layoutPhotoOn.
  ///
  /// In de, this message translates to:
  /// **' auf '**
  String get layoutPhotoOn;

  /// No description provided for @layoutEditProfile.
  ///
  /// In de, this message translates to:
  /// **'Profil bearbeiten'**
  String get layoutEditProfile;

  /// No description provided for @layoutLogout.
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get layoutLogout;

  /// No description provided for @layoutThemeLabel.
  ///
  /// In de, this message translates to:
  /// **'DESIGN'**
  String get layoutThemeLabel;

  /// No description provided for @layoutThemePearl.
  ///
  /// In de, this message translates to:
  /// **'Hell'**
  String get layoutThemePearl;

  /// No description provided for @layoutThemeDark.
  ///
  /// In de, this message translates to:
  /// **'Dunkel'**
  String get layoutThemeDark;

  /// No description provided for @layoutThemeGlassy.
  ///
  /// In de, this message translates to:
  /// **'Glasig'**
  String get layoutThemeGlassy;

  /// No description provided for @layoutThemeNature.
  ///
  /// In de, this message translates to:
  /// **'Natur'**
  String get layoutThemeNature;

  /// No description provided for @layoutThemeLiquid.
  ///
  /// In de, this message translates to:
  /// **'Flüssig'**
  String get layoutThemeLiquid;

  /// No description provided for @layoutThemeStage.
  ///
  /// In de, this message translates to:
  /// **'Bühne'**
  String get layoutThemeStage;

  /// No description provided for @layoutTargetLanguage.
  ///
  /// In de, this message translates to:
  /// **'ZIELSPRACHE'**
  String get layoutTargetLanguage;

  /// No description provided for @layoutDeeplUsage.
  ///
  /// In de, this message translates to:
  /// **'DEEPL VERBRAUCH'**
  String get layoutDeeplUsage;

  /// No description provided for @layoutUnavailable.
  ///
  /// In de, this message translates to:
  /// **'Nicht verfügbar'**
  String get layoutUnavailable;

  /// No description provided for @layoutUnlimited.
  ///
  /// In de, this message translates to:
  /// **'unbegrenzt'**
  String get layoutUnlimited;

  /// No description provided for @layoutUsed.
  ///
  /// In de, this message translates to:
  /// **'verbraucht'**
  String get layoutUsed;

  /// No description provided for @layoutTranslate.
  ///
  /// In de, this message translates to:
  /// **'Übersetzen'**
  String get layoutTranslate;

  /// No description provided for @analyticsSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Kompatibilität, Übersetzungsbedarf und Wochen-Verlauf.'**
  String get analyticsSubtitle;

  /// No description provided for @analyticsBacklog.
  ///
  /// In de, this message translates to:
  /// **'Übersetzungsbedarf'**
  String get analyticsBacklog;

  /// No description provided for @analyticsMissing.
  ///
  /// In de, this message translates to:
  /// **'Fehlend'**
  String get analyticsMissing;

  /// No description provided for @analyticsStale.
  ///
  /// In de, this message translates to:
  /// **'Veraltet'**
  String get analyticsStale;

  /// No description provided for @analyticsInReview.
  ///
  /// In de, this message translates to:
  /// **'Im Review'**
  String get analyticsInReview;

  /// No description provided for @analyticsReleased.
  ///
  /// In de, this message translates to:
  /// **'Freigegeben'**
  String get analyticsReleased;

  /// No description provided for @analyticsTranslated.
  ///
  /// In de, this message translates to:
  /// **'Übersetzt'**
  String get analyticsTranslated;

  /// No description provided for @analyticsTotalModules.
  ///
  /// In de, this message translates to:
  /// **'Module gesamt'**
  String get analyticsTotalModules;

  /// No description provided for @analyticsCompatByVersion.
  ///
  /// In de, this message translates to:
  /// **'Kompatibilität pro Drupal-Version'**
  String get analyticsCompatByVersion;

  /// No description provided for @analyticsLanguageLegend.
  ///
  /// In de, this message translates to:
  /// **'Sprache: {lang} · freigegeben / im Review / fehlend'**
  String analyticsLanguageLegend(String lang);

  /// No description provided for @analyticsLoadingCounts.
  ///
  /// In de, this message translates to:
  /// **'Lade Zähler …'**
  String get analyticsLoadingCounts;

  /// No description provided for @analyticsWindow.
  ///
  /// In de, this message translates to:
  /// **'Zeitraum:'**
  String get analyticsWindow;

  /// No description provided for @analyticsWeeks.
  ///
  /// In de, this message translates to:
  /// **'{weeks} Wochen'**
  String analyticsWeeks(String weeks);

  /// No description provided for @analyticsNewDescriptionsPerWeek.
  ///
  /// In de, this message translates to:
  /// **'Neue Projektbeschreibungen pro Woche'**
  String get analyticsNewDescriptionsPerWeek;

  /// No description provided for @analyticsMarkedOutdatedPerWeek.
  ///
  /// In de, this message translates to:
  /// **'Als veraltet markiert pro Woche ({lang})'**
  String analyticsMarkedOutdatedPerWeek(String lang);

  /// No description provided for @analyticsModuleCount.
  ///
  /// In de, this message translates to:
  /// **'{count} Module'**
  String analyticsModuleCount(String count);

  /// No description provided for @analyticsReviewShort.
  ///
  /// In de, this message translates to:
  /// **'Review'**
  String get analyticsReviewShort;

  /// No description provided for @analyticsNoDataInWindow.
  ///
  /// In de, this message translates to:
  /// **'Keine Daten im Zeitraum.'**
  String get analyticsNoDataInWindow;

  /// No description provided for @analyticsAndMore.
  ///
  /// In de, this message translates to:
  /// **'… und weitere'**
  String get analyticsAndMore;

  /// No description provided for @glossaryLoadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden: {error}'**
  String glossaryLoadError(String error);

  /// No description provided for @glossaryNewTerm.
  ///
  /// In de, this message translates to:
  /// **'Neuen Begriff anlegen'**
  String get glossaryNewTerm;

  /// No description provided for @glossaryEditTerm.
  ///
  /// In de, this message translates to:
  /// **'Begriff bearbeiten'**
  String get glossaryEditTerm;

  /// No description provided for @glossaryFieldSourceWord.
  ///
  /// In de, this message translates to:
  /// **'Quellwort (Grundform, erscheint im Text)'**
  String get glossaryFieldSourceWord;

  /// No description provided for @glossaryFieldSourceWordHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Knoten'**
  String get glossaryFieldSourceWordHint;

  /// No description provided for @glossaryWordForms.
  ///
  /// In de, this message translates to:
  /// **'Weitere Wortformen (Plural, Genitiv, Dativ …)'**
  String get glossaryWordForms;

  /// No description provided for @glossaryWordFormsHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Inhalte — Enter zum Hinzufügen'**
  String get glossaryWordFormsHint;

  /// No description provided for @glossaryAddForm.
  ///
  /// In de, this message translates to:
  /// **'Form hinzufügen'**
  String get glossaryAddForm;

  /// No description provided for @glossaryFieldPreferredWord.
  ///
  /// In de, this message translates to:
  /// **'Bevorzugte Übersetzung'**
  String get glossaryFieldPreferredWord;

  /// No description provided for @glossaryFieldPreferredWordHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Inhalt'**
  String get glossaryFieldPreferredWordHint;

  /// No description provided for @glossaryFieldExplanation.
  ///
  /// In de, this message translates to:
  /// **'Erklärung (wird im Tooltip angezeigt)'**
  String get glossaryFieldExplanation;

  /// No description provided for @glossaryFieldExplanationHint.
  ///
  /// In de, this message translates to:
  /// **'Warum soll dieses Wort anders übersetzt werden?'**
  String get glossaryFieldExplanationHint;

  /// No description provided for @glossaryCreate.
  ///
  /// In de, this message translates to:
  /// **'Anlegen'**
  String get glossaryCreate;

  /// No description provided for @glossaryRequiredFields.
  ///
  /// In de, this message translates to:
  /// **'Quellwort und bevorzugte Übersetzung sind Pflichtfelder.'**
  String get glossaryRequiredFields;

  /// No description provided for @glossaryCreated.
  ///
  /// In de, this message translates to:
  /// **'Begriff angelegt ✓'**
  String get glossaryCreated;

  /// No description provided for @glossaryUpdated.
  ///
  /// In de, this message translates to:
  /// **'Begriff aktualisiert ✓'**
  String get glossaryUpdated;

  /// No description provided for @glossaryError.
  ///
  /// In de, this message translates to:
  /// **'Fehler: {error}'**
  String glossaryError(String error);

  /// No description provided for @glossaryDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Begriff löschen?'**
  String get glossaryDeleteTitle;

  /// No description provided for @glossaryDeleteBody.
  ///
  /// In de, this message translates to:
  /// **'\"{word}\" wird dauerhaft aus dem Glossar entfernt.'**
  String glossaryDeleteBody(String word);

  /// No description provided for @glossaryDeleted.
  ///
  /// In de, this message translates to:
  /// **'Begriff gelöscht.'**
  String get glossaryDeleted;

  /// No description provided for @glossaryTitle.
  ///
  /// In de, this message translates to:
  /// **'Übersetzungs-Glossar'**
  String get glossaryTitle;

  /// No description provided for @glossaryLanguageCount.
  ///
  /// In de, this message translates to:
  /// **'Sprache: {lang} · {count} Einträge'**
  String glossaryLanguageCount(String lang, String count);

  /// No description provided for @glossaryNewShort.
  ///
  /// In de, this message translates to:
  /// **'Neu'**
  String get glossaryNewShort;

  /// No description provided for @glossaryCreateTerm.
  ///
  /// In de, this message translates to:
  /// **'Begriff anlegen'**
  String get glossaryCreateTerm;

  /// No description provided for @glossaryInfoBanner.
  ///
  /// In de, this message translates to:
  /// **'Wörter aus diesem Glossar werden im Review-Editor farblich hervorgehoben. Ein Tooltip erklärt beim Überfahren warum eine andere Übersetzung besser passt.'**
  String get glossaryInfoBanner;

  /// No description provided for @glossaryNoEntries.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Einträge.'**
  String get glossaryNoEntries;

  /// No description provided for @glossaryNoEntriesEditorHint.
  ///
  /// In de, this message translates to:
  /// **'Klicke auf „Begriff anlegen“ um den ersten Eintrag zu erstellen.'**
  String get glossaryNoEntriesEditorHint;

  /// No description provided for @glossaryNoEntriesForLanguage.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Glossar-Einträge für diese Sprache.'**
  String get glossaryNoEntriesForLanguage;

  /// No description provided for @diffNoChanges.
  ///
  /// In de, this message translates to:
  /// **'Keine inhaltlichen Unterschiede erkannt.'**
  String get diffNoChanges;

  /// No description provided for @diffRemoved.
  ///
  /// In de, this message translates to:
  /// **'Entfernt'**
  String get diffRemoved;

  /// No description provided for @diffAdded.
  ///
  /// In de, this message translates to:
  /// **'Hinzugefügt'**
  String get diffAdded;

  /// No description provided for @syncBarQuickSync.
  ///
  /// In de, this message translates to:
  /// **'Quick Sync: {count} geänderte Module …'**
  String syncBarQuickSync(String count);

  /// No description provided for @syncBarFullSyncProgress.
  ///
  /// In de, this message translates to:
  /// **'Full Sync: {current} / {total} Module'**
  String syncBarFullSyncProgress(String current, String total);

  /// No description provided for @syncBarFullSync.
  ///
  /// In de, this message translates to:
  /// **'Full Sync: {count} Module …'**
  String syncBarFullSync(String count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'az',
    'ca',
    'da',
    'de',
    'en',
    'es',
    'et',
    'fr',
    'hu',
    'id',
    'it',
    'ja',
    'ko',
    'lt',
    'nb',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sv',
    'tr',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'ca':
      return AppLocalizationsCa();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fr':
      return AppLocalizationsFr();
    case 'hu':
      return AppLocalizationsHu();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'lt':
      return AppLocalizationsLt();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
