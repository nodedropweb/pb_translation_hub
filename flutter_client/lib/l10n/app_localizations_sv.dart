// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Läser in projektdetaljer...';

  @override
  String editorLoadError(String error) {
    return 'Det gick inte att läsa in projektdata: $error';
  }

  @override
  String get editorGeminiSuccess => 'Översättning med Gemini lyckades! ✨';

  @override
  String get editorUnknownError => 'Okänt fel';

  @override
  String editorGeminiFailed(String detail) {
    return 'Översättning med Gemini misslyckades: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Lägg till din Google AI-nyckel i din användarprofil (inte i administratörsinställningarna).';

  @override
  String get editorGeminiError =>
      'Ett fel uppstod vid översättning med Gemini. Kontrollera din Google AI-nyckel i din profil.';

  @override
  String get editorDeeplSuccess => 'Översättning med DeepL lyckades! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Översättning med DeepL misslyckades: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Ett fel uppstod vid översättning med DeepL. Kontrollera att din DeepL API-nyckel är angiven i din profil.';

  @override
  String get editorDeeplInvalidKey =>
      'Ogiltig DeepL API-nyckel. Kontrollera den i din profil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL-kvoten är förbrukad. Kontrollera din plan.';

  @override
  String get editorReviewReset =>
      'Översättningen har återställts till granskningsstatus.';

  @override
  String editorResetError(String error) {
    return 'Det gick inte att återställa: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Modulen har återförts till den aktiva listan.';

  @override
  String get editorUnignoreError => 'Det gick inte att sluta ignorera modulen.';

  @override
  String get editorSaveSuccess =>
      'Översättningen sparad — tillbaka till granskningskön.';

  @override
  String editorSaveError(String error) {
    return 'Det gick inte att spara: $error';
  }

  @override
  String get editorNoMoreProjects => 'Inga fler öppna projekt i listan.';

  @override
  String get editorChangesDiscarded =>
      'Ändringarna förkastades, läser in nästa projekt...';

  @override
  String get editorEnglishSourceApplied =>
      'Engelska originalet har tillämpats — översätt det nu.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Det gick inte att öppna webbadressen: $url';
  }

  @override
  String get commonSave => 'Spara';

  @override
  String get commonClose => 'Stäng';

  @override
  String get editorCloseEnglishSource => 'Stäng engelsk källtext';

  @override
  String get editorShowEnglishSource => 'Visa engelsk källtext';

  @override
  String get editorUnignoreShortTooltip => 'Sluta ignorera modul';

  @override
  String get editorBackToReviewTooltip => 'Sätt tillbaka till granskning';

  @override
  String get editorAndNext => 'och nästa';

  @override
  String get editorBackToDashboard => 'Tillbaka till översikten';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Översätter till $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count kvar';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Återför modulen till den aktiva listan';

  @override
  String get editorUnignoreLabel => 'Sluta ignorera';

  @override
  String get editorUnpublishTooltip =>
      'Återkalla publiceringen och sätt tillbaka till granskning';

  @override
  String get editorBackToReview => 'Tillbaka till granskning';

  @override
  String get editorSaveAndNext => 'Spara och nästa';

  @override
  String get editorEnglishSourceHeader => 'ENGELSK KÄLLTEXT';

  @override
  String get editorStaleTooltip => 'Visa förklaring och tillämpa engelsk text';

  @override
  String get editorStaleDetailsLabel => 'Föråldrad — Detaljer';

  @override
  String get editorCopyPromptTooltip =>
      'Kopiera källtext + översättningsprompt';

  @override
  String get editorPromptCopied => 'Prompten har kopierats till urklipp 📋';

  @override
  String get editorShowPreview => 'Visa förhandsgranskning';

  @override
  String get editorShowHtmlSource => 'Visa HTML-källkod';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'SAMMANFATTNING:\n$summary\n\nINNEHÅLL:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Sammanfattning:';

  @override
  String get editorDescriptionLabelColon => 'Beskrivning:';

  @override
  String get editorStaleDialogTitle => 'Den engelska källtexten har ändrats';

  @override
  String get editorStaleExplanation =>
      'Den befintliga översättningen bygger på en föråldrad engelsk originaltext. Sedan den senaste översättningen har modulens underhållare ändrat den engelska texten på Drupal.org — innehållet i den befintliga översättningen kan därför inte längre vara korrekt eller fullständigt.';

  @override
  String get editorStaleTip =>
      'Tips: klicka på \"Använd engelskt original\" för att läsa in den aktuella engelska källtexten direkt i redigeraren. Du kan sedan använda den som utgångspunkt för en ny översättning. Det engelska originalet visas också i panelen till vänster.';

  @override
  String get editorEnglishSourceShort => 'Engelsk källtext';

  @override
  String get editorPreviousTranslation => 'Tidigare översättning';

  @override
  String get editorWhatChangedTitle => 'Vad har ändrats?';

  @override
  String get editorShowDiff => 'Visa skillnader';

  @override
  String get editorUseEnglish => 'Använd engelskt original';

  @override
  String get editorStaleBannerText =>
      'Den engelska källtexten har ändrats — översättningen är föråldrad';

  @override
  String get editorDetailsAndApply => 'Detaljer och tillämpa';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'ÖVERSÄTTNING TILL $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Översätter...';

  @override
  String get editorShowEditor => 'Visa redigerare';

  @override
  String get editorModuleTitleLabel => 'Modultitel (engelska)';

  @override
  String get editorSummaryFieldLabel => 'Sammanfattning';

  @override
  String get editorBodyFieldLabel => 'Innehåll';

  @override
  String get editorHtmlCleaned => 'HTML har städats upp';

  @override
  String get editorLivePreviewHeader => 'LIVEFÖRHANDSGRANSKNING';

  @override
  String get editorTidyHtmlTooltip =>
      'Städa upp HTML (ta bort DeepL-artefakter)';

  @override
  String get editorVisualMode => 'VISUELL';

  @override
  String get editorSourceCodeMode => 'KÄLLKOD (HTML)';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get costDialogTitle => 'Kostnadsuppskattning (AI)';

  @override
  String get costDialogIntro =>
      'Den valda modulen kommer att översättas med Google Gemini AI. Här är den uppskattade kostnadsfördelningen för den här åtgärden:';

  @override
  String get costRowModel => 'Modell';

  @override
  String get costRowInputTokens => 'Indatatoken';

  @override
  String get costRowOutputTokens => 'Utdatatoken (uppskattning)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars tecken)';
  }

  @override
  String get costRowPriceInput => 'Pris per 1M indata';

  @override
  String get costRowPriceOutput => 'Pris per 1M utdata';

  @override
  String get costRowTotalEstimate => 'Uppskattad totalkostnad';

  @override
  String get costDialogFootnote =>
      '* Obs: detta är en uppskattning baserad på Googles nuvarande betala-per-användning-prismodell. Den faktiska användningen kan variera något.';

  @override
  String get costDialogStartTranslation => 'Starta översättning';

  @override
  String get htmlToolbarInsertLink => 'Infoga länk';

  @override
  String get htmlToolbarLinkTooltip => 'Infoga länk (a)';

  @override
  String get htmlToolbarInsert => 'Infoga';

  @override
  String get htmlToolbarHeading2 => 'Rubrik 2';

  @override
  String get htmlToolbarHeading3 => 'Rubrik 3';

  @override
  String get htmlToolbarBold => 'Fetstil (strong)';

  @override
  String get htmlToolbarItalic => 'Kursiv (em)';

  @override
  String get htmlToolbarBulletList => 'Punktlista (ul)';

  @override
  String get htmlToolbarNumberedList => 'Numrerad lista (ol)';

  @override
  String get htmlToolbarQuote => 'Citat (blockquote)';

  @override
  String get screenshotAltsHeader => 'ALT-TEXT FÖR SKÄRMDUMPAR';

  @override
  String get screenshotAltsIntro =>
      'Ange en beskrivande alt-text på målspråket för varje skärmdump.';

  @override
  String screenshotLabel(int number) {
    return 'Skärmdump $number';
  }

  @override
  String get screenshotPreviewUnavailable =>
      'Förhandsgranskning ej tillgänglig';

  @override
  String get screenshotAltHint => 'Ange alt-text på målspråket…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Sluta ignorera alla moduler?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Alla ignorerade moduler återförs till den aktiva listan och blir tillgängliga för översättning igen.';

  @override
  String get dashUnignoreAllConfirmAction => 'Sluta ignorera alla';

  @override
  String get dashUnignoreAllSuccess =>
      'Alla ignorerade moduler har slutat ignoreras.';

  @override
  String get dashUnignoreAllError =>
      'Det gick inte att sluta ignorera modulerna.';

  @override
  String get dashUnignoreAllButton => 'Sluta ignorera alla moduler';

  @override
  String dashSyncStartError(String error) {
    return 'Det gick inte att starta synkroniseringen: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'Snabbuppdatering (7 dagar) har startats ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Fel vid snabbuppdatering: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Synkroniserades: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modulen hittades inte på Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'AI-massöversättning';

  @override
  String get dashHeaderTitle => 'Projektbeskrivningar';

  @override
  String get dashHeaderSubtitle =>
      'Översätt beskrivningar av Drupal-moduler till målspråket. Hjälp till att göra ekosystemet mer tillgängligt.';

  @override
  String get dashHeaderSubtitleShort =>
      'Översätt beskrivningar av Drupal-moduler.';

  @override
  String get dashLastLabel => 'Senast: ';

  @override
  String get dashContinue => 'Fortsätt';

  @override
  String get dashContinueShort => 'Fortsätt';

  @override
  String get dashUnignoreAllButtonLong => 'Sluta ignorera alla moduler';

  @override
  String get dashQuickUpdateTooltip => 'Snabbuppdatering (senaste 7 dagarna)';

  @override
  String get dashFullSyncTooltip =>
      'Fullständig databassynkronisering från Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Läs in en enskild modul manuellt från Drupal.org';

  @override
  String get dashQuickShort => 'Snabb';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Hittade: ';

  @override
  String get dashModulesSuffix => ' moduler';

  @override
  String dashPerPage(int count) {
    return '$count per sida';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / sida';
  }

  @override
  String get dashFirstPage => 'Första sidan';

  @override
  String get dashPrevPage => 'Föregående sida';

  @override
  String get dashNextPage => 'Nästa sida';

  @override
  String get dashLastPage => 'Sista sidan';

  @override
  String dashPageOf(int page, int total) {
    return 'Sida $page av $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (t.ex. pathauto)';

  @override
  String get dashAddButton => 'Lägg till';

  @override
  String get dashAddModuleManually => 'Lägg till modul manuellt';

  @override
  String get dashAddModuleSubtitle =>
      'Läs in direkt från Drupal.org via maskinnamn.';

  @override
  String get dashAddModuleShort => 'Lägg till modul';

  @override
  String get dashNoProjectsFound => 'Inga projekt hittades.';

  @override
  String get dashFilterAll => 'Alla projekt';

  @override
  String get dashFilterMissing => 'Saknade översättningar';

  @override
  String get dashFilterReview => 'Granskningskö';

  @override
  String get dashFilterTranslated => 'Översatta projekt';

  @override
  String get dashFilterReleased => 'Publicerade projekt';

  @override
  String get dashBulkDialogIntro =>
      'Översätt automatiskt flera moduler från det valda filtret med hjälp av Google Gemini.';

  @override
  String get dashActiveFilter => 'Aktivt filter';

  @override
  String get dashModuleCount => 'Antal moduler';

  @override
  String dashModulesCountItem(int count) {
    return '$count moduler';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioritera Drupal 12-moduler';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Översätter moduler utan stöd för Drupal 12 först';

  @override
  String get dashTotalModules => 'Totalt antal moduler';

  @override
  String get dashInputTokensEst => 'Indatatoken (uppsk.)';

  @override
  String get dashOutputTokensEst => 'Utdatatoken (uppsk.)';

  @override
  String get dashBulkFootnote =>
      '* Översättningen utförs i resurseffektiva satser för att förhindra tidsgränsöverskridanden.';

  @override
  String get dashStartBulkTranslation => 'Starta massöversättning';

  @override
  String dashStaleLoadError(String error) {
    return 'Fel vid inläsning av föråldrade moduler: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Inga föråldrade moduler hittades — allt är uppdaterat! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Översätt föråldrade moduler på nytt';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Alla översättningar vars engelska källtext har ändrats sedan den senaste översättningen kommer automatiskt att översättas på nytt med Google Gemini. Ingen anledning att öppna varje modul manuellt.';

  @override
  String get dashOutdatedModules => 'Föråldrade moduler';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Översättningen ersätter befintlig text och återställer is_reviewed. Utförs i satser om 4 moduler.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Översätt alla $count moduler på nytt';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Översätter föråldrade moduler på nytt…';

  @override
  String get dashFetchingProjects => 'Hämtar projekt från servern…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed av $total moduler bearbetade';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Inga översättningsbara projekt hittades för det här filtret.';

  @override
  String get dashStartingTranslation => 'Startar översättning…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Översätter modul $start–$end av $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end av $total moduler slutförda.';
  }

  @override
  String get dashTranslationCompleted => 'Översättningen slutfördes! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Massöversättning av $count moduler lyckades! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Fel vid massöversättning: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Alla $count moduler har översatts på nytt! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count föråldrade moduler har översatts på nytt! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Fel vid ny översättning: $error';
  }

  @override
  String get filterAllShort => 'Alla';

  @override
  String get filterMissing => 'Saknas';

  @override
  String get filterTranslated => 'Översatta';

  @override
  String get filterReviewQueue => 'Granskningskö';

  @override
  String get filterReleased => 'Publicerade';

  @override
  String get filterOutdated => 'Föråldrade';

  @override
  String get filterPriority => 'Prioritet';

  @override
  String get filterIgnored => 'Ignorerade';

  @override
  String get commonEdit => 'Redigera';

  @override
  String get commonReset => 'Återställ';

  @override
  String get commonRefresh => 'Uppdatera';

  @override
  String commonErrorPrefix(String error) {
    return 'Fel: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Återställa alla publicerade översättningar?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Alla översättningar markerade som publicerade för $langcode återställs till granskningsstatus. Detta kan inte ångras.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count översättningar återställda till granskningsstatus.';
  }

  @override
  String get reviewPipelineTitle => 'Granskningsflöde';

  @override
  String get reviewPipelineSubtitle =>
      'Mänskligt kvalitetssäkringsflöde för AI-översättningar';

  @override
  String get reviewSearchHint => 'Sök projekt...';

  @override
  String get reviewResetPublished => 'Återställ publicerade';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultat: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Väntande: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Inga projekt väntar på granskning.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Alla översättningar har redan verifierats, eller så finns det inga i det här språksammanhanget.';

  @override
  String get reviewNoSummary => 'Ingen sammanfattning.';

  @override
  String get reviewStartAudit => 'STARTA GRANSKNING';

  @override
  String get reviewHtmlSourceShort => 'HTML-källkod';

  @override
  String get reviewCopySource => 'Kopiera källtext';

  @override
  String get reviewModuleDetails => 'Moduldetaljer';

  @override
  String get reviewOriginalTitle => 'Originaltitel';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org-projekt';

  @override
  String get reviewSuggestions => 'Förslag';

  @override
  String get reviewNoSuggestions => 'Inga förslag tillgängliga.';

  @override
  String get reviewApply => 'Tillämpa';

  @override
  String get reviewNoChanges => 'Inga ändringar';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (före korrigering)';

  @override
  String get reviewCorrectedCurrentVersion => 'Korrigerad (aktuell version)';

  @override
  String get reviewBaseOriginal => 'Bas (original)';

  @override
  String get reviewYourCorrection => 'Din korrigering';

  @override
  String get reviewChangesVisual => 'Granska dina ändringar (visuellt)';

  @override
  String get commonSkip => 'Hoppa över';

  @override
  String get commonIgnore => 'Ignorera';

  @override
  String get reviewEmptyProjectTitle => 'Tomt projekt';

  @override
  String get reviewEmptyProjectBody =>
      'Det här projektet är tomt (ingen titel, sammanfattning eller innehåll) och kan inte godkännas. Hoppa över det.';

  @override
  String get reviewApprovedSuccess => 'Översättningen godkändes! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Godkännande av \"$machine\" misslyckades — försök igen.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Slutade ignorera. Modulen är aktiv igen!';

  @override
  String get reviewActionFailed => 'Åtgärden misslyckades.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorera modul?';

  @override
  String get reviewIgnoreModuleBody =>
      'Den här modulen kommer att döljas permanent från alla listor. Du kommer inte längre att fastna på den.';

  @override
  String get reviewModulePermanentlyIgnored => 'Modulen ignoreras permanent.';

  @override
  String get reviewIgnoreFailed => 'Det gick inte att ignorera modulen.';

  @override
  String get reviewSuggestionSaved => 'Förslagsutkastet har sparats! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Det gick inte att spara förslagsutkastet.';

  @override
  String get reviewSuggestionDeleted => 'Förslaget har tagits bort.';

  @override
  String get reviewDeleteFailed => 'Det gick inte att ta bort.';

  @override
  String get reviewSuggestionApplied => 'Förslaget har tillämpats.';

  @override
  String get reviewPreparingData => 'Förbereder granskningsdata...';

  @override
  String get reviewDirectEdit => 'Direktredigering';

  @override
  String get reviewLivePreview => 'Liveförhandsgranskning';

  @override
  String get reviewCompareWith => 'Jämför med:';

  @override
  String get reviewProductionVersion => 'Produktionsversion';

  @override
  String get reviewEditorialReview => 'Redaktionell granskning';

  @override
  String get reviewOpenQueue => 'Öppna granskningskön';

  @override
  String get reviewCopyPromptShort => 'Kopiera prompt';

  @override
  String get reviewUnignoreShort => 'Sluta ignorera';

  @override
  String get reviewApproveButton => 'GODKÄNN';

  @override
  String get reviewHideDetails => 'Dölj detaljer';

  @override
  String get reviewDetailsAndEnglishSource => 'Detaljer och engelsk källtext';

  @override
  String reviewPendingCountShort(int count) {
    return '$count väntande';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Granskar $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Jämför översättningen med engelsk källtext';

  @override
  String get reviewTranslationLabel => 'Översättning';

  @override
  String get reviewComparisonTitle => 'Jämförelse';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Kopiera källtext + översättningsprompt till urklipp';

  @override
  String get reviewUnignoreCaps => 'SLUTA IGNORERA';

  @override
  String get reviewIgnoreCaps => 'IGNORERA';

  @override
  String get reviewSkipShortcut => 'HOPPA ÖVER (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Redaktionell granskning';

  @override
  String get reviewUnignoreTablet => 'SLUTA IGNORERA';

  @override
  String get reviewApproveForProduction =>
      'GODKÄNN FÖR PRODUKTION (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Direkt finjustering';

  @override
  String get reviewTitleField => 'Titel';

  @override
  String get reviewSummaryField => 'Sammanfattning';

  @override
  String get reviewBodyField => 'Innehåll';

  @override
  String get reviewSaveShortcut => 'SPARA (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Liveförhandsgranskning (renderar)';

  @override
  String get reviewVoiceFemale => 'Kvinnlig';

  @override
  String get reviewVoiceMale => 'Manlig';

  @override
  String get reviewStopListening => 'Stoppa';

  @override
  String get reviewListen => 'Lyssna';

  @override
  String get reviewAutopTooltip =>
      'Formatera stycken automatiskt (radbrytningar → <p>)';

  @override
  String get reviewSourceCodeShort => 'KÄLLKOD';

  @override
  String get reviewNoParagraphChange =>
      'Texten innehåller redan <p>-taggar — ingen ändring';

  @override
  String get reviewParagraphsFormatted => 'Styckena har formaterats ¶';

  @override
  String get commonRetry => 'Försök igen';

  @override
  String categoriesLoadError(String error) {
    return 'Det gick inte att läsa in kategorier: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategorierna har sparats.';

  @override
  String get categoriesSaveFailed =>
      'Det gick inte att spara översättningarna.';

  @override
  String get categoriesFileEmpty => 'Filen är tom.';

  @override
  String get categoriesInvalidJson => 'Ogiltigt JSON-format.';

  @override
  String get categoriesNoValidUuids =>
      'Inga giltiga UUID-poster hittades i filen.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count kategorier importerade från filen.';
  }

  @override
  String get categoriesTitle => 'Kategorier';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Översätter för: $lang';
  }

  @override
  String get categoriesImportJson => 'Importera JSON';

  @override
  String get categoriesSaving => 'Sparar...';

  @override
  String get categoriesSaveAll => 'Spara allt';

  @override
  String get categoriesLoading => 'Läser in kategorier...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Översättning ($code)';
  }

  @override
  String get categoriesNoneFound => 'Inga kategorier hittades.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Översätt \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto av ';

  @override
  String get loginPhotoOn => ' på ';

  @override
  String get loginPleaseSignIn => 'Logga in';

  @override
  String get loginUsername => 'Användarnamn';

  @override
  String get loginPassword => 'Lösenord';

  @override
  String get loginRememberMe => 'Kom ihåg mig';

  @override
  String get loginSignIn => 'LOGGA IN';

  @override
  String get loginNoAccount => 'Har du inget konto än? ';

  @override
  String get loginRegisterNow => 'Registrera dig nu';

  @override
  String get commonBack => 'Tillbaka';

  @override
  String get commonNext => 'Nästa';

  @override
  String get registerFillRequired => 'Fyll i alla obligatoriska fält.';

  @override
  String get registerPasswordMismatch => 'Lösenorden matchar inte.';

  @override
  String get registerPasswordTooShort =>
      'Lösenordet måste vara minst 8 tecken.';

  @override
  String get registerSelectLanguage => 'Välj minst ett språk.';

  @override
  String get registerFailed => 'Registreringen misslyckades.';

  @override
  String get registerHeaderTitle => 'REGISTRERING';

  @override
  String get registerStepAccount => 'Konto';

  @override
  String get registerStepRole => 'Roll';

  @override
  String get registerStepLanguages => 'Språk';

  @override
  String get registerStepApiKeys => 'API-nycklar';

  @override
  String get registerYourAccount => 'Ditt konto';

  @override
  String get registerAvatarOptional => 'Profilbild (valfritt)';

  @override
  String get registerUsernameRequired => 'Användarnamn *';

  @override
  String get registerEmailRequired => 'E-postadress *';

  @override
  String get registerPasswordRequired => 'Lösenord *';

  @override
  String get registerPasswordRepeat => 'Upprepa lösenord *';

  @override
  String get registerYourRole => 'Din roll';

  @override
  String get registerRoleExplanation =>
      'Översättare kan översätta texter men har ingen åtkomst till granskningskön. Granskare kontrollerar och godkänner översatt innehåll.';

  @override
  String get registerRoleTranslator => 'Översättare';

  @override
  String get registerRoleTranslatorDesc => 'Skapa och redigera översättningar.';

  @override
  String get registerRoleReviewer => 'Granskare';

  @override
  String get registerRoleReviewerDesc => 'Granska och godkänn översättningar.';

  @override
  String get registerTargetLanguages => 'Målspråk';

  @override
  String get registerLanguagesExplanation =>
      'Välj alla språk du vill arbeta med.';

  @override
  String get registerNoLanguagesAvailable => 'Inga språk tillgängliga.';

  @override
  String get registerApiKeysTitle => 'API-nycklar';

  @override
  String get registerApiKeysExplanation =>
      'Ange dina egna API-nycklar. Varje användare använder uteslutande sina egna nycklar. Du kan även lägga till dem senare i din profil.';

  @override
  String get registerKeysEncryptedNote =>
      'Nycklarna lagras krypterade och delas aldrig med andra användare.';

  @override
  String get registerOptionalSuffix => ' (valfritt)';

  @override
  String get registerSuccessTitle => 'Registreringen lyckades!';

  @override
  String get registerSuccessBody =>
      'Ditt konto har skapats och väntar på godkännande av en administratör. Du meddelas så snart din åtkomst har aktiverats.';

  @override
  String get registerGoToLogin => 'Gå till inloggning';

  @override
  String get registerSubmit => 'Registrera';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto av $name på Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profilen har uppdaterats!';

  @override
  String get profileUpdateFailed => 'Uppdateringen misslyckades.';

  @override
  String profileSaveError(String error) {
    return 'Fel vid sparande: $error';
  }

  @override
  String get profilePasswordMismatch => 'Lösenorden matchar inte!';

  @override
  String get profilePasswordChangeSuccess => 'Lösenordet har ändrats!';

  @override
  String get profilePasswordChangeError =>
      'Fel vid ändring av lösenord: felaktigt nuvarande lösenord.';

  @override
  String get profileAvatarUploadSuccess => 'Profilbilden har laddats upp!';

  @override
  String get profileAvatarUploadError => 'Fel vid uppladdning av profilbild.';

  @override
  String get profileTitle => 'Profil och inställningar';

  @override
  String get profileSubtitle =>
      'Hantera din användarprofil, dina översättnings-API:er (Gemini och DeepL) och kontosäkerheten.';

  @override
  String get profileRoleUser => 'Användare';

  @override
  String get profileNoEmail => 'Ingen e-postadress angiven';

  @override
  String get profileTabDetails => 'Profildetaljer';

  @override
  String get profileTabGemini => 'AI-översättning (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL-översättning';

  @override
  String get profileTabPassword => 'Byt lösenord';

  @override
  String get profileSectionInfo => 'PROFILINFORMATION';

  @override
  String get profileFieldName => 'Namn';

  @override
  String get profileFieldNameHint => 'Ditt fullständiga namn';

  @override
  String get profileFieldEmail => 'E-postadress';

  @override
  String get profileFieldEmailHint => 'Din e-postadress';

  @override
  String get profileSectionGemini => 'INSTÄLLNINGAR FÖR GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API-nyckel';

  @override
  String get profileFieldGeminiKeyHint =>
      'Ange din API-nyckel för gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Anpassad AI-prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Valfritt: anpassa systemprompten för Gemini...';

  @override
  String get profileSectionDeepl => 'INSTÄLLNINGAR FÖR DEEPL-ÖVERSÄTTNING';

  @override
  String get profileDeeplDescription =>
      'DeepL erbjuder maskinöversättning av hög kvalitet med bevarande av HTML-taggar. Gratiskonton (500 000 tecken/månad) får en nyckel med suffixet \":fx\".';

  @override
  String get profileFieldDeeplKey => 'DeepL API-nyckel';

  @override
  String get profileFieldDeeplKeyHint =>
      't.ex. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Gratisnycklar slutar på \":fx\" och använder api-free.deepl.com. Pro-nycklar använder api.deepl.com. Åtskillnaden görs automatiskt.';

  @override
  String get profileSectionSecurity => 'KONTOSÄKERHET';

  @override
  String get profileFieldCurrentPassword => 'Nuvarande lösenord';

  @override
  String get profileFieldCurrentPasswordHint => 'Ange ditt nuvarande lösenord';

  @override
  String get profileFieldNewPassword => 'Nytt lösenord';

  @override
  String get profileFieldNewPasswordHint => 'Minst 6 tecken';

  @override
  String get profileFieldConfirmPassword => 'Bekräfta nytt lösenord';

  @override
  String get profileFieldConfirmPasswordHint => 'Upprepa lösenord';

  @override
  String get profileChangePasswordButton => 'Byt lösenord';

  @override
  String get commonDelete => 'Ta bort';

  @override
  String get settingsRegistrationUpdated =>
      'Registreringsinställningen har uppdaterats';

  @override
  String get settingsUpdateFailed => 'Uppdateringen misslyckades.';

  @override
  String get settingsUserApproved => 'Användaren har godkänts!';

  @override
  String get settingsAccountDeactivated => 'Kontot har inaktiverats.';

  @override
  String get settingsUserDeleted => 'Användaren har tagits bort.';

  @override
  String get settingsActionFailed => 'Åtgärden misslyckades.';

  @override
  String get settingsDeleteAccountTitle => 'Ta bort kontot?';

  @override
  String get settingsDeactivateAccountTitle => 'Inaktivera kontot?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Kontot \"$username\" tas bort permanent. Fortsätta?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Kontot \"$username\" låses. Användaren kan inte längre logga in, men kontot behålls.';
  }

  @override
  String get settingsDeactivate => 'Inaktivera';

  @override
  String settingsSyncSuccess(String count) {
    return '$count översättningar synkroniserade!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Synkroniseringsfel: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioriterade moduler synkroniserade!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Fel vid synkronisering av prioritetslistan: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Säkerhetskopieringen lyckades: $count filer bearbetade.';
  }

  @override
  String get settingsUploadFailed => 'Uppladdningen misslyckades.';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get settingsSystemConfig => 'SYSTEMKONFIGURATION';

  @override
  String get settingsRegistration => 'Registrering';

  @override
  String get settingsRegistrationHint =>
      'Slå på eller av synligheten för det globala registreringsformuläret.';

  @override
  String get settingsPendingUsers => 'Väntande användare';

  @override
  String get settingsNoNewRequests => 'Inga nya förfrågningar.';

  @override
  String get settingsWantsReviewer => 'Vill bli granskare';

  @override
  String get settingsAssignRole => 'Tilldela roll';

  @override
  String get settingsRoleTranslator => 'Översättare';

  @override
  String get settingsRoleReviewer => 'Granskare';

  @override
  String get settingsApprove => 'Godkänn';

  @override
  String get settingsReject => 'Avvisa';

  @override
  String get settingsActiveUsers => 'Aktiva användare';

  @override
  String get settingsNoActiveUsers => 'Inga aktiva användare.';

  @override
  String get settingsDeactivateAccountTooltip => 'Inaktivera';

  @override
  String get settingsDeleteAccountAction => 'Ta bort konto';

  @override
  String get settingsAppearance => 'Utseende';

  @override
  String get settingsThemePearl => 'LJUST (PÄRLA)';

  @override
  String get settingsThemeDark => 'MÖRKT';

  @override
  String get settingsThemeGlassy => 'GLASIGT';

  @override
  String get settingsThemeNature => 'NATUR';

  @override
  String get settingsThemeLiquid => 'FLYTANDE';

  @override
  String get settingsThemeStage => 'SCEN';

  @override
  String get settingsTypography => 'Typografi';

  @override
  String get settingsFontHint => 'Ändra gränssnittets typsnittsfamilj.';

  @override
  String get settingsFontClean => 'Ren';

  @override
  String get settingsFontFuturistic => 'Futuristisk';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Arbetsflöde och nöje';

  @override
  String get settingsConfettiTitle => 'Fira framgång (konfetti)';

  @override
  String get settingsConfettiHint =>
      'Visar en liten animation när sparandet lyckas.';

  @override
  String get settingsLargeUiTitle => 'Förbättrad läsbarhet (stort typsnitt)';

  @override
  String get settingsLargeUiHint =>
      'Ökar storleken på typsnitt och märken för bättre läsbarhet.';

  @override
  String get settingsAutoPTitle => 'Automatisk styckeformatering (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Omsluter automatiskt oformaterad text i <p>-stycken när en modul läses in i granskningsvyn. Motsvarar att klicka på ¶-knappen manuellt.';

  @override
  String get settingsDatabaseSync => 'Databassynkronisering';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synkroniserar databasposter med JSON-översättningsfiler.';

  @override
  String get settingsDatabaseSyncHint =>
      'Synkroniserar interna databasposter med översättnings-JSON på servern.';

  @override
  String get settingsSyncing => 'Synkroniserar...';

  @override
  String get settingsSyncNow => 'Synkronisera nu';

  @override
  String get settingsSyncD11List => 'Synkronisera D11-lista';

  @override
  String get settingsUploadBackup => 'Ladda upp säkerhetskopia (.zip)';

  @override
  String get settingsSelectZipFile => 'Välj ZIP-fil';

  @override
  String get settingsUploading => 'Laddar upp...';

  @override
  String get settingsErrorDiagnostics => 'Feldiagnostik och systemloggar';

  @override
  String get settingsLogsCopied => 'Loggarna har kopierats till urklipp! 📋';

  @override
  String get settingsCopyLogs => 'Kopiera loggar';

  @override
  String get settingsLogsRotated => 'Loggarna har arkiverats och roterats! 📁';

  @override
  String get settingsRotate => 'Rotera';

  @override
  String get settingsClear => 'Rensa';

  @override
  String get settingsLogLimit => 'Logggräns: ';

  @override
  String get settingsNoLogs => 'Inga loggar registrerade';

  @override
  String get layoutMenu => 'Meny';

  @override
  String get layoutNavAnalytics => 'Statistik';

  @override
  String get layoutNavReviewQueue => 'Granskningskö';

  @override
  String get layoutNavGlossary => 'Ordlista';

  @override
  String get layoutNavCategories => 'Kategorier';

  @override
  String get layoutNavHelp => 'Hjälp';

  @override
  String get layoutNavSettings => 'Inställningar';

  @override
  String get layoutPhotoBy => 'Foto av ';

  @override
  String get layoutPhotoOn => ' på ';

  @override
  String get layoutEditProfile => 'Redigera profil';

  @override
  String get layoutLogout => 'Logga ut';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Ljust';

  @override
  String get layoutThemeDark => 'Mörkt';

  @override
  String get layoutThemeGlassy => 'Glasigt';

  @override
  String get layoutThemeNature => 'Natur';

  @override
  String get layoutThemeLiquid => 'Flytande';

  @override
  String get layoutThemeStage => 'Scen';

  @override
  String get layoutTargetLanguage => 'MÅLSPRÅK';

  @override
  String get layoutDeeplUsage => 'DEEPL-ANVÄNDNING';

  @override
  String get layoutUnavailable => 'Ej tillgängligt';

  @override
  String get layoutUnlimited => 'obegränsat';

  @override
  String get layoutUsed => 'använt';

  @override
  String get layoutTranslate => 'Översätt';

  @override
  String get analyticsSubtitle =>
      'Kompatibilitet, översättningsefterslag och veckotrender.';

  @override
  String get analyticsBacklog => 'Översättningsefterslag';

  @override
  String get analyticsMissing => 'Saknas';

  @override
  String get analyticsStale => 'Föråldrade';

  @override
  String get analyticsInReview => 'Under granskning';

  @override
  String get analyticsReleased => 'Publicerade';

  @override
  String get analyticsTranslated => 'Översatta';

  @override
  String get analyticsTotalModules => 'Totalt antal moduler';

  @override
  String get analyticsCompatByVersion => 'Kompatibilitet per Drupal-version';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Språk: $lang · publicerade / under granskning / saknas';
  }

  @override
  String get analyticsLoadingCounts => 'Läser in antal …';

  @override
  String get analyticsWindow => 'Period:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks veckor';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nya projektbeskrivningar per vecka';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Markerade som föråldrade per vecka ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count moduler';
  }

  @override
  String get analyticsReviewShort => 'Granska';

  @override
  String get analyticsNoDataInWindow => 'Inga data i den valda perioden.';

  @override
  String get analyticsAndMore => '… och fler';

  @override
  String glossaryLoadError(String error) {
    return 'Fel vid inläsning: $error';
  }

  @override
  String get glossaryNewTerm => 'Skapa nytt begrepp';

  @override
  String get glossaryEditTerm => 'Redigera begrepp';

  @override
  String get glossaryFieldSourceWord =>
      'Källord (grundform, så som det förekommer i texten)';

  @override
  String get glossaryFieldSourceWordHint => 't.ex. node';

  @override
  String get glossaryWordForms =>
      'Ytterligare ordformer (plural, genitiv, dativ …)';

  @override
  String get glossaryWordFormsHint =>
      't.ex. content — tryck på Enter för att lägga till';

  @override
  String get glossaryAddForm => 'Lägg till form';

  @override
  String get glossaryFieldPreferredWord => 'Föredragen översättning';

  @override
  String get glossaryFieldPreferredWordHint => 't.ex. innehåll';

  @override
  String get glossaryFieldExplanation => 'Förklaring (visas i verktygstipset)';

  @override
  String get glossaryFieldExplanationHint =>
      'Varför bör det här ordet översättas annorlunda?';

  @override
  String get glossaryCreate => 'Skapa';

  @override
  String get glossaryRequiredFields =>
      'Källord och föredragen översättning krävs.';

  @override
  String get glossaryCreated => 'Begreppet har skapats ✓';

  @override
  String get glossaryUpdated => 'Begreppet har uppdaterats ✓';

  @override
  String glossaryError(String error) {
    return 'Fel: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Ta bort begrepp?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" tas bort permanent från ordlistan.';
  }

  @override
  String get glossaryDeleted => 'Begreppet har tagits bort.';

  @override
  String get glossaryTitle => 'Översättningsordlista';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Språk: $lang · $count poster';
  }

  @override
  String get glossaryNewShort => 'Ny';

  @override
  String get glossaryCreateTerm => 'Skapa begrepp';

  @override
  String get glossaryInfoBanner =>
      'Ord från den här ordlistan markeras i granskningsredigeraren. Ett verktygstips förklarar vid hovring varför en annan översättning passar bättre.';

  @override
  String get glossaryNoEntries => 'Inga poster ännu.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klicka på \"Skapa begrepp\" för att skapa den första posten.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Inga ordlisteposter för det här språket ännu.';

  @override
  String get diffNoChanges => 'Inga innehållsskillnader upptäcktes.';

  @override
  String get diffRemoved => 'Borttaget';

  @override
  String get diffAdded => 'Tillagt';

  @override
  String syncBarQuickSync(String count) {
    return 'Snabbsynk: $count ändrade moduler …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Fullständig synk: $current / $total moduler';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Fullständig synk: $count moduler …';
  }
}
