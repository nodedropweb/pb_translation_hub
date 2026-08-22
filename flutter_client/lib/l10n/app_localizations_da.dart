// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Indlæser projektoplysninger...';

  @override
  String editorLoadError(String error) {
    return 'Kunne ikke indlæse projektdata: $error';
  }

  @override
  String get editorGeminiSuccess => 'Oversættelse med Gemini gennemført! ✨';

  @override
  String get editorUnknownError => 'Ukendt fejl';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini-oversættelse mislykkedes: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Tilføj din Google AI-nøgle i din brugerprofil (ikke i administrationsindstillingerne).';

  @override
  String get editorGeminiError =>
      'Fejl under Gemini-oversættelse. Tjek venligst din Google AI-nøgle i din profil.';

  @override
  String get editorDeeplSuccess => 'Oversættelse med DeepL gennemført! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL-oversættelse mislykkedes: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Fejl under DeepL-oversættelse. Sørg for, at din DeepL API-nøgle er angivet i din profil.';

  @override
  String get editorDeeplInvalidKey =>
      'Ugyldig DeepL API-nøgle. Tjek den venligst i din profil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL-kvoten er opbrugt. Tjek venligst din plan.';

  @override
  String get editorReviewReset =>
      'Oversættelsen er nulstillet til status til gennemgang.';

  @override
  String editorResetError(String error) {
    return 'Nulstilling mislykkedes: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Modulet er blevet flyttet tilbage til den aktive liste.';

  @override
  String get editorUnignoreError => 'Modulet kunne ikke fjernes fra ignoreret.';

  @override
  String get editorSaveSuccess =>
      'Oversættelse gemt — tilbage til gennemgangskøen.';

  @override
  String editorSaveError(String error) {
    return 'Kunne ikke gemme: $error';
  }

  @override
  String get editorNoMoreProjects => 'Ingen flere åbne projekter på listen.';

  @override
  String get editorChangesDiscarded =>
      'Ændringer forkastet, indlæser næste projekt...';

  @override
  String get editorEnglishSourceApplied =>
      'Engelsk original anvendt — oversæt den venligst nu.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Kunne ikke åbne URL: $url';
  }

  @override
  String get commonSave => 'Gem';

  @override
  String get commonClose => 'Luk';

  @override
  String get editorCloseEnglishSource => 'Luk engelsk kilde';

  @override
  String get editorShowEnglishSource => 'Vis engelsk kilde';

  @override
  String get editorUnignoreShortTooltip => 'Fjern modul fra ignoreret';

  @override
  String get editorBackToReviewTooltip => 'Sæt tilbage til gennemgang';

  @override
  String get editorAndNext => '& næste';

  @override
  String get editorBackToDashboard => 'Tilbage til dashboard';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Oversætter til $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count tilbage';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Flyt modul tilbage til den aktive liste';

  @override
  String get editorUnignoreLabel => 'Fjern ignorering';

  @override
  String get editorUnpublishTooltip =>
      'Ophæv publicering og sæt tilbage til gennemgang';

  @override
  String get editorBackToReview => 'Tilbage til gennemgang';

  @override
  String get editorSaveAndNext => 'Gem & næste';

  @override
  String get editorEnglishSourceHeader => 'ENGELSK KILDE';

  @override
  String get editorStaleTooltip => 'Vis forklaring og anvend engelsk tekst';

  @override
  String get editorStaleDetailsLabel => 'Forældet — detaljer';

  @override
  String get editorCopyPromptTooltip => 'Kopiér kilde + oversættelsesprompt';

  @override
  String get editorPromptCopied => 'Prompt kopieret til udklipsholder 📋';

  @override
  String get editorShowPreview => 'Vis forhåndsvisning';

  @override
  String get editorShowHtmlSource => 'Vis HTML-kilde';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RESUMÉ:\n$summary\n\nTEKST:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Resumé:';

  @override
  String get editorDescriptionLabelColon => 'Beskrivelse:';

  @override
  String get editorStaleDialogTitle => 'Den engelske kilde er blevet ændret';

  @override
  String get editorStaleExplanation =>
      'Den eksisterende oversættelse er baseret på en forældet engelsk originaltekst. Siden den seneste oversættelse har modulets vedligeholder ændret den engelske tekst på Drupal.org — indholdet af den eksisterende oversættelse er derfor muligvis ikke længere korrekt eller fuldstændigt.';

  @override
  String get editorStaleTip =>
      'Tip: klik på \"Brug engelsk original\" for at indlæse den aktuelle engelske kilde direkte i editoren. Du kan derefter bruge den som udgangspunkt for en ny oversættelse. Den engelske original vises også i panelet til venstre.';

  @override
  String get editorEnglishSourceShort => 'Engelsk kilde';

  @override
  String get editorPreviousTranslation => 'Tidligere oversættelse';

  @override
  String get editorWhatChangedTitle => 'Hvad er ændret?';

  @override
  String get editorShowDiff => 'Vis forskel';

  @override
  String get editorUseEnglish => 'Brug engelsk original';

  @override
  String get editorStaleBannerText =>
      'Den engelske kilde er ændret — oversættelsen er forældet';

  @override
  String get editorDetailsAndApply => 'Detaljer og anvend';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName-OVERSÆTTELSE';
  }

  @override
  String get editorTranslatingEllipsis => 'Oversætter...';

  @override
  String get editorShowEditor => 'Vis editor';

  @override
  String get editorModuleTitleLabel => 'Modultitel (engelsk)';

  @override
  String get editorSummaryFieldLabel => 'Resumé';

  @override
  String get editorBodyFieldLabel => 'Tekst';

  @override
  String get editorHtmlCleaned => 'HTML ryddet op';

  @override
  String get editorLivePreviewHeader => 'LIVE FORHÅNDSVISNING';

  @override
  String get editorTidyHtmlTooltip => 'Ryd op i HTML (fjern DeepL-artefakter)';

  @override
  String get editorVisualMode => 'VISUEL';

  @override
  String get editorSourceCodeMode => 'KILDE (HTML)';

  @override
  String get commonCancel => 'Annuller';

  @override
  String get costDialogTitle => 'Omkostningsestimat (AI)';

  @override
  String get costDialogIntro =>
      'Det valgte modul oversættes med Google Gemini AI. Her er det estimerede omkostningsoverblik for denne handling:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Input-tokens';

  @override
  String get costRowOutputTokens => 'Output-tokens (estimat)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars tegn)';
  }

  @override
  String get costRowPriceInput => 'Pris pr. 1 mio. input';

  @override
  String get costRowPriceOutput => 'Pris pr. 1 mio. output';

  @override
  String get costRowTotalEstimate => 'Estimeret samlet omkostning';

  @override
  String get costDialogFootnote =>
      '* Bemærk: Dette er et estimat baseret på Googles nuværende pay-as-you-go-prismodel. Det faktiske forbrug kan variere lidt.';

  @override
  String get costDialogStartTranslation => 'Start oversættelse';

  @override
  String get htmlToolbarInsertLink => 'Indsæt link';

  @override
  String get htmlToolbarLinkTooltip => 'Indsæt link (a)';

  @override
  String get htmlToolbarInsert => 'Indsæt';

  @override
  String get htmlToolbarHeading2 => 'Overskrift 2';

  @override
  String get htmlToolbarHeading3 => 'Overskrift 3';

  @override
  String get htmlToolbarBold => 'Fed (strong)';

  @override
  String get htmlToolbarItalic => 'Kursiv (em)';

  @override
  String get htmlToolbarBulletList => 'Punktliste (ul)';

  @override
  String get htmlToolbarNumberedList => 'Nummereret liste (ol)';

  @override
  String get htmlToolbarQuote => 'Citat (blockquote)';

  @override
  String get screenshotAltsHeader => 'ALT-TEKST TIL SKÆRMBILLEDER';

  @override
  String get screenshotAltsIntro =>
      'Indtast en beskrivende alt-tekst på målsproget for hvert skærmbillede.';

  @override
  String screenshotLabel(int number) {
    return 'Skærmbillede $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Forhåndsvisning ikke tilgængelig';

  @override
  String get screenshotAltHint => 'Indtast alt-tekst på målsproget…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Fjern ignorering af alle moduler?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Alle ignorerede moduler flyttes tilbage til den aktive liste og bliver tilgængelige for oversættelse igen.';

  @override
  String get dashUnignoreAllConfirmAction => 'Fjern ignorering af alle';

  @override
  String get dashUnignoreAllSuccess =>
      'Alle ignorerede moduler er blevet gendannet.';

  @override
  String get dashUnignoreAllError => 'Kunne ikke fjerne ignorering af moduler.';

  @override
  String get dashUnignoreAllButton => 'Fjern ignorering af alle moduler';

  @override
  String dashSyncStartError(String error) {
    return 'Kunne ikke starte synkronisering: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Hurtig opdatering (7 dage) startet ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Fejl ved hurtig opdatering: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Synkroniseret: $name';
  }

  @override
  String get dashManualSyncNotFound =>
      'Modulet blev ikke fundet på Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'AI-masseoversættelse';

  @override
  String get dashHeaderTitle => 'Projektbeskrivelser';

  @override
  String get dashHeaderSubtitle =>
      'Oversæt beskrivelser af Drupal-moduler til målsproget. Vær med til at gøre økosystemet mere tilgængeligt.';

  @override
  String get dashHeaderSubtitleShort =>
      'Oversæt beskrivelser af Drupal-moduler.';

  @override
  String get dashLastLabel => 'Senest: ';

  @override
  String get dashContinue => 'Fortsæt';

  @override
  String get dashContinueShort => 'Fortsæt';

  @override
  String get dashUnignoreAllButtonLong => 'Fjern ignorering af alle moduler';

  @override
  String get dashQuickUpdateTooltip => 'Hurtig opdatering (seneste 7 dage)';

  @override
  String get dashFullSyncTooltip =>
      'Fuld databasesynkronisering fra Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Indlæs manuelt et enkelt modul fra Drupal.org';

  @override
  String get dashQuickShort => 'Hurtig';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Fundet: ';

  @override
  String get dashModulesSuffix => ' moduler';

  @override
  String dashPerPage(int count) {
    return '$count pr. side';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / side';
  }

  @override
  String get dashFirstPage => 'Første side';

  @override
  String get dashPrevPage => 'Forrige side';

  @override
  String get dashNextPage => 'Næste side';

  @override
  String get dashLastPage => 'Sidste side';

  @override
  String dashPageOf(int page, int total) {
    return 'Side $page af $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (f.eks. pathauto)';

  @override
  String get dashAddButton => 'Tilføj';

  @override
  String get dashAddModuleManually => 'Tilføj modul manuelt';

  @override
  String get dashAddModuleSubtitle =>
      'Indlæs direkte fra Drupal.org via machine name.';

  @override
  String get dashAddModuleShort => 'Tilføj modul';

  @override
  String get dashNoProjectsFound => 'Ingen projekter fundet.';

  @override
  String get dashFilterAll => 'Alle projekter';

  @override
  String get dashFilterMissing => 'Manglende oversættelser';

  @override
  String get dashFilterReview => 'Gennemgangskø';

  @override
  String get dashFilterTranslated => 'Oversatte projekter';

  @override
  String get dashFilterReleased => 'Udgivne projekter';

  @override
  String get dashBulkDialogIntro =>
      'Oversæt automatisk flere moduler fra det valgte filter med Google Gemini.';

  @override
  String get dashActiveFilter => 'Aktivt filter';

  @override
  String get dashModuleCount => 'Antal moduler';

  @override
  String dashModulesCountItem(int count) {
    return '$count moduler';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioritér Drupal 12-moduler';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Oversætter moduler uden Drupal 12-understøttelse først';

  @override
  String get dashTotalModules => 'Moduler i alt';

  @override
  String get dashInputTokensEst => 'Input-tokens (est.)';

  @override
  String get dashOutputTokensEst => 'Output-tokens (est.)';

  @override
  String get dashBulkFootnote =>
      '* Oversættelsen udføres i ressourcebesparende batches for at undgå timeouts.';

  @override
  String get dashStartBulkTranslation => 'Start masseoversættelse';

  @override
  String dashStaleLoadError(String error) {
    return 'Fejl ved indlæsning af forældede moduler: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Ingen forældede moduler fundet — alt er opdateret! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Genoversæt forældede moduler';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Alle oversættelser, hvis engelske kilde er ændret siden sidste oversættelse, genoversættes automatisk med Google Gemini. Ingen grund til at åbne hvert modul manuelt.';

  @override
  String get dashOutdatedModules => 'Forældede moduler';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Oversættelsen erstatter eksisterende tekst og nulstiller is_reviewed. Udføres i batches af 4 moduler.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Genoversæt alle $count moduler';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Genoversætter forældede moduler…';

  @override
  String get dashFetchingProjects => 'Henter projekter fra server…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed af $total moduler behandlet';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Ingen oversættelige projekter fundet for dette filter.';

  @override
  String get dashStartingTranslation => 'Starter oversættelse…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Oversætter modul $start–$end af $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end af $total moduler fuldført.';
  }

  @override
  String get dashTranslationCompleted => 'Oversættelse fuldført! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Masseoversættelse af $count moduler gennemført! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Fejl ved masseoversættelse: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Alle $count moduler er genoversat! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count forældede moduler er genoversat! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Fejl under genoversættelse: $error';
  }

  @override
  String get filterAllShort => 'Alle';

  @override
  String get filterMissing => 'Mangler';

  @override
  String get filterTranslated => 'Oversat';

  @override
  String get filterReviewQueue => 'Gennemgangskø';

  @override
  String get filterReleased => 'Udgivet';

  @override
  String get filterOutdated => 'Forældet';

  @override
  String get filterPriority => 'Prioritet';

  @override
  String get filterIgnored => 'Ignoreret';

  @override
  String get commonEdit => 'Rediger';

  @override
  String get commonReset => 'Nulstil';

  @override
  String get commonRefresh => 'Opdater';

  @override
  String commonErrorPrefix(String error) {
    return 'Fejl: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Nulstil alle publicerede oversættelser?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Alle oversættelser markeret som publiceret for $langcode nulstilles til status til gennemgang. Dette kan ikke fortrydes.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count oversættelser nulstillet til status til gennemgang.';
  }

  @override
  String get reviewPipelineTitle => 'Gennemgangspipeline';

  @override
  String get reviewPipelineSubtitle =>
      'Manuel kvalitetssikring af AI-oversættelser';

  @override
  String get reviewSearchHint => 'Søg projekter...';

  @override
  String get reviewResetPublished => 'Nulstil publicerede';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultater: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Afventer: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Ingen projekter afventer gennemgang.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Alle oversættelser er allerede blevet verificeret, eller der findes ingen i denne sprogkontekst.';

  @override
  String get reviewNoSummary => 'Intet resumé.';

  @override
  String get reviewStartAudit => 'START GENNEMGANG';

  @override
  String get reviewHtmlSourceShort => 'HTML-kilde';

  @override
  String get reviewCopySource => 'Kopiér kilde';

  @override
  String get reviewModuleDetails => 'Moduldetaljer';

  @override
  String get reviewOriginalTitle => 'Original titel';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org-projekt';

  @override
  String get reviewSuggestions => 'Forslag';

  @override
  String get reviewNoSuggestions => 'Ingen forslag tilgængelige.';

  @override
  String get reviewApply => 'Anvend';

  @override
  String get reviewNoChanges => 'Ingen ændringer';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (før korrektur)';

  @override
  String get reviewCorrectedCurrentVersion => 'Korrigeret (nuværende version)';

  @override
  String get reviewBaseOriginal => 'Basis (original)';

  @override
  String get reviewYourCorrection => 'Din korrektur';

  @override
  String get reviewChangesVisual => 'Gennemgå dine ændringer (visuelt)';

  @override
  String get commonSkip => 'Spring over';

  @override
  String get commonIgnore => 'Ignorer';

  @override
  String get reviewEmptyProjectTitle => 'Tomt projekt';

  @override
  String get reviewEmptyProjectBody =>
      'Dette projekt er tomt (ingen titel, resumé eller tekst) og kan ikke godkendes. Spring det venligst over.';

  @override
  String get reviewApprovedSuccess => 'Oversættelse godkendt! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Godkendelse af \"$machine\" mislykkedes — prøv venligst igen.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Ignorering fjernet. Modulet er aktivt igen!';

  @override
  String get reviewActionFailed => 'Handlingen mislykkedes.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorer modul?';

  @override
  String get reviewIgnoreModuleBody =>
      'Dette modul skjules permanent fra alle lister. Du støder ikke på det igen.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modulet er permanent ignoreret.';

  @override
  String get reviewIgnoreFailed => 'Kunne ikke ignorere modulet.';

  @override
  String get reviewSuggestionSaved => 'Forslagskladde gemt! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'Kunne ikke gemme forslagskladde.';

  @override
  String get reviewSuggestionDeleted => 'Forslag slettet.';

  @override
  String get reviewDeleteFailed => 'Sletning mislykkedes.';

  @override
  String get reviewSuggestionApplied => 'Forslag anvendt.';

  @override
  String get reviewPreparingData => 'Forbereder gennemgangsdata...';

  @override
  String get reviewDirectEdit => 'Direkte redigering';

  @override
  String get reviewLivePreview => 'Live forhåndsvisning';

  @override
  String get reviewCompareWith => 'Sammenlign med:';

  @override
  String get reviewProductionVersion => 'Produktionsversion';

  @override
  String get reviewEditorialReview => 'Redaktionel gennemgang';

  @override
  String get reviewOpenQueue => 'Åbn gennemgangskø';

  @override
  String get reviewCopyPromptShort => 'Kopiér prompt';

  @override
  String get reviewUnignoreShort => 'Fjern ignorering';

  @override
  String get reviewApproveButton => 'GODKEND';

  @override
  String get reviewHideDetails => 'Skjul detaljer';

  @override
  String get reviewDetailsAndEnglishSource => 'Detaljer og engelsk kilde';

  @override
  String reviewPendingCountShort(int count) {
    return '$count afventer';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Gennemgår $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Sammenlign oversættelse med engelsk kilde';

  @override
  String get reviewTranslationLabel => 'Oversættelse';

  @override
  String get reviewComparisonTitle => 'Sammenligning';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Kopiér kildetekst + oversættelsesprompt til udklipsholder';

  @override
  String get reviewUnignoreCaps => 'FJERN IGNORERING';

  @override
  String get reviewIgnoreCaps => 'IGNORER';

  @override
  String get reviewSkipShortcut => 'SPRING OVER (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Redaktionel gennemgang';

  @override
  String get reviewUnignoreTablet => 'FJERN IGNORERING';

  @override
  String get reviewApproveForProduction =>
      'GODKEND TIL PRODUKTION (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Direkte finpudsning';

  @override
  String get reviewTitleField => 'Titel';

  @override
  String get reviewSummaryField => 'Resumé';

  @override
  String get reviewBodyField => 'Tekstindhold';

  @override
  String get reviewSaveShortcut => 'GEM (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Live forhåndsvisning (rendering)';

  @override
  String get reviewVoiceFemale => 'Kvinde';

  @override
  String get reviewVoiceMale => 'Mand';

  @override
  String get reviewStopListening => 'Stop';

  @override
  String get reviewListen => 'Lyt';

  @override
  String get reviewAutopTooltip => 'Autoformatér afsnit (linjeskift → <p>)';

  @override
  String get reviewSourceCodeShort => 'KILDE';

  @override
  String get reviewNoParagraphChange =>
      'Teksten indeholder allerede <p>-tags — ingen ændring';

  @override
  String get reviewParagraphsFormatted => 'Afsnit formateret ¶';

  @override
  String get commonRetry => 'Prøv igen';

  @override
  String categoriesLoadError(String error) {
    return 'Kunne ikke indlæse kategorier: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategorier gemt.';

  @override
  String get categoriesSaveFailed => 'Kunne ikke gemme oversættelser.';

  @override
  String get categoriesFileEmpty => 'Filen er tom.';

  @override
  String get categoriesInvalidJson => 'Ugyldigt JSON-format.';

  @override
  String get categoriesNoValidUuids =>
      'Ingen gyldige UUID-poster fundet i filen.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count kategorier importeret fra fil.';
  }

  @override
  String get categoriesTitle => 'Kategorier';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Oversætter for: $lang';
  }

  @override
  String get categoriesImportJson => 'Importér JSON';

  @override
  String get categoriesSaving => 'Gemmer...';

  @override
  String get categoriesSaveAll => 'Gem alle';

  @override
  String get categoriesLoading => 'Indlæser kategorier...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Oversættelse ($code)';
  }

  @override
  String get categoriesNoneFound => 'Ingen kategorier fundet.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Oversæt \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto af ';

  @override
  String get loginPhotoOn => ' på ';

  @override
  String get loginPleaseSignIn => 'Log venligst ind';

  @override
  String get loginUsername => 'Brugernavn';

  @override
  String get loginPassword => 'Adgangskode';

  @override
  String get loginRememberMe => 'Husk mig';

  @override
  String get loginSignIn => 'LOG IND';

  @override
  String get loginNoAccount => 'Har du ikke en konto endnu? ';

  @override
  String get loginRegisterNow => 'Opret konto nu';

  @override
  String get commonBack => 'Tilbage';

  @override
  String get commonNext => 'Næste';

  @override
  String get registerFillRequired => 'Udfyld venligst alle påkrævede felter.';

  @override
  String get registerPasswordMismatch => 'Adgangskoderne stemmer ikke overens.';

  @override
  String get registerPasswordTooShort =>
      'Adgangskoden skal være mindst 8 tegn.';

  @override
  String get registerSelectLanguage => 'Vælg venligst mindst ét sprog.';

  @override
  String get registerFailed => 'Registrering mislykkedes.';

  @override
  String get registerHeaderTitle => 'REGISTRERING';

  @override
  String get registerStepAccount => 'Konto';

  @override
  String get registerStepRole => 'Rolle';

  @override
  String get registerStepLanguages => 'Sprog';

  @override
  String get registerStepApiKeys => 'API-nøgler';

  @override
  String get registerYourAccount => 'Din konto';

  @override
  String get registerAvatarOptional => 'Avatar (valgfrit)';

  @override
  String get registerUsernameRequired => 'Brugernavn *';

  @override
  String get registerEmailRequired => 'E-mailadresse *';

  @override
  String get registerPasswordRequired => 'Adgangskode *';

  @override
  String get registerPasswordRepeat => 'Gentag adgangskode *';

  @override
  String get registerYourRole => 'Din rolle';

  @override
  String get registerRoleExplanation =>
      'Oversættere kan oversætte tekster, men har ikke adgang til gennemgangskøen. Reviewere kontrollerer og godkender oversat indhold.';

  @override
  String get registerRoleTranslator => 'Oversætter';

  @override
  String get registerRoleTranslatorDesc => 'Opret og rediger oversættelser.';

  @override
  String get registerRoleReviewer => 'Reviewer';

  @override
  String get registerRoleReviewerDesc => 'Gennemgå og godkend oversættelser.';

  @override
  String get registerTargetLanguages => 'Målsprog';

  @override
  String get registerLanguagesExplanation =>
      'Vælg alle de sprog, du vil arbejde med.';

  @override
  String get registerNoLanguagesAvailable => 'Ingen sprog tilgængelige.';

  @override
  String get registerApiKeysTitle => 'API-nøgler';

  @override
  String get registerApiKeysExplanation =>
      'Indtast dine egne API-nøgler. Hver bruger bruger udelukkende sine egne nøgler. Du kan også tilføje dem senere i din profil.';

  @override
  String get registerKeysEncryptedNote =>
      'Nøgler gemmes krypteret og deles aldrig med andre brugere.';

  @override
  String get registerOptionalSuffix => ' (valgfrit)';

  @override
  String get registerSuccessTitle => 'Registrering gennemført!';

  @override
  String get registerSuccessBody =>
      'Din konto er blevet oprettet og afventer godkendelse fra en administrator. Du får besked, når din adgang er blevet aktiveret.';

  @override
  String get registerGoToLogin => 'Gå til login';

  @override
  String get registerSubmit => 'Registrer';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto af $name på Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profilen er opdateret!';

  @override
  String get profileUpdateFailed => 'Opdatering mislykkedes.';

  @override
  String profileSaveError(String error) {
    return 'Fejl under gemning: $error';
  }

  @override
  String get profilePasswordMismatch => 'Adgangskoderne stemmer ikke overens!';

  @override
  String get profilePasswordChangeSuccess => 'Adgangskoden er ændret!';

  @override
  String get profilePasswordChangeError =>
      'Fejl ved ændring af adgangskode: forkert nuværende adgangskode.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar uploadet!';

  @override
  String get profileAvatarUploadError => 'Fejl ved upload af avatar.';

  @override
  String get profileTitle => 'Profil & indstillinger';

  @override
  String get profileSubtitle =>
      'Administrer din brugerprofil, dine oversættelses-API\'er (Gemini & DeepL) og din kontosikkerhed.';

  @override
  String get profileRoleUser => 'Bruger';

  @override
  String get profileNoEmail => 'Ingen e-mailadresse angivet';

  @override
  String get profileTabDetails => 'Profildetaljer';

  @override
  String get profileTabGemini => 'AI-oversættelse (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL-oversættelse';

  @override
  String get profileTabPassword => 'Skift adgangskode';

  @override
  String get profileSectionInfo => 'PROFILOPLYSNINGER';

  @override
  String get profileFieldName => 'Navn';

  @override
  String get profileFieldNameHint => 'Dit fulde navn';

  @override
  String get profileFieldEmail => 'E-mailadresse';

  @override
  String get profileFieldEmailHint => 'Din e-mailadresse';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT-INDSTILLINGER';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API-nøgle';

  @override
  String get profileFieldGeminiKeyHint =>
      'Indtast din gemini-3.1-flash API-nøgle';

  @override
  String get profileFieldAiPrompt => 'Tilpasset AI-prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Valgfrit: tilpas systempromptet til Gemini...';

  @override
  String get profileSectionDeepl => 'DEEPL-OVERSÆTTELSESINDSTILLINGER';

  @override
  String get profileDeeplDescription =>
      'DeepL tilbyder maskinoversættelse i høj kvalitet med bevarelse af HTML-tags. Gratis konti (500.000 tegn/måned) får en nøgle med endelsen \":fx\".';

  @override
  String get profileFieldDeeplKey => 'DeepL API-nøgle';

  @override
  String get profileFieldDeeplKeyHint =>
      'f.eks. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Gratis nøgler slutter med \":fx\" og bruger api-free.deepl.com. Pro-nøgler bruger api.deepl.com. Skelnen sker automatisk.';

  @override
  String get profileSectionSecurity => 'KONTOSIKKERHED';

  @override
  String get profileFieldCurrentPassword => 'Nuværende adgangskode';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Indtast din nuværende adgangskode';

  @override
  String get profileFieldNewPassword => 'Ny adgangskode';

  @override
  String get profileFieldNewPasswordHint => 'Mindst 6 tegn';

  @override
  String get profileFieldConfirmPassword => 'Bekræft ny adgangskode';

  @override
  String get profileFieldConfirmPasswordHint => 'Gentag adgangskode';

  @override
  String get profileChangePasswordButton => 'Skift adgangskode';

  @override
  String get commonDelete => 'Slet';

  @override
  String get settingsRegistrationUpdated =>
      'Registreringsindstilling opdateret';

  @override
  String get settingsUpdateFailed => 'Opdatering mislykkedes.';

  @override
  String get settingsUserApproved => 'Bruger godkendt!';

  @override
  String get settingsAccountDeactivated => 'Konto deaktiveret.';

  @override
  String get settingsUserDeleted => 'Bruger slettet.';

  @override
  String get settingsActionFailed => 'Handlingen mislykkedes.';

  @override
  String get settingsDeleteAccountTitle => 'Slet konto?';

  @override
  String get settingsDeactivateAccountTitle => 'Deaktiver konto?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Kontoen \"$username\" slettes permanent. Fortsæt?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Kontoen \"$username\" låses. Brugeren kan ikke logge ind længere, men kontoen bevares.';
  }

  @override
  String get settingsDeactivate => 'Deaktiver';

  @override
  String settingsSyncSuccess(String count) {
    return '$count oversættelser synkroniseret!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Synkroniseringsfejl: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioritetsmoduler synkroniseret!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Fejl ved synkronisering af prioritetsliste: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup gennemført: $count filer behandlet.';
  }

  @override
  String get settingsUploadFailed => 'Upload mislykkedes.';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get settingsSystemConfig => 'SYSTEMKONFIGURATION';

  @override
  String get settingsRegistration => 'Registrering';

  @override
  String get settingsRegistrationHint =>
      'Slå synligheden af den globale registreringsformular til/fra.';

  @override
  String get settingsPendingUsers => 'Afventende brugere';

  @override
  String get settingsNoNewRequests => 'Ingen nye anmodninger.';

  @override
  String get settingsWantsReviewer => 'Ønsker at være reviewer';

  @override
  String get settingsAssignRole => 'Tildel rolle';

  @override
  String get settingsRoleTranslator => 'Oversætter';

  @override
  String get settingsRoleReviewer => 'Reviewer';

  @override
  String get settingsApprove => 'Godkend';

  @override
  String get settingsReject => 'Afvis';

  @override
  String get settingsActiveUsers => 'Aktive brugere';

  @override
  String get settingsNoActiveUsers => 'Ingen aktive brugere.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deaktiver';

  @override
  String get settingsDeleteAccountAction => 'Slet konto';

  @override
  String get settingsAppearance => 'Udseende';

  @override
  String get settingsThemePearl => 'LYST (PEARL)';

  @override
  String get settingsThemeDark => 'MØRKT';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Typografi';

  @override
  String get settingsFontHint => 'Skift skrifttypefamilien for brugerfladen.';

  @override
  String get settingsFontClean => 'Clean';

  @override
  String get settingsFontFuturistic => 'Futuristisk';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Arbejdsgang & sjov';

  @override
  String get settingsConfettiTitle => 'Succesfejring (konfetti)';

  @override
  String get settingsConfettiHint =>
      'Viser en lille animation ved vellykket gemning.';

  @override
  String get settingsLargeUiTitle => 'Forbedret læsbarhed (stor skrift)';

  @override
  String get settingsLargeUiHint =>
      'Øger størrelsen på skrift og badges for bedre læsbarhed.';

  @override
  String get settingsAutoPTitle => 'Automatisk afsnitsformatering (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Ombryder automatisk almindelig tekst i <p>-afsnit, når et modul indlæses i gennemgangsskærmen. Svarer til at klikke på ¶-knappen manuelt.';

  @override
  String get settingsDatabaseSync => 'Databasesynkronisering';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synkroniserer databaseposter med JSON-oversættelsesfiler.';

  @override
  String get settingsDatabaseSyncHint =>
      'Synkroniserer interne databaseposter med oversættelses-JSON\'er på serveren.';

  @override
  String get settingsSyncing => 'Synkroniserer...';

  @override
  String get settingsSyncNow => 'Synkroniser nu';

  @override
  String get settingsSyncD11List => 'Synkroniser D11-liste';

  @override
  String get settingsUploadBackup => 'Upload backup (.zip)';

  @override
  String get settingsSelectZipFile => 'Vælg ZIP-fil';

  @override
  String get settingsUploading => 'Uploader...';

  @override
  String get settingsErrorDiagnostics => 'Fejldiagnostik & systemlogs';

  @override
  String get settingsLogsCopied => 'Logs kopieret til udklipsholder! 📋';

  @override
  String get settingsCopyLogs => 'Kopiér logs';

  @override
  String get settingsLogsRotated => 'Logs arkiveret og roteret! 📁';

  @override
  String get settingsRotate => 'Rotér';

  @override
  String get settingsClear => 'Ryd';

  @override
  String get settingsLogLimit => 'Loggrænse: ';

  @override
  String get settingsNoLogs => 'Ingen logs registreret';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Analyse';

  @override
  String get layoutNavReviewQueue => 'Gennemgangskø';

  @override
  String get layoutNavGlossary => 'Ordliste';

  @override
  String get layoutNavCategories => 'Kategorier';

  @override
  String get layoutNavHelp => 'Hjælp';

  @override
  String get layoutNavSettings => 'Indstillinger';

  @override
  String get layoutPhotoBy => 'Foto af ';

  @override
  String get layoutPhotoOn => ' på ';

  @override
  String get layoutEditProfile => 'Rediger profil';

  @override
  String get layoutLogout => 'Log ud';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Lyst';

  @override
  String get layoutThemeDark => 'Mørkt';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'MÅLSPROG';

  @override
  String get layoutDeeplUsage => 'DEEPL-FORBRUG';

  @override
  String get layoutUnavailable => 'Ikke tilgængelig';

  @override
  String get layoutUnlimited => 'ubegrænset';

  @override
  String get layoutUsed => 'brugt';

  @override
  String get layoutTranslate => 'Oversæt';

  @override
  String get analyticsSubtitle =>
      'Kompatibilitet, oversættelsesefterslæb og ugentlige tendenser.';

  @override
  String get analyticsBacklog => 'Oversættelsesefterslæb';

  @override
  String get analyticsMissing => 'Mangler';

  @override
  String get analyticsStale => 'Forældet';

  @override
  String get analyticsInReview => 'Under gennemgang';

  @override
  String get analyticsReleased => 'Udgivet';

  @override
  String get analyticsTranslated => 'Oversat';

  @override
  String get analyticsTotalModules => 'Moduler i alt';

  @override
  String get analyticsCompatByVersion => 'Kompatibilitet efter Drupal-version';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Sprog: $lang · udgivet / under gennemgang / mangler';
  }

  @override
  String get analyticsLoadingCounts => 'Indlæser antal …';

  @override
  String get analyticsWindow => 'Vindue:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks uger';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nye projektbeskrivelser pr. uge';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Markeret forældet pr. uge ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count moduler';
  }

  @override
  String get analyticsReviewShort => 'Gennemgang';

  @override
  String get analyticsNoDataInWindow => 'Ingen data i vinduet.';

  @override
  String get analyticsAndMore => '… og mere';

  @override
  String glossaryLoadError(String error) {
    return 'Fejl ved indlæsning: $error';
  }

  @override
  String get glossaryNewTerm => 'Opret nyt begreb';

  @override
  String get glossaryEditTerm => 'Rediger begreb';

  @override
  String get glossaryFieldSourceWord =>
      'Kildeord (grundform, som det optræder i teksten)';

  @override
  String get glossaryFieldSourceWordHint => 'f.eks. node';

  @override
  String get glossaryWordForms =>
      'Yderligere ordformer (flertal, genitiv, dativ …)';

  @override
  String get glossaryWordFormsHint =>
      'f.eks. content — tryk Enter for at tilføje';

  @override
  String get glossaryAddForm => 'Tilføj form';

  @override
  String get glossaryFieldPreferredWord => 'Foretrukken oversættelse';

  @override
  String get glossaryFieldPreferredWordHint => 'f.eks. content';

  @override
  String get glossaryFieldExplanation => 'Forklaring (vises i tooltip)';

  @override
  String get glossaryFieldExplanationHint =>
      'Hvorfor bør dette ord oversættes anderledes?';

  @override
  String get glossaryCreate => 'Opret';

  @override
  String get glossaryRequiredFields =>
      'Kildeord og foretrukken oversættelse er påkrævet.';

  @override
  String get glossaryCreated => 'Begreb oprettet ✓';

  @override
  String get glossaryUpdated => 'Begreb opdateret ✓';

  @override
  String glossaryError(String error) {
    return 'Fejl: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Slet begreb?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" fjernes permanent fra ordlisten.';
  }

  @override
  String get glossaryDeleted => 'Begreb slettet.';

  @override
  String get glossaryTitle => 'Oversættelsesordliste';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Sprog: $lang · $count poster';
  }

  @override
  String get glossaryNewShort => 'Ny';

  @override
  String get glossaryCreateTerm => 'Opret begreb';

  @override
  String get glossaryInfoBanner =>
      'Ord fra denne ordliste fremhæves i gennemgangseditoren. Et tooltip forklarer ved museover, hvorfor en anden oversættelse passer bedre.';

  @override
  String get glossaryNoEntries => 'Ingen poster endnu.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klik på \"Opret begreb\" for at oprette den første post.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Ingen ordlisteposter for dette sprog endnu.';

  @override
  String get diffNoChanges => 'Ingen indholdsforskelle registreret.';

  @override
  String get diffRemoved => 'Fjernet';

  @override
  String get diffAdded => 'Tilføjet';

  @override
  String syncBarQuickSync(String count) {
    return 'Hurtig synkronisering: $count ændrede moduler …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Fuld synkronisering: $current / $total moduler';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Fuld synkronisering: $count moduler …';
  }
}
