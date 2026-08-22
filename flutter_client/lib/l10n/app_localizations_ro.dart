// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Se încarcă detaliile proiectului...';

  @override
  String editorLoadError(String error) {
    return 'Nu s-au putut încărca datele proiectului: $error';
  }

  @override
  String get editorGeminiSuccess => 'Traducere reușită cu Gemini! ✨';

  @override
  String get editorUnknownError => 'Eroare necunoscută';

  @override
  String editorGeminiFailed(String detail) {
    return 'Traducerea Gemini a eșuat: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Adaugă cheia ta Google AI în profilul de utilizator (nu în setările de administrare).';

  @override
  String get editorGeminiError =>
      'Eroare la traducerea cu Gemini. Verifică cheia Google AI din profilul tău.';

  @override
  String get editorDeeplSuccess => 'Traducere reușită cu DeepL! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Traducerea DeepL a eșuat: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Eroare la traducerea cu DeepL. Asigură-te că ai setată cheia API DeepL în profilul tău.';

  @override
  String get editorDeeplInvalidKey =>
      'Cheie API DeepL invalidă. Verific-o în profilul tău.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Cota DeepL a fost epuizată. Verifică-ți planul.';

  @override
  String get editorReviewReset =>
      'Traducerea a fost resetată la starea de verificare.';

  @override
  String editorResetError(String error) {
    return 'Resetarea a eșuat: $error';
  }

  @override
  String get editorUnignoreSuccess => 'Modulul a fost readus în lista activă.';

  @override
  String get editorUnignoreError => 'Nu s-a putut readuce modulul.';

  @override
  String get editorSaveSuccess =>
      'Traducere salvată — înapoi în coada de verificare.';

  @override
  String editorSaveError(String error) {
    return 'Salvarea a eșuat: $error';
  }

  @override
  String get editorNoMoreProjects => 'Nu mai sunt proiecte deschise în listă.';

  @override
  String get editorChangesDiscarded =>
      'Modificările au fost anulate, se încarcă următorul proiect...';

  @override
  String get editorEnglishSourceApplied =>
      'S-a aplicat originalul în engleză — te rugăm să îl traduci acum.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Nu s-a putut deschide URL-ul: $url';
  }

  @override
  String get commonSave => 'Salvează';

  @override
  String get commonClose => 'Închide';

  @override
  String get editorCloseEnglishSource => 'Închide sursa în engleză';

  @override
  String get editorShowEnglishSource => 'Afișează sursa în engleză';

  @override
  String get editorUnignoreShortTooltip => 'Readu modulul';

  @override
  String get editorBackToReviewTooltip => 'Setează din nou pentru verificare';

  @override
  String get editorAndNext => 'și următorul';

  @override
  String get editorBackToDashboard => 'Înapoi la panou';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Se traduce în $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count rămase';
  }

  @override
  String get editorUnignoreLongTooltip => 'Readu modulul în lista activă';

  @override
  String get editorUnignoreLabel => 'Readu';

  @override
  String get editorUnpublishTooltip =>
      'Revocă publicarea și setează din nou pentru verificare';

  @override
  String get editorBackToReview => 'Înapoi la verificare';

  @override
  String get editorSaveAndNext => 'Salvează și continuă';

  @override
  String get editorEnglishSourceHeader => 'SURSA ÎN ENGLEZĂ';

  @override
  String get editorStaleTooltip =>
      'Afișează explicația și aplică textul în engleză';

  @override
  String get editorStaleDetailsLabel => 'Perimat — detalii';

  @override
  String get editorCopyPromptTooltip => 'Copiază sursa + promptul de traducere';

  @override
  String get editorPromptCopied => 'Prompt copiat în clipboard 📋';

  @override
  String get editorShowPreview => 'Afișează previzualizarea';

  @override
  String get editorShowHtmlSource => 'Afișează sursa HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'REZUMAT:\n$summary\n\nCONȚINUT:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Rezumat:';

  @override
  String get editorDescriptionLabelColon => 'Descriere:';

  @override
  String get editorStaleDialogTitle => 'Sursa în engleză s-a schimbat';

  @override
  String get editorStaleExplanation =>
      'Traducerea existentă se bazează pe un text original în engleză care este perimat. De la ultima traducere, responsabilul modulului a modificat textul în engleză pe Drupal.org — conținutul traducerii existente ar putea fi, prin urmare, incorect sau incomplet.';

  @override
  String get editorStaleTip =>
      'Sfat: apasă pe „Folosește originalul în engleză” pentru a încărca sursa în engleză actuală direct în editor. O poți folosi apoi ca punct de plecare pentru o traducere nouă. Originalul în engleză este vizibil și în panoul din stânga.';

  @override
  String get editorEnglishSourceShort => 'Sursa în engleză';

  @override
  String get editorPreviousTranslation => 'Traducerea anterioară';

  @override
  String get editorWhatChangedTitle => 'Ce s-a schimbat?';

  @override
  String get editorShowDiff => 'Afișează diferențele';

  @override
  String get editorUseEnglish => 'Folosește originalul în engleză';

  @override
  String get editorStaleBannerText =>
      'Sursa în engleză s-a schimbat — traducerea este perimată';

  @override
  String get editorDetailsAndApply => 'Detalii și aplicare';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUCERE ($langName)';
  }

  @override
  String get editorTranslatingEllipsis => 'Se traduce...';

  @override
  String get editorShowEditor => 'Afișează editorul';

  @override
  String get editorModuleTitleLabel => 'Titlul modulului (engleză)';

  @override
  String get editorSummaryFieldLabel => 'Rezumat';

  @override
  String get editorBodyFieldLabel => 'Conținut';

  @override
  String get editorHtmlCleaned => 'HTML curățat';

  @override
  String get editorLivePreviewHeader => 'PREVIZUALIZARE LIVE';

  @override
  String get editorTidyHtmlTooltip =>
      'Curăță HTML-ul (elimină artefactele DeepL)';

  @override
  String get editorVisualMode => 'VIZUAL';

  @override
  String get editorSourceCodeMode => 'SURSĂ (HTML)';

  @override
  String get commonCancel => 'Anulează';

  @override
  String get costDialogTitle => 'Estimare cost (AI)';

  @override
  String get costDialogIntro =>
      'Modulul selectat va fi tradus cu Google Gemini AI. Iată defalcarea estimată a costurilor pentru această operațiune:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Tokenuri de intrare';

  @override
  String get costRowOutputTokens => 'Tokenuri de ieșire (estimare)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caractere)';
  }

  @override
  String get costRowPriceInput => 'Preț per 1M intrare';

  @override
  String get costRowPriceOutput => 'Preț per 1M ieșire';

  @override
  String get costRowTotalEstimate => 'Cost total estimat';

  @override
  String get costDialogFootnote =>
      '* Notă: aceasta este o estimare bazată pe modelul actual de preț pay-as-you-go al Google. Consumul real poate varia ușor.';

  @override
  String get costDialogStartTranslation => 'Începe traducerea';

  @override
  String get htmlToolbarInsertLink => 'Inserează link';

  @override
  String get htmlToolbarLinkTooltip => 'Inserează link (a)';

  @override
  String get htmlToolbarInsert => 'Inserează';

  @override
  String get htmlToolbarHeading2 => 'Titlu 2';

  @override
  String get htmlToolbarHeading3 => 'Titlu 3';

  @override
  String get htmlToolbarBold => 'Aldin (strong)';

  @override
  String get htmlToolbarItalic => 'Cursiv (em)';

  @override
  String get htmlToolbarBulletList => 'Listă cu marcatori (ul)';

  @override
  String get htmlToolbarNumberedList => 'Listă numerotată (ol)';

  @override
  String get htmlToolbarQuote => 'Citat (blockquote)';

  @override
  String get screenshotAltsHeader => 'TEXT ALTERNATIV PENTRU CAPTURI DE ECRAN';

  @override
  String get screenshotAltsIntro =>
      'Introdu un text alternativ descriptiv în limba țintă pentru fiecare captură de ecran.';

  @override
  String screenshotLabel(int number) {
    return 'Captură de ecran $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Previzualizare indisponibilă';

  @override
  String get screenshotAltHint => 'Introdu textul alternativ în limba țintă…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Readuci toate modulele?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Toate modulele ignorate vor fi readuse în lista activă și vor fi din nou disponibile pentru traducere.';

  @override
  String get dashUnignoreAllConfirmAction => 'Readu toate';

  @override
  String get dashUnignoreAllSuccess =>
      'Toate modulele ignorate au fost readuse.';

  @override
  String get dashUnignoreAllError => 'Nu s-au putut readuce modulele.';

  @override
  String get dashUnignoreAllButton => 'Readu toate modulele';

  @override
  String dashSyncStartError(String error) {
    return 'Sincronizarea nu a putut fi pornită: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'A început actualizarea rapidă (7 zile) ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Eroare la actualizarea rapidă: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sincronizat cu succes: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modulul nu a fost găsit pe Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Traducere în masă cu AI';

  @override
  String get dashHeaderTitle => 'Descrieri de proiecte';

  @override
  String get dashHeaderSubtitle =>
      'Tradu descrierile modulelor Drupal în limba țintă. Ajută la a face ecosistemul mai accesibil.';

  @override
  String get dashHeaderSubtitleShort => 'Tradu descrierile modulelor Drupal.';

  @override
  String get dashLastLabel => 'Ultima: ';

  @override
  String get dashContinue => 'Continuă';

  @override
  String get dashContinueShort => 'Continuă';

  @override
  String get dashUnignoreAllButtonLong => 'Readu toate modulele';

  @override
  String get dashQuickUpdateTooltip => 'Actualizare rapidă (ultimele 7 zile)';

  @override
  String get dashFullSyncTooltip =>
      'Sincronizare completă a bazei de date de pe Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Încarcă manual un singur modul de pe Drupal.org';

  @override
  String get dashQuickShort => 'Rapid';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Găsite: ';

  @override
  String get dashModulesSuffix => ' module';

  @override
  String dashPerPage(int count) {
    return '$count pe pagină';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / pagină';
  }

  @override
  String get dashFirstPage => 'Prima pagină';

  @override
  String get dashPrevPage => 'Pagina anterioară';

  @override
  String get dashNextPage => 'Pagina următoare';

  @override
  String get dashLastPage => 'Ultima pagină';

  @override
  String dashPageOf(int page, int total) {
    return 'Pagina $page din $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (ex. pathauto)';

  @override
  String get dashAddButton => 'Adaugă';

  @override
  String get dashAddModuleManually => 'Adaugă modul manual';

  @override
  String get dashAddModuleSubtitle =>
      'Încarcă direct de pe Drupal.org după machine name.';

  @override
  String get dashAddModuleShort => 'Adaugă modul';

  @override
  String get dashNoProjectsFound => 'Nu s-au găsit proiecte.';

  @override
  String get dashFilterAll => 'Toate proiectele';

  @override
  String get dashFilterMissing => 'Traduceri lipsă';

  @override
  String get dashFilterReview => 'Coadă de verificare';

  @override
  String get dashFilterTranslated => 'Proiecte traduse';

  @override
  String get dashFilterReleased => 'Proiecte publicate';

  @override
  String get dashBulkDialogIntro =>
      'Tradu automat mai multe module din filtrul selectat folosind Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtru activ';

  @override
  String get dashModuleCount => 'Număr de module';

  @override
  String dashModulesCountItem(int count) {
    return '$count module';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioritizează modulele Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Traduce mai întâi modulele fără suport pentru Drupal 12';

  @override
  String get dashTotalModules => 'Total module';

  @override
  String get dashInputTokensEst => 'Tokenuri de intrare (est.)';

  @override
  String get dashOutputTokensEst => 'Tokenuri de ieșire (est.)';

  @override
  String get dashBulkFootnote =>
      '* Traducerea este efectuată în loturi optimizate pentru resurse, pentru a preveni depășirile de timp.';

  @override
  String get dashStartBulkTranslation => 'Începe traducerea în masă';

  @override
  String dashStaleLoadError(String error) {
    return 'Eroare la încărcarea modulelor perimate: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Nu s-au găsit module perimate — totul este la zi! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Retradu modulele perimate';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Toate traducerile a căror sursă în engleză s-a schimbat de la ultima traducere vor fi retraduse automat cu Google Gemini. Nu este nevoie să deschizi manual fiecare modul.';

  @override
  String get dashOutdatedModules => 'Module perimate';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Traducerea înlocuiește textul existent și resetează is_reviewed. Se execută în loturi de 4 module.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Retradu toate cele $count module';
  }

  @override
  String get dashRetranslatingOutdatedTitle => 'Se retraduc modulele perimate…';

  @override
  String get dashFetchingProjects => 'Se preiau proiectele de pe server…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed din $total module procesate';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Nu s-au găsit proiecte traductibile pentru acest filtru.';

  @override
  String get dashStartingTranslation => 'Se pornește traducerea…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Se traduce modulul $start–$end din $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end din $total module finalizate.';
  }

  @override
  String get dashTranslationCompleted => 'Traducere finalizată cu succes! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Traducerea în masă a $count module a reușit! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Eroare la traducerea în masă: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Toate cele $count module au fost retraduse cu succes! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count module perimate au fost retraduse cu succes! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Eroare la retraducere: $error';
  }

  @override
  String get filterAllShort => 'Toate';

  @override
  String get filterMissing => 'Lipsă';

  @override
  String get filterTranslated => 'Traduse';

  @override
  String get filterReviewQueue => 'Coadă de verificare';

  @override
  String get filterReleased => 'Publicate';

  @override
  String get filterOutdated => 'Perimate';

  @override
  String get filterPriority => 'Prioritate';

  @override
  String get filterIgnored => 'Ignorate';

  @override
  String get commonEdit => 'Editează';

  @override
  String get commonReset => 'Resetează';

  @override
  String get commonRefresh => 'Reîmprospătează';

  @override
  String commonErrorPrefix(String error) {
    return 'Eroare: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Resetezi toate traducerile publicate?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Toate traducerile marcate ca publicate pentru $langcode vor fi resetate la starea de verificare. Această acțiune nu poate fi anulată.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traduceri resetate la starea de verificare.';
  }

  @override
  String get reviewPipelineTitle => 'Flux de verificare';

  @override
  String get reviewPipelineSubtitle =>
      'Control uman al calității pentru traducerile AI';

  @override
  String get reviewSearchHint => 'Caută proiecte...';

  @override
  String get reviewResetPublished => 'Resetează publicate';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Rezultate: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'În așteptare: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Niciun proiect în așteptarea verificării.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Toate traducerile au fost deja verificate sau nu există niciuna în acest context lingvistic.';

  @override
  String get reviewNoSummary => 'Niciun rezumat.';

  @override
  String get reviewStartAudit => 'ÎNCEPE AUDITUL';

  @override
  String get reviewHtmlSourceShort => 'Sursă HTML';

  @override
  String get reviewCopySource => 'Copiază sursa';

  @override
  String get reviewModuleDetails => 'Detalii modul';

  @override
  String get reviewOriginalTitle => 'Titlu original';

  @override
  String get reviewDrupalOrgProject => 'Proiect Drupal.org';

  @override
  String get reviewSuggestions => 'Sugestii';

  @override
  String get reviewNoSuggestions => 'Nu există sugestii disponibile.';

  @override
  String get reviewApply => 'Aplică';

  @override
  String get reviewNoChanges => 'Nicio modificare';

  @override
  String get reviewOriginalBeforeCorrection =>
      'Original (înainte de corectare)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corectat (versiunea curentă)';

  @override
  String get reviewBaseOriginal => 'Bază (original)';

  @override
  String get reviewYourCorrection => 'Corectura ta';

  @override
  String get reviewChangesVisual => 'Verifică modificările tale (vizual)';

  @override
  String get commonSkip => 'Sari peste';

  @override
  String get commonIgnore => 'Ignoră';

  @override
  String get reviewEmptyProjectTitle => 'Proiect gol';

  @override
  String get reviewEmptyProjectBody =>
      'Acest proiect este gol (fără titlu, rezumat sau conținut) și nu poate fi aprobat. Te rugăm să-l sari.';

  @override
  String get reviewApprovedSuccess => 'Traducere aprobată! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Aprobarea pentru „$machine” a eșuat — te rugăm să reîncerci.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Ignorare anulată. Modulul este din nou activ!';

  @override
  String get reviewActionFailed => 'Acțiunea a eșuat.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignori modulul?';

  @override
  String get reviewIgnoreModuleBody =>
      'Acest modul va fi ascuns permanent din toate listele. Nu vei mai da peste el.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modulul a fost ignorat permanent.';

  @override
  String get reviewIgnoreFailed => 'Modulul nu a putut fi ignorat.';

  @override
  String get reviewSuggestionSaved => 'Ciornă de sugestie salvată! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Ciorna de sugestie nu a putut fi salvată.';

  @override
  String get reviewSuggestionDeleted => 'Sugestie ștearsă.';

  @override
  String get reviewDeleteFailed => 'Ștergerea a eșuat.';

  @override
  String get reviewSuggestionApplied => 'Sugestie aplicată.';

  @override
  String get reviewPreparingData => 'Se pregătesc datele pentru verificare...';

  @override
  String get reviewDirectEdit => 'Editare directă';

  @override
  String get reviewLivePreview => 'Previzualizare live';

  @override
  String get reviewCompareWith => 'Compară cu:';

  @override
  String get reviewProductionVersion => 'Versiunea de producție';

  @override
  String get reviewEditorialReview => 'Verificare editorială';

  @override
  String get reviewOpenQueue => 'Deschide coada de verificare';

  @override
  String get reviewCopyPromptShort => 'Copiază promptul';

  @override
  String get reviewUnignoreShort => 'Readu';

  @override
  String get reviewApproveButton => 'APROBĂ';

  @override
  String get reviewHideDetails => 'Ascunde detaliile';

  @override
  String get reviewDetailsAndEnglishSource => 'Detalii și sursă în engleză';

  @override
  String reviewPendingCountShort(int count) {
    return '$count în așteptare';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Se verifică $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Compară traducerea cu sursa în engleză';

  @override
  String get reviewTranslationLabel => 'Traducere';

  @override
  String get reviewComparisonTitle => 'Comparație';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copiază textul sursă + promptul de traducere în clipboard';

  @override
  String get reviewUnignoreCaps => 'READU';

  @override
  String get reviewIgnoreCaps => 'IGNORĂ';

  @override
  String get reviewSkipShortcut => 'SARI (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Verificare editorială';

  @override
  String get reviewUnignoreTablet => 'READU';

  @override
  String get reviewApproveForProduction =>
      'APROBĂ PENTRU PRODUCȚIE (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Ajustare directă';

  @override
  String get reviewTitleField => 'Titlu';

  @override
  String get reviewSummaryField => 'Rezumat';

  @override
  String get reviewBodyField => 'Conținut';

  @override
  String get reviewSaveShortcut => 'SALVEAZĂ (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Previzualizare live (randare)';

  @override
  String get reviewVoiceFemale => 'Feminin';

  @override
  String get reviewVoiceMale => 'Masculin';

  @override
  String get reviewStopListening => 'Oprește';

  @override
  String get reviewListen => 'Ascultă';

  @override
  String get reviewAutopTooltip =>
      'Formatare automată a paragrafelor (întreruperi de rând → <p>)';

  @override
  String get reviewSourceCodeShort => 'SURSĂ';

  @override
  String get reviewNoParagraphChange =>
      'Textul conține deja etichete <p> — nicio modificare';

  @override
  String get reviewParagraphsFormatted => 'Paragrafe formatate ¶';

  @override
  String get commonRetry => 'Reîncearcă';

  @override
  String categoriesLoadError(String error) {
    return 'Categoriile nu au putut fi încărcate: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categorii salvate cu succes.';

  @override
  String get categoriesSaveFailed => 'Traducerile nu au putut fi salvate.';

  @override
  String get categoriesFileEmpty => 'Fișierul este gol.';

  @override
  String get categoriesInvalidJson => 'Format JSON invalid.';

  @override
  String get categoriesNoValidUuids =>
      'Nu s-au găsit intrări UUID valide în fișier.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categorii importate din fișier.';
  }

  @override
  String get categoriesTitle => 'Categorii';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Se traduce pentru: $lang';
  }

  @override
  String get categoriesImportJson => 'Importă JSON';

  @override
  String get categoriesSaving => 'Se salvează...';

  @override
  String get categoriesSaveAll => 'Salvează tot';

  @override
  String get categoriesLoading => 'Se încarcă categoriile...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Traducere ($code)';
  }

  @override
  String get categoriesNoneFound => 'Nu s-au găsit categorii.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Tradu „$name”...';
  }

  @override
  String get loginPhotoBy => 'Fotografie de ';

  @override
  String get loginPhotoOn => ' pe ';

  @override
  String get loginPleaseSignIn => 'Te rugăm să te autentifici';

  @override
  String get loginUsername => 'Nume de utilizator';

  @override
  String get loginPassword => 'Parolă';

  @override
  String get loginRememberMe => 'Ține-mă minte';

  @override
  String get loginSignIn => 'AUTENTIFICARE';

  @override
  String get loginNoAccount => 'Nu ai încă un cont? ';

  @override
  String get loginRegisterNow => 'Înregistrează-te acum';

  @override
  String get commonBack => 'Înapoi';

  @override
  String get commonNext => 'Continuă';

  @override
  String get registerFillRequired =>
      'Te rugăm să completezi toate câmpurile obligatorii.';

  @override
  String get registerPasswordMismatch => 'Parolele nu coincid.';

  @override
  String get registerPasswordTooShort =>
      'Parola trebuie să aibă cel puțin 8 caractere.';

  @override
  String get registerSelectLanguage =>
      'Te rugăm să selectezi cel puțin o limbă.';

  @override
  String get registerFailed => 'Înregistrarea a eșuat.';

  @override
  String get registerHeaderTitle => 'ÎNREGISTRARE';

  @override
  String get registerStepAccount => 'Cont';

  @override
  String get registerStepRole => 'Rol';

  @override
  String get registerStepLanguages => 'Limbi';

  @override
  String get registerStepApiKeys => 'Chei API';

  @override
  String get registerYourAccount => 'Contul tău';

  @override
  String get registerAvatarOptional => 'Avatar (opțional)';

  @override
  String get registerUsernameRequired => 'Nume de utilizator *';

  @override
  String get registerEmailRequired => 'Adresă de e-mail *';

  @override
  String get registerPasswordRequired => 'Parolă *';

  @override
  String get registerPasswordRepeat => 'Repetă parola *';

  @override
  String get registerYourRole => 'Rolul tău';

  @override
  String get registerRoleExplanation =>
      'Traducătorii pot traduce texte, dar nu au acces la coada de verificare. Recenzorii verifică și aprobă conținutul tradus.';

  @override
  String get registerRoleTranslator => 'Traducător';

  @override
  String get registerRoleTranslatorDesc => 'Creează și editează traduceri.';

  @override
  String get registerRoleReviewer => 'Recenzor';

  @override
  String get registerRoleReviewerDesc => 'Verifică și aprobă traducerile.';

  @override
  String get registerTargetLanguages => 'Limbi țintă';

  @override
  String get registerLanguagesExplanation =>
      'Alege toate limbile la care vrei să lucrezi.';

  @override
  String get registerNoLanguagesAvailable => 'Nu există limbi disponibile.';

  @override
  String get registerApiKeysTitle => 'Chei API';

  @override
  String get registerApiKeysExplanation =>
      'Introdu propriile chei API. Fiecare utilizator folosește exclusiv propriile chei. Le poți adăuga și mai târziu în profilul tău.';

  @override
  String get registerKeysEncryptedNote =>
      'Cheile sunt stocate criptat și nu sunt niciodată partajate cu alți utilizatori.';

  @override
  String get registerOptionalSuffix => ' (opțional)';

  @override
  String get registerSuccessTitle => 'Înregistrare reușită!';

  @override
  String get registerSuccessBody =>
      'Contul tău a fost creat și așteaptă aprobarea unui administrator. Vei fi notificat de îndată ce accesul tău a fost activat.';

  @override
  String get registerGoToLogin => 'Mergi la autentificare';

  @override
  String get registerSubmit => 'Înregistrează-te';

  @override
  String registerPhotoCredit(String name) {
    return 'Fotografie de $name pe Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil actualizat cu succes!';

  @override
  String get profileUpdateFailed => 'Actualizarea a eșuat.';

  @override
  String profileSaveError(String error) {
    return 'Eroare la salvare: $error';
  }

  @override
  String get profilePasswordMismatch => 'Parolele nu coincid!';

  @override
  String get profilePasswordChangeSuccess =>
      'Parola a fost schimbată cu succes!';

  @override
  String get profilePasswordChangeError =>
      'Eroare la schimbarea parolei: parola curentă este incorectă.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar încărcat cu succes!';

  @override
  String get profileAvatarUploadError => 'Eroare la încărcarea avatarului.';

  @override
  String get profileTitle => 'Profil și setări';

  @override
  String get profileSubtitle =>
      'Gestionează-ți profilul de utilizator, cheile API pentru traducere (Gemini și DeepL) și securitatea contului.';

  @override
  String get profileRoleUser => 'Utilizator';

  @override
  String get profileNoEmail => 'Nu a fost furnizată nicio adresă de e-mail';

  @override
  String get profileTabDetails => 'Detalii profil';

  @override
  String get profileTabGemini => 'Traducere AI (Gemini)';

  @override
  String get profileTabDeepl => 'Traducere DeepL';

  @override
  String get profileTabPassword => 'Schimbă parola';

  @override
  String get profileSectionInfo => 'INFORMAȚII PROFIL';

  @override
  String get profileFieldName => 'Nume';

  @override
  String get profileFieldNameHint => 'Numele tău complet';

  @override
  String get profileFieldEmail => 'Adresă de e-mail';

  @override
  String get profileFieldEmailHint => 'Adresa ta de e-mail';

  @override
  String get profileSectionGemini => 'SETĂRI GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Cheie API Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Introdu cheia ta API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Prompt AI personalizat';

  @override
  String get profileFieldAiPromptHint =>
      'Opțional: personalizează promptul de sistem pentru Gemini...';

  @override
  String get profileSectionDeepl => 'SETĂRI TRADUCERE DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL oferă traducere automată de înaltă calitate cu păstrarea etichetelor HTML. Conturile gratuite (500.000 de caractere/lună) primesc o cheie cu sufixul „:fx”.';

  @override
  String get profileFieldDeeplKey => 'Cheie API DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'ex. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Cheile gratuite se termină în „:fx” și folosesc api-free.deepl.com. Cheile Pro folosesc api.deepl.com. Distincția se face automat.';

  @override
  String get profileSectionSecurity => 'SECURITATEA CONTULUI';

  @override
  String get profileFieldCurrentPassword => 'Parola curentă';

  @override
  String get profileFieldCurrentPasswordHint => 'Introdu parola ta curentă';

  @override
  String get profileFieldNewPassword => 'Parolă nouă';

  @override
  String get profileFieldNewPasswordHint => 'Cel puțin 6 caractere';

  @override
  String get profileFieldConfirmPassword => 'Confirmă parola nouă';

  @override
  String get profileFieldConfirmPasswordHint => 'Repetă parola';

  @override
  String get profileChangePasswordButton => 'Schimbă parola';

  @override
  String get commonDelete => 'Șterge';

  @override
  String get settingsRegistrationUpdated =>
      'Setarea de înregistrare a fost actualizată';

  @override
  String get settingsUpdateFailed => 'Actualizarea a eșuat.';

  @override
  String get settingsUserApproved => 'Utilizator aprobat!';

  @override
  String get settingsAccountDeactivated => 'Cont dezactivat.';

  @override
  String get settingsUserDeleted => 'Utilizator șters.';

  @override
  String get settingsActionFailed => 'Acțiunea a eșuat.';

  @override
  String get settingsDeleteAccountTitle => 'Ștergi contul?';

  @override
  String get settingsDeactivateAccountTitle => 'Dezactivezi contul?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Contul „$username” va fi șters definitiv. Continui?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Contul „$username” va fi blocat. Utilizatorul nu se mai poate autentifica, dar contul este păstrat.';
  }

  @override
  String get settingsDeactivate => 'Dezactivează';

  @override
  String settingsSyncSuccess(String count) {
    return '$count traduceri sincronizate!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Eroare de sincronizare: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count module prioritare sincronizate!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Eroare la sincronizarea listei prioritare: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup reușit: $count fișiere procesate.';
  }

  @override
  String get settingsUploadFailed => 'Încărcarea a eșuat.';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get settingsSystemConfig => 'CONFIGURAȚIE SISTEM';

  @override
  String get settingsRegistration => 'Înregistrare';

  @override
  String get settingsRegistrationHint =>
      'Comută vizibilitatea formularului global de înregistrare.';

  @override
  String get settingsPendingUsers => 'Utilizatori în așteptare';

  @override
  String get settingsNoNewRequests => 'Nicio cerere nouă.';

  @override
  String get settingsWantsReviewer => 'Dorește să fie recenzor';

  @override
  String get settingsAssignRole => 'Atribuie rol';

  @override
  String get settingsRoleTranslator => 'Traducător';

  @override
  String get settingsRoleReviewer => 'Recenzor';

  @override
  String get settingsApprove => 'Aprobă';

  @override
  String get settingsReject => 'Respinge';

  @override
  String get settingsActiveUsers => 'Utilizatori activi';

  @override
  String get settingsNoActiveUsers => 'Niciun utilizator activ.';

  @override
  String get settingsDeactivateAccountTooltip => 'Dezactivează';

  @override
  String get settingsDeleteAccountAction => 'Șterge contul';

  @override
  String get settingsAppearance => 'Aspect';

  @override
  String get settingsThemePearl => 'DESCHIS (PEARL)';

  @override
  String get settingsThemeDark => 'ÎNTUNECAT';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Tipografie';

  @override
  String get settingsFontHint => 'Modifică familia de fonturi a interfeței.';

  @override
  String get settingsFontClean => 'Clean';

  @override
  String get settingsFontFuturistic => 'Futurist';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Flux de lucru și distracție';

  @override
  String get settingsConfettiTitle => 'Sărbătorirea succesului (confetti)';

  @override
  String get settingsConfettiHint =>
      'Afișează o mică animație la salvarea cu succes.';

  @override
  String get settingsLargeUiTitle => 'Lizibilitate îmbunătățită (font mare)';

  @override
  String get settingsLargeUiHint =>
      'Mărește dimensiunea fonturilor și a insignelor pentru o lizibilitate mai bună.';

  @override
  String get settingsAutoPTitle =>
      'Formatare automată a paragrafelor (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Încadrează automat textul simplu în paragrafe <p> atunci când un modul este încărcat în ecranul de verificare. Echivalent cu apăsarea manuală a butonului ¶.';

  @override
  String get settingsDatabaseSync => 'Sincronizare bază de date';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sincronizează intrările din baza de date cu fișierele JSON de traducere.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sincronizează intrările interne din baza de date cu fișierele JSON de traducere de pe server.';

  @override
  String get settingsSyncing => 'Se sincronizează...';

  @override
  String get settingsSyncNow => 'Sincronizează acum';

  @override
  String get settingsSyncD11List => 'Sincronizează lista D11';

  @override
  String get settingsUploadBackup => 'Încarcă backup (.zip)';

  @override
  String get settingsSelectZipFile => 'Selectează fișierul ZIP';

  @override
  String get settingsUploading => 'Se încarcă...';

  @override
  String get settingsErrorDiagnostics =>
      'Diagnosticare erori și jurnale de sistem';

  @override
  String get settingsLogsCopied => 'Jurnale copiate în clipboard! 📋';

  @override
  String get settingsCopyLogs => 'Copiază jurnalele';

  @override
  String get settingsLogsRotated => 'Jurnale arhivate și rotite! 📁';

  @override
  String get settingsRotate => 'Rotește';

  @override
  String get settingsClear => 'Golește';

  @override
  String get settingsLogLimit => 'Limită jurnale: ';

  @override
  String get settingsNoLogs => 'Niciun jurnal înregistrat';

  @override
  String get layoutMenu => 'Meniu';

  @override
  String get layoutNavAnalytics => 'Analiză';

  @override
  String get layoutNavReviewQueue => 'Coadă de verificare';

  @override
  String get layoutNavGlossary => 'Glosar';

  @override
  String get layoutNavCategories => 'Categorii';

  @override
  String get layoutNavHelp => 'Ajutor';

  @override
  String get layoutNavSettings => 'Setări';

  @override
  String get layoutPhotoBy => 'Fotografie de ';

  @override
  String get layoutPhotoOn => ' pe ';

  @override
  String get layoutEditProfile => 'Editează profilul';

  @override
  String get layoutLogout => 'Deconectare';

  @override
  String get layoutThemeLabel => 'TEMĂ';

  @override
  String get layoutThemePearl => 'Deschis';

  @override
  String get layoutThemeDark => 'Întunecat';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'LIMBĂ ȚINTĂ';

  @override
  String get layoutDeeplUsage => 'UTILIZARE DEEPL';

  @override
  String get layoutUnavailable => 'Indisponibil';

  @override
  String get layoutUnlimited => 'nelimitat';

  @override
  String get layoutUsed => 'utilizat';

  @override
  String get layoutTranslate => 'Tradu';

  @override
  String get analyticsSubtitle =>
      'Compatibilitate, restanțe de traducere și tendințe săptămânale.';

  @override
  String get analyticsBacklog => 'Restanțe de traducere';

  @override
  String get analyticsMissing => 'Lipsă';

  @override
  String get analyticsStale => 'Perimate';

  @override
  String get analyticsInReview => 'În verificare';

  @override
  String get analyticsReleased => 'Publicate';

  @override
  String get analyticsTranslated => 'Traduse';

  @override
  String get analyticsTotalModules => 'Total module';

  @override
  String get analyticsCompatByVersion =>
      'Compatibilitate după versiunea Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Limbă: $lang · publicate / în verificare / lipsă';
  }

  @override
  String get analyticsLoadingCounts => 'Se încarcă numărătorile …';

  @override
  String get analyticsWindow => 'Interval:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks săptămâni';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Descrieri noi de proiecte pe săptămână';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marcate ca perimate pe săptămână ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count module';
  }

  @override
  String get analyticsReviewShort => 'Verificare';

  @override
  String get analyticsNoDataInWindow => 'Nu există date în acest interval.';

  @override
  String get analyticsAndMore => '… și altele';

  @override
  String glossaryLoadError(String error) {
    return 'Eroare la încărcare: $error';
  }

  @override
  String get glossaryNewTerm => 'Creează termen nou';

  @override
  String get glossaryEditTerm => 'Editează termenul';

  @override
  String get glossaryFieldSourceWord =>
      'Cuvânt sursă (forma de bază, așa cum apare în text)';

  @override
  String get glossaryFieldSourceWordHint => 'ex. node';

  @override
  String get glossaryWordForms =>
      'Forme suplimentare ale cuvântului (plural, genitiv, dativ …)';

  @override
  String get glossaryWordFormsHint =>
      'ex. content — apasă Enter pentru a adăuga';

  @override
  String get glossaryAddForm => 'Adaugă formă';

  @override
  String get glossaryFieldPreferredWord => 'Traducere preferată';

  @override
  String get glossaryFieldPreferredWordHint => 'ex. content';

  @override
  String get glossaryFieldExplanation => 'Explicație (afișată în tooltip)';

  @override
  String get glossaryFieldExplanationHint =>
      'De ce ar trebui tradus altfel acest cuvânt?';

  @override
  String get glossaryCreate => 'Creează';

  @override
  String get glossaryRequiredFields =>
      'Cuvântul sursă și traducerea preferată sunt obligatorii.';

  @override
  String get glossaryCreated => 'Termen creat ✓';

  @override
  String get glossaryUpdated => 'Termen actualizat ✓';

  @override
  String glossaryError(String error) {
    return 'Eroare: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Ștergi termenul?';

  @override
  String glossaryDeleteBody(String word) {
    return '„$word” va fi eliminat definitiv din glosar.';
  }

  @override
  String get glossaryDeleted => 'Termen șters.';

  @override
  String get glossaryTitle => 'Glosar de traducere';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Limbă: $lang · $count intrări';
  }

  @override
  String get glossaryNewShort => 'Nou';

  @override
  String get glossaryCreateTerm => 'Creează termen';

  @override
  String get glossaryInfoBanner =>
      'Cuvintele din acest glosar sunt evidențiate în editorul de verificare. Un tooltip explică la trecerea cursorului de ce se potrivește mai bine o altă traducere.';

  @override
  String get glossaryNoEntries => 'Încă nu există intrări.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Apasă pe „Creează termen” pentru a crea prima intrare.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Încă nu există intrări în glosar pentru această limbă.';

  @override
  String get diffNoChanges => 'Nu s-au detectat diferențe de conținut.';

  @override
  String get diffRemoved => 'Eliminat';

  @override
  String get diffAdded => 'Adăugat';

  @override
  String syncBarQuickSync(String count) {
    return 'Sincronizare rapidă: $count module modificate …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sincronizare completă: $current / $total module';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sincronizare completă: $count module …';
  }
}
