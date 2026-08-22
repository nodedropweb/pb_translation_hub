// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Laster inn prosjektdetaljer...';

  @override
  String editorLoadError(String error) {
    return 'Kunne ikke laste inn prosjektdata: $error';
  }

  @override
  String get editorGeminiSuccess => 'Oversettelse med Gemini fullført! ✨';

  @override
  String get editorUnknownError => 'Ukjent feil';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini-oversettelse mislyktes: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Legg til Google AI-nøkkelen din i brukerprofilen (ikke i admininnstillingene).';

  @override
  String get editorGeminiError =>
      'Feil under Gemini-oversettelse. Sjekk Google AI-nøkkelen din i profilen.';

  @override
  String get editorDeeplSuccess => 'Oversettelse med DeepL fullført! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL-oversettelse mislyktes: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Feil under DeepL-oversettelse. Sørg for at DeepL API-nøkkelen din er angitt i profilen.';

  @override
  String get editorDeeplInvalidKey =>
      'Ugyldig DeepL API-nøkkel. Sjekk den i profilen din.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL-kvoten er brukt opp. Sjekk abonnementet ditt.';

  @override
  String get editorReviewReset =>
      'Oversettelsen er tilbakestilt til gjennomgangsstatus.';

  @override
  String editorResetError(String error) {
    return 'Tilbakestilling mislyktes: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Modulen er lagt tilbake på den aktive listen.';

  @override
  String get editorUnignoreError => 'Kunne ikke oppheve ignorering av modulen.';

  @override
  String get editorSaveSuccess =>
      'Oversettelsen er lagret — tilbake til gjennomgangskøen.';

  @override
  String editorSaveError(String error) {
    return 'Lagring mislyktes: $error';
  }

  @override
  String get editorNoMoreProjects => 'Ingen flere åpne prosjekter i listen.';

  @override
  String get editorChangesDiscarded =>
      'Endringer forkastet, laster inn neste prosjekt...';

  @override
  String get editorEnglishSourceApplied =>
      'Engelsk original er brukt — oversett den nå.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Kunne ikke åpne URL: $url';
  }

  @override
  String get commonSave => 'Lagre';

  @override
  String get commonClose => 'Lukk';

  @override
  String get editorCloseEnglishSource => 'Lukk engelsk kilde';

  @override
  String get editorShowEnglishSource => 'Vis engelsk kilde';

  @override
  String get editorUnignoreShortTooltip => 'Opphev ignorering av modul';

  @override
  String get editorBackToReviewTooltip => 'Sett tilbake til gjennomgang';

  @override
  String get editorAndNext => '& Neste';

  @override
  String get editorBackToDashboard => 'Tilbake til dashbordet';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Oversetter til $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count gjenstår';
  }

  @override
  String get editorUnignoreLongTooltip => 'Legg modulen tilbake på aktiv liste';

  @override
  String get editorUnignoreLabel => 'Opphev ignorering';

  @override
  String get editorUnpublishTooltip =>
      'Trekk tilbake publisering og sett tilbake til gjennomgang';

  @override
  String get editorBackToReview => 'Tilbake til gjennomgang';

  @override
  String get editorSaveAndNext => 'Lagre og neste';

  @override
  String get editorEnglishSourceHeader => 'ENGELSK KILDE';

  @override
  String get editorStaleTooltip => 'Vis forklaring og bruk engelsk tekst';

  @override
  String get editorStaleDetailsLabel => 'Utdatert — detaljer';

  @override
  String get editorCopyPromptTooltip => 'Kopier kilde + oversettelsesprompt';

  @override
  String get editorPromptCopied => 'Prompten er kopiert til utklippstavlen 📋';

  @override
  String get editorShowPreview => 'Vis forhåndsvisning';

  @override
  String get editorShowHtmlSource => 'Vis HTML-kilde';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'SAMMENDRAG:\n$summary\n\nINNHOLD:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Sammendrag:';

  @override
  String get editorDescriptionLabelColon => 'Beskrivelse:';

  @override
  String get editorStaleDialogTitle => 'Engelsk kilde er endret';

  @override
  String get editorStaleExplanation =>
      'Den eksisterende oversettelsen er basert på en utdatert engelsk originaltekst. Siden forrige oversettelse har modulens vedlikeholder endret den engelske teksten på Drupal.org — innholdet i den eksisterende oversettelsen er derfor kanskje ikke lenger korrekt eller fullstendig.';

  @override
  String get editorStaleTip =>
      'Tips: klikk på \"Bruk engelsk original\" for å laste den gjeldende engelske kilden direkte inn i editoren. Du kan deretter bruke den som utgangspunkt for en ny oversettelse. Den engelske originalen vises også i panelet til venstre.';

  @override
  String get editorEnglishSourceShort => 'Engelsk kilde';

  @override
  String get editorPreviousTranslation => 'Forrige oversettelse';

  @override
  String get editorWhatChangedTitle => 'Hva er endret?';

  @override
  String get editorShowDiff => 'Vis diff';

  @override
  String get editorUseEnglish => 'Bruk engelsk original';

  @override
  String get editorStaleBannerText =>
      'Engelsk kilde er endret — oversettelsen er utdatert';

  @override
  String get editorDetailsAndApply => 'Detaljer og bruk';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'OVERSETTELSE $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Oversetter...';

  @override
  String get editorShowEditor => 'Vis redigeringsverktøy';

  @override
  String get editorModuleTitleLabel => 'Modultittel (engelsk)';

  @override
  String get editorSummaryFieldLabel => 'Sammendrag';

  @override
  String get editorBodyFieldLabel => 'Innhold';

  @override
  String get editorHtmlCleaned => 'HTML er ryddet opp';

  @override
  String get editorLivePreviewHeader => 'LIVE FORHÅNDSVISNING';

  @override
  String get editorTidyHtmlTooltip =>
      'Rydd opp i HTML (fjern DeepL-artefakter)';

  @override
  String get editorVisualMode => 'VISUELL';

  @override
  String get editorSourceCodeMode => 'KILDE (HTML)';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get costDialogTitle => 'Kostnadsestimat (AI)';

  @override
  String get costDialogIntro =>
      'Den valgte modulen vil bli oversatt med Google Gemini AI. Her er en estimert kostnadsoversikt for denne operasjonen:';

  @override
  String get costRowModel => 'Modell';

  @override
  String get costRowInputTokens => 'Input-tokens';

  @override
  String get costRowOutputTokens => 'Output-tokens (estimat)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars tegn)';
  }

  @override
  String get costRowPriceInput => 'Pris per 1M input';

  @override
  String get costRowPriceOutput => 'Pris per 1M output';

  @override
  String get costRowTotalEstimate => 'Estimert totalkostnad';

  @override
  String get costDialogFootnote =>
      '* Merk: Dette er et estimat basert på Googles gjeldende pay-as-you-go-prismodell. Faktisk bruk kan variere noe.';

  @override
  String get costDialogStartTranslation => 'Start oversettelse';

  @override
  String get htmlToolbarInsertLink => 'Sett inn lenke';

  @override
  String get htmlToolbarLinkTooltip => 'Sett inn lenke (a)';

  @override
  String get htmlToolbarInsert => 'Sett inn';

  @override
  String get htmlToolbarHeading2 => 'Overskrift 2';

  @override
  String get htmlToolbarHeading3 => 'Overskrift 3';

  @override
  String get htmlToolbarBold => 'Fet (strong)';

  @override
  String get htmlToolbarItalic => 'Kursiv (em)';

  @override
  String get htmlToolbarBulletList => 'Punktliste (ul)';

  @override
  String get htmlToolbarNumberedList => 'Nummerert liste (ol)';

  @override
  String get htmlToolbarQuote => 'Sitat (blockquote)';

  @override
  String get screenshotAltsHeader => 'ALT-TEKST FOR SKJERMBILDER';

  @override
  String get screenshotAltsIntro =>
      'Skriv inn en beskrivende alt-tekst på målspråket for hvert skjermbilde.';

  @override
  String screenshotLabel(int number) {
    return 'Skjermbilde $number';
  }

  @override
  String get screenshotPreviewUnavailable =>
      'Forhåndsvisning ikke tilgjengelig';

  @override
  String get screenshotAltHint => 'Skriv inn alt-tekst på målspråket …';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Opphev ignorering av alle moduler?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Alle ignorerte moduler blir lagt tilbake på den aktive listen og blir igjen tilgjengelige for oversettelse.';

  @override
  String get dashUnignoreAllConfirmAction => 'Opphev ignorering av alle';

  @override
  String get dashUnignoreAllSuccess =>
      'Ignorering av alle moduler er opphevet.';

  @override
  String get dashUnignoreAllError =>
      'Kunne ikke oppheve ignorering av moduler.';

  @override
  String get dashUnignoreAllButton => 'Opphev ignorering av alle moduler';

  @override
  String dashSyncStartError(String error) {
    return 'Kunne ikke starte synkronisering: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Hurtigoppdatering (7 dager) startet ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Feil ved hurtigoppdatering: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Synkronisert: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Fant ikke modulen på Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'AI-massoversettelse';

  @override
  String get dashHeaderTitle => 'Prosjektbeskrivelser';

  @override
  String get dashHeaderSubtitle =>
      'Oversett beskrivelser av Drupal-moduler til målspråket. Bidra til å gjøre økosystemet mer tilgjengelig.';

  @override
  String get dashHeaderSubtitleShort =>
      'Oversett beskrivelser av Drupal-moduler.';

  @override
  String get dashLastLabel => 'Sist: ';

  @override
  String get dashContinue => 'Fortsett';

  @override
  String get dashContinueShort => 'Fortsett';

  @override
  String get dashUnignoreAllButtonLong => 'Opphev ignorering av alle moduler';

  @override
  String get dashQuickUpdateTooltip => 'Hurtigoppdatering (siste 7 dager)';

  @override
  String get dashFullSyncTooltip =>
      'Full databasesynkronisering fra Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Last inn én enkelt modul manuelt fra Drupal.org';

  @override
  String get dashQuickShort => 'Hurtig';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Funnet: ';

  @override
  String get dashModulesSuffix => ' moduler';

  @override
  String dashPerPage(int count) {
    return '$count per side';
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
  String get dashNextPage => 'Neste side';

  @override
  String get dashLastPage => 'Siste side';

  @override
  String dashPageOf(int page, int total) {
    return 'Side $page av $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (f.eks. pathauto)';

  @override
  String get dashAddButton => 'Legg til';

  @override
  String get dashAddModuleManually => 'Legg til modul manuelt';

  @override
  String get dashAddModuleSubtitle =>
      'Last direkte inn fra Drupal.org basert på machine name.';

  @override
  String get dashAddModuleShort => 'Legg til modul';

  @override
  String get dashNoProjectsFound => 'Ingen prosjekter funnet.';

  @override
  String get dashFilterAll => 'Alle prosjekter';

  @override
  String get dashFilterMissing => 'Manglende oversettelser';

  @override
  String get dashFilterReview => 'Gjennomgangskø';

  @override
  String get dashFilterTranslated => 'Oversatte prosjekter';

  @override
  String get dashFilterReleased => 'Publiserte prosjekter';

  @override
  String get dashBulkDialogIntro =>
      'Oversett automatisk flere moduler fra det valgte filteret med Google Gemini.';

  @override
  String get dashActiveFilter => 'Aktivt filter';

  @override
  String get dashModuleCount => 'Antall moduler';

  @override
  String dashModulesCountItem(int count) {
    return '$count moduler';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioriter Drupal 12-moduler';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Oversetter først moduler uten Drupal 12-støtte';

  @override
  String get dashTotalModules => 'Totalt antall moduler';

  @override
  String get dashInputTokensEst => 'Input-tokens (est.)';

  @override
  String get dashOutputTokensEst => 'Output-tokens (est.)';

  @override
  String get dashBulkFootnote =>
      '* Oversettelsen utføres i ressurseffektive batcher for å unngå tidsavbrudd.';

  @override
  String get dashStartBulkTranslation => 'Start massoversettelse';

  @override
  String dashStaleLoadError(String error) {
    return 'Feil ved lasting av utdaterte moduler: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Ingen utdaterte moduler funnet — alt er oppdatert! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Oversett utdaterte moduler på nytt';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Alle oversettelser der den engelske kilden er endret siden forrige oversettelse, blir automatisk oversatt på nytt med Google Gemini. Du trenger ikke åpne hver modul manuelt.';

  @override
  String get dashOutdatedModules => 'Utdaterte moduler';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Oversettelsen erstatter eksisterende tekst og tilbakestiller is_reviewed. Utføres i batcher på 4 moduler.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Oversett alle $count moduler på nytt';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Oversetter utdaterte moduler på nytt …';

  @override
  String get dashFetchingProjects => 'Henter prosjekter fra serveren …';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed av $total moduler behandlet';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Fant ingen oversettbare prosjekter for dette filteret.';

  @override
  String get dashStartingTranslation => 'Starter oversettelse …';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Oversetter modul $start–$end av $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end av $total moduler fullført.';
  }

  @override
  String get dashTranslationCompleted => 'Oversettelsen ble fullført! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Massoversettelse av $count moduler fullført! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Feil ved massoversettelse: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Alle $count moduler er oversatt på nytt! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count utdaterte moduler er oversatt på nytt! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Feil under ny oversettelse: $error';
  }

  @override
  String get filterAllShort => 'Alle';

  @override
  String get filterMissing => 'Mangler';

  @override
  String get filterTranslated => 'Oversatt';

  @override
  String get filterReviewQueue => 'Gjennomgangskø';

  @override
  String get filterReleased => 'Publisert';

  @override
  String get filterOutdated => 'Utdatert';

  @override
  String get filterPriority => 'Prioritet';

  @override
  String get filterIgnored => 'Ignorert';

  @override
  String get commonEdit => 'Rediger';

  @override
  String get commonReset => 'Tilbakestill';

  @override
  String get commonRefresh => 'Oppdater';

  @override
  String commonErrorPrefix(String error) {
    return 'Feil: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Tilbakestille alle publiserte oversettelser?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Alle oversettelser merket som publisert for $langcode blir tilbakestilt til gjennomgangsstatus. Dette kan ikke angres.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count oversettelser tilbakestilt til gjennomgangsstatus.';
  }

  @override
  String get reviewPipelineTitle => 'Gjennomgangspipeline';

  @override
  String get reviewPipelineSubtitle =>
      'Menneskelig kvalitetssikring for AI-oversettelser';

  @override
  String get reviewSearchHint => 'Søk i prosjekter...';

  @override
  String get reviewResetPublished => 'Tilbakestill publiserte';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultater: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Venter: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Ingen prosjekter venter på gjennomgang.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Alle oversettelser er allerede verifisert, eller det finnes ingen i denne språkkonteksten.';

  @override
  String get reviewNoSummary => 'Ingen sammendrag.';

  @override
  String get reviewStartAudit => 'START GJENNOMGANG';

  @override
  String get reviewHtmlSourceShort => 'HTML-kilde';

  @override
  String get reviewCopySource => 'Kopier kilde';

  @override
  String get reviewModuleDetails => 'Moduldetaljer';

  @override
  String get reviewOriginalTitle => 'Opprinnelig tittel';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org-prosjekt';

  @override
  String get reviewSuggestions => 'Forslag';

  @override
  String get reviewNoSuggestions => 'Ingen forslag tilgjengelig.';

  @override
  String get reviewApply => 'Bruk';

  @override
  String get reviewNoChanges => 'Ingen endringer';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (før korrigering)';

  @override
  String get reviewCorrectedCurrentVersion => 'Korrigert (gjeldende versjon)';

  @override
  String get reviewBaseOriginal => 'Grunnlag (original)';

  @override
  String get reviewYourCorrection => 'Din korrigering';

  @override
  String get reviewChangesVisual => 'Se gjennom endringene dine (visuelt)';

  @override
  String get commonSkip => 'Hopp over';

  @override
  String get commonIgnore => 'Ignorer';

  @override
  String get reviewEmptyProjectTitle => 'Tomt prosjekt';

  @override
  String get reviewEmptyProjectBody =>
      'Dette prosjektet er tomt (ingen tittel, sammendrag eller innhold) og kan ikke godkjennes. Hopp over det.';

  @override
  String get reviewApprovedSuccess => 'Oversettelsen er godkjent! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Godkjenning av \"$machine\" mislyktes — prøv på nytt.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Ignorering opphevet. Modulen er aktiv igjen!';

  @override
  String get reviewActionFailed => 'Handlingen mislyktes.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorer modul?';

  @override
  String get reviewIgnoreModuleBody =>
      'Denne modulen blir permanent skjult fra alle lister. Du vil ikke lenger bli sittende fast på den.';

  @override
  String get reviewModulePermanentlyIgnored => 'Modulen er permanent ignorert.';

  @override
  String get reviewIgnoreFailed => 'Kunne ikke ignorere modulen.';

  @override
  String get reviewSuggestionSaved => 'Forslagsutkast lagret! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'Kunne ikke lagre forslagsutkastet.';

  @override
  String get reviewSuggestionDeleted => 'Forslaget er slettet.';

  @override
  String get reviewDeleteFailed => 'Sletting mislyktes.';

  @override
  String get reviewSuggestionApplied => 'Forslaget er brukt.';

  @override
  String get reviewPreparingData => 'Forbereder gjennomgangsdata...';

  @override
  String get reviewDirectEdit => 'Direkte redigering';

  @override
  String get reviewLivePreview => 'Live forhåndsvisning';

  @override
  String get reviewCompareWith => 'Sammenlign med:';

  @override
  String get reviewProductionVersion => 'Produksjonsversjon';

  @override
  String get reviewEditorialReview => 'Redaksjonell gjennomgang';

  @override
  String get reviewOpenQueue => 'Åpne gjennomgangskø';

  @override
  String get reviewCopyPromptShort => 'Kopier prompt';

  @override
  String get reviewUnignoreShort => 'Opphev ignorering';

  @override
  String get reviewApproveButton => 'GODKJENN';

  @override
  String get reviewHideDetails => 'Skjul detaljer';

  @override
  String get reviewDetailsAndEnglishSource => 'Detaljer og engelsk kilde';

  @override
  String reviewPendingCountShort(int count) {
    return '$count venter';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Gjennomgår $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Sammenlign oversettelse med engelsk kilde';

  @override
  String get reviewTranslationLabel => 'Oversettelse';

  @override
  String get reviewComparisonTitle => 'Sammenligning';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Kopier kildetekst + oversettelsesprompt til utklippstavlen';

  @override
  String get reviewUnignoreCaps => 'OPPHEV IGNORERING';

  @override
  String get reviewIgnoreCaps => 'IGNORER';

  @override
  String get reviewSkipShortcut => 'HOPP OVER (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Redaksjonell gjennomgang';

  @override
  String get reviewUnignoreTablet => 'OPPHEV IGNORERING';

  @override
  String get reviewApproveForProduction =>
      'GODKJENN FOR PRODUKSJON (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Direkte finpussing';

  @override
  String get reviewTitleField => 'Tittel';

  @override
  String get reviewSummaryField => 'Sammendrag';

  @override
  String get reviewBodyField => 'Innhold';

  @override
  String get reviewSaveShortcut => 'LAGRE (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Live forhåndsvisning (rendering)';

  @override
  String get reviewVoiceFemale => 'Kvinne';

  @override
  String get reviewVoiceMale => 'Mann';

  @override
  String get reviewStopListening => 'Stopp';

  @override
  String get reviewListen => 'Lytt';

  @override
  String get reviewAutopTooltip => 'Autoformater avsnitt (linjeskift → <p>)';

  @override
  String get reviewSourceCodeShort => 'KILDE';

  @override
  String get reviewNoParagraphChange =>
      'Teksten inneholder allerede <p>-tagger — ingen endring';

  @override
  String get reviewParagraphsFormatted => 'Avsnitt formatert ¶';

  @override
  String get commonRetry => 'Prøv på nytt';

  @override
  String categoriesLoadError(String error) {
    return 'Kunne ikke laste inn kategorier: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategoriene ble lagret.';

  @override
  String get categoriesSaveFailed => 'Kunne ikke lagre oversettelser.';

  @override
  String get categoriesFileEmpty => 'Filen er tom.';

  @override
  String get categoriesInvalidJson => 'Ugyldig JSON-format.';

  @override
  String get categoriesNoValidUuids =>
      'Fant ingen gyldige UUID-oppføringer i filen.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count kategorier importert fra fil.';
  }

  @override
  String get categoriesTitle => 'Kategorier';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Oversetter for: $lang';
  }

  @override
  String get categoriesImportJson => 'Importer JSON';

  @override
  String get categoriesSaving => 'Lagrer...';

  @override
  String get categoriesSaveAll => 'Lagre alt';

  @override
  String get categoriesLoading => 'Laster inn kategorier...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Oversettelse ($code)';
  }

  @override
  String get categoriesNoneFound => 'Ingen kategorier funnet.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Oversett \"$name\" ...';
  }

  @override
  String get loginPhotoBy => 'Foto av ';

  @override
  String get loginPhotoOn => ' på ';

  @override
  String get loginPleaseSignIn => 'Logg inn';

  @override
  String get loginUsername => 'Brukernavn';

  @override
  String get loginPassword => 'Passord';

  @override
  String get loginRememberMe => 'Husk meg';

  @override
  String get loginSignIn => 'LOGG INN';

  @override
  String get loginNoAccount => 'Har du ikke konto ennå? ';

  @override
  String get loginRegisterNow => 'Registrer deg nå';

  @override
  String get commonBack => 'Tilbake';

  @override
  String get commonNext => 'Neste';

  @override
  String get registerFillRequired => 'Fyll ut alle obligatoriske felt.';

  @override
  String get registerPasswordMismatch => 'Passordene stemmer ikke overens.';

  @override
  String get registerPasswordTooShort =>
      'Passordet må være minst 8 tegn langt.';

  @override
  String get registerSelectLanguage => 'Velg minst ett språk.';

  @override
  String get registerFailed => 'Registreringen mislyktes.';

  @override
  String get registerHeaderTitle => 'REGISTRERING';

  @override
  String get registerStepAccount => 'Konto';

  @override
  String get registerStepRole => 'Rolle';

  @override
  String get registerStepLanguages => 'Språk';

  @override
  String get registerStepApiKeys => 'API-nøkler';

  @override
  String get registerYourAccount => 'Din konto';

  @override
  String get registerAvatarOptional => 'Avatar (valgfritt)';

  @override
  String get registerUsernameRequired => 'Brukernavn *';

  @override
  String get registerEmailRequired => 'E-postadresse *';

  @override
  String get registerPasswordRequired => 'Passord *';

  @override
  String get registerPasswordRepeat => 'Gjenta passord *';

  @override
  String get registerYourRole => 'Din rolle';

  @override
  String get registerRoleExplanation =>
      'Oversettere kan oversette tekster, men har ikke tilgang til gjennomgangskøen. Godkjennere sjekker og godkjenner oversatt innhold.';

  @override
  String get registerRoleTranslator => 'Oversetter';

  @override
  String get registerRoleTranslatorDesc => 'Opprett og rediger oversettelser.';

  @override
  String get registerRoleReviewer => 'Godkjenner';

  @override
  String get registerRoleReviewerDesc => 'Gjennomgå og godkjenn oversettelser.';

  @override
  String get registerTargetLanguages => 'Målspråk';

  @override
  String get registerLanguagesExplanation =>
      'Velg alle språkene du ønsker å jobbe med.';

  @override
  String get registerNoLanguagesAvailable => 'Ingen språk tilgjengelig.';

  @override
  String get registerApiKeysTitle => 'API-nøkler';

  @override
  String get registerApiKeysExplanation =>
      'Skriv inn dine egne API-nøkler. Hver bruker bruker utelukkende sine egne nøkler. Du kan også legge dem til senere i profilen din.';

  @override
  String get registerKeysEncryptedNote =>
      'Nøklene lagres kryptert og deles aldri med andre brukere.';

  @override
  String get registerOptionalSuffix => ' (valgfritt)';

  @override
  String get registerSuccessTitle => 'Registreringen var vellykket!';

  @override
  String get registerSuccessBody =>
      'Kontoen din er opprettet og venter på godkjenning fra en administrator. Du får beskjed når tilgangen din er aktivert.';

  @override
  String get registerGoToLogin => 'Gå til innlogging';

  @override
  String get registerSubmit => 'Registrer';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto av $name på Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profilen ble oppdatert!';

  @override
  String get profileUpdateFailed => 'Oppdateringen mislyktes.';

  @override
  String profileSaveError(String error) {
    return 'Feil ved lagring: $error';
  }

  @override
  String get profilePasswordMismatch => 'Passordene stemmer ikke overens!';

  @override
  String get profilePasswordChangeSuccess => 'Passordet ble endret!';

  @override
  String get profilePasswordChangeError =>
      'Feil ved endring av passord: gjeldende passord er feil.';

  @override
  String get profileAvatarUploadSuccess => 'Avataren ble lastet opp!';

  @override
  String get profileAvatarUploadError => 'Feil ved opplasting av avatar.';

  @override
  String get profileTitle => 'Profil og innstillinger';

  @override
  String get profileSubtitle =>
      'Administrer brukerprofilen din, oversettelses-API-ene dine (Gemini og DeepL) og kontosikkerheten.';

  @override
  String get profileRoleUser => 'Bruker';

  @override
  String get profileNoEmail => 'Ingen e-postadresse oppgitt';

  @override
  String get profileTabDetails => 'Profildetaljer';

  @override
  String get profileTabGemini => 'AI-oversettelse (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL-oversettelse';

  @override
  String get profileTabPassword => 'Endre passord';

  @override
  String get profileSectionInfo => 'PROFILINFORMASJON';

  @override
  String get profileFieldName => 'Navn';

  @override
  String get profileFieldNameHint => 'Fullt navn';

  @override
  String get profileFieldEmail => 'E-postadresse';

  @override
  String get profileFieldEmailHint => 'E-postadressen din';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT-INNSTILLINGER';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API-nøkkel';

  @override
  String get profileFieldGeminiKeyHint =>
      'Skriv inn gemini-3.1-flash API-nøkkelen din';

  @override
  String get profileFieldAiPrompt => 'Egendefinert AI-prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Valgfritt: tilpass systempromten for Gemini...';

  @override
  String get profileSectionDeepl => 'DEEPL-OVERSETTELSESINNSTILLINGER';

  @override
  String get profileDeeplDescription =>
      'DeepL tilbyr maskinoversettelse av høy kvalitet med bevaring av HTML-tagger. Gratiskontoer (500 000 tegn/måned) får en nøkkel med suffikset \":fx\".';

  @override
  String get profileFieldDeeplKey => 'DeepL API-nøkkel';

  @override
  String get profileFieldDeeplKeyHint =>
      'f.eks. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Gratisnøkler slutter på \":fx\" og bruker api-free.deepl.com. Pro-nøkler bruker api.deepl.com. Skillet gjøres automatisk.';

  @override
  String get profileSectionSecurity => 'KONTOSIKKERHET';

  @override
  String get profileFieldCurrentPassword => 'Gjeldende passord';

  @override
  String get profileFieldCurrentPasswordHint => 'Skriv inn gjeldende passord';

  @override
  String get profileFieldNewPassword => 'Nytt passord';

  @override
  String get profileFieldNewPasswordHint => 'Minst 6 tegn';

  @override
  String get profileFieldConfirmPassword => 'Bekreft nytt passord';

  @override
  String get profileFieldConfirmPasswordHint => 'Gjenta passord';

  @override
  String get profileChangePasswordButton => 'Endre passord';

  @override
  String get commonDelete => 'Slett';

  @override
  String get settingsRegistrationUpdated =>
      'Registreringsinnstillingen ble oppdatert';

  @override
  String get settingsUpdateFailed => 'Oppdateringen mislyktes.';

  @override
  String get settingsUserApproved => 'Brukeren er godkjent!';

  @override
  String get settingsAccountDeactivated => 'Kontoen er deaktivert.';

  @override
  String get settingsUserDeleted => 'Brukeren er slettet.';

  @override
  String get settingsActionFailed => 'Handlingen mislyktes.';

  @override
  String get settingsDeleteAccountTitle => 'Slette kontoen?';

  @override
  String get settingsDeactivateAccountTitle => 'Deaktivere kontoen?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Kontoen \"$username\" blir permanent slettet. Fortsette?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Kontoen \"$username\" blir låst. Brukeren kan ikke lenger logge inn, men kontoen beholdes.';
  }

  @override
  String get settingsDeactivate => 'Deaktiver';

  @override
  String settingsSyncSuccess(String count) {
    return '$count oversettelser synkronisert!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Synkroniseringsfeil: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioriterte moduler synkronisert!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Feil ved synkronisering av prioriteringsliste: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Sikkerhetskopiering fullført: $count filer behandlet.';
  }

  @override
  String get settingsUploadFailed => 'Opplasting mislyktes.';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get settingsSystemConfig => 'SYSTEMKONFIGURASJON';

  @override
  String get settingsRegistration => 'Registrering';

  @override
  String get settingsRegistrationHint =>
      'Slå av/på synligheten til det globale registreringsskjemaet.';

  @override
  String get settingsPendingUsers => 'Ventende brukere';

  @override
  String get settingsNoNewRequests => 'Ingen nye forespørsler.';

  @override
  String get settingsWantsReviewer => 'Vil bli godkjenner';

  @override
  String get settingsAssignRole => 'Tildel rolle';

  @override
  String get settingsRoleTranslator => 'Oversetter';

  @override
  String get settingsRoleReviewer => 'Godkjenner';

  @override
  String get settingsApprove => 'Godkjenn';

  @override
  String get settingsReject => 'Avvis';

  @override
  String get settingsActiveUsers => 'Aktive brukere';

  @override
  String get settingsNoActiveUsers => 'Ingen aktive brukere.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deaktiver';

  @override
  String get settingsDeleteAccountAction => 'Slett konto';

  @override
  String get settingsAppearance => 'Utseende';

  @override
  String get settingsThemePearl => 'LYS (PEARL)';

  @override
  String get settingsThemeDark => 'MØRK';

  @override
  String get settingsThemeGlassy => 'GLASSAKTIG';

  @override
  String get settingsThemeNature => 'NATUR';

  @override
  String get settingsThemeLiquid => 'FLYTENDE';

  @override
  String get settingsThemeStage => 'SCENE';

  @override
  String get settingsTypography => 'Typografi';

  @override
  String get settingsFontHint => 'Endre skrifttypefamilien i grensesnittet.';

  @override
  String get settingsFontClean => 'Ren';

  @override
  String get settingsFontFuturistic => 'Futuristisk';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Arbeidsflyt og moro';

  @override
  String get settingsConfettiTitle => 'Suksessfeiring (konfetti)';

  @override
  String get settingsConfettiHint =>
      'Viser en liten animasjon når lagring lykkes.';

  @override
  String get settingsLargeUiTitle => 'Bedre lesbarhet (stor skrift)';

  @override
  String get settingsLargeUiHint =>
      'Øker størrelsen på skrift og merker for bedre lesbarhet.';

  @override
  String get settingsAutoPTitle => 'Automatisk avsnittsformatering (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Pakker automatisk vanlig tekst inn i <p>-avsnitt når en modul lastes inn i gjennomgangsvisningen. Tilsvarer å klikke på ¶-knappen manuelt.';

  @override
  String get settingsDatabaseSync => 'Databasesynkronisering';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synkroniserer databaseoppføringer med JSON-oversettelsesfiler.';

  @override
  String get settingsDatabaseSyncHint =>
      'Synkroniserer interne databaseoppføringer med oversettelses-JSON-er på serveren.';

  @override
  String get settingsSyncing => 'Synkroniserer...';

  @override
  String get settingsSyncNow => 'Synkroniser nå';

  @override
  String get settingsSyncD11List => 'Synkroniser D11-liste';

  @override
  String get settingsUploadBackup => 'Last opp sikkerhetskopi (.zip)';

  @override
  String get settingsSelectZipFile => 'Velg ZIP-fil';

  @override
  String get settingsUploading => 'Laster opp...';

  @override
  String get settingsErrorDiagnostics => 'Feildiagnostikk og systemlogger';

  @override
  String get settingsLogsCopied => 'Loggene er kopiert til utklippstavlen! 📋';

  @override
  String get settingsCopyLogs => 'Kopier logger';

  @override
  String get settingsLogsRotated => 'Loggene er arkivert og rotert! 📁';

  @override
  String get settingsRotate => 'Roter';

  @override
  String get settingsClear => 'Tøm';

  @override
  String get settingsLogLimit => 'Logggrense: ';

  @override
  String get settingsNoLogs => 'Ingen logger registrert';

  @override
  String get layoutMenu => 'Meny';

  @override
  String get layoutNavAnalytics => 'Analyse';

  @override
  String get layoutNavReviewQueue => 'Gjennomgangskø';

  @override
  String get layoutNavGlossary => 'Ordliste';

  @override
  String get layoutNavCategories => 'Kategorier';

  @override
  String get layoutNavHelp => 'Hjelp';

  @override
  String get layoutNavSettings => 'Innstillinger';

  @override
  String get layoutPhotoBy => 'Foto av ';

  @override
  String get layoutPhotoOn => ' på ';

  @override
  String get layoutEditProfile => 'Rediger profil';

  @override
  String get layoutLogout => 'Logg ut';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Lys';

  @override
  String get layoutThemeDark => 'Mørk';

  @override
  String get layoutThemeGlassy => 'Glassaktig';

  @override
  String get layoutThemeNature => 'Natur';

  @override
  String get layoutThemeLiquid => 'Flytende';

  @override
  String get layoutThemeStage => 'Scene';

  @override
  String get layoutTargetLanguage => 'MÅLSPRÅK';

  @override
  String get layoutDeeplUsage => 'DEEPL-BRUK';

  @override
  String get layoutUnavailable => 'Ikke tilgjengelig';

  @override
  String get layoutUnlimited => 'ubegrenset';

  @override
  String get layoutUsed => 'brukt';

  @override
  String get layoutTranslate => 'Oversett';

  @override
  String get analyticsSubtitle =>
      'Kompatibilitet, oversettelsesetterslep og ukentlige trender.';

  @override
  String get analyticsBacklog => 'Oversettelsesetterslep';

  @override
  String get analyticsMissing => 'Mangler';

  @override
  String get analyticsStale => 'Utdatert';

  @override
  String get analyticsInReview => 'Til gjennomgang';

  @override
  String get analyticsReleased => 'Publisert';

  @override
  String get analyticsTranslated => 'Oversatt';

  @override
  String get analyticsTotalModules => 'Totalt antall moduler';

  @override
  String get analyticsCompatByVersion => 'Kompatibilitet etter Drupal-versjon';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Språk: $lang · publisert / til gjennomgang / mangler';
  }

  @override
  String get analyticsLoadingCounts => 'Laster inn tellinger …';

  @override
  String get analyticsWindow => 'Tidsvindu:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks uker';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nye prosjektbeskrivelser per uke';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Merket som utdatert per uke ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count moduler';
  }

  @override
  String get analyticsReviewShort => 'Gjennomgang';

  @override
  String get analyticsNoDataInWindow => 'Ingen data i dette tidsvinduet.';

  @override
  String get analyticsAndMore => '… og mer';

  @override
  String glossaryLoadError(String error) {
    return 'Feil ved lasting: $error';
  }

  @override
  String get glossaryNewTerm => 'Opprett nytt begrep';

  @override
  String get glossaryEditTerm => 'Rediger begrep';

  @override
  String get glossaryFieldSourceWord =>
      'Kildeord (grunnform, slik det forekommer i teksten)';

  @override
  String get glossaryFieldSourceWordHint => 'f.eks. node';

  @override
  String get glossaryWordForms =>
      'Andre ordformer (flertall, genitiv, dativ …)';

  @override
  String get glossaryWordFormsHint =>
      'f.eks. content – trykk Enter for å legge til';

  @override
  String get glossaryAddForm => 'Legg til form';

  @override
  String get glossaryFieldPreferredWord => 'Foretrukket oversettelse';

  @override
  String get glossaryFieldPreferredWordHint => 'f.eks. content';

  @override
  String get glossaryFieldExplanation => 'Forklaring (vises i verktøytipset)';

  @override
  String get glossaryFieldExplanationHint =>
      'Hvorfor bør dette ordet oversettes annerledes?';

  @override
  String get glossaryCreate => 'Opprett';

  @override
  String get glossaryRequiredFields =>
      'Kildeord og foretrukket oversettelse er obligatorisk.';

  @override
  String get glossaryCreated => 'Begrepet er opprettet ✓';

  @override
  String get glossaryUpdated => 'Begrepet er oppdatert ✓';

  @override
  String glossaryError(String error) {
    return 'Feil: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Slette begrepet?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" blir permanent fjernet fra ordlisten.';
  }

  @override
  String get glossaryDeleted => 'Begrepet er slettet.';

  @override
  String get glossaryTitle => 'Oversettelsesordliste';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Språk: $lang · $count oppføringer';
  }

  @override
  String get glossaryNewShort => 'Ny';

  @override
  String get glossaryCreateTerm => 'Opprett begrep';

  @override
  String get glossaryInfoBanner =>
      'Ord fra denne ordlisten blir uthevet i gjennomgangsredigeringen. Et verktøytips forklarer ved museover hvorfor en annen oversettelse passer bedre.';

  @override
  String get glossaryNoEntries => 'Ingen oppføringer ennå.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klikk på \"Opprett begrep\" for å opprette den første oppføringen.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Ingen ordlisteoppføringer for dette språket ennå.';

  @override
  String get diffNoChanges => 'Ingen innholdsforskjeller oppdaget.';

  @override
  String get diffRemoved => 'Fjernet';

  @override
  String get diffAdded => 'Lagt til';

  @override
  String syncBarQuickSync(String count) {
    return 'Hurtigsynkronisering: $count endrede moduler …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Full synkronisering: $current / $total moduler';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Full synkronisering: $count moduler …';
  }
}
