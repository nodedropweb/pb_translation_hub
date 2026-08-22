// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Projekti andmete laadimine...';

  @override
  String editorLoadError(String error) {
    return 'Projekti andmete laadimine ebaõnnestus: $error';
  }

  @override
  String get editorGeminiSuccess => 'Tõlge Geminiga õnnestus! ✨';

  @override
  String get editorUnknownError => 'Tundmatu viga';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini tõlge ebaõnnestus: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Lisa oma Google AI võti kasutajaprofiilis (mitte administreerimise seadetes).';

  @override
  String get editorGeminiError =>
      'Viga Gemini tõlkimisel. Kontrolli oma Google AI võtit profiilis.';

  @override
  String get editorDeeplSuccess => 'Tõlge DeepLiga õnnestus! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL tõlge ebaõnnestus: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Viga DeepL tõlkimisel. Veendu, et DeepL API võti on profiilis seadistatud.';

  @override
  String get editorDeeplInvalidKey =>
      'Kehtetu DeepL API võti. Kontrolli seda oma profiilis.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL kvoot on ammendatud. Kontrolli oma plaani.';

  @override
  String get editorReviewReset => 'Tõlge lähtestati läbivaatuse olekusse.';

  @override
  String editorResetError(String error) {
    return 'Lähtestamine ebaõnnestus: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Moodul on taastatud aktiivsete nimekirjas.';

  @override
  String get editorUnignoreError => 'Mooduli taastamine ebaõnnestus.';

  @override
  String get editorSaveSuccess =>
      'Tõlge salvestatud — tagasi läbivaatusjärjekorras.';

  @override
  String editorSaveError(String error) {
    return 'Salvestamine ebaõnnestus: $error';
  }

  @override
  String get editorNoMoreProjects => 'Nimekirjas pole enam avatud projekte.';

  @override
  String get editorChangesDiscarded =>
      'Muudatused tühistati, järgmise projekti laadimine...';

  @override
  String get editorEnglishSourceApplied =>
      'Ingliskeelne originaal on rakendatud — palun tõlgi see nüüd.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'URL-i ei õnnestunud avada: $url';
  }

  @override
  String get commonSave => 'Salvesta';

  @override
  String get commonClose => 'Sulge';

  @override
  String get editorCloseEnglishSource => 'Sulge ingliskeelne allikas';

  @override
  String get editorShowEnglishSource => 'Näita ingliskeelset allikat';

  @override
  String get editorUnignoreShortTooltip => 'Taasta moodul';

  @override
  String get editorBackToReviewTooltip => 'Sea uuesti läbivaatusele';

  @override
  String get editorAndNext => 'ja järgmine';

  @override
  String get editorBackToDashboard => 'Tagasi töölauale';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Tõlgitakse keelde $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return 'Jäänud: $count';
  }

  @override
  String get editorUnignoreLongTooltip => 'Taasta moodul aktiivsete nimekirjas';

  @override
  String get editorUnignoreLabel => 'Taasta';

  @override
  String get editorUnpublishTooltip =>
      'Tühista avaldamine ja sea uuesti läbivaatusele';

  @override
  String get editorBackToReview => 'Tagasi läbivaatusele';

  @override
  String get editorSaveAndNext => 'Salvesta ja jätka';

  @override
  String get editorEnglishSourceHeader => 'INGLISKEELNE ALLIKAS';

  @override
  String get editorStaleTooltip =>
      'Näita selgitust ja rakenda ingliskeelne tekst';

  @override
  String get editorStaleDetailsLabel => 'Aegunud — üksikasjad';

  @override
  String get editorCopyPromptTooltip => 'Kopeeri allikas + tõlkejuhis';

  @override
  String get editorPromptCopied => 'Juhis kopeeritud lõikelauale 📋';

  @override
  String get editorShowPreview => 'Näita eelvaadet';

  @override
  String get editorShowHtmlSource => 'Näita HTML-lähtekoodi';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'KOKKUVÕTE:\n$summary\n\nSISU:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Kokkuvõte:';

  @override
  String get editorDescriptionLabelColon => 'Kirjeldus:';

  @override
  String get editorStaleDialogTitle => 'Ingliskeelne allikas on muutunud';

  @override
  String get editorStaleExplanation =>
      'Olemasolev tõlge põhineb aegunud ingliskeelsel originaaltekstil. Alates viimasest tõlkest on mooduli haldaja muutnud ingliskeelset teksti Drupal.org-is — seega ei pruugi olemasoleva tõlke sisu enam olla täpne ega täielik.';

  @override
  String get editorStaleTip =>
      'Vihje: klõpsa nupul „Kasuta ingliskeelset originaali”, et laadida praegune ingliskeelne allikas otse redaktorisse. Seejärel saad seda kasutada uue tõlke lähtepunktina. Ingliskeelne originaal on näha ka vasakpoolsel paneelil.';

  @override
  String get editorEnglishSourceShort => 'Ingliskeelne allikas';

  @override
  String get editorPreviousTranslation => 'Eelmine tõlge';

  @override
  String get editorWhatChangedTitle => 'Mis muutus?';

  @override
  String get editorShowDiff => 'Näita erinevusi';

  @override
  String get editorUseEnglish => 'Kasuta ingliskeelset originaali';

  @override
  String get editorStaleBannerText =>
      'Ingliskeelne allikas on muutunud — tõlge on aegunud';

  @override
  String get editorDetailsAndApply => 'Üksikasjad ja rakendamine';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TÕLGE ($langName)';
  }

  @override
  String get editorTranslatingEllipsis => 'Tõlgitakse...';

  @override
  String get editorShowEditor => 'Näita redaktorit';

  @override
  String get editorModuleTitleLabel => 'Mooduli pealkiri (inglise keeles)';

  @override
  String get editorSummaryFieldLabel => 'Kokkuvõte';

  @override
  String get editorBodyFieldLabel => 'Sisu';

  @override
  String get editorHtmlCleaned => 'HTML puhastatud';

  @override
  String get editorLivePreviewHeader => 'REAALAJA EELVAADE';

  @override
  String get editorTidyHtmlTooltip =>
      'Puhasta HTML (eemalda DeepLi artefaktid)';

  @override
  String get editorVisualMode => 'VISUAALNE';

  @override
  String get editorSourceCodeMode => 'LÄHTEKOOD (HTML)';

  @override
  String get commonCancel => 'Tühista';

  @override
  String get costDialogTitle => 'Kuluprognoos (tehisintellekt)';

  @override
  String get costDialogIntro =>
      'Valitud moodul tõlgitakse Google Gemini AI abil. Siin on selle toimingu hinnanguline kulujaotus:';

  @override
  String get costRowModel => 'Mudel';

  @override
  String get costRowInputTokens => 'Sisendmärgid';

  @override
  String get costRowOutputTokens => 'Väljundmärgid (hinnang)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars tähemärki)';
  }

  @override
  String get costRowPriceInput => 'Hind 1M sisendi kohta';

  @override
  String get costRowPriceOutput => 'Hind 1M väljundi kohta';

  @override
  String get costRowTotalEstimate => 'Hinnanguline kogukulu';

  @override
  String get costDialogFootnote =>
      '* Märkus: see on hinnang, mis põhineb Google\'i praegusel kasutuspõhisel hinnamudelil. Tegelik kulu võib veidi erineda.';

  @override
  String get costDialogStartTranslation => 'Alusta tõlkimist';

  @override
  String get htmlToolbarInsertLink => 'Sisesta link';

  @override
  String get htmlToolbarLinkTooltip => 'Sisesta link (a)';

  @override
  String get htmlToolbarInsert => 'Sisesta';

  @override
  String get htmlToolbarHeading2 => 'Pealkiri 2';

  @override
  String get htmlToolbarHeading3 => 'Pealkiri 3';

  @override
  String get htmlToolbarBold => 'Rasvane (strong)';

  @override
  String get htmlToolbarItalic => 'Kaldkiri (em)';

  @override
  String get htmlToolbarBulletList => 'Punktloend (ul)';

  @override
  String get htmlToolbarNumberedList => 'Nummerdatud loend (ol)';

  @override
  String get htmlToolbarQuote => 'Tsitaat (blockquote)';

  @override
  String get screenshotAltsHeader => 'EKRAANIPILDI ALT-TEKST';

  @override
  String get screenshotAltsIntro =>
      'Sisesta iga ekraanipildi jaoks kirjeldav alt-tekst sihtkeeles.';

  @override
  String screenshotLabel(int number) {
    return 'Ekraanipilt $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Eelvaade pole saadaval';

  @override
  String get screenshotAltHint => 'Sisesta alt-tekst sihtkeeles…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Taastada kõik moodulid?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Kõik eiratud moodulid taastatakse aktiivsete nimekirjas ja need muutuvad taas tõlkimiseks saadavaks.';

  @override
  String get dashUnignoreAllConfirmAction => 'Taasta kõik';

  @override
  String get dashUnignoreAllSuccess => 'Kõik eiratud moodulid on taastatud.';

  @override
  String get dashUnignoreAllError => 'Moodulite taastamine ebaõnnestus.';

  @override
  String get dashUnignoreAllButton => 'Taasta kõik moodulid';

  @override
  String dashSyncStartError(String error) {
    return 'Sünkroonimist ei õnnestunud alustada: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Kiiruuendus (7 päeva) algas ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Kiiruuenduse viga: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Edukalt sünkroonitud: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Moodulit ei leitud Drupal.org-ist.';

  @override
  String get dashAiBulkTranslation => 'Tehisintellekti masstõlkimine';

  @override
  String get dashHeaderTitle => 'Projektide kirjeldused';

  @override
  String get dashHeaderSubtitle =>
      'Tõlgi Drupali moodulite kirjeldused sihtkeelde. Aita muuta ökosüsteemi kättesaadavamaks.';

  @override
  String get dashHeaderSubtitleShort => 'Tõlgi Drupali moodulite kirjeldused.';

  @override
  String get dashLastLabel => 'Viimane: ';

  @override
  String get dashContinue => 'Jätka';

  @override
  String get dashContinueShort => 'Jätka';

  @override
  String get dashUnignoreAllButtonLong => 'Taasta kõik moodulid';

  @override
  String get dashQuickUpdateTooltip => 'Kiiruuendus (viimased 7 päeva)';

  @override
  String get dashFullSyncTooltip =>
      'Täielik andmebaasi sünkroonimine Drupal.org-ist';

  @override
  String get dashManualLoadTooltip => 'Laadi käsitsi üks moodul Drupal.org-ist';

  @override
  String get dashQuickShort => 'Kiire';

  @override
  String get dashModuleShort => 'Moodul';

  @override
  String get dashFoundLabel => 'Leitud: ';

  @override
  String get dashModulesSuffix => ' moodulit';

  @override
  String dashPerPage(int count) {
    return '$count lehe kohta';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / lk';
  }

  @override
  String get dashFirstPage => 'Esimene lehekülg';

  @override
  String get dashPrevPage => 'Eelmine lehekülg';

  @override
  String get dashNextPage => 'Järgmine lehekülg';

  @override
  String get dashLastPage => 'Viimane lehekülg';

  @override
  String dashPageOf(int page, int total) {
    return 'Lehekülg $page / $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (nt pathauto)';

  @override
  String get dashAddButton => 'Lisa';

  @override
  String get dashAddModuleManually => 'Lisa moodul käsitsi';

  @override
  String get dashAddModuleSubtitle =>
      'Laadi otse Drupal.org-ist machine name\'i järgi.';

  @override
  String get dashAddModuleShort => 'Lisa moodul';

  @override
  String get dashNoProjectsFound => 'Projekte ei leitud.';

  @override
  String get dashFilterAll => 'Kõik projektid';

  @override
  String get dashFilterMissing => 'Puuduvad tõlked';

  @override
  String get dashFilterReview => 'Läbivaatusjärjekord';

  @override
  String get dashFilterTranslated => 'Tõlgitud projektid';

  @override
  String get dashFilterReleased => 'Avaldatud projektid';

  @override
  String get dashBulkDialogIntro =>
      'Tõlgi automaatselt mitu moodulit valitud filtrist, kasutades Google Geminit.';

  @override
  String get dashActiveFilter => 'Aktiivne filter';

  @override
  String get dashModuleCount => 'Moodulite arv';

  @override
  String dashModulesCountItem(int count) {
    return '$count moodulit';
  }

  @override
  String get dashPrioritizeD12Title => 'Sea prioriteediks Drupal 12 moodulid';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Tõlgib esmalt moodulid, millel puudub Drupal 12 tugi';

  @override
  String get dashTotalModules => 'Moodulite koguarv';

  @override
  String get dashInputTokensEst => 'Sisendmärgid (hinnang)';

  @override
  String get dashOutputTokensEst => 'Väljundmärgid (hinnang)';

  @override
  String get dashBulkFootnote =>
      '* Tõlkimine toimub ressursisäästlikes partiides, et vältida aegumist.';

  @override
  String get dashStartBulkTranslation => 'Alusta masstõlkimist';

  @override
  String dashStaleLoadError(String error) {
    return 'Viga aegunud moodulite laadimisel: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Aegunud mooduleid ei leitud — kõik on ajakohane! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Tõlgi aegunud moodulid uuesti';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Kõik tõlked, mille ingliskeelne allikas on pärast viimast tõlget muutunud, tõlgitakse automaatselt uuesti Google Gemini abil. Iga moodulit ei ole vaja käsitsi avada.';

  @override
  String get dashOutdatedModules => 'Aegunud moodulid';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Tõlkimine asendab olemasoleva teksti ja lähtestab is_reviewed. Toimub 4-moodulistes partiides.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Tõlgi uuesti kõik $count moodulit';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Aegunud moodulite uuesti tõlkimine…';

  @override
  String get dashFetchingProjects => 'Projektide toomine serverist…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return 'Töödeldud $processed / $total moodulit';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Selle filtri jaoks ei leitud tõlgitavaid projekte.';

  @override
  String get dashStartingTranslation => 'Tõlkimise alustamine…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Tõlgitakse moodulit $start–$end / $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return 'Valmis $end / $total moodulit.';
  }

  @override
  String get dashTranslationCompleted => 'Tõlkimine lõpetati edukalt! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '$count mooduli masstõlge õnnestus! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Masstõlke viga: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Kõik $count moodulit on edukalt uuesti tõlgitud! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count aegunud moodulit on edukalt uuesti tõlgitud! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Viga uuesti tõlkimisel: $error';
  }

  @override
  String get filterAllShort => 'Kõik';

  @override
  String get filterMissing => 'Puuduvad';

  @override
  String get filterTranslated => 'Tõlgitud';

  @override
  String get filterReviewQueue => 'Läbivaatusjärjekord';

  @override
  String get filterReleased => 'Avaldatud';

  @override
  String get filterOutdated => 'Aegunud';

  @override
  String get filterPriority => 'Prioriteet';

  @override
  String get filterIgnored => 'Eiratud';

  @override
  String get commonEdit => 'Muuda';

  @override
  String get commonReset => 'Lähtesta';

  @override
  String get commonRefresh => 'Värskenda';

  @override
  String commonErrorPrefix(String error) {
    return 'Viga: $error';
  }

  @override
  String get reviewResetAllConfirmTitle => 'Lähtestada kõik avaldatud tõlked?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Kõik keelele $langcode avaldatuks märgitud tõlked lähtestatakse läbivaatuse olekusse. Seda ei saa tagasi võtta.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count tõlget lähtestati läbivaatuse olekusse.';
  }

  @override
  String get reviewPipelineTitle => 'Läbivaatusprotsess';

  @override
  String get reviewPipelineSubtitle =>
      'Tehisintellekti tõlgete inimlik kvaliteedikontroll';

  @override
  String get reviewSearchHint => 'Otsi projekte...';

  @override
  String get reviewResetPublished => 'Lähtesta avaldatud';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Tulemused: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Ootel: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Läbivaatust ootavaid projekte pole.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Kõik tõlked on juba kontrollitud või neid pole selles keelekontekstis üldse olemas.';

  @override
  String get reviewNoSummary => 'Kokkuvõtet pole.';

  @override
  String get reviewStartAudit => 'ALUSTA KONTROLLI';

  @override
  String get reviewHtmlSourceShort => 'HTML-allikas';

  @override
  String get reviewCopySource => 'Kopeeri allikas';

  @override
  String get reviewModuleDetails => 'Mooduli üksikasjad';

  @override
  String get reviewOriginalTitle => 'Algne pealkiri';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org projekt';

  @override
  String get reviewSuggestions => 'Ettepanekud';

  @override
  String get reviewNoSuggestions => 'Ettepanekuid pole saadaval.';

  @override
  String get reviewApply => 'Rakenda';

  @override
  String get reviewNoChanges => 'Muudatusi pole';

  @override
  String get reviewOriginalBeforeCorrection => 'Originaal (enne parandust)';

  @override
  String get reviewCorrectedCurrentVersion => 'Parandatud (praegune versioon)';

  @override
  String get reviewBaseOriginal => 'Alusversioon (originaal)';

  @override
  String get reviewYourCorrection => 'Sinu parandus';

  @override
  String get reviewChangesVisual => 'Vaata oma muudatused üle (visuaalne)';

  @override
  String get commonSkip => 'Jäta vahele';

  @override
  String get commonIgnore => 'Eira';

  @override
  String get reviewEmptyProjectTitle => 'Tühi projekt';

  @override
  String get reviewEmptyProjectBody =>
      'See projekt on tühi (puudub pealkiri, kokkuvõte või sisu) ega ole kinnitatav. Palun jäta see vahele.';

  @override
  String get reviewApprovedSuccess => 'Tõlge kinnitatud! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ „$machine” kinnitamine ebaõnnestus — palun proovi uuesti.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Eiramine tühistatud. Moodul on taas aktiivne!';

  @override
  String get reviewActionFailed => 'Toiming ebaõnnestus.';

  @override
  String get reviewIgnoreModuleTitle => 'Eirata moodulit?';

  @override
  String get reviewIgnoreModuleBody =>
      'See moodul peidetakse jäädavalt kõikidest nimekirjadest. Sa ei satu selle otsa enam kunagi.';

  @override
  String get reviewModulePermanentlyIgnored => 'Moodul on jäädavalt eiratud.';

  @override
  String get reviewIgnoreFailed => 'Mooduli eiramine ebaõnnestus.';

  @override
  String get reviewSuggestionSaved => 'Ettepaneku mustand salvestatud! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Ettepaneku mustandi salvestamine ebaõnnestus.';

  @override
  String get reviewSuggestionDeleted => 'Ettepanek kustutatud.';

  @override
  String get reviewDeleteFailed => 'Kustutamine ebaõnnestus.';

  @override
  String get reviewSuggestionApplied => 'Ettepanek rakendatud.';

  @override
  String get reviewPreparingData => 'Läbivaatuse andmete ettevalmistamine...';

  @override
  String get reviewDirectEdit => 'Otsene muutmine';

  @override
  String get reviewLivePreview => 'Reaalajas eelvaade';

  @override
  String get reviewCompareWith => 'Võrdle:';

  @override
  String get reviewProductionVersion => 'Tootmisversioon';

  @override
  String get reviewEditorialReview => 'Toimetuslik läbivaatus';

  @override
  String get reviewOpenQueue => 'Ava läbivaatusjärjekord';

  @override
  String get reviewCopyPromptShort => 'Kopeeri juhis';

  @override
  String get reviewUnignoreShort => 'Taasta';

  @override
  String get reviewApproveButton => 'KINNITA';

  @override
  String get reviewHideDetails => 'Peida üksikasjad';

  @override
  String get reviewDetailsAndEnglishSource =>
      'Üksikasjad ja ingliskeelne allikas';

  @override
  String reviewPendingCountShort(int count) {
    return 'Ootel: $count';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Vaadatakse üle $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Võrdle tõlget ingliskeelse allikaga';

  @override
  String get reviewTranslationLabel => 'Tõlge';

  @override
  String get reviewComparisonTitle => 'Võrdlus';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Kopeeri lähtetekst + tõlkejuhis lõikelauale';

  @override
  String get reviewUnignoreCaps => 'TAASTA';

  @override
  String get reviewIgnoreCaps => 'EIRA';

  @override
  String get reviewSkipShortcut => 'JÄTA VAHELE (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Toimetuslik läbivaatus';

  @override
  String get reviewUnignoreTablet => 'TAASTA';

  @override
  String get reviewApproveForProduction => 'KINNITA TOOTMISESSE (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Otsene viimistlus';

  @override
  String get reviewTitleField => 'Pealkiri';

  @override
  String get reviewSummaryField => 'Kokkuvõte';

  @override
  String get reviewBodyField => 'Sisu';

  @override
  String get reviewSaveShortcut => 'SALVESTA (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Reaalajas eelvaade (renderdamine)';

  @override
  String get reviewVoiceFemale => 'Naishääl';

  @override
  String get reviewVoiceMale => 'Meeshääl';

  @override
  String get reviewStopListening => 'Peata';

  @override
  String get reviewListen => 'Kuula';

  @override
  String get reviewAutopTooltip =>
      'Lõikude automaatne vormindamine (reavahetused → <p>)';

  @override
  String get reviewSourceCodeShort => 'LÄHTEKOOD';

  @override
  String get reviewNoParagraphChange =>
      'Tekst sisaldab juba <p>-silte — muudatusi pole';

  @override
  String get reviewParagraphsFormatted => 'Lõigud vormindatud ¶';

  @override
  String get commonRetry => 'Proovi uuesti';

  @override
  String categoriesLoadError(String error) {
    return 'Kategooriate laadimine ebaõnnestus: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategooriad salvestatud edukalt.';

  @override
  String get categoriesSaveFailed => 'Tõlgete salvestamine ebaõnnestus.';

  @override
  String get categoriesFileEmpty => 'Fail on tühi.';

  @override
  String get categoriesInvalidJson => 'Vigane JSON-vorming.';

  @override
  String get categoriesNoValidUuids =>
      'Failist ei leitud kehtivaid UUID-kirjeid.';

  @override
  String categoriesImportSuccess(int count) {
    return 'Failist imporditi $count kategooriat.';
  }

  @override
  String get categoriesTitle => 'Kategooriad';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Tõlgitakse keelele: $lang';
  }

  @override
  String get categoriesImportJson => 'Impordi JSON';

  @override
  String get categoriesSaving => 'Salvestamine...';

  @override
  String get categoriesSaveAll => 'Salvesta kõik';

  @override
  String get categoriesLoading => 'Kategooriate laadimine...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Tõlge ($code)';
  }

  @override
  String get categoriesNoneFound => 'Kategooriaid ei leitud.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Tõlgi „$name”...';
  }

  @override
  String get loginPhotoBy => 'Foto: ';

  @override
  String get loginPhotoOn => ' – ';

  @override
  String get loginPleaseSignIn => 'Palun logi sisse';

  @override
  String get loginUsername => 'Kasutajanimi';

  @override
  String get loginPassword => 'Parool';

  @override
  String get loginRememberMe => 'Jäta mind meelde';

  @override
  String get loginSignIn => 'LOGI SISSE';

  @override
  String get loginNoAccount => 'Kontot pole veel? ';

  @override
  String get loginRegisterNow => 'Registreeru kohe';

  @override
  String get commonBack => 'Tagasi';

  @override
  String get commonNext => 'Edasi';

  @override
  String get registerFillRequired => 'Palun täida kõik kohustuslikud väljad.';

  @override
  String get registerPasswordMismatch => 'Paroolid ei kattu.';

  @override
  String get registerPasswordTooShort =>
      'Parool peab olema vähemalt 8 tähemärki pikk.';

  @override
  String get registerSelectLanguage => 'Palun vali vähemalt üks keel.';

  @override
  String get registerFailed => 'Registreerimine ebaõnnestus.';

  @override
  String get registerHeaderTitle => 'REGISTREERIMINE';

  @override
  String get registerStepAccount => 'Konto';

  @override
  String get registerStepRole => 'Roll';

  @override
  String get registerStepLanguages => 'Keeled';

  @override
  String get registerStepApiKeys => 'API-võtmed';

  @override
  String get registerYourAccount => 'Sinu konto';

  @override
  String get registerAvatarOptional => 'Avatar (valikuline)';

  @override
  String get registerUsernameRequired => 'Kasutajanimi *';

  @override
  String get registerEmailRequired => 'E-posti aadress *';

  @override
  String get registerPasswordRequired => 'Parool *';

  @override
  String get registerPasswordRepeat => 'Korda parooli *';

  @override
  String get registerYourRole => 'Sinu roll';

  @override
  String get registerRoleExplanation =>
      'Tõlkijad saavad tõlkida tekste, kuid neil pole ligipääsu läbivaatusjärjekorrale. Retsensendid kontrollivad ja kinnitavad tõlgitud sisu.';

  @override
  String get registerRoleTranslator => 'Tõlkija';

  @override
  String get registerRoleTranslatorDesc => 'Loo ja muuda tõlkeid.';

  @override
  String get registerRoleReviewer => 'Retsensent';

  @override
  String get registerRoleReviewerDesc => 'Vaata üle ja kinnita tõlkeid.';

  @override
  String get registerTargetLanguages => 'Sihtkeeled';

  @override
  String get registerLanguagesExplanation =>
      'Vali kõik keeled, millega soovid töötada.';

  @override
  String get registerNoLanguagesAvailable => 'Keeli pole saadaval.';

  @override
  String get registerApiKeysTitle => 'API-võtmed';

  @override
  String get registerApiKeysExplanation =>
      'Sisesta oma API-võtmed. Iga kasutaja kasutab ainult enda võtmeid. Neid saab hiljem lisada ka profiilis.';

  @override
  String get registerKeysEncryptedNote =>
      'Võtmeid hoitakse krüpteeritult ega jagata kunagi teiste kasutajatega.';

  @override
  String get registerOptionalSuffix => ' (valikuline)';

  @override
  String get registerSuccessTitle => 'Registreerimine õnnestus!';

  @override
  String get registerSuccessBody =>
      'Sinu konto on loodud ja ootab administraatori kinnitust. Sind teavitatakse, kui ligipääs on aktiveeritud.';

  @override
  String get registerGoToLogin => 'Mine sisselogimisele';

  @override
  String get registerSubmit => 'Registreeru';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profiil uuendati edukalt!';

  @override
  String get profileUpdateFailed => 'Uuendamine ebaõnnestus.';

  @override
  String profileSaveError(String error) {
    return 'Viga salvestamisel: $error';
  }

  @override
  String get profilePasswordMismatch => 'Paroolid ei kattu!';

  @override
  String get profilePasswordChangeSuccess => 'Parool muudeti edukalt!';

  @override
  String get profilePasswordChangeError =>
      'Viga parooli muutmisel: praegune parool on vale.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar laaditi edukalt üles!';

  @override
  String get profileAvatarUploadError => 'Viga avatari üleslaadimisel.';

  @override
  String get profileTitle => 'Profiil ja seaded';

  @override
  String get profileSubtitle =>
      'Halda oma kasutajaprofiili, tõlke-API-sid (Gemini ja DeepL) ning konto turvalisust.';

  @override
  String get profileRoleUser => 'Kasutaja';

  @override
  String get profileNoEmail => 'E-posti aadressi pole sisestatud';

  @override
  String get profileTabDetails => 'Profiili andmed';

  @override
  String get profileTabGemini => 'Tehisintellekti tõlge (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL tõlge';

  @override
  String get profileTabPassword => 'Muuda parooli';

  @override
  String get profileSectionInfo => 'PROFIILI TEAVE';

  @override
  String get profileFieldName => 'Nimi';

  @override
  String get profileFieldNameHint => 'Sinu täisnimi';

  @override
  String get profileFieldEmail => 'E-posti aadress';

  @override
  String get profileFieldEmailHint => 'Sinu e-posti aadress';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT SEADED';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API võti';

  @override
  String get profileFieldGeminiKeyHint =>
      'Sisesta oma gemini-3.1-flash API võti';

  @override
  String get profileFieldAiPrompt => 'Kohandatud tehisintellekti juhis';

  @override
  String get profileFieldAiPromptHint =>
      'Valikuline: kohanda Gemini süsteemijuhist...';

  @override
  String get profileSectionDeepl => 'DEEPL TÕLKESEADED';

  @override
  String get profileDeeplDescription =>
      'DeepL pakub kõrgekvaliteedilist masintõlget, säilitades HTML-sildid. Tasuta kontod (500 000 tähemärki/kuus) saavad võtme, mille lõpus on „:fx”.';

  @override
  String get profileFieldDeeplKey => 'DeepL API võti';

  @override
  String get profileFieldDeeplKeyHint =>
      'nt xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Tasuta võtmed lõppevad tähistusega „:fx” ja kasutavad domeeni api-free.deepl.com. Pro-võtmed kasutavad domeeni api.deepl.com. Eristamine toimub automaatselt.';

  @override
  String get profileSectionSecurity => 'KONTO TURVALISUS';

  @override
  String get profileFieldCurrentPassword => 'Praegune parool';

  @override
  String get profileFieldCurrentPasswordHint => 'Sisesta oma praegune parool';

  @override
  String get profileFieldNewPassword => 'Uus parool';

  @override
  String get profileFieldNewPasswordHint => 'Vähemalt 6 tähemärki';

  @override
  String get profileFieldConfirmPassword => 'Kinnita uus parool';

  @override
  String get profileFieldConfirmPasswordHint => 'Korda parooli';

  @override
  String get profileChangePasswordButton => 'Muuda parooli';

  @override
  String get commonDelete => 'Kustuta';

  @override
  String get settingsRegistrationUpdated =>
      'Registreerimise seadistus uuendatud';

  @override
  String get settingsUpdateFailed => 'Uuendamine ebaõnnestus.';

  @override
  String get settingsUserApproved => 'Kasutaja kinnitatud!';

  @override
  String get settingsAccountDeactivated => 'Konto deaktiveeritud.';

  @override
  String get settingsUserDeleted => 'Kasutaja kustutatud.';

  @override
  String get settingsActionFailed => 'Toiming ebaõnnestus.';

  @override
  String get settingsDeleteAccountTitle => 'Kustutada konto?';

  @override
  String get settingsDeactivateAccountTitle => 'Deaktiveerida konto?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Konto „$username” kustutatakse jäädavalt. Kas jätkata?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Konto „$username” lukustatakse. Kasutaja ei saa enam sisse logida, kuid konto säilib.';
  }

  @override
  String get settingsDeactivate => 'Deaktiveeri';

  @override
  String settingsSyncSuccess(String count) {
    return '$count tõlget sünkroonitud!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Sünkroonimise viga: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioriteetset moodulit sünkroonitud!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Viga prioriteetnimekirja sünkroonimisel: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Varundamine õnnestus: töödeldud $count faili.';
  }

  @override
  String get settingsUploadFailed => 'Üleslaadimine ebaõnnestus.';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get settingsSystemConfig => 'SÜSTEEMI SEADISTUS';

  @override
  String get settingsRegistration => 'Registreerimine';

  @override
  String get settingsRegistrationHint =>
      'Lülita üldise registreerimisvormi nähtavust.';

  @override
  String get settingsPendingUsers => 'Ootel kasutajad';

  @override
  String get settingsNoNewRequests => 'Uusi taotlusi pole.';

  @override
  String get settingsWantsReviewer => 'Soovib olla retsensent';

  @override
  String get settingsAssignRole => 'Määra roll';

  @override
  String get settingsRoleTranslator => 'Tõlkija';

  @override
  String get settingsRoleReviewer => 'Retsensent';

  @override
  String get settingsApprove => 'Kinnita';

  @override
  String get settingsReject => 'Lükka tagasi';

  @override
  String get settingsActiveUsers => 'Aktiivsed kasutajad';

  @override
  String get settingsNoActiveUsers => 'Aktiivseid kasutajaid pole.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deaktiveeri';

  @override
  String get settingsDeleteAccountAction => 'Kustuta konto';

  @override
  String get settingsAppearance => 'Välimus';

  @override
  String get settingsThemePearl => 'HELE (PEARL)';

  @override
  String get settingsThemeDark => 'TUME';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Tüpograafia';

  @override
  String get settingsFontHint => 'Muuda kasutajaliidese fondipere.';

  @override
  String get settingsFontClean => 'Clean';

  @override
  String get settingsFontFuturistic => 'Futuristlik';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Töövoog ja lõbu';

  @override
  String get settingsConfettiTitle => 'Õnnestumise tähistamine (konfetid)';

  @override
  String get settingsConfettiHint =>
      'Näitab väikest animatsiooni edukal salvestamisel.';

  @override
  String get settingsLargeUiTitle => 'Parem loetavus (suur kiri)';

  @override
  String get settingsLargeUiHint =>
      'Suurendab fontide ja märgiste suurust parema loetavuse jaoks.';

  @override
  String get settingsAutoPTitle => 'Lõikude automaatne vormindamine (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Mähib tavateksti automaatselt <p>-lõikudesse, kui moodul laaditakse läbivaatuse ekraanile. Vastab ¶-nupu käsitsi vajutamisele.';

  @override
  String get settingsDatabaseSync => 'Andmebaasi sünkroonimine';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sünkroonib andmebaasi kirjed JSON-tõlkefailidega.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sünkroonib serveri sisemised andmebaasikirjed tõlke-JSON-failidega.';

  @override
  String get settingsSyncing => 'Sünkroonimine...';

  @override
  String get settingsSyncNow => 'Sünkrooni kohe';

  @override
  String get settingsSyncD11List => 'Sünkrooni D11 nimekiri';

  @override
  String get settingsUploadBackup => 'Laadi üles varukoopia (.zip)';

  @override
  String get settingsSelectZipFile => 'Vali ZIP-fail';

  @override
  String get settingsUploading => 'Üleslaadimine...';

  @override
  String get settingsErrorDiagnostics => 'Vigade diagnostika ja süsteemilogid';

  @override
  String get settingsLogsCopied => 'Logid kopeeritud lõikelauale! 📋';

  @override
  String get settingsCopyLogs => 'Kopeeri logid';

  @override
  String get settingsLogsRotated => 'Logid arhiveeriti ja roteeriti! 📁';

  @override
  String get settingsRotate => 'Roteeri';

  @override
  String get settingsClear => 'Tühjenda';

  @override
  String get settingsLogLimit => 'Logi piirmäär: ';

  @override
  String get settingsNoLogs => 'Ühtegi logi pole registreeritud';

  @override
  String get layoutMenu => 'Menüü';

  @override
  String get layoutNavAnalytics => 'Analüütika';

  @override
  String get layoutNavReviewQueue => 'Läbivaatusjärjekord';

  @override
  String get layoutNavGlossary => 'Sõnastik';

  @override
  String get layoutNavCategories => 'Kategooriad';

  @override
  String get layoutNavHelp => 'Abi';

  @override
  String get layoutNavSettings => 'Seaded';

  @override
  String get layoutPhotoBy => 'Foto: ';

  @override
  String get layoutPhotoOn => ' – ';

  @override
  String get layoutEditProfile => 'Muuda profiili';

  @override
  String get layoutLogout => 'Logi välja';

  @override
  String get layoutThemeLabel => 'TEEMA';

  @override
  String get layoutThemePearl => 'Hele';

  @override
  String get layoutThemeDark => 'Tume';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'SIHTKEEL';

  @override
  String get layoutDeeplUsage => 'DEEPL KASUTUS';

  @override
  String get layoutUnavailable => 'Pole saadaval';

  @override
  String get layoutUnlimited => 'piiramatu';

  @override
  String get layoutUsed => 'kasutatud';

  @override
  String get layoutTranslate => 'Tõlgi';

  @override
  String get analyticsSubtitle =>
      'Ühilduvus, tõlkevõlgnevus ja iganädalased trendid.';

  @override
  String get analyticsBacklog => 'Tõlkevõlgnevus';

  @override
  String get analyticsMissing => 'Puudub';

  @override
  String get analyticsStale => 'Aegunud';

  @override
  String get analyticsInReview => 'Läbivaatamisel';

  @override
  String get analyticsReleased => 'Avaldatud';

  @override
  String get analyticsTranslated => 'Tõlgitud';

  @override
  String get analyticsTotalModules => 'Moodulite koguarv';

  @override
  String get analyticsCompatByVersion => 'Ühilduvus Drupali versiooni järgi';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Keel: $lang · avaldatud / läbivaatamisel / puudub';
  }

  @override
  String get analyticsLoadingCounts => 'Arvude laadimine …';

  @override
  String get analyticsWindow => 'Ajavahemik:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks nädalat';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Uued projektikirjeldused nädalas';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Aegunuks märgitud nädalas ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count moodulit';
  }

  @override
  String get analyticsReviewShort => 'Läbivaatus';

  @override
  String get analyticsNoDataInWindow => 'Sellel perioodil andmed puuduvad.';

  @override
  String get analyticsAndMore => '… ja rohkem';

  @override
  String glossaryLoadError(String error) {
    return 'Viga laadimisel: $error';
  }

  @override
  String get glossaryNewTerm => 'Loo uus termin';

  @override
  String get glossaryEditTerm => 'Muuda terminit';

  @override
  String get glossaryFieldSourceWord =>
      'Lähtesõna (algvorm, nagu tekstis esineb)';

  @override
  String get glossaryFieldSourceWordHint => 'nt node';

  @override
  String get glossaryWordForms =>
      'Täiendavad sõnavormid (mitmus, omastav, alaleütlev …)';

  @override
  String get glossaryWordFormsHint => 'nt content — lisamiseks vajuta Enter';

  @override
  String get glossaryAddForm => 'Lisa vorm';

  @override
  String get glossaryFieldPreferredWord => 'Eelistatud tõlge';

  @override
  String get glossaryFieldPreferredWordHint => 'nt content';

  @override
  String get glossaryFieldExplanation => 'Selgitus (kuvatakse vihjena)';

  @override
  String get glossaryFieldExplanationHint =>
      'Miks tuleks seda sõna teisiti tõlkida?';

  @override
  String get glossaryCreate => 'Loo';

  @override
  String get glossaryRequiredFields =>
      'Lähtesõna ja eelistatud tõlge on kohustuslikud.';

  @override
  String get glossaryCreated => 'Termin loodud ✓';

  @override
  String get glossaryUpdated => 'Termin uuendatud ✓';

  @override
  String glossaryError(String error) {
    return 'Viga: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Kustutada termin?';

  @override
  String glossaryDeleteBody(String word) {
    return '„$word” eemaldatakse sõnastikust jäädavalt.';
  }

  @override
  String get glossaryDeleted => 'Termin kustutatud.';

  @override
  String get glossaryTitle => 'Tõlkesõnastik';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Keel: $lang · $count kirjet';
  }

  @override
  String get glossaryNewShort => 'Uus';

  @override
  String get glossaryCreateTerm => 'Loo termin';

  @override
  String get glossaryInfoBanner =>
      'Selle sõnastiku sõnad on läbivaatusredaktoris esile tõstetud. Hõljutades kuvatav vihje selgitab, miks mõni teine tõlge paremini sobib.';

  @override
  String get glossaryNoEntries => 'Kirjeid pole veel.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klõpsa „Loo termin”, et luua esimene kirje.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Sellele keelele pole veel sõnastikukirjeid.';

  @override
  String get diffNoChanges => 'Sisulisi erinevusi ei tuvastatud.';

  @override
  String get diffRemoved => 'Eemaldatud';

  @override
  String get diffAdded => 'Lisatud';

  @override
  String syncBarQuickSync(String count) {
    return 'Kiiresünkroonimine: $count muudetud moodulit …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Täielik sünkroonimine: $current / $total moodulit';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Täielik sünkroonimine: $count moodulit …';
  }
}
