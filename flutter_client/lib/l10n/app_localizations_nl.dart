// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Projectgegevens laden...';

  @override
  String editorLoadError(String error) {
    return 'Projectgegevens konden niet worden geladen: $error';
  }

  @override
  String get editorGeminiSuccess => 'Vertaling met Gemini geslaagd! ✨';

  @override
  String get editorUnknownError => 'Onbekende fout';

  @override
  String editorGeminiFailed(String detail) {
    return 'Vertaling met Gemini mislukt: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Voeg je Google AI-sleutel toe in je gebruikersprofiel (niet in de beheerdersinstellingen).';

  @override
  String get editorGeminiError =>
      'Fout tijdens vertalen met Gemini. Controleer je Google AI-sleutel in je profiel.';

  @override
  String get editorDeeplSuccess => 'Vertaling met DeepL geslaagd! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Vertaling met DeepL mislukt: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Fout tijdens vertalen met DeepL. Zorg ervoor dat je DeepL API-sleutel is ingesteld in je profiel.';

  @override
  String get editorDeeplInvalidKey =>
      'Ongeldige DeepL API-sleutel. Controleer deze in je profiel.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL-quotum is op. Controleer je abonnement.';

  @override
  String get editorReviewReset =>
      'Vertaling teruggezet naar beoordelingsstatus.';

  @override
  String editorResetError(String error) {
    return 'Terugzetten mislukt: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Module is teruggezet naar de actieve lijst.';

  @override
  String get editorUnignoreError =>
      'Negeren van de module kon niet worden opgeheven.';

  @override
  String get editorSaveSuccess =>
      'Vertaling opgeslagen — terug naar de beoordelingswachtrij.';

  @override
  String editorSaveError(String error) {
    return 'Opslaan mislukt: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'Geen openstaande projecten meer in de lijst.';

  @override
  String get editorChangesDiscarded =>
      'Wijzigingen verworpen, volgend project wordt geladen...';

  @override
  String get editorEnglishSourceApplied =>
      'Engels origineel toegepast — vertaal het nu.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Kon URL niet openen: $url';
  }

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonClose => 'Sluiten';

  @override
  String get editorCloseEnglishSource => 'Engelse bron sluiten';

  @override
  String get editorShowEnglishSource => 'Engelse bron tonen';

  @override
  String get editorUnignoreShortTooltip => 'Negeren opheffen';

  @override
  String get editorBackToReviewTooltip => 'Terugzetten naar beoordeling';

  @override
  String get editorAndNext => '& Volgende';

  @override
  String get editorBackToDashboard => 'Terug naar dashboard';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Vertalen naar $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count resterend';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Module terugzetten naar actieve lijst';

  @override
  String get editorUnignoreLabel => 'Negeren opheffen';

  @override
  String get editorUnpublishTooltip =>
      'Publicatie intrekken en terugzetten naar beoordeling';

  @override
  String get editorBackToReview => 'Terug naar beoordeling';

  @override
  String get editorSaveAndNext => 'Opslaan & volgende';

  @override
  String get editorEnglishSourceHeader => 'ENGELSE BRON';

  @override
  String get editorStaleTooltip => 'Uitleg tonen & Engelse tekst toepassen';

  @override
  String get editorStaleDetailsLabel => 'Verouderd — details';

  @override
  String get editorCopyPromptTooltip => 'Bron + vertaalprompt kopiëren';

  @override
  String get editorPromptCopied => 'Prompt gekopieerd naar klembord 📋';

  @override
  String get editorShowPreview => 'Voorbeeld tonen';

  @override
  String get editorShowHtmlSource => 'HTML-broncode tonen';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'SAMENVATTING:\n$summary\n\nINHOUD:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Samenvatting:';

  @override
  String get editorDescriptionLabelColon => 'Beschrijving:';

  @override
  String get editorStaleDialogTitle => 'Engelse bron is gewijzigd';

  @override
  String get editorStaleExplanation =>
      'De bestaande vertaling is gebaseerd op een verouderde Engelse brontekst. Sinds de laatste vertaling heeft de moduleonderhouder de Engelse tekst op Drupal.org gewijzigd — de inhoud van de bestaande vertaling is daardoor mogelijk niet meer juist of volledig.';

  @override
  String get editorStaleTip =>
      'Tip: klik op \"Engels origineel gebruiken\" om de huidige Engelse bron direct in de editor te laden. Je kunt deze vervolgens gebruiken als uitgangspunt voor een nieuwe vertaling. Het Engelse origineel is ook zichtbaar in het linkerpaneel.';

  @override
  String get editorEnglishSourceShort => 'Engelse bron';

  @override
  String get editorPreviousTranslation => 'Vorige vertaling';

  @override
  String get editorWhatChangedTitle => 'Wat is er gewijzigd?';

  @override
  String get editorShowDiff => 'Verschil tonen';

  @override
  String get editorUseEnglish => 'Engels origineel gebruiken';

  @override
  String get editorStaleBannerText =>
      'Engelse bron is gewijzigd — vertaling is verouderd';

  @override
  String get editorDetailsAndApply => 'Details & toepassen';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'VERTALING $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Bezig met vertalen...';

  @override
  String get editorShowEditor => 'Editor tonen';

  @override
  String get editorModuleTitleLabel => 'Moduletitel (Engels)';

  @override
  String get editorSummaryFieldLabel => 'Samenvatting';

  @override
  String get editorBodyFieldLabel => 'Inhoud';

  @override
  String get editorHtmlCleaned => 'HTML opgeschoond';

  @override
  String get editorLivePreviewHeader => 'LIVE VOORBEELD';

  @override
  String get editorTidyHtmlTooltip =>
      'HTML opschonen (DeepL-artefacten verwijderen)';

  @override
  String get editorVisualMode => 'VISUEEL';

  @override
  String get editorSourceCodeMode => 'BRON (HTML)';

  @override
  String get commonCancel => 'Annuleren';

  @override
  String get costDialogTitle => 'Kostenraming (AI)';

  @override
  String get costDialogIntro =>
      'De geselecteerde module wordt vertaald met Google Gemini AI. Hier is de geschatte kostenverdeling voor deze bewerking:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Invoertokens';

  @override
  String get costRowOutputTokens => 'Uitvoertokens (schatting)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars tekens)';
  }

  @override
  String get costRowPriceInput => 'Prijs per 1M invoer';

  @override
  String get costRowPriceOutput => 'Prijs per 1M uitvoer';

  @override
  String get costRowTotalEstimate => 'Geschatte totale kosten';

  @override
  String get costDialogFootnote =>
      '* Let op: dit is een schatting op basis van het huidige Google pay-as-you-go-prijsmodel. Het werkelijke gebruik kan iets afwijken.';

  @override
  String get costDialogStartTranslation => 'Vertaling starten';

  @override
  String get htmlToolbarInsertLink => 'Link invoegen';

  @override
  String get htmlToolbarLinkTooltip => 'Link invoegen (a)';

  @override
  String get htmlToolbarInsert => 'Invoegen';

  @override
  String get htmlToolbarHeading2 => 'Kop 2';

  @override
  String get htmlToolbarHeading3 => 'Kop 3';

  @override
  String get htmlToolbarBold => 'Vet (strong)';

  @override
  String get htmlToolbarItalic => 'Cursief (em)';

  @override
  String get htmlToolbarBulletList => 'Opsommingslijst (ul)';

  @override
  String get htmlToolbarNumberedList => 'Genummerde lijst (ol)';

  @override
  String get htmlToolbarQuote => 'Citaat (blockquote)';

  @override
  String get screenshotAltsHeader => 'ALT-TEKST VOOR SCREENSHOTS';

  @override
  String get screenshotAltsIntro =>
      'Voer voor elke screenshot een beschrijvende alt-tekst in de doeltaal in.';

  @override
  String screenshotLabel(int number) {
    return 'Screenshot $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Voorbeeld niet beschikbaar';

  @override
  String get screenshotAltHint => 'Voer alt-tekst in de doeltaal in…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Negeren van alle modules opheffen?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Alle genegeerde modules worden teruggezet naar de actieve lijst en zijn weer beschikbaar voor vertaling.';

  @override
  String get dashUnignoreAllConfirmAction => 'Alles negeren opheffen';

  @override
  String get dashUnignoreAllSuccess =>
      'Het negeren van alle modules is opgeheven.';

  @override
  String get dashUnignoreAllError =>
      'Negeren van modules kon niet worden opgeheven.';

  @override
  String get dashUnignoreAllButton => 'Negeren van alle modules opheffen';

  @override
  String dashSyncStartError(String error) {
    return 'Synchronisatie kon niet worden gestart: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Snelle update (7 dagen) gestart ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Fout bij snelle update: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Succesvol gesynchroniseerd: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Module niet gevonden op Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'AI-bulkvertaling';

  @override
  String get dashHeaderTitle => 'Projectbeschrijvingen';

  @override
  String get dashHeaderSubtitle =>
      'Vertaal beschrijvingen van Drupal-modules naar de doeltaal. Help het ecosysteem toegankelijker te maken.';

  @override
  String get dashHeaderSubtitleShort =>
      'Vertaal beschrijvingen van Drupal-modules.';

  @override
  String get dashLastLabel => 'Laatst: ';

  @override
  String get dashContinue => 'Doorgaan';

  @override
  String get dashContinueShort => 'Doorgaan';

  @override
  String get dashUnignoreAllButtonLong => 'Negeren van alle modules opheffen';

  @override
  String get dashQuickUpdateTooltip => 'Snelle update (laatste 7 dagen)';

  @override
  String get dashFullSyncTooltip =>
      'Volledige databasesynchronisatie vanaf Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Handmatig één module laden vanaf Drupal.org';

  @override
  String get dashQuickShort => 'Snel';

  @override
  String get dashModuleShort => 'Module';

  @override
  String get dashFoundLabel => 'Gevonden: ';

  @override
  String get dashModulesSuffix => ' modules';

  @override
  String dashPerPage(int count) {
    return '$count per pagina';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / pagina';
  }

  @override
  String get dashFirstPage => 'Eerste pagina';

  @override
  String get dashPrevPage => 'Vorige pagina';

  @override
  String get dashNextPage => 'Volgende pagina';

  @override
  String get dashLastPage => 'Laatste pagina';

  @override
  String dashPageOf(int page, int total) {
    return 'Pagina $page van $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (bijv. pathauto)';

  @override
  String get dashAddButton => 'Toevoegen';

  @override
  String get dashAddModuleManually => 'Module handmatig toevoegen';

  @override
  String get dashAddModuleSubtitle =>
      'Direct laden vanaf Drupal.org op basis van de machine name.';

  @override
  String get dashAddModuleShort => 'Module toevoegen';

  @override
  String get dashNoProjectsFound => 'Geen projecten gevonden.';

  @override
  String get dashFilterAll => 'Alle projecten';

  @override
  String get dashFilterMissing => 'Ontbrekende vertalingen';

  @override
  String get dashFilterReview => 'Beoordelingswachtrij';

  @override
  String get dashFilterTranslated => 'Vertaalde projecten';

  @override
  String get dashFilterReleased => 'Gepubliceerde projecten';

  @override
  String get dashBulkDialogIntro =>
      'Vertaal automatisch meerdere modules uit het geselecteerde filter met Google Gemini.';

  @override
  String get dashActiveFilter => 'Actief filter';

  @override
  String get dashModuleCount => 'Aantal modules';

  @override
  String dashModulesCountItem(int count) {
    return '$count modules';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12-modules prioriteren';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Vertaalt eerst modules zonder Drupal 12-ondersteuning';

  @override
  String get dashTotalModules => 'Totaal aantal modules';

  @override
  String get dashInputTokensEst => 'Invoertokens (schatting)';

  @override
  String get dashOutputTokensEst => 'Uitvoertokens (schatting)';

  @override
  String get dashBulkFootnote =>
      '* Vertaling wordt uitgevoerd in resource-efficiënte batches om time-outs te voorkomen.';

  @override
  String get dashStartBulkTranslation => 'Bulkvertaling starten';

  @override
  String dashStaleLoadError(String error) {
    return 'Fout bij laden van verouderde modules: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Geen verouderde modules gevonden — alles is up-to-date! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Verouderde modules opnieuw vertalen';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Alle vertalingen waarvan de Engelse bron is gewijzigd sinds de laatste vertaling, worden automatisch opnieuw vertaald met Google Gemini. Je hoeft niet elke module handmatig te openen.';

  @override
  String get dashOutdatedModules => 'Verouderde modules';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Vertaling vervangt bestaande tekst en zet is_reviewed terug. Uitgevoerd in batches van 4 modules.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Alle $count modules opnieuw vertalen';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Verouderde modules worden opnieuw vertaald…';

  @override
  String get dashFetchingProjects =>
      'Projecten worden opgehaald van de server…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed van $total modules verwerkt';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Geen vertaalbare projecten gevonden voor dit filter.';

  @override
  String get dashStartingTranslation => 'Vertaling wordt gestart…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Module $start–$end van $total wordt vertaald …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end van $total modules voltooid.';
  }

  @override
  String get dashTranslationCompleted => 'Vertaling succesvol voltooid! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Bulkvertaling van $count modules geslaagd! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Fout bij bulkvertaling: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Alle $count modules zijn succesvol opnieuw vertaald! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count verouderde modules zijn succesvol opnieuw vertaald! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Fout tijdens opnieuw vertalen: $error';
  }

  @override
  String get filterAllShort => 'Alle';

  @override
  String get filterMissing => 'Ontbrekend';

  @override
  String get filterTranslated => 'Vertaald';

  @override
  String get filterReviewQueue => 'Beoordelingswachtrij';

  @override
  String get filterReleased => 'Gepubliceerd';

  @override
  String get filterOutdated => 'Verouderd';

  @override
  String get filterPriority => 'Prioriteit';

  @override
  String get filterIgnored => 'Genegeerd';

  @override
  String get commonEdit => 'Bewerken';

  @override
  String get commonReset => 'Resetten';

  @override
  String get commonRefresh => 'Vernieuwen';

  @override
  String commonErrorPrefix(String error) {
    return 'Fout: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Alle gepubliceerde vertalingen resetten?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Alle vertalingen die zijn gemarkeerd als gepubliceerd voor $langcode worden teruggezet naar de beoordelingsstatus. Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count vertalingen teruggezet naar beoordelingsstatus.';
  }

  @override
  String get reviewPipelineTitle => 'Beoordelingspipeline';

  @override
  String get reviewPipelineSubtitle =>
      'Menselijke kwaliteitscontrole voor AI-vertalingen';

  @override
  String get reviewSearchHint => 'Projecten zoeken...';

  @override
  String get reviewResetPublished => 'Gepubliceerde resetten';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultaten: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'In behandeling: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Geen projecten in afwachting van beoordeling.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Alle vertalingen zijn al geverifieerd of er bestaan er nog geen in deze taalcontext.';

  @override
  String get reviewNoSummary => 'Geen samenvatting.';

  @override
  String get reviewStartAudit => 'AUDIT STARTEN';

  @override
  String get reviewHtmlSourceShort => 'HTML-bron';

  @override
  String get reviewCopySource => 'Bron kopiëren';

  @override
  String get reviewModuleDetails => 'Moduledetails';

  @override
  String get reviewOriginalTitle => 'Oorspronkelijke titel';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org-project';

  @override
  String get reviewSuggestions => 'Suggesties';

  @override
  String get reviewNoSuggestions => 'Geen suggesties beschikbaar.';

  @override
  String get reviewApply => 'Toepassen';

  @override
  String get reviewNoChanges => 'Geen wijzigingen';

  @override
  String get reviewOriginalBeforeCorrection => 'Origineel (vóór correctie)';

  @override
  String get reviewCorrectedCurrentVersion => 'Gecorrigeerd (huidige versie)';

  @override
  String get reviewBaseOriginal => 'Basis (origineel)';

  @override
  String get reviewYourCorrection => 'Jouw correctie';

  @override
  String get reviewChangesVisual => 'Bekijk je wijzigingen (visueel)';

  @override
  String get commonSkip => 'Overslaan';

  @override
  String get commonIgnore => 'Negeren';

  @override
  String get reviewEmptyProjectTitle => 'Leeg project';

  @override
  String get reviewEmptyProjectBody =>
      'Dit project is leeg (geen titel, samenvatting of inhoud) en kan niet worden goedgekeurd. Sla het over.';

  @override
  String get reviewApprovedSuccess => 'Vertaling goedgekeurd! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Goedkeuring van \"$machine\" mislukt — probeer het opnieuw.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Niet meer genegeerd. Module is weer actief!';

  @override
  String get reviewActionFailed => 'Actie mislukt.';

  @override
  String get reviewIgnoreModuleTitle => 'Module negeren?';

  @override
  String get reviewIgnoreModuleBody =>
      'Deze module wordt permanent verborgen in alle lijsten. Je loopt er niet meer tegenaan.';

  @override
  String get reviewModulePermanentlyIgnored => 'Module permanent genegeerd.';

  @override
  String get reviewIgnoreFailed => 'Negeren van module mislukt.';

  @override
  String get reviewSuggestionSaved => 'Concept van suggestie opgeslagen! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Opslaan van conceptsuggestie mislukt.';

  @override
  String get reviewSuggestionDeleted => 'Suggestie verwijderd.';

  @override
  String get reviewDeleteFailed => 'Verwijderen mislukt.';

  @override
  String get reviewSuggestionApplied => 'Suggestie toegepast.';

  @override
  String get reviewPreparingData => 'Beoordelingsgegevens worden voorbereid...';

  @override
  String get reviewDirectEdit => 'Direct bewerken';

  @override
  String get reviewLivePreview => 'Live voorbeeld';

  @override
  String get reviewCompareWith => 'Vergelijken met:';

  @override
  String get reviewProductionVersion => 'Productieversie';

  @override
  String get reviewEditorialReview => 'Redactionele beoordeling';

  @override
  String get reviewOpenQueue => 'Beoordelingswachtrij openen';

  @override
  String get reviewCopyPromptShort => 'Prompt kopiëren';

  @override
  String get reviewUnignoreShort => 'Negeren opheffen';

  @override
  String get reviewApproveButton => 'GOEDKEUREN';

  @override
  String get reviewHideDetails => 'Details verbergen';

  @override
  String get reviewDetailsAndEnglishSource => 'Details & Engelse bron';

  @override
  String reviewPendingCountShort(int count) {
    return '$count in behandeling';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Bezig met beoordelen van $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Vertaling vergelijken met Engelse bron';

  @override
  String get reviewTranslationLabel => 'Vertaling';

  @override
  String get reviewComparisonTitle => 'Vergelijking';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Brontekst + vertaalprompt naar klembord kopiëren';

  @override
  String get reviewUnignoreCaps => 'NEGEREN OPHEFFEN';

  @override
  String get reviewIgnoreCaps => 'NEGEREN';

  @override
  String get reviewSkipShortcut => 'OVERSLAAN (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Redactionele beoordeling';

  @override
  String get reviewUnignoreTablet => 'NEGEREN OPHEFFEN';

  @override
  String get reviewApproveForProduction =>
      'GOEDKEUREN VOOR PRODUCTIE (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Directe verfijning';

  @override
  String get reviewTitleField => 'Titel';

  @override
  String get reviewSummaryField => 'Samenvatting';

  @override
  String get reviewBodyField => 'Inhoud';

  @override
  String get reviewSaveShortcut => 'OPSLAAN (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Live voorbeeld (rendering)';

  @override
  String get reviewVoiceFemale => 'Vrouw';

  @override
  String get reviewVoiceMale => 'Man';

  @override
  String get reviewStopListening => 'Stop';

  @override
  String get reviewListen => 'Beluisteren';

  @override
  String get reviewAutopTooltip =>
      'Alinea\'s automatisch opmaken (regeleinden → <p>)';

  @override
  String get reviewSourceCodeShort => 'BRON';

  @override
  String get reviewNoParagraphChange =>
      'Tekst bevat al <p>-tags — geen wijziging';

  @override
  String get reviewParagraphsFormatted => 'Alinea\'s opgemaakt ¶';

  @override
  String get commonRetry => 'Opnieuw proberen';

  @override
  String categoriesLoadError(String error) {
    return 'Categorieën konden niet worden geladen: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categorieën succesvol opgeslagen.';

  @override
  String get categoriesSaveFailed => 'Opslaan van vertalingen mislukt.';

  @override
  String get categoriesFileEmpty => 'Bestand is leeg.';

  @override
  String get categoriesInvalidJson => 'Ongeldig JSON-formaat.';

  @override
  String get categoriesNoValidUuids =>
      'Geen geldige UUID-vermeldingen gevonden in het bestand.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categorieën geïmporteerd uit bestand.';
  }

  @override
  String get categoriesTitle => 'Categorieën';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Vertalen voor: $lang';
  }

  @override
  String get categoriesImportJson => 'JSON importeren';

  @override
  String get categoriesSaving => 'Bezig met opslaan...';

  @override
  String get categoriesSaveAll => 'Alles opslaan';

  @override
  String get categoriesLoading => 'Categorieën laden...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Vertaling ($code)';
  }

  @override
  String get categoriesNoneFound => 'Geen categorieën gevonden.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Vertaal \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto door ';

  @override
  String get loginPhotoOn => ' op ';

  @override
  String get loginPleaseSignIn => 'Log in';

  @override
  String get loginUsername => 'Gebruikersnaam';

  @override
  String get loginPassword => 'Wachtwoord';

  @override
  String get loginRememberMe => 'Onthoud mij';

  @override
  String get loginSignIn => 'INLOGGEN';

  @override
  String get loginNoAccount => 'Nog geen account? ';

  @override
  String get loginRegisterNow => 'Nu registreren';

  @override
  String get commonBack => 'Terug';

  @override
  String get commonNext => 'Volgende';

  @override
  String get registerFillRequired => 'Vul alle verplichte velden in.';

  @override
  String get registerPasswordMismatch => 'Wachtwoorden komen niet overeen.';

  @override
  String get registerPasswordTooShort =>
      'Wachtwoord moet minimaal 8 tekens bevatten.';

  @override
  String get registerSelectLanguage => 'Selecteer ten minste één taal.';

  @override
  String get registerFailed => 'Registratie mislukt.';

  @override
  String get registerHeaderTitle => 'REGISTRATIE';

  @override
  String get registerStepAccount => 'Account';

  @override
  String get registerStepRole => 'Rol';

  @override
  String get registerStepLanguages => 'Talen';

  @override
  String get registerStepApiKeys => 'API-sleutels';

  @override
  String get registerYourAccount => 'Jouw account';

  @override
  String get registerAvatarOptional => 'Avatar (optioneel)';

  @override
  String get registerUsernameRequired => 'Gebruikersnaam *';

  @override
  String get registerEmailRequired => 'E-mailadres *';

  @override
  String get registerPasswordRequired => 'Wachtwoord *';

  @override
  String get registerPasswordRepeat => 'Herhaal wachtwoord *';

  @override
  String get registerYourRole => 'Jouw rol';

  @override
  String get registerRoleExplanation =>
      'Vertalers kunnen teksten vertalen, maar hebben geen toegang tot de beoordelingswachtrij. Reviewers controleren en keuren vertaalde inhoud goed.';

  @override
  String get registerRoleTranslator => 'Vertaler';

  @override
  String get registerRoleTranslatorDesc => 'Vertalingen maken en bewerken.';

  @override
  String get registerRoleReviewer => 'Reviewer';

  @override
  String get registerRoleReviewerDesc =>
      'Vertalingen beoordelen en goedkeuren.';

  @override
  String get registerTargetLanguages => 'Doeltalen';

  @override
  String get registerLanguagesExplanation =>
      'Kies alle talen waarmee je wilt werken.';

  @override
  String get registerNoLanguagesAvailable => 'Geen talen beschikbaar.';

  @override
  String get registerApiKeysTitle => 'API-sleutels';

  @override
  String get registerApiKeysExplanation =>
      'Voer je eigen API-sleutels in. Elke gebruiker gebruikt uitsluitend zijn eigen sleutels. Je kunt deze ook later in je profiel toevoegen.';

  @override
  String get registerKeysEncryptedNote =>
      'Sleutels worden versleuteld opgeslagen en nooit gedeeld met andere gebruikers.';

  @override
  String get registerOptionalSuffix => ' (optioneel)';

  @override
  String get registerSuccessTitle => 'Registratie geslaagd!';

  @override
  String get registerSuccessBody =>
      'Je account is aangemaakt en wacht op goedkeuring door een beheerder. Je ontvangt een melding zodra je toegang is geactiveerd.';

  @override
  String get registerGoToLogin => 'Ga naar inloggen';

  @override
  String get registerSubmit => 'Registreren';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto door $name op Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profiel succesvol bijgewerkt!';

  @override
  String get profileUpdateFailed => 'Bijwerken mislukt.';

  @override
  String profileSaveError(String error) {
    return 'Fout bij opslaan: $error';
  }

  @override
  String get profilePasswordMismatch => 'Wachtwoorden komen niet overeen!';

  @override
  String get profilePasswordChangeSuccess => 'Wachtwoord succesvol gewijzigd!';

  @override
  String get profilePasswordChangeError =>
      'Fout bij wijzigen van wachtwoord: huidig wachtwoord onjuist.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar succesvol geüpload!';

  @override
  String get profileAvatarUploadError => 'Fout bij uploaden van avatar.';

  @override
  String get profileTitle => 'Profiel & instellingen';

  @override
  String get profileSubtitle =>
      'Beheer je gebruikersprofiel, je vertaal-API\'s (Gemini & DeepL) en je accountbeveiliging.';

  @override
  String get profileRoleUser => 'Gebruiker';

  @override
  String get profileNoEmail => 'Geen e-mailadres opgegeven';

  @override
  String get profileTabDetails => 'Profielgegevens';

  @override
  String get profileTabGemini => 'AI-vertaling (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL-vertaling';

  @override
  String get profileTabPassword => 'Wachtwoord wijzigen';

  @override
  String get profileSectionInfo => 'PROFIELGEGEVENS';

  @override
  String get profileFieldName => 'Naam';

  @override
  String get profileFieldNameHint => 'Je volledige naam';

  @override
  String get profileFieldEmail => 'E-mailadres';

  @override
  String get profileFieldEmailHint => 'Je e-mailadres';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT-INSTELLINGEN';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API-sleutel';

  @override
  String get profileFieldGeminiKeyHint =>
      'Voer je gemini-3.1-flash API-sleutel in';

  @override
  String get profileFieldAiPrompt => 'Aangepaste AI-prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Optioneel: pas de systeemprompt voor Gemini aan...';

  @override
  String get profileSectionDeepl => 'DEEPL-VERTAALINSTELLINGEN';

  @override
  String get profileDeeplDescription =>
      'DeepL biedt hoogwaardige machinevertaling met behoud van HTML-tags. Gratis accounts (500.000 tekens/maand) krijgen een sleutel met de toevoeging \":fx\".';

  @override
  String get profileFieldDeeplKey => 'DeepL API-sleutel';

  @override
  String get profileFieldDeeplKeyHint =>
      'bijv. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Gratis sleutels eindigen op \":fx\" en gebruiken api-free.deepl.com. Pro-sleutels gebruiken api.deepl.com. Het onderscheid wordt automatisch gemaakt.';

  @override
  String get profileSectionSecurity => 'ACCOUNTBEVEILIGING';

  @override
  String get profileFieldCurrentPassword => 'Huidig wachtwoord';

  @override
  String get profileFieldCurrentPasswordHint => 'Voer je huidige wachtwoord in';

  @override
  String get profileFieldNewPassword => 'Nieuw wachtwoord';

  @override
  String get profileFieldNewPasswordHint => 'Minimaal 6 tekens';

  @override
  String get profileFieldConfirmPassword => 'Bevestig nieuw wachtwoord';

  @override
  String get profileFieldConfirmPasswordHint => 'Herhaal wachtwoord';

  @override
  String get profileChangePasswordButton => 'Wachtwoord wijzigen';

  @override
  String get commonDelete => 'Verwijderen';

  @override
  String get settingsRegistrationUpdated => 'Registratie-instelling bijgewerkt';

  @override
  String get settingsUpdateFailed => 'Bijwerken mislukt.';

  @override
  String get settingsUserApproved => 'Gebruiker goedgekeurd!';

  @override
  String get settingsAccountDeactivated => 'Account gedeactiveerd.';

  @override
  String get settingsUserDeleted => 'Gebruiker verwijderd.';

  @override
  String get settingsActionFailed => 'Actie mislukt.';

  @override
  String get settingsDeleteAccountTitle => 'Account verwijderen?';

  @override
  String get settingsDeactivateAccountTitle => 'Account deactiveren?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Het account \"$username\" wordt permanent verwijderd. Doorgaan?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Het account \"$username\" wordt vergrendeld. De gebruiker kan niet meer inloggen, maar het account blijft behouden.';
  }

  @override
  String get settingsDeactivate => 'Deactiveren';

  @override
  String settingsSyncSuccess(String count) {
    return '$count vertalingen gesynchroniseerd!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Synchronisatiefout: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioriteitsmodules gesynchroniseerd!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Fout bij synchroniseren van prioriteitenlijst: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Back-up geslaagd: $count bestanden verwerkt.';
  }

  @override
  String get settingsUploadFailed => 'Uploaden mislukt.';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsSystemConfig => 'SYSTEEMCONFIGURATIE';

  @override
  String get settingsRegistration => 'Registratie';

  @override
  String get settingsRegistrationHint =>
      'Schakel de zichtbaarheid van het algemene registratieformulier in of uit.';

  @override
  String get settingsPendingUsers => 'Gebruikers in behandeling';

  @override
  String get settingsNoNewRequests => 'Geen nieuwe aanvragen.';

  @override
  String get settingsWantsReviewer => 'Wil reviewer worden';

  @override
  String get settingsAssignRole => 'Rol toewijzen';

  @override
  String get settingsRoleTranslator => 'Vertaler';

  @override
  String get settingsRoleReviewer => 'Reviewer';

  @override
  String get settingsApprove => 'Goedkeuren';

  @override
  String get settingsReject => 'Afwijzen';

  @override
  String get settingsActiveUsers => 'Actieve gebruikers';

  @override
  String get settingsNoActiveUsers => 'Geen actieve gebruikers.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deactiveren';

  @override
  String get settingsDeleteAccountAction => 'Account verwijderen';

  @override
  String get settingsAppearance => 'Weergave';

  @override
  String get settingsThemePearl => 'LICHT (PEARL)';

  @override
  String get settingsThemeDark => 'DONKER';

  @override
  String get settingsThemeGlassy => 'GLASACHTIG';

  @override
  String get settingsThemeNature => 'NATUUR';

  @override
  String get settingsThemeLiquid => 'VLOEIBAAR';

  @override
  String get settingsThemeStage => 'PODIUM';

  @override
  String get settingsTypography => 'Typografie';

  @override
  String get settingsFontHint => 'Wijzig het lettertype van de interface.';

  @override
  String get settingsFontClean => 'Strak';

  @override
  String get settingsFontFuturistic => 'Futuristisch';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Workflow & plezier';

  @override
  String get settingsConfettiTitle => 'Succesviering (confetti)';

  @override
  String get settingsConfettiHint =>
      'Toont een kleine animatie bij succesvol opslaan.';

  @override
  String get settingsLargeUiTitle =>
      'Verbeterde leesbaarheid (groot lettertype)';

  @override
  String get settingsLargeUiHint =>
      'Vergroot lettertypen en badges voor betere leesbaarheid.';

  @override
  String get settingsAutoPTitle => 'Automatische alineaopmaak (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Verpakt platte tekst automatisch in <p>-alinea\'s wanneer een module wordt geladen in het beoordelingsscherm. Gelijk aan handmatig klikken op de ¶-knop.';

  @override
  String get settingsDatabaseSync => 'Database synchroniseren';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synchroniseert database-items met JSON-vertaalbestanden.';

  @override
  String get settingsDatabaseSyncHint =>
      'Synchroniseert interne database-items met vertaal-JSON\'s op de server.';

  @override
  String get settingsSyncing => 'Bezig met synchroniseren...';

  @override
  String get settingsSyncNow => 'Nu synchroniseren';

  @override
  String get settingsSyncD11List => 'D11-lijst synchroniseren';

  @override
  String get settingsUploadBackup => 'Back-up uploaden (.zip)';

  @override
  String get settingsSelectZipFile => 'ZIP-bestand selecteren';

  @override
  String get settingsUploading => 'Bezig met uploaden...';

  @override
  String get settingsErrorDiagnostics => 'Foutdiagnose & systeemlogboeken';

  @override
  String get settingsLogsCopied => 'Logboeken gekopieerd naar klembord! 📋';

  @override
  String get settingsCopyLogs => 'Logboeken kopiëren';

  @override
  String get settingsLogsRotated => 'Logboeken gearchiveerd en geroteerd! 📁';

  @override
  String get settingsRotate => 'Roteren';

  @override
  String get settingsClear => 'Wissen';

  @override
  String get settingsLogLimit => 'Loglimiet: ';

  @override
  String get settingsNoLogs => 'Geen logboeken vastgelegd';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Analyse';

  @override
  String get layoutNavReviewQueue => 'Beoordelingswachtrij';

  @override
  String get layoutNavGlossary => 'Woordenlijst';

  @override
  String get layoutNavCategories => 'Categorieën';

  @override
  String get layoutNavHelp => 'Help';

  @override
  String get layoutNavSettings => 'Instellingen';

  @override
  String get layoutPhotoBy => 'Foto door ';

  @override
  String get layoutPhotoOn => ' op ';

  @override
  String get layoutEditProfile => 'Profiel bewerken';

  @override
  String get layoutLogout => 'Uitloggen';

  @override
  String get layoutThemeLabel => 'THEMA';

  @override
  String get layoutThemePearl => 'Licht';

  @override
  String get layoutThemeDark => 'Donker';

  @override
  String get layoutThemeGlassy => 'Glasachtig';

  @override
  String get layoutThemeNature => 'Natuur';

  @override
  String get layoutThemeLiquid => 'Vloeibaar';

  @override
  String get layoutThemeStage => 'Podium';

  @override
  String get layoutTargetLanguage => 'DOELTAAL';

  @override
  String get layoutDeeplUsage => 'DEEPL-GEBRUIK';

  @override
  String get layoutUnavailable => 'Niet beschikbaar';

  @override
  String get layoutUnlimited => 'onbeperkt';

  @override
  String get layoutUsed => 'gebruikt';

  @override
  String get layoutTranslate => 'Vertalen';

  @override
  String get analyticsSubtitle =>
      'Compatibiliteit, vertaalachterstand en wekelijkse trends.';

  @override
  String get analyticsBacklog => 'Vertaalachterstand';

  @override
  String get analyticsMissing => 'Ontbrekend';

  @override
  String get analyticsStale => 'Verouderd';

  @override
  String get analyticsInReview => 'In beoordeling';

  @override
  String get analyticsReleased => 'Gepubliceerd';

  @override
  String get analyticsTranslated => 'Vertaald';

  @override
  String get analyticsTotalModules => 'Totaal aantal modules';

  @override
  String get analyticsCompatByVersion => 'Compatibiliteit per Drupal-versie';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Taal: $lang · gepubliceerd / in beoordeling / ontbrekend';
  }

  @override
  String get analyticsLoadingCounts => 'Aantallen worden geladen …';

  @override
  String get analyticsWindow => 'Periode:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks weken';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nieuwe projectbeschrijvingen per week';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Gemarkeerd als verouderd per week ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modules';
  }

  @override
  String get analyticsReviewShort => 'Beoordeling';

  @override
  String get analyticsNoDataInWindow => 'Geen gegevens in deze periode.';

  @override
  String get analyticsAndMore => '… en meer';

  @override
  String glossaryLoadError(String error) {
    return 'Fout bij laden: $error';
  }

  @override
  String get glossaryNewTerm => 'Nieuwe term maken';

  @override
  String get glossaryEditTerm => 'Term bewerken';

  @override
  String get glossaryFieldSourceWord =>
      'Bronwoord (basisvorm, zoals het in de tekst voorkomt)';

  @override
  String get glossaryFieldSourceWordHint => 'bijv. node';

  @override
  String get glossaryWordForms =>
      'Aanvullende woordvormen (meervoud, genitief, datief …)';

  @override
  String get glossaryWordFormsHint =>
      'bijv. content — druk op Enter om toe te voegen';

  @override
  String get glossaryAddForm => 'Vorm toevoegen';

  @override
  String get glossaryFieldPreferredWord => 'Voorkeursvertaling';

  @override
  String get glossaryFieldPreferredWordHint => 'bijv. content';

  @override
  String get glossaryFieldExplanation => 'Uitleg (weergegeven in de tooltip)';

  @override
  String get glossaryFieldExplanationHint =>
      'Waarom moet dit woord anders worden vertaald?';

  @override
  String get glossaryCreate => 'Maken';

  @override
  String get glossaryRequiredFields =>
      'Bronwoord en voorkeursvertaling zijn verplicht.';

  @override
  String get glossaryCreated => 'Term aangemaakt ✓';

  @override
  String get glossaryUpdated => 'Term bijgewerkt ✓';

  @override
  String glossaryError(String error) {
    return 'Fout: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Term verwijderen?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" wordt permanent verwijderd uit de woordenlijst.';
  }

  @override
  String get glossaryDeleted => 'Term verwijderd.';

  @override
  String get glossaryTitle => 'Vertaalwoordenlijst';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Taal: $lang · $count items';
  }

  @override
  String get glossaryNewShort => 'Nieuw';

  @override
  String get glossaryCreateTerm => 'Term maken';

  @override
  String get glossaryInfoBanner =>
      'Woorden uit deze woordenlijst worden gemarkeerd in de beoordelingseditor. Een tooltip legt bij het hoveren uit waarom een andere vertaling beter past.';

  @override
  String get glossaryNoEntries => 'Nog geen items.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klik op \"Term maken\" om het eerste item te maken.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Nog geen woordenlijstitems voor deze taal.';

  @override
  String get diffNoChanges => 'Geen inhoudelijke verschillen gedetecteerd.';

  @override
  String get diffRemoved => 'Verwijderd';

  @override
  String get diffAdded => 'Toegevoegd';

  @override
  String syncBarQuickSync(String count) {
    return 'Snelle synchronisatie: $count gewijzigde modules …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Volledige synchronisatie: $current / $total modules';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Volledige synchronisatie: $count modules …';
  }
}
