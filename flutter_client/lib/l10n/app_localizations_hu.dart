// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Projekt adatainak betöltése...';

  @override
  String editorLoadError(String error) {
    return 'Nem sikerült betölteni a projekt adatait: $error';
  }

  @override
  String get editorGeminiSuccess => 'A Gemini fordítás sikeres! ✨';

  @override
  String get editorUnknownError => 'Ismeretlen hiba';

  @override
  String editorGeminiFailed(String detail) {
    return 'A Gemini fordítás sikertelen: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Kérjük, adja meg a Google AI kulcsát a felhasználói profiljában (nem az admin beállításokban).';

  @override
  String get editorGeminiError =>
      'Hiba történt a Gemini fordítás során. Ellenőrizze a Google AI kulcsát a profiljában.';

  @override
  String get editorDeeplSuccess => 'A DeepL fordítás sikeres! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'A DeepL fordítás sikertelen: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Hiba történt a DeepL fordítás során. Győződjön meg róla, hogy a DeepL API-kulcsa be van állítva a profiljában.';

  @override
  String get editorDeeplInvalidKey =>
      'Érvénytelen DeepL API-kulcs. Ellenőrizze a profiljában.';

  @override
  String get editorDeeplQuotaExceeded =>
      'A DeepL kvóta kimerült. Ellenőrizze az előfizetését.';

  @override
  String get editorReviewReset =>
      'A fordítás visszaállítva felülvizsgálati állapotba.';

  @override
  String editorResetError(String error) {
    return 'Nem sikerült visszaállítani: $error';
  }

  @override
  String get editorUnignoreSuccess => 'A modul visszakerült az aktív listára.';

  @override
  String get editorUnignoreError =>
      'Nem sikerült visszaállítani a modult a mellőzöttek listájáról.';

  @override
  String get editorSaveSuccess =>
      'A fordítás mentve — vissza a felülvizsgálati sorba.';

  @override
  String editorSaveError(String error) {
    return 'Nem sikerült menteni: $error';
  }

  @override
  String get editorNoMoreProjects => 'Nincs több nyitott projekt a listában.';

  @override
  String get editorChangesDiscarded =>
      'Változtatások elvetve, következő projekt betöltése...';

  @override
  String get editorEnglishSourceApplied =>
      'Az angol eredeti alkalmazva — most fordítsa le.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Nem sikerült megnyitni az URL-t: $url';
  }

  @override
  String get commonSave => 'Mentés';

  @override
  String get commonClose => 'Bezárás';

  @override
  String get editorCloseEnglishSource => 'Angol forrás bezárása';

  @override
  String get editorShowEnglishSource => 'Angol forrás megjelenítése';

  @override
  String get editorUnignoreShortTooltip => 'Modul visszaállítása';

  @override
  String get editorBackToReviewTooltip => 'Vissza felülvizsgálatra';

  @override
  String get editorAndNext => 'és következő';

  @override
  String get editorBackToDashboard => 'Vissza az irányítópulthoz';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Fordítás erre: $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count hátravan';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Modul visszahelyezése az aktív listára';

  @override
  String get editorUnignoreLabel => 'Visszaállítás';

  @override
  String get editorUnpublishTooltip =>
      'Közzététel visszavonása és felülvizsgálatra állítás';

  @override
  String get editorBackToReview => 'Vissza a felülvizsgálathoz';

  @override
  String get editorSaveAndNext => 'Mentés és következő';

  @override
  String get editorEnglishSourceHeader => 'ANGOL FORRÁS';

  @override
  String get editorStaleTooltip =>
      'Magyarázat megjelenítése és angol szöveg alkalmazása';

  @override
  String get editorStaleDetailsLabel => 'Elavult — Részletek';

  @override
  String get editorCopyPromptTooltip => 'Forrás és fordítási prompt másolása';

  @override
  String get editorPromptCopied => 'Prompt vágólapra másolva 📋';

  @override
  String get editorShowPreview => 'Előnézet megjelenítése';

  @override
  String get editorShowHtmlSource => 'HTML forrás megjelenítése';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'ÖSSZEFOGLALÓ:\n$summary\n\nTÖRZS:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Összefoglaló:';

  @override
  String get editorDescriptionLabelColon => 'Leírás:';

  @override
  String get editorStaleDialogTitle => 'Az angol forrás megváltozott';

  @override
  String get editorStaleExplanation =>
      'A meglévő fordítás egy elavult angol eredeti szövegen alapul. Az utolsó fordítás óta a modul karbantartója módosította az angol szöveget a Drupal.org-on — ezért előfordulhat, hogy a meglévő fordítás tartalma már nem pontos vagy nem teljes.';

  @override
  String get editorStaleTip =>
      'Tipp: kattintson az „Angol eredeti használata” gombra, hogy az aktuális angol forrást közvetlenül betöltse a szerkesztőbe. Ezt aztán kiindulópontként használhatja egy friss fordításhoz. Az angol eredeti a bal oldali panelen is látható.';

  @override
  String get editorEnglishSourceShort => 'Angol forrás';

  @override
  String get editorPreviousTranslation => 'Korábbi fordítás';

  @override
  String get editorWhatChangedTitle => 'Mi változott?';

  @override
  String get editorShowDiff => 'Eltérések megjelenítése';

  @override
  String get editorUseEnglish => 'Angol eredeti használata';

  @override
  String get editorStaleBannerText =>
      'Az angol forrás megváltozott — a fordítás elavult';

  @override
  String get editorDetailsAndApply => 'Részletek és alkalmazás';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName FORDÍTÁS';
  }

  @override
  String get editorTranslatingEllipsis => 'Fordítás folyamatban...';

  @override
  String get editorShowEditor => 'Szerkesztő megjelenítése';

  @override
  String get editorModuleTitleLabel => 'Modul címe (angol)';

  @override
  String get editorSummaryFieldLabel => 'Összefoglaló';

  @override
  String get editorBodyFieldLabel => 'Törzsszöveg';

  @override
  String get editorHtmlCleaned => 'HTML megtisztítva';

  @override
  String get editorLivePreviewHeader => 'ÉLŐ ELŐNÉZET';

  @override
  String get editorTidyHtmlTooltip =>
      'HTML megtisztítása (DeepL-maradványok eltávolítása)';

  @override
  String get editorVisualMode => 'VIZUÁLIS';

  @override
  String get editorSourceCodeMode => 'FORRÁS (HTML)';

  @override
  String get commonCancel => 'Mégse';

  @override
  String get costDialogTitle => 'Költségbecslés (AI)';

  @override
  String get costDialogIntro =>
      'A kiválasztott modult a Google Gemini AI fogja lefordítani. Az alábbiakban a becsült költségbontás látható erre a műveletre:';

  @override
  String get costRowModel => 'Modell';

  @override
  String get costRowInputTokens => 'Bemeneti tokenek';

  @override
  String get costRowOutputTokens => 'Kimeneti tokenek (becslés)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars karakter)';
  }

  @override
  String get costRowPriceInput => 'Ár 1M bemeneti tokenenként';

  @override
  String get costRowPriceOutput => 'Ár 1M kimeneti tokenenként';

  @override
  String get costRowTotalEstimate => 'Becsült teljes költség';

  @override
  String get costDialogFootnote =>
      '* Megjegyzés: Ez egy becslés a Google jelenlegi, használat alapú árazási modellje alapján. A tényleges költség kissé eltérhet.';

  @override
  String get costDialogStartTranslation => 'Fordítás indítása';

  @override
  String get htmlToolbarInsertLink => 'Hivatkozás beszúrása';

  @override
  String get htmlToolbarLinkTooltip => 'Hivatkozás beszúrása (a)';

  @override
  String get htmlToolbarInsert => 'Beszúrás';

  @override
  String get htmlToolbarHeading2 => '2. szintű címsor';

  @override
  String get htmlToolbarHeading3 => '3. szintű címsor';

  @override
  String get htmlToolbarBold => 'Félkövér (strong)';

  @override
  String get htmlToolbarItalic => 'Dőlt (em)';

  @override
  String get htmlToolbarBulletList => 'Felsorolás (ul)';

  @override
  String get htmlToolbarNumberedList => 'Számozott lista (ol)';

  @override
  String get htmlToolbarQuote => 'Idézet (blockquote)';

  @override
  String get screenshotAltsHeader => 'KÉPERNYŐKÉP ALTERNATÍV SZÖVEG';

  @override
  String get screenshotAltsIntro =>
      'Adjon meg egy leíró alternatív szöveget a célnyelven minden képernyőképhez.';

  @override
  String screenshotLabel(int number) {
    return '$number. képernyőkép';
  }

  @override
  String get screenshotPreviewUnavailable => 'Előnézet nem elérhető';

  @override
  String get screenshotAltHint =>
      'Adja meg az alternatív szöveget a célnyelven…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Visszaállítja az összes modult?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Az összes mellőzött modul visszakerül az aktív listára, és ismét elérhető lesz fordításra.';

  @override
  String get dashUnignoreAllConfirmAction => 'Összes visszaállítása';

  @override
  String get dashUnignoreAllSuccess =>
      'Az összes mellőzött modul visszaállítva.';

  @override
  String get dashUnignoreAllError => 'Nem sikerült visszaállítani a modulokat.';

  @override
  String get dashUnignoreAllButton => 'Összes modul visszaállítása';

  @override
  String dashSyncStartError(String error) {
    return 'Nem sikerült elindítani a szinkronizálást: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Gyors frissítés (7 nap) elindítva ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Gyors frissítési hiba: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sikeres szinkronizálás: $name';
  }

  @override
  String get dashManualSyncNotFound => 'A modul nem található a Drupal.org-on.';

  @override
  String get dashAiBulkTranslation => 'AI tömeges fordítás';

  @override
  String get dashHeaderTitle => 'Projektleírások';

  @override
  String get dashHeaderSubtitle =>
      'Fordítsa le a Drupal modulok leírásait a célnyelvre. Segítsen elérhetőbbé tenni az ökoszisztémát.';

  @override
  String get dashHeaderSubtitleShort => 'Drupal modulleírások fordítása.';

  @override
  String get dashLastLabel => 'Utolsó: ';

  @override
  String get dashContinue => 'Folytatás';

  @override
  String get dashContinueShort => 'Folytatás';

  @override
  String get dashUnignoreAllButtonLong => 'Összes modul visszaállítása';

  @override
  String get dashQuickUpdateTooltip => 'Gyors frissítés (utolsó 7 nap)';

  @override
  String get dashFullSyncTooltip =>
      'Teljes adatbázis-szinkronizálás a Drupal.org-ról';

  @override
  String get dashManualLoadTooltip =>
      'Egyetlen modul manuális betöltése a Drupal.org-ról';

  @override
  String get dashQuickShort => 'Gyors';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Találat: ';

  @override
  String get dashModulesSuffix => ' modul';

  @override
  String dashPerPage(int count) {
    return '$count / oldal';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / oldal';
  }

  @override
  String get dashFirstPage => 'Első oldal';

  @override
  String get dashPrevPage => 'Előző oldal';

  @override
  String get dashNextPage => 'Következő oldal';

  @override
  String get dashLastPage => 'Utolsó oldal';

  @override
  String dashPageOf(int page, int total) {
    return '$page. oldal / $total';
  }

  @override
  String get dashMachineNameHint => 'gépi_név (pl. pathauto)';

  @override
  String get dashAddButton => 'Hozzáadás';

  @override
  String get dashAddModuleManually => 'Modul hozzáadása manuálisan';

  @override
  String get dashAddModuleSubtitle =>
      'Betöltés közvetlenül a Drupal.org-ról a gépi név alapján.';

  @override
  String get dashAddModuleShort => 'Modul hozzáadása';

  @override
  String get dashNoProjectsFound => 'Nem található projekt.';

  @override
  String get dashFilterAll => 'Összes projekt';

  @override
  String get dashFilterMissing => 'Hiányzó fordítások';

  @override
  String get dashFilterReview => 'Felülvizsgálati sor';

  @override
  String get dashFilterTranslated => 'Lefordított projektek';

  @override
  String get dashFilterReleased => 'Közzétett projektek';

  @override
  String get dashBulkDialogIntro =>
      'Automatikusan lefordítja a kiválasztott szűrőnek megfelelő modulokat a Google Gemini segítségével.';

  @override
  String get dashActiveFilter => 'Aktív szűrő';

  @override
  String get dashModuleCount => 'Modulok száma';

  @override
  String dashModulesCountItem(int count) {
    return '$count modul';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12 modulok előnyben részesítése';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Előbb azokat a modulokat fordítja, amelyek nem támogatják a Drupal 12-t';

  @override
  String get dashTotalModules => 'Modulok összesen';

  @override
  String get dashInputTokensEst => 'Bemeneti tokenek (becslés)';

  @override
  String get dashOutputTokensEst => 'Kimeneti tokenek (becslés)';

  @override
  String get dashBulkFootnote =>
      '* A fordítás erőforrás-kímélő kötegekben zajlik az időtúllépések elkerülése érdekében.';

  @override
  String get dashStartBulkTranslation => 'Tömeges fordítás indítása';

  @override
  String dashStaleLoadError(String error) {
    return 'Hiba az elavult modulok betöltésekor: $error';
  }

  @override
  String get dashNoStaleModules => 'Nincs elavult modul — minden naprakész! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Elavult modulok újrafordítása';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Minden olyan fordítás, amelynek angol forrása az utolsó fordítás óta megváltozott, automatikusan újrafordításra kerül a Google Gemini segítségével. Nem szükséges minden modult egyenként megnyitni.';

  @override
  String get dashOutdatedModules => 'Elavult modulok';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* A fordítás felülírja a meglévő szöveget, és visszaállítja az is_reviewed állapotot. 4 moduls kötegekben fut.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Mind a(z) $count modul újrafordítása';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Elavult modulok újrafordítása folyamatban…';

  @override
  String get dashFetchingProjects => 'Projektek lekérése a szerverről…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed / $total modul feldolgozva';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Nem található fordítható projekt ehhez a szűrőhöz.';

  @override
  String get dashStartingTranslation => 'Fordítás indítása…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return '$start–$end. modul fordítása / $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end / $total modul kész.';
  }

  @override
  String get dashTranslationCompleted => 'A fordítás sikeresen befejeződött! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '$count modul tömeges fordítása sikeres! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Tömeges fordítási hiba: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Mind a(z) $count modul sikeresen újrafordítva! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count elavult modul sikeresen újrafordítva! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Hiba az újrafordítás során: $error';
  }

  @override
  String get filterAllShort => 'Összes';

  @override
  String get filterMissing => 'Hiányzó';

  @override
  String get filterTranslated => 'Lefordított';

  @override
  String get filterReviewQueue => 'Felülvizsgálati sor';

  @override
  String get filterReleased => 'Közzétett';

  @override
  String get filterOutdated => 'Elavult';

  @override
  String get filterPriority => 'Prioritás';

  @override
  String get filterIgnored => 'Mellőzött';

  @override
  String get commonEdit => 'Szerkesztés';

  @override
  String get commonReset => 'Visszaállítás';

  @override
  String get commonRefresh => 'Frissítés';

  @override
  String commonErrorPrefix(String error) {
    return 'Hiba: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Visszaállítja az összes közzétett fordítást?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Minden $langcode nyelvre közzétettként megjelölt fordítás felülvizsgálati állapotba kerül vissza. Ez nem vonható vissza.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count fordítás visszaállítva felülvizsgálati állapotba.';
  }

  @override
  String get reviewPipelineTitle => 'Felülvizsgálati folyamat';

  @override
  String get reviewPipelineSubtitle =>
      'Emberi minőségbiztosítási folyamat az AI-fordításokhoz';

  @override
  String get reviewSearchHint => 'Projektek keresése...';

  @override
  String get reviewResetPublished => 'Közzétettek visszaállítása';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Találatok: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Függőben: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Nincs felülvizsgálatra váró projekt.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Minden fordítás már ellenőrizve van, vagy egy sem létezik ebben a nyelvi kontextusban.';

  @override
  String get reviewNoSummary => 'Nincs összefoglaló.';

  @override
  String get reviewStartAudit => 'ELLENŐRZÉS INDÍTÁSA';

  @override
  String get reviewHtmlSourceShort => 'HTML forrás';

  @override
  String get reviewCopySource => 'Forrás másolása';

  @override
  String get reviewModuleDetails => 'Modul részletei';

  @override
  String get reviewOriginalTitle => 'Eredeti cím';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org projekt';

  @override
  String get reviewSuggestions => 'Javaslatok';

  @override
  String get reviewNoSuggestions => 'Nincs elérhető javaslat.';

  @override
  String get reviewApply => 'Alkalmaz';

  @override
  String get reviewNoChanges => 'Nincs változás';

  @override
  String get reviewOriginalBeforeCorrection => 'Eredeti (javítás előtt)';

  @override
  String get reviewCorrectedCurrentVersion => 'Javított (jelenlegi verzió)';

  @override
  String get reviewBaseOriginal => 'Alap (eredeti)';

  @override
  String get reviewYourCorrection => 'Az Ön javítása';

  @override
  String get reviewChangesVisual => 'Változtatások áttekintése (vizuális)';

  @override
  String get commonSkip => 'Kihagyás';

  @override
  String get commonIgnore => 'Mellőzés';

  @override
  String get reviewEmptyProjectTitle => 'Üres projekt';

  @override
  String get reviewEmptyProjectBody =>
      'Ez a projekt üres (nincs cím, összefoglaló vagy törzsszöveg), ezért nem hagyható jóvá. Kérjük, hagyja ki.';

  @override
  String get reviewApprovedSuccess => 'A fordítás jóváhagyva! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ A(z) „$machine” jóváhagyása sikertelen — próbálja újra.';
  }

  @override
  String get reviewUnignoredSuccess => 'Visszaállítva. A modul ismét aktív!';

  @override
  String get reviewActionFailed => 'A művelet sikertelen.';

  @override
  String get reviewIgnoreModuleTitle => 'Mellőzi a modult?';

  @override
  String get reviewIgnoreModuleBody =>
      'Ez a modul véglegesen elrejtésre kerül minden listáról. Többé nem akad el rajta.';

  @override
  String get reviewModulePermanentlyIgnored => 'A modul véglegesen mellőzve.';

  @override
  String get reviewIgnoreFailed => 'Nem sikerült mellőzni a modult.';

  @override
  String get reviewSuggestionSaved => 'A javaslat piszkozata mentve! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Nem sikerült menteni a javaslat piszkozatát.';

  @override
  String get reviewSuggestionDeleted => 'A javaslat törölve.';

  @override
  String get reviewDeleteFailed => 'Nem sikerült törölni.';

  @override
  String get reviewSuggestionApplied => 'A javaslat alkalmazva.';

  @override
  String get reviewPreparingData => 'Felülvizsgálati adatok előkészítése...';

  @override
  String get reviewDirectEdit => 'Közvetlen szerkesztés';

  @override
  String get reviewLivePreview => 'Élő előnézet';

  @override
  String get reviewCompareWith => 'Összehasonlítás ezzel:';

  @override
  String get reviewProductionVersion => 'Éles verzió';

  @override
  String get reviewEditorialReview => 'Szerkesztői felülvizsgálat';

  @override
  String get reviewOpenQueue => 'Felülvizsgálati sor megnyitása';

  @override
  String get reviewCopyPromptShort => 'Prompt másolása';

  @override
  String get reviewUnignoreShort => 'Visszaállítás';

  @override
  String get reviewApproveButton => 'JÓVÁHAGYÁS';

  @override
  String get reviewHideDetails => 'Részletek elrejtése';

  @override
  String get reviewDetailsAndEnglishSource => 'Részletek és angol forrás';

  @override
  String reviewPendingCountShort(int count) {
    return '$count függőben';
  }

  @override
  String reviewReviewingModule(String name) {
    return '$name felülvizsgálata';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Fordítás összehasonlítása az angol forrással';

  @override
  String get reviewTranslationLabel => 'Fordítás';

  @override
  String get reviewComparisonTitle => 'Összehasonlítás';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Forrásszöveg és fordítási prompt másolása vágólapra';

  @override
  String get reviewUnignoreCaps => 'VISSZAÁLLÍTÁS';

  @override
  String get reviewIgnoreCaps => 'MELLŐZÉS';

  @override
  String get reviewSkipShortcut => 'KIHAGYÁS (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Szerkesztői felülvizsgálat';

  @override
  String get reviewUnignoreTablet => 'VISSZAÁLLÍTÁS';

  @override
  String get reviewApproveForProduction =>
      'JÓVÁHAGYÁS ÉLES KIADÁSRA (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Közvetlen finomítás';

  @override
  String get reviewTitleField => 'Cím';

  @override
  String get reviewSummaryField => 'Összefoglaló';

  @override
  String get reviewBodyField => 'Törzsszöveg';

  @override
  String get reviewSaveShortcut => 'MENTÉS (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Élő előnézet (renderelés)';

  @override
  String get reviewVoiceFemale => 'Női';

  @override
  String get reviewVoiceMale => 'Férfi';

  @override
  String get reviewStopListening => 'Leállítás';

  @override
  String get reviewListen => 'Meghallgatás';

  @override
  String get reviewAutopTooltip =>
      'Bekezdések automatikus formázása (sortörés → <p>)';

  @override
  String get reviewSourceCodeShort => 'FORRÁS';

  @override
  String get reviewNoParagraphChange =>
      'A szöveg már tartalmaz <p> címkéket — nincs változás';

  @override
  String get reviewParagraphsFormatted => 'Bekezdések formázva ¶';

  @override
  String get commonRetry => 'Újra';

  @override
  String categoriesLoadError(String error) {
    return 'Nem sikerült betölteni a kategóriákat: $error';
  }

  @override
  String get categoriesSaveSuccess => 'A kategóriák sikeresen mentve.';

  @override
  String get categoriesSaveFailed => 'Nem sikerült menteni a fordításokat.';

  @override
  String get categoriesFileEmpty => 'A fájl üres.';

  @override
  String get categoriesInvalidJson => 'Érvénytelen JSON formátum.';

  @override
  String get categoriesNoValidUuids =>
      'Nem található érvényes UUID bejegyzés a fájlban.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count kategória importálva a fájlból.';
  }

  @override
  String get categoriesTitle => 'Kategóriák';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Fordítás ehhez: $lang';
  }

  @override
  String get categoriesImportJson => 'JSON importálása';

  @override
  String get categoriesSaving => 'Mentés...';

  @override
  String get categoriesSaveAll => 'Összes mentése';

  @override
  String get categoriesLoading => 'Kategóriák betöltése...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Fordítás ($code)';
  }

  @override
  String get categoriesNoneFound => 'Nem található kategória.';

  @override
  String categoriesTranslateHint(String name) {
    return '„$name” fordítása...';
  }

  @override
  String get loginPhotoBy => 'Fotó: ';

  @override
  String get loginPhotoOn => ' – ';

  @override
  String get loginPleaseSignIn => 'Kérjük, jelentkezzen be';

  @override
  String get loginUsername => 'Felhasználónév';

  @override
  String get loginPassword => 'Jelszó';

  @override
  String get loginRememberMe => 'Emlékezz rám';

  @override
  String get loginSignIn => 'BEJELENTKEZÉS';

  @override
  String get loginNoAccount => 'Még nincs fiókja? ';

  @override
  String get loginRegisterNow => 'Regisztráljon most';

  @override
  String get commonBack => 'Vissza';

  @override
  String get commonNext => 'Következő';

  @override
  String get registerFillRequired =>
      'Kérjük, töltse ki az összes kötelező mezőt.';

  @override
  String get registerPasswordMismatch => 'A jelszavak nem egyeznek.';

  @override
  String get registerPasswordTooShort =>
      'A jelszónak legalább 8 karakter hosszúnak kell lennie.';

  @override
  String get registerSelectLanguage =>
      'Kérjük, válasszon legalább egy nyelvet.';

  @override
  String get registerFailed => 'A regisztráció sikertelen.';

  @override
  String get registerHeaderTitle => 'REGISZTRÁCIÓ';

  @override
  String get registerStepAccount => 'Fiók';

  @override
  String get registerStepRole => 'Szerepkör';

  @override
  String get registerStepLanguages => 'Nyelvek';

  @override
  String get registerStepApiKeys => 'API-kulcsok';

  @override
  String get registerYourAccount => 'Az Ön fiókja';

  @override
  String get registerAvatarOptional => 'Profilkép (opcionális)';

  @override
  String get registerUsernameRequired => 'Felhasználónév *';

  @override
  String get registerEmailRequired => 'E-mail cím *';

  @override
  String get registerPasswordRequired => 'Jelszó *';

  @override
  String get registerPasswordRepeat => 'Jelszó megismétlése *';

  @override
  String get registerYourRole => 'Az Ön szerepköre';

  @override
  String get registerRoleExplanation =>
      'A fordítók fordíthatnak szövegeket, de nem férnek hozzá a felülvizsgálati sorhoz. A felülvizsgálók ellenőrzik és jóváhagyják a lefordított tartalmat.';

  @override
  String get registerRoleTranslator => 'Fordító';

  @override
  String get registerRoleTranslatorDesc =>
      'Fordítások létrehozása és szerkesztése.';

  @override
  String get registerRoleReviewer => 'Felülvizsgáló';

  @override
  String get registerRoleReviewerDesc =>
      'Fordítások felülvizsgálata és jóváhagyása.';

  @override
  String get registerTargetLanguages => 'Célnyelvek';

  @override
  String get registerLanguagesExplanation =>
      'Válassza ki az összes nyelvet, amelyen dolgozni szeretne.';

  @override
  String get registerNoLanguagesAvailable => 'Nincs elérhető nyelv.';

  @override
  String get registerApiKeysTitle => 'API-kulcsok';

  @override
  String get registerApiKeysExplanation =>
      'Adja meg saját API-kulcsait. Minden felhasználó kizárólag a saját kulcsait használja. Ezeket később a profiljában is hozzáadhatja.';

  @override
  String get registerKeysEncryptedNote =>
      'A kulcsok titkosítva vannak tárolva, és soha nem kerülnek megosztásra más felhasználókkal.';

  @override
  String get registerOptionalSuffix => ' (opcionális)';

  @override
  String get registerSuccessTitle => 'Sikeres regisztráció!';

  @override
  String get registerSuccessBody =>
      'A fiókja létrejött, és egy adminisztrátor jóváhagyására vár. Amint a hozzáférése aktiválva lesz, értesítést kap.';

  @override
  String get registerGoToLogin => 'Tovább a bejelentkezéshez';

  @override
  String get registerSubmit => 'Regisztráció';

  @override
  String registerPhotoCredit(String name) {
    return 'Fotó: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'A profil sikeresen frissítve!';

  @override
  String get profileUpdateFailed => 'A frissítés sikertelen.';

  @override
  String profileSaveError(String error) {
    return 'Hiba a mentés során: $error';
  }

  @override
  String get profilePasswordMismatch => 'A jelszavak nem egyeznek!';

  @override
  String get profilePasswordChangeSuccess =>
      'A jelszó sikeresen megváltoztatva!';

  @override
  String get profilePasswordChangeError =>
      'Hiba a jelszó megváltoztatása során: helytelen jelenlegi jelszó.';

  @override
  String get profileAvatarUploadSuccess => 'A profilkép sikeresen feltöltve!';

  @override
  String get profileAvatarUploadError => 'Hiba a profilkép feltöltése során.';

  @override
  String get profileTitle => 'Profil és beállítások';

  @override
  String get profileSubtitle =>
      'Kezelje felhasználói profilját, fordítási API-jait (Gemini és DeepL), valamint fiókja biztonságát.';

  @override
  String get profileRoleUser => 'Felhasználó';

  @override
  String get profileNoEmail => 'Nincs megadva e-mail cím';

  @override
  String get profileTabDetails => 'Profil adatai';

  @override
  String get profileTabGemini => 'AI fordítás (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL fordítás';

  @override
  String get profileTabPassword => 'Jelszó megváltoztatása';

  @override
  String get profileSectionInfo => 'PROFIL ADATOK';

  @override
  String get profileFieldName => 'Név';

  @override
  String get profileFieldNameHint => 'Az Ön teljes neve';

  @override
  String get profileFieldEmail => 'E-mail cím';

  @override
  String get profileFieldEmailHint => 'Az Ön e-mail címe';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT BEÁLLÍTÁSOK';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API-kulcs';

  @override
  String get profileFieldGeminiKeyHint =>
      'Adja meg a gemini-3.1-flash API-kulcsát';

  @override
  String get profileFieldAiPrompt => 'Egyéni AI prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Opcionális: testreszabhatja a Gemini rendszerpromptját...';

  @override
  String get profileSectionDeepl => 'DEEPL FORDÍTÁSI BEÁLLÍTÁSOK';

  @override
  String get profileDeeplDescription =>
      'A DeepL kiváló minőségű gépi fordítást kínál a HTML-címkék megőrzésével. Az ingyenes fiókok (500 000 karakter/hónap) „:fx” utótagú kulcsot kapnak.';

  @override
  String get profileFieldDeeplKey => 'DeepL API-kulcs';

  @override
  String get profileFieldDeeplKeyHint =>
      'pl. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Az ingyenes kulcsok „:fx” végződésűek, és az api-free.deepl.com-ot használják. A Pro kulcsok az api.deepl.com-ot használják. A megkülönböztetés automatikusan történik.';

  @override
  String get profileSectionSecurity => 'FIÓKBIZTONSÁG';

  @override
  String get profileFieldCurrentPassword => 'Jelenlegi jelszó';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Adja meg a jelenlegi jelszavát';

  @override
  String get profileFieldNewPassword => 'Új jelszó';

  @override
  String get profileFieldNewPasswordHint => 'Legalább 6 karakter';

  @override
  String get profileFieldConfirmPassword => 'Új jelszó megerősítése';

  @override
  String get profileFieldConfirmPasswordHint => 'Ismételje meg a jelszót';

  @override
  String get profileChangePasswordButton => 'Jelszó megváltoztatása';

  @override
  String get commonDelete => 'Törlés';

  @override
  String get settingsRegistrationUpdated => 'Regisztrációs beállítás frissítve';

  @override
  String get settingsUpdateFailed => 'A frissítés sikertelen.';

  @override
  String get settingsUserApproved => 'Felhasználó jóváhagyva!';

  @override
  String get settingsAccountDeactivated => 'A fiók deaktiválva.';

  @override
  String get settingsUserDeleted => 'A felhasználó törölve.';

  @override
  String get settingsActionFailed => 'A művelet sikertelen.';

  @override
  String get settingsDeleteAccountTitle => 'Törli a fiókot?';

  @override
  String get settingsDeactivateAccountTitle => 'Deaktiválja a fiókot?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'A(z) „$username” fiók véglegesen törlésre kerül. Folytatja?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'A(z) „$username” fiók zárolásra kerül. A felhasználó nem tud bejelentkezni, de a fiók megmarad.';
  }

  @override
  String get settingsDeactivate => 'Deaktiválás';

  @override
  String settingsSyncSuccess(String count) {
    return '$count fordítás szinkronizálva!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Szinkronizálási hiba: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioritásos modul szinkronizálva!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Hiba a prioritási lista szinkronizálásakor: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Sikeres biztonsági mentés: $count fájl feldolgozva.';
  }

  @override
  String get settingsUploadFailed => 'A feltöltés sikertelen.';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get settingsSystemConfig => 'RENDSZERKONFIGURÁCIÓ';

  @override
  String get settingsRegistration => 'Regisztráció';

  @override
  String get settingsRegistrationHint =>
      'A globális regisztrációs űrlap láthatóságának ki- és bekapcsolása.';

  @override
  String get settingsPendingUsers => 'Függőben lévő felhasználók';

  @override
  String get settingsNoNewRequests => 'Nincs új kérelem.';

  @override
  String get settingsWantsReviewer => 'Felülvizsgáló szeretne lenni';

  @override
  String get settingsAssignRole => 'Szerepkör hozzárendelése';

  @override
  String get settingsRoleTranslator => 'Fordító';

  @override
  String get settingsRoleReviewer => 'Felülvizsgáló';

  @override
  String get settingsApprove => 'Jóváhagyás';

  @override
  String get settingsReject => 'Elutasítás';

  @override
  String get settingsActiveUsers => 'Aktív felhasználók';

  @override
  String get settingsNoActiveUsers => 'Nincs aktív felhasználó.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deaktiválás';

  @override
  String get settingsDeleteAccountAction => 'Fiók törlése';

  @override
  String get settingsAppearance => 'Megjelenés';

  @override
  String get settingsThemePearl => 'VILÁGOS (GYÖNGY)';

  @override
  String get settingsThemeDark => 'SÖTÉT';

  @override
  String get settingsThemeGlassy => 'ÜVEGES';

  @override
  String get settingsThemeNature => 'TERMÉSZET';

  @override
  String get settingsThemeLiquid => 'FOLYÉKONY';

  @override
  String get settingsThemeStage => 'SZÍNPAD';

  @override
  String get settingsTypography => 'Tipográfia';

  @override
  String get settingsFontHint => 'A felület betűtípus-családjának módosítása.';

  @override
  String get settingsFontClean => 'Letisztult';

  @override
  String get settingsFontFuturistic => 'Futurisztikus';

  @override
  String get settingsFontTech => 'Technikai';

  @override
  String get settingsWorkflowFun => 'Munkafolyamat és szórakozás';

  @override
  String get settingsConfettiTitle => 'Sikerünnepség (konfetti)';

  @override
  String get settingsConfettiHint =>
      'Kis animációt jelenít meg sikeres mentéskor.';

  @override
  String get settingsLargeUiTitle => 'Fokozott olvashatóság (nagy betűméret)';

  @override
  String get settingsLargeUiHint =>
      'Megnöveli a betűtípusok és jelvények méretét az olvashatóság érdekében.';

  @override
  String get settingsAutoPTitle => 'Automatikus bekezdésformázás (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'A sima szöveget automatikusan <p> bekezdésekbe csomagolja, amikor egy modul betöltődik a felülvizsgálati képernyőn. Ez megegyezik a ¶ gomb kézi megnyomásával.';

  @override
  String get settingsDatabaseSync => 'Adatbázis-szinkronizálás';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Szinkronizálja az adatbázis-bejegyzéseket a JSON fordítási fájlokkal.';

  @override
  String get settingsDatabaseSyncHint =>
      'Szinkronizálja a belső adatbázis bejegyzéseit a szerveren lévő fordítási JSON-okkal.';

  @override
  String get settingsSyncing => 'Szinkronizálás...';

  @override
  String get settingsSyncNow => 'Szinkronizálás most';

  @override
  String get settingsSyncD11List => 'D11 lista szinkronizálása';

  @override
  String get settingsUploadBackup => 'Biztonsági mentés feltöltése (.zip)';

  @override
  String get settingsSelectZipFile => 'ZIP-fájl kiválasztása';

  @override
  String get settingsUploading => 'Feltöltés...';

  @override
  String get settingsErrorDiagnostics => 'Hibadiagnosztika és rendszernaplók';

  @override
  String get settingsLogsCopied => 'Naplók vágólapra másolva! 📋';

  @override
  String get settingsCopyLogs => 'Naplók másolása';

  @override
  String get settingsLogsRotated => 'Naplók archiválva és rotálva! 📁';

  @override
  String get settingsRotate => 'Rotálás';

  @override
  String get settingsClear => 'Törlés';

  @override
  String get settingsLogLimit => 'Naplókorlát: ';

  @override
  String get settingsNoLogs => 'Nincs rögzített napló';

  @override
  String get layoutMenu => 'Menü';

  @override
  String get layoutNavAnalytics => 'Elemzések';

  @override
  String get layoutNavReviewQueue => 'Felülvizsgálati sor';

  @override
  String get layoutNavGlossary => 'Szószedet';

  @override
  String get layoutNavCategories => 'Kategóriák';

  @override
  String get layoutNavHelp => 'Súgó';

  @override
  String get layoutNavSettings => 'Beállítások';

  @override
  String get layoutPhotoBy => 'Fotó: ';

  @override
  String get layoutPhotoOn => ' – ';

  @override
  String get layoutEditProfile => 'Profil szerkesztése';

  @override
  String get layoutLogout => 'Kijelentkezés';

  @override
  String get layoutThemeLabel => 'TÉMA';

  @override
  String get layoutThemePearl => 'Világos';

  @override
  String get layoutThemeDark => 'Sötét';

  @override
  String get layoutThemeGlassy => 'Üveges';

  @override
  String get layoutThemeNature => 'Természet';

  @override
  String get layoutThemeLiquid => 'Folyékony';

  @override
  String get layoutThemeStage => 'Színpad';

  @override
  String get layoutTargetLanguage => 'CÉLNYELV';

  @override
  String get layoutDeeplUsage => 'DEEPL HASZNÁLAT';

  @override
  String get layoutUnavailable => 'Nem elérhető';

  @override
  String get layoutUnlimited => 'korlátlan';

  @override
  String get layoutUsed => 'felhasználva';

  @override
  String get layoutTranslate => 'Fordítás';

  @override
  String get analyticsSubtitle =>
      'Kompatibilitás, fordítási hátralék és heti trendek.';

  @override
  String get analyticsBacklog => 'Fordítási hátralék';

  @override
  String get analyticsMissing => 'Hiányzó';

  @override
  String get analyticsStale => 'Elavult';

  @override
  String get analyticsInReview => 'Felülvizsgálat alatt';

  @override
  String get analyticsReleased => 'Közzétett';

  @override
  String get analyticsTranslated => 'Lefordított';

  @override
  String get analyticsTotalModules => 'Modulok összesen';

  @override
  String get analyticsCompatByVersion => 'Kompatibilitás Drupal-verzió szerint';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Nyelv: $lang · közzétett / felülvizsgálat alatt / hiányzó';
  }

  @override
  String get analyticsLoadingCounts => 'Számok betöltése …';

  @override
  String get analyticsWindow => 'Időablak:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks hét';
  }

  @override
  String get analyticsNewDescriptionsPerWeek => 'Új projektleírások hetente';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Elavultnak jelölve hetente ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modul';
  }

  @override
  String get analyticsReviewShort => 'Felülvizsgálat';

  @override
  String get analyticsNoDataInWindow => 'Nincs adat az időablakban.';

  @override
  String get analyticsAndMore => '… és több';

  @override
  String glossaryLoadError(String error) {
    return 'Hiba betöltés közben: $error';
  }

  @override
  String get glossaryNewTerm => 'Új kifejezés létrehozása';

  @override
  String get glossaryEditTerm => 'Kifejezés szerkesztése';

  @override
  String get glossaryFieldSourceWord =>
      'Forrásszó (alapalak, ahogy a szövegben szerepel)';

  @override
  String get glossaryFieldSourceWordHint => 'pl. node';

  @override
  String get glossaryWordForms =>
      'További szóalakok (többes szám, birtokos eset stb. …)';

  @override
  String get glossaryWordFormsHint =>
      'pl. tartalom — nyomja meg az Entert a hozzáadáshoz';

  @override
  String get glossaryAddForm => 'Alak hozzáadása';

  @override
  String get glossaryFieldPreferredWord => 'Preferált fordítás';

  @override
  String get glossaryFieldPreferredWordHint => 'pl. tartalom';

  @override
  String get glossaryFieldExplanation =>
      'Magyarázat (az elemleírásban jelenik meg)';

  @override
  String get glossaryFieldExplanationHint =>
      'Miért kellene ezt a szót másképp fordítani?';

  @override
  String get glossaryCreate => 'Létrehozás';

  @override
  String get glossaryRequiredFields =>
      'A forrásszó és a preferált fordítás kötelező.';

  @override
  String get glossaryCreated => 'Kifejezés létrehozva ✓';

  @override
  String get glossaryUpdated => 'Kifejezés frissítve ✓';

  @override
  String glossaryError(String error) {
    return 'Hiba: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Törli a kifejezést?';

  @override
  String glossaryDeleteBody(String word) {
    return 'A(z) „$word” véglegesen eltávolításra kerül a szószedetből.';
  }

  @override
  String get glossaryDeleted => 'A kifejezés törölve.';

  @override
  String get glossaryTitle => 'Fordítási szószedet';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Nyelv: $lang · $count bejegyzés';
  }

  @override
  String get glossaryNewShort => 'Új';

  @override
  String get glossaryCreateTerm => 'Kifejezés létrehozása';

  @override
  String get glossaryInfoBanner =>
      'A szószedetből származó szavak ki vannak emelve a felülvizsgálati szerkesztőben. Egy elemleírás rámutatáskor elmagyarázza, miért illik jobban egy másik fordítás.';

  @override
  String get glossaryNoEntries => 'Még nincs bejegyzés.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Kattintson a „Kifejezés létrehozása” gombra az első bejegyzés létrehozásához.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Ehhez a nyelvhez még nincs szószedet-bejegyzés.';

  @override
  String get diffNoChanges => 'Nem található tartalmi eltérés.';

  @override
  String get diffRemoved => 'Eltávolítva';

  @override
  String get diffAdded => 'Hozzáadva';

  @override
  String syncBarQuickSync(String count) {
    return 'Gyors szinkronizálás: $count módosított modul …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Teljes szinkronizálás: $current / $total modul';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Teljes szinkronizálás: $count modul …';
  }
}
