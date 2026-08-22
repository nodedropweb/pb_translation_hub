// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Įkeliama projekto informacija...';

  @override
  String editorLoadError(String error) {
    return 'Nepavyko įkelti projekto duomenų: $error';
  }

  @override
  String get editorGeminiSuccess => 'Vertimas su Gemini sėkmingas! ✨';

  @override
  String get editorUnknownError => 'Nežinoma klaida';

  @override
  String editorGeminiFailed(String detail) {
    return 'Nepavyko Gemini vertimo: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Pridėkite savo „Google AI“ raktą naudotojo profilyje (ne administravimo nustatymuose).';

  @override
  String get editorGeminiError =>
      'Klaida verčiant su Gemini. Patikrinkite savo „Google AI“ raktą profilyje.';

  @override
  String get editorDeeplSuccess => 'Vertimas su DeepL sėkmingas! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Nepavyko DeepL vertimo: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Klaida verčiant su DeepL. Įsitikinkite, kad profilyje nustatytas DeepL API raktas.';

  @override
  String get editorDeeplInvalidKey =>
      'Netinkamas DeepL API raktas. Patikrinkite jį savo profilyje.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL kvota išnaudota. Patikrinkite savo planą.';

  @override
  String get editorReviewReset => 'Vertimas grąžintas į peržiūros būseną.';

  @override
  String editorResetError(String error) {
    return 'Nepavyko atstatyti: $error';
  }

  @override
  String get editorUnignoreSuccess => 'Modulis grąžintas į aktyvių sąrašą.';

  @override
  String get editorUnignoreError => 'Nepavyko grąžinti modulio.';

  @override
  String get editorSaveSuccess =>
      'Vertimas išsaugotas — grąžinama į peržiūros eilę.';

  @override
  String editorSaveError(String error) {
    return 'Nepavyko išsaugoti: $error';
  }

  @override
  String get editorNoMoreProjects => 'Sąraše nebeliko atvirų projektų.';

  @override
  String get editorChangesDiscarded =>
      'Pakeitimai atmesti, įkeliamas kitas projektas...';

  @override
  String get editorEnglishSourceApplied =>
      'Pritaikytas originalus angliškas tekstas — dabar jį išverskite.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Nepavyko atidaryti URL: $url';
  }

  @override
  String get commonSave => 'Išsaugoti';

  @override
  String get commonClose => 'Uždaryti';

  @override
  String get editorCloseEnglishSource => 'Uždaryti anglišką šaltinį';

  @override
  String get editorShowEnglishSource => 'Rodyti anglišką šaltinį';

  @override
  String get editorUnignoreShortTooltip => 'Grąžinti modulį';

  @override
  String get editorBackToReviewTooltip => 'Grąžinti į peržiūrą';

  @override
  String get editorAndNext => 'ir kitas';

  @override
  String get editorBackToDashboard => 'Grįžti į skydelį';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Verčiama į $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return 'Liko: $count';
  }

  @override
  String get editorUnignoreLongTooltip => 'Grąžinti modulį į aktyvių sąrašą';

  @override
  String get editorUnignoreLabel => 'Grąžinti';

  @override
  String get editorUnpublishTooltip =>
      'Panaikinti publikavimą ir grąžinti į peržiūrą';

  @override
  String get editorBackToReview => 'Grįžti į peržiūrą';

  @override
  String get editorSaveAndNext => 'Išsaugoti ir toliau';

  @override
  String get editorEnglishSourceHeader => 'ANGLIŠKAS ŠALTINIS';

  @override
  String get editorStaleTooltip =>
      'Rodyti paaiškinimą ir pritaikyti anglišką tekstą';

  @override
  String get editorStaleDetailsLabel => 'Pasenęs — informacija';

  @override
  String get editorCopyPromptTooltip => 'Kopijuoti šaltinį + vertimo užklausą';

  @override
  String get editorPromptCopied => 'Užklausa nukopijuota į iškarpinę 📋';

  @override
  String get editorShowPreview => 'Rodyti peržiūrą';

  @override
  String get editorShowHtmlSource => 'Rodyti HTML šaltinį';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'SANTRAUKA:\n$summary\n\nTURINYS:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Santrauka:';

  @override
  String get editorDescriptionLabelColon => 'Aprašymas:';

  @override
  String get editorStaleDialogTitle => 'Angliškas šaltinis pasikeitė';

  @override
  String get editorStaleExplanation =>
      'Esamas vertimas paremtas pasenusiu angliškuoju originaliu tekstu. Nuo paskutinio vertimo modulio prižiūrėtojas pakeitė anglišką tekstą svetainėje Drupal.org — todėl esamo vertimo turinys gali būti nebetikslus arba nepilnas.';

  @override
  String get editorStaleTip =>
      'Patarimas: spustelėkite „Naudoti anglišką originalą“, kad dabartinis angliškas šaltinis būtų įkeltas tiesiai į redaktorių. Vėliau galėsite juo naudotis kaip naujo vertimo pagrindu. Angliškas originalas taip pat matomas kairiajame skydelyje.';

  @override
  String get editorEnglishSourceShort => 'Angliškas šaltinis';

  @override
  String get editorPreviousTranslation => 'Ankstesnis vertimas';

  @override
  String get editorWhatChangedTitle => 'Kas pasikeitė?';

  @override
  String get editorShowDiff => 'Rodyti skirtumus';

  @override
  String get editorUseEnglish => 'Naudoti anglišką originalą';

  @override
  String get editorStaleBannerText =>
      'Angliškas šaltinis pasikeitė — vertimas pasenęs';

  @override
  String get editorDetailsAndApply => 'Informacija ir pritaikymas';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'VERTIMAS ($langName)';
  }

  @override
  String get editorTranslatingEllipsis => 'Verčiama...';

  @override
  String get editorShowEditor => 'Rodyti redaktorių';

  @override
  String get editorModuleTitleLabel => 'Modulio pavadinimas (angliškai)';

  @override
  String get editorSummaryFieldLabel => 'Santrauka';

  @override
  String get editorBodyFieldLabel => 'Turinys';

  @override
  String get editorHtmlCleaned => 'HTML sutvarkytas';

  @override
  String get editorLivePreviewHeader => 'TIESIOGINĖ PERŽIŪRA';

  @override
  String get editorTidyHtmlTooltip =>
      'Sutvarkyti HTML (pašalinti DeepL artefaktus)';

  @override
  String get editorVisualMode => 'VIZUALUS';

  @override
  String get editorSourceCodeMode => 'ŠALTINIS (HTML)';

  @override
  String get commonCancel => 'Atšaukti';

  @override
  String get costDialogTitle => 'Sąnaudų įvertis (DI)';

  @override
  String get costDialogIntro =>
      'Pasirinktas modulis bus išverstas naudojant „Google Gemini“ DI. Štai numatomas šios operacijos sąnaudų suskirstymas:';

  @override
  String get costRowModel => 'Modelis';

  @override
  String get costRowInputTokens => 'Įvesties leksemos';

  @override
  String get costRowOutputTokens => 'Išvesties leksemos (įvertis)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars simbolių)';
  }

  @override
  String get costRowPriceInput => 'Kaina už 1 mln. įvesties';

  @override
  String get costRowPriceOutput => 'Kaina už 1 mln. išvesties';

  @override
  String get costRowTotalEstimate => 'Numatoma bendra kaina';

  @override
  String get costDialogFootnote =>
      '* Pastaba: tai įvertis, pagrįstas dabartiniu „Google“ mokėjimo pagal naudojimą kainodaros modeliu. Faktinis naudojimas gali šiek tiek skirtis.';

  @override
  String get costDialogStartTranslation => 'Pradėti vertimą';

  @override
  String get htmlToolbarInsertLink => 'Įterpti nuorodą';

  @override
  String get htmlToolbarLinkTooltip => 'Įterpti nuorodą (a)';

  @override
  String get htmlToolbarInsert => 'Įterpti';

  @override
  String get htmlToolbarHeading2 => '2 lygio antraštė';

  @override
  String get htmlToolbarHeading3 => '3 lygio antraštė';

  @override
  String get htmlToolbarBold => 'Paryškintas (strong)';

  @override
  String get htmlToolbarItalic => 'Kursyvas (em)';

  @override
  String get htmlToolbarBulletList => 'Ženklelių sąrašas (ul)';

  @override
  String get htmlToolbarNumberedList => 'Numeruotas sąrašas (ol)';

  @override
  String get htmlToolbarQuote => 'Citata (blockquote)';

  @override
  String get screenshotAltsHeader => 'EKRANO NUOTRAUKŲ ALT TEKSTAS';

  @override
  String get screenshotAltsIntro =>
      'Kiekvienai ekrano nuotraukai įveskite aprašomąjį alt tekstą tiksline kalba.';

  @override
  String screenshotLabel(int number) {
    return 'Ekrano nuotrauka $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Peržiūra nepasiekiama';

  @override
  String get screenshotAltHint => 'Įveskite alt tekstą tiksline kalba…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Grąžinti visus modulius?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Visi ignoruojami moduliai bus grąžinti į aktyvių sąrašą ir vėl bus prieinami vertimui.';

  @override
  String get dashUnignoreAllConfirmAction => 'Grąžinti visus';

  @override
  String get dashUnignoreAllSuccess => 'Visi ignoruoti moduliai buvo grąžinti.';

  @override
  String get dashUnignoreAllError => 'Nepavyko grąžinti modulių.';

  @override
  String get dashUnignoreAllButton => 'Grąžinti visus modulius';

  @override
  String dashSyncStartError(String error) {
    return 'Nepavyko pradėti sinchronizavimo: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'Pradėtas greitasis atnaujinimas (7 dienos) ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Greitojo atnaujinimo klaida: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sėkmingai sinchronizuota: $name';
  }

  @override
  String get dashManualSyncNotFound =>
      'Modulis nerastas svetainėje Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Masinis vertimas su DI';

  @override
  String get dashHeaderTitle => 'Projektų aprašymai';

  @override
  String get dashHeaderSubtitle =>
      'Verskite Drupal modulių aprašymus į tikslinę kalbą. Padėkite padaryti ekosistemą prieinamesnę.';

  @override
  String get dashHeaderSubtitleShort => 'Verskite Drupal modulių aprašymus.';

  @override
  String get dashLastLabel => 'Paskutinis: ';

  @override
  String get dashContinue => 'Tęsti';

  @override
  String get dashContinueShort => 'Tęsti';

  @override
  String get dashUnignoreAllButtonLong => 'Grąžinti visus modulius';

  @override
  String get dashQuickUpdateTooltip =>
      'Greitasis atnaujinimas (paskutinės 7 dienos)';

  @override
  String get dashFullSyncTooltip =>
      'Pilnas duomenų bazės sinchronizavimas iš Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Rankiniu būdu įkelti vieną modulį iš Drupal.org';

  @override
  String get dashQuickShort => 'Greitas';

  @override
  String get dashModuleShort => 'Modulis';

  @override
  String get dashFoundLabel => 'Rasta: ';

  @override
  String get dashModulesSuffix => ' modulių';

  @override
  String dashPerPage(int count) {
    return '$count puslapyje';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / psl.';
  }

  @override
  String get dashFirstPage => 'Pirmas puslapis';

  @override
  String get dashPrevPage => 'Ankstesnis puslapis';

  @override
  String get dashNextPage => 'Kitas puslapis';

  @override
  String get dashLastPage => 'Paskutinis puslapis';

  @override
  String dashPageOf(int page, int total) {
    return '$page puslapis iš $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (pvz., pathauto)';

  @override
  String get dashAddButton => 'Pridėti';

  @override
  String get dashAddModuleManually => 'Pridėti modulį rankiniu būdu';

  @override
  String get dashAddModuleSubtitle =>
      'Įkelti tiesiogiai iš Drupal.org pagal machine name.';

  @override
  String get dashAddModuleShort => 'Pridėti modulį';

  @override
  String get dashNoProjectsFound => 'Projektų nerasta.';

  @override
  String get dashFilterAll => 'Visi projektai';

  @override
  String get dashFilterMissing => 'Trūkstami vertimai';

  @override
  String get dashFilterReview => 'Peržiūros eilė';

  @override
  String get dashFilterTranslated => 'Išversti projektai';

  @override
  String get dashFilterReleased => 'Paskelbti projektai';

  @override
  String get dashBulkDialogIntro =>
      'Automatiškai išverskite kelis modulius iš pasirinkto filtro naudodami „Google Gemini“.';

  @override
  String get dashActiveFilter => 'Aktyvus filtras';

  @override
  String get dashModuleCount => 'Modulių skaičius';

  @override
  String dashModulesCountItem(int count) {
    return '$count modulių';
  }

  @override
  String get dashPrioritizeD12Title => 'Teikti pirmenybę Drupal 12 moduliams';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Pirmiausia verčia modulius be Drupal 12 palaikymo';

  @override
  String get dashTotalModules => 'Iš viso modulių';

  @override
  String get dashInputTokensEst => 'Įvesties leksemos (įvert.)';

  @override
  String get dashOutputTokensEst => 'Išvesties leksemos (įvert.)';

  @override
  String get dashBulkFootnote =>
      '* Vertimas atliekamas mažomis, išteklius taupančiomis partijomis, kad būtų išvengta laiko limito viršijimo.';

  @override
  String get dashStartBulkTranslation => 'Pradėti masinį vertimą';

  @override
  String dashStaleLoadError(String error) {
    return 'Klaida įkeliant pasenusius modulius: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Pasenusių modulių nerasta — viskas atnaujinta! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Iš naujo versti pasenusius modulius';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Visi vertimai, kurių angliškas šaltinis pasikeitė nuo paskutinio vertimo, bus automatiškai iš naujo išversti naudojant „Google Gemini“. Nereikės rankiniu būdu atidaryti kiekvieno modulio.';

  @override
  String get dashOutdatedModules => 'Pasenę moduliai';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Vertimas pakeičia esamą tekstą ir atstato is_reviewed. Atliekama 4 modulių partijomis.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Iš naujo versti visus $count modulius';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Iš naujo verčiami pasenę moduliai…';

  @override
  String get dashFetchingProjects => 'Gaunami projektai iš serverio…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return 'Apdorota $processed iš $total modulių';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Šiam filtrui neišverčiamų projektų nerasta.';

  @override
  String get dashStartingTranslation => 'Pradedamas vertimas…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Verčiamas modulis $start–$end iš $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return 'Baigta $end iš $total modulių.';
  }

  @override
  String get dashTranslationCompleted => 'Vertimas sėkmingai baigtas! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '$count modulių masinis vertimas sėkmingas! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Masinio vertimo klaida: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Visi $count moduliai sėkmingai iš naujo išversti! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count pasenusių modulių sėkmingai iš naujo išversti! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Klaida verčiant iš naujo: $error';
  }

  @override
  String get filterAllShort => 'Visi';

  @override
  String get filterMissing => 'Trūkstami';

  @override
  String get filterTranslated => 'Išversti';

  @override
  String get filterReviewQueue => 'Peržiūros eilė';

  @override
  String get filterReleased => 'Paskelbti';

  @override
  String get filterOutdated => 'Pasenę';

  @override
  String get filterPriority => 'Prioritetas';

  @override
  String get filterIgnored => 'Ignoruojami';

  @override
  String get commonEdit => 'Redaguoti';

  @override
  String get commonReset => 'Atstatyti';

  @override
  String get commonRefresh => 'Atnaujinti';

  @override
  String commonErrorPrefix(String error) {
    return 'Klaida: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Atstatyti visus paskelbtus vertimus?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Visi vertimai, pažymėti kaip paskelbti kalbai $langcode, bus grąžinti į peržiūros būseną. Šio veiksmo atšaukti negalima.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count vertimų grąžinta į peržiūros būseną.';
  }

  @override
  String get reviewPipelineTitle => 'Peržiūros procesas';

  @override
  String get reviewPipelineSubtitle =>
      'Žmogaus atliekama DI vertimų kokybės kontrolė';

  @override
  String get reviewSearchHint => 'Ieškoti projektų...';

  @override
  String get reviewResetPublished => 'Atstatyti paskelbtus';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Rezultatai: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Laukiama: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Nėra peržiūros laukiančių projektų.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Visi vertimai jau patikrinti arba šiame kalbos kontekste jų nėra.';

  @override
  String get reviewNoSummary => 'Nėra santraukos.';

  @override
  String get reviewStartAudit => 'PRADĖTI PATIKRĄ';

  @override
  String get reviewHtmlSourceShort => 'HTML šaltinis';

  @override
  String get reviewCopySource => 'Kopijuoti šaltinį';

  @override
  String get reviewModuleDetails => 'Modulio informacija';

  @override
  String get reviewOriginalTitle => 'Originalus pavadinimas';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org projektas';

  @override
  String get reviewSuggestions => 'Pasiūlymai';

  @override
  String get reviewNoSuggestions => 'Pasiūlymų nėra.';

  @override
  String get reviewApply => 'Pritaikyti';

  @override
  String get reviewNoChanges => 'Jokių pakeitimų';

  @override
  String get reviewOriginalBeforeCorrection => 'Originalas (prieš taisymą)';

  @override
  String get reviewCorrectedCurrentVersion => 'Pataisyta (dabartinė versija)';

  @override
  String get reviewBaseOriginal => 'Bazinis (originalas)';

  @override
  String get reviewYourCorrection => 'Jūsų taisymas';

  @override
  String get reviewChangesVisual => 'Peržiūrėkite savo pakeitimus (vizualiai)';

  @override
  String get commonSkip => 'Praleisti';

  @override
  String get commonIgnore => 'Ignoruoti';

  @override
  String get reviewEmptyProjectTitle => 'Tuščias projektas';

  @override
  String get reviewEmptyProjectBody =>
      'Šis projektas tuščias (nėra pavadinimo, santraukos ar turinio) ir negali būti patvirtintas. Praleiskite jį.';

  @override
  String get reviewApprovedSuccess => 'Vertimas patvirtintas! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Nepavyko patvirtinti „$machine“ — bandykite dar kartą.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Ignoravimas panaikintas. Modulis vėl aktyvus!';

  @override
  String get reviewActionFailed => 'Veiksmas nepavyko.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignoruoti modulį?';

  @override
  String get reviewIgnoreModuleBody =>
      'Šis modulis bus visam laikui paslėptas visuose sąrašuose. Daugiau jo nesutiksite.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modulis visam laikui ignoruojamas.';

  @override
  String get reviewIgnoreFailed => 'Nepavyko ignoruoti modulio.';

  @override
  String get reviewSuggestionSaved => 'Pasiūlymo juodraštis išsaugotas! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Nepavyko išsaugoti pasiūlymo juodraščio.';

  @override
  String get reviewSuggestionDeleted => 'Pasiūlymas ištrintas.';

  @override
  String get reviewDeleteFailed => 'Nepavyko ištrinti.';

  @override
  String get reviewSuggestionApplied => 'Pasiūlymas pritaikytas.';

  @override
  String get reviewPreparingData => 'Ruošiami peržiūros duomenys...';

  @override
  String get reviewDirectEdit => 'Tiesioginis redagavimas';

  @override
  String get reviewLivePreview => 'Tiesioginė peržiūra';

  @override
  String get reviewCompareWith => 'Palyginti su:';

  @override
  String get reviewProductionVersion => 'Gamybinė versija';

  @override
  String get reviewEditorialReview => 'Redakcinė peržiūra';

  @override
  String get reviewOpenQueue => 'Atidaryti peržiūros eilę';

  @override
  String get reviewCopyPromptShort => 'Kopijuoti užklausą';

  @override
  String get reviewUnignoreShort => 'Grąžinti';

  @override
  String get reviewApproveButton => 'PATVIRTINTI';

  @override
  String get reviewHideDetails => 'Slėpti informaciją';

  @override
  String get reviewDetailsAndEnglishSource =>
      'Informacija ir angliškas šaltinis';

  @override
  String reviewPendingCountShort(int count) {
    return 'Laukiama: $count';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Peržiūrima $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Palyginti vertimą su angliškuoju šaltiniu';

  @override
  String get reviewTranslationLabel => 'Vertimas';

  @override
  String get reviewComparisonTitle => 'Palyginimas';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Kopijuoti šaltinio tekstą + vertimo užklausą į iškarpinę';

  @override
  String get reviewUnignoreCaps => 'GRĄŽINTI';

  @override
  String get reviewIgnoreCaps => 'IGNORUOTI';

  @override
  String get reviewSkipShortcut => 'PRALEISTI (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Redakcinė peržiūra';

  @override
  String get reviewUnignoreTablet => 'GRĄŽINTI';

  @override
  String get reviewApproveForProduction => 'PATVIRTINTI GAMYBAI (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Tiesioginis tobulinimas';

  @override
  String get reviewTitleField => 'Pavadinimas';

  @override
  String get reviewSummaryField => 'Santrauka';

  @override
  String get reviewBodyField => 'Turinys';

  @override
  String get reviewSaveShortcut => 'IŠSAUGOTI (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Tiesioginė peržiūra (atvaizdavimas)';

  @override
  String get reviewVoiceFemale => 'Moteriškas';

  @override
  String get reviewVoiceMale => 'Vyriškas';

  @override
  String get reviewStopListening => 'Stabdyti';

  @override
  String get reviewListen => 'Klausytis';

  @override
  String get reviewAutopTooltip =>
      'Automatinis pastraipų formatavimas (eilučių lūžiai → <p>)';

  @override
  String get reviewSourceCodeShort => 'ŠALTINIS';

  @override
  String get reviewNoParagraphChange =>
      'Tekste jau yra <p> žymos — pakeitimų nėra';

  @override
  String get reviewParagraphsFormatted => 'Pastraipos suformatuotos ¶';

  @override
  String get commonRetry => 'Bandyti dar kartą';

  @override
  String categoriesLoadError(String error) {
    return 'Nepavyko įkelti kategorijų: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategorijos sėkmingai išsaugotos.';

  @override
  String get categoriesSaveFailed => 'Nepavyko išsaugoti vertimų.';

  @override
  String get categoriesFileEmpty => 'Failas tuščias.';

  @override
  String get categoriesInvalidJson => 'Netinkamas JSON formatas.';

  @override
  String get categoriesNoValidUuids => 'Faile nerasta tinkamų UUID įrašų.';

  @override
  String categoriesImportSuccess(int count) {
    return 'Iš failo importuota $count kategorijų.';
  }

  @override
  String get categoriesTitle => 'Kategorijos';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Verčiama kalbai: $lang';
  }

  @override
  String get categoriesImportJson => 'Importuoti JSON';

  @override
  String get categoriesSaving => 'Išsaugoma...';

  @override
  String get categoriesSaveAll => 'Išsaugoti viską';

  @override
  String get categoriesLoading => 'Įkeliamos kategorijos...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Vertimas ($code)';
  }

  @override
  String get categoriesNoneFound => 'Kategorijų nerasta.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Versti „$name“...';
  }

  @override
  String get loginPhotoBy => 'Nuotrauka: ';

  @override
  String get loginPhotoOn => ' – ';

  @override
  String get loginPleaseSignIn => 'Prisijunkite';

  @override
  String get loginUsername => 'Vartotojo vardas';

  @override
  String get loginPassword => 'Slaptažodis';

  @override
  String get loginRememberMe => 'Prisiminti mane';

  @override
  String get loginSignIn => 'PRISIJUNGTI';

  @override
  String get loginNoAccount => 'Dar neturite paskyros? ';

  @override
  String get loginRegisterNow => 'Registruokitės dabar';

  @override
  String get commonBack => 'Atgal';

  @override
  String get commonNext => 'Toliau';

  @override
  String get registerFillRequired => 'Užpildykite visus privalomus laukus.';

  @override
  String get registerPasswordMismatch => 'Slaptažodžiai nesutampa.';

  @override
  String get registerPasswordTooShort =>
      'Slaptažodis turi būti bent 8 simbolių.';

  @override
  String get registerSelectLanguage => 'Pasirinkite bent vieną kalbą.';

  @override
  String get registerFailed => 'Registracija nepavyko.';

  @override
  String get registerHeaderTitle => 'REGISTRACIJA';

  @override
  String get registerStepAccount => 'Paskyra';

  @override
  String get registerStepRole => 'Vaidmuo';

  @override
  String get registerStepLanguages => 'Kalbos';

  @override
  String get registerStepApiKeys => 'API raktai';

  @override
  String get registerYourAccount => 'Jūsų paskyra';

  @override
  String get registerAvatarOptional => 'Avataras (neprivaloma)';

  @override
  String get registerUsernameRequired => 'Vartotojo vardas *';

  @override
  String get registerEmailRequired => 'El. pašto adresas *';

  @override
  String get registerPasswordRequired => 'Slaptažodis *';

  @override
  String get registerPasswordRepeat => 'Pakartokite slaptažodį *';

  @override
  String get registerYourRole => 'Jūsų vaidmuo';

  @override
  String get registerRoleExplanation =>
      'Vertėjai gali versti tekstus, bet neturi prieigos prie peržiūros eilės. Peržiūrėtojai tikrina ir tvirtina išverstą turinį.';

  @override
  String get registerRoleTranslator => 'Vertėjas';

  @override
  String get registerRoleTranslatorDesc => 'Kurkite ir redaguokite vertimus.';

  @override
  String get registerRoleReviewer => 'Peržiūrėtojas';

  @override
  String get registerRoleReviewerDesc =>
      'Peržiūrėkite ir tvirtinkite vertimus.';

  @override
  String get registerTargetLanguages => 'Tikslinės kalbos';

  @override
  String get registerLanguagesExplanation =>
      'Pasirinkite visas kalbas, su kuriomis norite dirbti.';

  @override
  String get registerNoLanguagesAvailable => 'Nėra prieinamų kalbų.';

  @override
  String get registerApiKeysTitle => 'API raktai';

  @override
  String get registerApiKeysExplanation =>
      'Įveskite savo API raktus. Kiekvienas naudotojas naudoja tik savo raktus. Juos taip pat galite pridėti vėliau savo profilyje.';

  @override
  String get registerKeysEncryptedNote =>
      'Raktai saugomi užšifruoti ir niekada nebendrinami su kitais naudotojais.';

  @override
  String get registerOptionalSuffix => ' (neprivaloma)';

  @override
  String get registerSuccessTitle => 'Registracija sėkminga!';

  @override
  String get registerSuccessBody =>
      'Jūsų paskyra sukurta ir laukia administratoriaus patvirtinimo. Būsite informuoti, kai jūsų prieiga bus aktyvuota.';

  @override
  String get registerGoToLogin => 'Eiti į prisijungimą';

  @override
  String get registerSubmit => 'Registruotis';

  @override
  String registerPhotoCredit(String name) {
    return 'Nuotrauka: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profilis sėkmingai atnaujintas!';

  @override
  String get profileUpdateFailed => 'Atnaujinti nepavyko.';

  @override
  String profileSaveError(String error) {
    return 'Klaida išsaugant: $error';
  }

  @override
  String get profilePasswordMismatch => 'Slaptažodžiai nesutampa!';

  @override
  String get profilePasswordChangeSuccess => 'Slaptažodis sėkmingai pakeistas!';

  @override
  String get profilePasswordChangeError =>
      'Klaida keičiant slaptažodį: neteisingas dabartinis slaptažodis.';

  @override
  String get profileAvatarUploadSuccess => 'Avataras sėkmingai įkeltas!';

  @override
  String get profileAvatarUploadError => 'Klaida įkeliant avatarą.';

  @override
  String get profileTitle => 'Profilis ir nustatymai';

  @override
  String get profileSubtitle =>
      'Tvarkykite savo naudotojo profilį, vertimo API raktus (Gemini ir DeepL) bei paskyros saugumą.';

  @override
  String get profileRoleUser => 'Naudotojas';

  @override
  String get profileNoEmail => 'El. pašto adresas nenurodytas';

  @override
  String get profileTabDetails => 'Profilio informacija';

  @override
  String get profileTabGemini => 'DI vertimas (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL vertimas';

  @override
  String get profileTabPassword => 'Keisti slaptažodį';

  @override
  String get profileSectionInfo => 'PROFILIO INFORMACIJA';

  @override
  String get profileFieldName => 'Vardas';

  @override
  String get profileFieldNameHint => 'Jūsų pilnas vardas';

  @override
  String get profileFieldEmail => 'El. pašto adresas';

  @override
  String get profileFieldEmailHint => 'Jūsų el. pašto adresas';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT NUSTATYMAI';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API raktas';

  @override
  String get profileFieldGeminiKeyHint =>
      'Įveskite savo gemini-3.1-flash API raktą';

  @override
  String get profileFieldAiPrompt => 'Pritaikyta DI užklausa';

  @override
  String get profileFieldAiPromptHint =>
      'Neprivaloma: pritaikykite Gemini sistemos užklausą...';

  @override
  String get profileSectionDeepl => 'DEEPL VERTIMO NUSTATYMAI';

  @override
  String get profileDeeplDescription =>
      'DeepL siūlo aukštos kokybės mašininį vertimą su HTML žymų išsaugojimu. Nemokamos paskyros (500 000 simbolių per mėnesį) gauna raktą su priesaga „:fx“.';

  @override
  String get profileFieldDeeplKey => 'DeepL API raktas';

  @override
  String get profileFieldDeeplKeyHint =>
      'pvz., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Nemokami raktai baigiasi „:fx“ ir naudoja api-free.deepl.com. „Pro“ raktai naudoja api.deepl.com. Skirtumas nustatomas automatiškai.';

  @override
  String get profileSectionSecurity => 'PASKYROS SAUGUMAS';

  @override
  String get profileFieldCurrentPassword => 'Dabartinis slaptažodis';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Įveskite savo dabartinį slaptažodį';

  @override
  String get profileFieldNewPassword => 'Naujas slaptažodis';

  @override
  String get profileFieldNewPasswordHint => 'Bent 6 simboliai';

  @override
  String get profileFieldConfirmPassword => 'Patvirtinkite naują slaptažodį';

  @override
  String get profileFieldConfirmPasswordHint => 'Pakartokite slaptažodį';

  @override
  String get profileChangePasswordButton => 'Keisti slaptažodį';

  @override
  String get commonDelete => 'Ištrinti';

  @override
  String get settingsRegistrationUpdated =>
      'Registracijos nustatymas atnaujintas';

  @override
  String get settingsUpdateFailed => 'Atnaujinti nepavyko.';

  @override
  String get settingsUserApproved => 'Naudotojas patvirtintas!';

  @override
  String get settingsAccountDeactivated => 'Paskyra deaktyvuota.';

  @override
  String get settingsUserDeleted => 'Naudotojas ištrintas.';

  @override
  String get settingsActionFailed => 'Veiksmas nepavyko.';

  @override
  String get settingsDeleteAccountTitle => 'Ištrinti paskyrą?';

  @override
  String get settingsDeactivateAccountTitle => 'Deaktyvuoti paskyrą?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Paskyra „$username“ bus negrįžtamai ištrinta. Tęsti?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Paskyra „$username“ bus užrakinta. Naudotojas nebegalės prisijungti, bet paskyra bus išsaugota.';
  }

  @override
  String get settingsDeactivate => 'Deaktyvuoti';

  @override
  String settingsSyncSuccess(String count) {
    return 'Sinchronizuota $count vertimų!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Sinchronizavimo klaida: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return 'Sinchronizuota $count prioritetinių modulių!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Klaida sinchronizuojant prioritetinį sąrašą: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Atsarginė kopija sėkminga: apdorota $count failų.';
  }

  @override
  String get settingsUploadFailed => 'Įkėlimas nepavyko.';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get settingsSystemConfig => 'SISTEMOS KONFIGŪRACIJA';

  @override
  String get settingsRegistration => 'Registracija';

  @override
  String get settingsRegistrationHint =>
      'Perjunkite bendros registracijos formos matomumą.';

  @override
  String get settingsPendingUsers => 'Laukiantys naudotojai';

  @override
  String get settingsNoNewRequests => 'Naujų užklausų nėra.';

  @override
  String get settingsWantsReviewer => 'Nori tapti peržiūrėtoju';

  @override
  String get settingsAssignRole => 'Priskirti vaidmenį';

  @override
  String get settingsRoleTranslator => 'Vertėjas';

  @override
  String get settingsRoleReviewer => 'Peržiūrėtojas';

  @override
  String get settingsApprove => 'Patvirtinti';

  @override
  String get settingsReject => 'Atmesti';

  @override
  String get settingsActiveUsers => 'Aktyvūs naudotojai';

  @override
  String get settingsNoActiveUsers => 'Aktyvių naudotojų nėra.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deaktyvuoti';

  @override
  String get settingsDeleteAccountAction => 'Ištrinti paskyrą';

  @override
  String get settingsAppearance => 'Išvaizda';

  @override
  String get settingsThemePearl => 'ŠVIESI (PEARL)';

  @override
  String get settingsThemeDark => 'TAMSI';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Tipografija';

  @override
  String get settingsFontHint => 'Keiskite sąsajos šrifto šeimą.';

  @override
  String get settingsFontClean => 'Clean';

  @override
  String get settingsFontFuturistic => 'Futuristinis';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Darbo eiga ir smagumai';

  @override
  String get settingsConfettiTitle => 'Sėkmės šventimas (konfeti)';

  @override
  String get settingsConfettiHint =>
      'Rodo mažą animaciją sėkmingai išsaugojus.';

  @override
  String get settingsLargeUiTitle => 'Geresnis skaitomumas (didelis šriftas)';

  @override
  String get settingsLargeUiHint =>
      'Padidina šriftų ir ženkliukų dydį geresniam skaitomumui.';

  @override
  String get settingsAutoPTitle =>
      'Automatinis pastraipų formatavimas (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Automatiškai apgaubia paprastą tekstą <p> pastraipomis, kai modulis įkeliamas peržiūros ekrane. Atitinka rankinį ¶ mygtuko paspaudimą.';

  @override
  String get settingsDatabaseSync => 'Duomenų bazės sinchronizavimas';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sinchronizuoja duomenų bazės įrašus su JSON vertimo failais.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sinchronizuoja vidinius duomenų bazės įrašus su vertimo JSON failais serveryje.';

  @override
  String get settingsSyncing => 'Sinchronizuojama...';

  @override
  String get settingsSyncNow => 'Sinchronizuoti dabar';

  @override
  String get settingsSyncD11List => 'Sinchronizuoti D11 sąrašą';

  @override
  String get settingsUploadBackup => 'Įkelti atsarginę kopiją (.zip)';

  @override
  String get settingsSelectZipFile => 'Pasirinkti ZIP failą';

  @override
  String get settingsUploading => 'Įkeliama...';

  @override
  String get settingsErrorDiagnostics =>
      'Klaidų diagnostika ir sistemos žurnalai';

  @override
  String get settingsLogsCopied => 'Žurnalai nukopijuoti į iškarpinę! 📋';

  @override
  String get settingsCopyLogs => 'Kopijuoti žurnalus';

  @override
  String get settingsLogsRotated => 'Žurnalai archyvuoti ir rotuoti! 📁';

  @override
  String get settingsRotate => 'Rotuoti';

  @override
  String get settingsClear => 'Išvalyti';

  @override
  String get settingsLogLimit => 'Žurnalo riba: ';

  @override
  String get settingsNoLogs => 'Įrašytų žurnalų nėra';

  @override
  String get layoutMenu => 'Meniu';

  @override
  String get layoutNavAnalytics => 'Analitika';

  @override
  String get layoutNavReviewQueue => 'Peržiūros eilė';

  @override
  String get layoutNavGlossary => 'Žodynėlis';

  @override
  String get layoutNavCategories => 'Kategorijos';

  @override
  String get layoutNavHelp => 'Pagalba';

  @override
  String get layoutNavSettings => 'Nustatymai';

  @override
  String get layoutPhotoBy => 'Nuotrauka: ';

  @override
  String get layoutPhotoOn => ' – ';

  @override
  String get layoutEditProfile => 'Redaguoti profilį';

  @override
  String get layoutLogout => 'Atsijungti';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Šviesi';

  @override
  String get layoutThemeDark => 'Tamsi';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'TIKSLINĖ KALBA';

  @override
  String get layoutDeeplUsage => 'DEEPL NAUDOJIMAS';

  @override
  String get layoutUnavailable => 'Nepasiekiama';

  @override
  String get layoutUnlimited => 'neribota';

  @override
  String get layoutUsed => 'panaudota';

  @override
  String get layoutTranslate => 'Versti';

  @override
  String get analyticsSubtitle =>
      'Suderinamumas, vertimų atsilikimas ir savaitiniai trendai.';

  @override
  String get analyticsBacklog => 'Vertimų atsilikimas';

  @override
  String get analyticsMissing => 'Trūksta';

  @override
  String get analyticsStale => 'Pasenę';

  @override
  String get analyticsInReview => 'Peržiūrima';

  @override
  String get analyticsReleased => 'Paskelbta';

  @override
  String get analyticsTranslated => 'Išversta';

  @override
  String get analyticsTotalModules => 'Iš viso modulių';

  @override
  String get analyticsCompatByVersion => 'Suderinamumas pagal Drupal versiją';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Kalba: $lang · paskelbta / peržiūrima / trūksta';
  }

  @override
  String get analyticsLoadingCounts => 'Įkeliami skaičiai …';

  @override
  String get analyticsWindow => 'Laikotarpis:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks sav.';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nauji projektų aprašymai per savaitę';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Pažymėta pasenusiais per savaitę ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modulių';
  }

  @override
  String get analyticsReviewShort => 'Peržiūra';

  @override
  String get analyticsNoDataInWindow => 'Šiuo laikotarpiu duomenų nėra.';

  @override
  String get analyticsAndMore => '… ir daugiau';

  @override
  String glossaryLoadError(String error) {
    return 'Įkėlimo klaida: $error';
  }

  @override
  String get glossaryNewTerm => 'Sukurti naują terminą';

  @override
  String get glossaryEditTerm => 'Redaguoti terminą';

  @override
  String get glossaryFieldSourceWord =>
      'Šaltinio žodis (pagrindinė forma, kaip pateikta tekste)';

  @override
  String get glossaryFieldSourceWordHint => 'pvz., node';

  @override
  String get glossaryWordForms =>
      'Papildomos žodžio formos (daugiskaita, kilmininkas, naudininkas …)';

  @override
  String get glossaryWordFormsHint =>
      'pvz., content — norėdami pridėti, paspauskite Enter';

  @override
  String get glossaryAddForm => 'Pridėti formą';

  @override
  String get glossaryFieldPreferredWord => 'Pageidaujamas vertimas';

  @override
  String get glossaryFieldPreferredWordHint => 'pvz., content';

  @override
  String get glossaryFieldExplanation => 'Paaiškinimas (rodomas patarime)';

  @override
  String get glossaryFieldExplanationHint =>
      'Kodėl šis žodis turėtų būti verčiamas kitaip?';

  @override
  String get glossaryCreate => 'Sukurti';

  @override
  String get glossaryRequiredFields =>
      'Būtina nurodyti šaltinio žodį ir pageidaujamą vertimą.';

  @override
  String get glossaryCreated => 'Terminas sukurtas ✓';

  @override
  String get glossaryUpdated => 'Terminas atnaujintas ✓';

  @override
  String glossaryError(String error) {
    return 'Klaida: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Ištrinti terminą?';

  @override
  String glossaryDeleteBody(String word) {
    return '„$word“ bus negrįžtamai pašalintas iš žodynėlio.';
  }

  @override
  String get glossaryDeleted => 'Terminas ištrintas.';

  @override
  String get glossaryTitle => 'Vertimo žodynėlis';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Kalba: $lang · $count įrašų';
  }

  @override
  String get glossaryNewShort => 'Naujas';

  @override
  String get glossaryCreateTerm => 'Sukurti terminą';

  @override
  String get glossaryInfoBanner =>
      'Šio žodynėlio žodžiai paryškinami peržiūros redaktoriuje. Užvedus žymeklį patarimas paaiškina, kodėl geriau tinka kitas vertimas.';

  @override
  String get glossaryNoEntries => 'Įrašų dar nėra.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Spustelėkite „Sukurti terminą“, kad sukurtumėte pirmą įrašą.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Šiai kalbai žodynėlio įrašų dar nėra.';

  @override
  String get diffNoChanges => 'Turinio skirtumų neaptikta.';

  @override
  String get diffRemoved => 'Pašalinta';

  @override
  String get diffAdded => 'Pridėta';

  @override
  String syncBarQuickSync(String count) {
    return 'Greitas sinchronizavimas: $count pakeistų modulių …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Pilnas sinchronizavimas: $current / $total modulių';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Pilnas sinchronizavimas: $count modulių …';
  }
}
