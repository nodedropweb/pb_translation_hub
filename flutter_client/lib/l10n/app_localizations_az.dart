// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Layihə təfərrüatları yüklənir...';

  @override
  String editorLoadError(String error) {
    return 'Layihə məlumatlarını yükləmək alınmadı: $error';
  }

  @override
  String get editorGeminiSuccess => 'Gemini ilə tərcümə uğurlu oldu! ✨';

  @override
  String get editorUnknownError => 'Naməlum xəta';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini tərcüməsi uğursuz oldu: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Zəhmət olmasa Google AI açarınızı istifadəçi profilinizdə əlavə edin (admin ayarlarında yox).';

  @override
  String get editorGeminiError =>
      'Gemini tərcüməsi zamanı xəta baş verdi. Zəhmət olmasa profilinizdəki Google AI açarını yoxlayın.';

  @override
  String get editorDeeplSuccess => 'DeepL ilə tərcümə uğurlu oldu! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL tərcüməsi uğursuz oldu: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'DeepL tərcüməsi zamanı xəta baş verdi. Zəhmət olmasa DeepL API açarınızın profilinizdə təyin olunduğundan əmin olun.';

  @override
  String get editorDeeplInvalidKey =>
      'Yanlış DeepL API açarı. Zəhmət olmasa profilinizdə yoxlayın.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL kvotası tükənib. Zəhmət olmasa planınızı yoxlayın.';

  @override
  String get editorReviewReset => 'Tərcümə baxış statusuna sıfırlandı.';

  @override
  String editorResetError(String error) {
    return 'Sıfırlama uğursuz oldu: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Modul yenidən aktiv siyahıya qaytarıldı.';

  @override
  String get editorUnignoreError => 'Modulu nəzərə almağa qaytarmaq alınmadı.';

  @override
  String get editorSaveSuccess =>
      'Tərcümə saxlanıldı — baxış növbəsinə qaytarıldı.';

  @override
  String editorSaveError(String error) {
    return 'Saxlamaq alınmadı: $error';
  }

  @override
  String get editorNoMoreProjects => 'Siyahıda daha açıq layihə yoxdur.';

  @override
  String get editorChangesDiscarded =>
      'Dəyişikliklər ləğv edildi, növbəti layihə yüklənir...';

  @override
  String get editorEnglishSourceApplied =>
      'İngilis dilində orijinal tətbiq olundu — zəhmət olmasa indi onu tərcümə edin.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'URL açıla bilmədi: $url';
  }

  @override
  String get commonSave => 'Saxla';

  @override
  String get commonClose => 'Bağla';

  @override
  String get editorCloseEnglishSource => 'İngilis mənbəyini bağla';

  @override
  String get editorShowEnglishSource => 'İngilis mənbəyini göstər';

  @override
  String get editorUnignoreShortTooltip => 'Modulu nəzərə al';

  @override
  String get editorBackToReviewTooltip => 'Yenidən baxışa qaytar';

  @override
  String get editorAndNext => '& Növbəti';

  @override
  String get editorBackToDashboard => 'İdarə panelinə qayıt';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return '$langName ($langCode) dilinə tərcümə edilir';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count qalıb';
  }

  @override
  String get editorUnignoreLongTooltip => 'Modulu aktiv siyahıya qaytar';

  @override
  String get editorUnignoreLabel => 'Nəzərə al';

  @override
  String get editorUnpublishTooltip => 'Nəşri ləğv et və baxışa qaytar';

  @override
  String get editorBackToReview => 'Baxışa qayıt';

  @override
  String get editorSaveAndNext => 'Saxla və Növbəti';

  @override
  String get editorEnglishSourceHeader => 'İNGİLİS MƏNBƏYİ';

  @override
  String get editorStaleTooltip => 'İzahı göstər və ingilis mətnini tətbiq et';

  @override
  String get editorStaleDetailsLabel => 'Köhnəlmiş — Təfərrüatlar';

  @override
  String get editorCopyPromptTooltip => 'Mənbə + tərcümə təlimatını kopyala';

  @override
  String get editorPromptCopied => 'Təlimat mübadilə buferinə kopyalandı 📋';

  @override
  String get editorShowPreview => 'Önizləməni göstər';

  @override
  String get editorShowHtmlSource => 'HTML mənbəyini göstər';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'XÜLASƏ:\n$summary\n\nMƏTN:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Xülasə:';

  @override
  String get editorDescriptionLabelColon => 'Təsvir:';

  @override
  String get editorStaleDialogTitle => 'İngilis mənbəyi dəyişdirilib';

  @override
  String get editorStaleExplanation =>
      'Mövcud tərcümə köhnəlmiş ingilis orijinal mətninə əsaslanır. Son tərcümədən bəri modul icraçısı Drupal.org saytında ingilis mətnini dəyişdirib — buna görə mövcud tərcümənin məzmunu artıq dəqiq və ya tam olmaya bilər.';

  @override
  String get editorStaleTip =>
      'Məsləhət: cari ingilis mənbəyini birbaşa redaktora yükləmək üçün \"İngilis orijinalını istifadə et\" düyməsini klikləyin. Sonra bunu yeni tərcümə üçün başlanğıc nöqtəsi kimi istifadə edə bilərsiniz. İngilis orijinalı sol paneldə də görünür.';

  @override
  String get editorEnglishSourceShort => 'İngilis mənbəyi';

  @override
  String get editorPreviousTranslation => 'Əvvəlki tərcümə';

  @override
  String get editorWhatChangedTitle => 'Nə dəyişib?';

  @override
  String get editorShowDiff => 'Fərqi göstər';

  @override
  String get editorUseEnglish => 'İngilis orijinalını istifadə et';

  @override
  String get editorStaleBannerText =>
      'İngilis mənbəyi dəyişdirilib — tərcümə köhnəlmişdir';

  @override
  String get editorDetailsAndApply => 'Təfərrüatlar və tətbiq';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName TƏRCÜMƏSİ';
  }

  @override
  String get editorTranslatingEllipsis => 'Tərcümə edilir...';

  @override
  String get editorShowEditor => 'Redaktoru göstər';

  @override
  String get editorModuleTitleLabel => 'Modul başlığı (İngiliscə)';

  @override
  String get editorSummaryFieldLabel => 'Xülasə';

  @override
  String get editorBodyFieldLabel => 'Mətn';

  @override
  String get editorHtmlCleaned => 'HTML təmizləndi';

  @override
  String get editorLivePreviewHeader => 'CANLI ÖNİZLƏMƏ';

  @override
  String get editorTidyHtmlTooltip =>
      'HTML-i təmizlə (DeepL artefaktlarını sil)';

  @override
  String get editorVisualMode => 'VİZUAL';

  @override
  String get editorSourceCodeMode => 'MƏNBƏ (HTML)';

  @override
  String get commonCancel => 'Ləğv et';

  @override
  String get costDialogTitle => 'Xərc Təxmini (AI)';

  @override
  String get costDialogIntro =>
      'Seçilmiş modul Google Gemini AI ilə tərcümə ediləcək. Bu əməliyyat üçün təxmini xərc bölgüsü aşağıdadır:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Giriş tokenləri';

  @override
  String get costRowOutputTokens => 'Çıxış tokenləri (təxmini)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars simvol)';
  }

  @override
  String get costRowPriceInput => '1M giriş üçün qiymət';

  @override
  String get costRowPriceOutput => '1M çıxış üçün qiymət';

  @override
  String get costRowTotalEstimate => 'Təxmini ümumi xərc';

  @override
  String get costDialogFootnote =>
      '* Qeyd: Bu, cari Google pay-as-you-go qiymət modelinə əsaslanan təxminidir. Faktiki istifadə bir qədər fərqli ola bilər.';

  @override
  String get costDialogStartTranslation => 'Tərcüməyə başla';

  @override
  String get htmlToolbarInsertLink => 'Keçid əlavə et';

  @override
  String get htmlToolbarLinkTooltip => 'Keçid əlavə et (a)';

  @override
  String get htmlToolbarInsert => 'Əlavə et';

  @override
  String get htmlToolbarHeading2 => 'Başlıq 2';

  @override
  String get htmlToolbarHeading3 => 'Başlıq 3';

  @override
  String get htmlToolbarBold => 'Qalın (strong)';

  @override
  String get htmlToolbarItalic => 'Kursiv (em)';

  @override
  String get htmlToolbarBulletList => 'Nöqtəli siyahı (ul)';

  @override
  String get htmlToolbarNumberedList => 'Nömrələnmiş siyahı (ol)';

  @override
  String get htmlToolbarQuote => 'Sitat (blockquote)';

  @override
  String get screenshotAltsHeader => 'EKRAN GÖRÜNTÜSÜ ALT MƏTNİ';

  @override
  String get screenshotAltsIntro =>
      'Hər ekran görüntüsü üçün hədəf dildə təsviri alt mətn daxil edin.';

  @override
  String screenshotLabel(int number) {
    return 'Ekran görüntüsü $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Önizləmə mövcud deyil';

  @override
  String get screenshotAltHint => 'Hədəf dildə alt mətn daxil edin…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Bütün modullar nəzərə alınsın?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Bütün nəzərə alınmayan modullar aktiv siyahıya qaytarılacaq və yenidən tərcümə üçün əlçatan olacaq.';

  @override
  String get dashUnignoreAllConfirmAction => 'Hamısını nəzərə al';

  @override
  String get dashUnignoreAllSuccess =>
      'Bütün nəzərə alınmayan modullar bərpa edildi.';

  @override
  String get dashUnignoreAllError => 'Modulları bərpa etmək alınmadı.';

  @override
  String get dashUnignoreAllButton => 'Bütün modulları nəzərə al';

  @override
  String dashSyncStartError(String error) {
    return 'Sinxronizasiyanı başlatmaq alınmadı: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Sürətli yeniləmə (7 gün) başladıldı ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Sürətli yeniləmə xətası: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Uğurla sinxronlaşdırıldı: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modul Drupal.org saytında tapılmadı.';

  @override
  String get dashAiBulkTranslation => 'AI Kütləvi Tərcümə';

  @override
  String get dashHeaderTitle => 'Layihə Təsvirləri';

  @override
  String get dashHeaderSubtitle =>
      'Drupal modul təsvirlərini hədəf dilə tərcümə edin. Ekosistemi daha əlçatan etməyə kömək edin.';

  @override
  String get dashHeaderSubtitleShort =>
      'Drupal modul təsvirlərini tərcümə edin.';

  @override
  String get dashLastLabel => 'Son: ';

  @override
  String get dashContinue => 'Davam et';

  @override
  String get dashContinueShort => 'Davam et';

  @override
  String get dashUnignoreAllButtonLong => 'Bütün modulları nəzərə al';

  @override
  String get dashQuickUpdateTooltip => 'Sürətli yeniləmə (son 7 gün)';

  @override
  String get dashFullSyncTooltip =>
      'Drupal.org saytından tam verilənlər bazası sinxronizasiyası';

  @override
  String get dashManualLoadTooltip =>
      'Drupal.org saytından tək bir modulu əl ilə yüklə';

  @override
  String get dashQuickShort => 'Sürətli';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Tapıldı: ';

  @override
  String get dashModulesSuffix => ' modul';

  @override
  String dashPerPage(int count) {
    return 'Səhifədə $count';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / səhifə';
  }

  @override
  String get dashFirstPage => 'İlk səhifə';

  @override
  String get dashPrevPage => 'Əvvəlki səhifə';

  @override
  String get dashNextPage => 'Növbəti səhifə';

  @override
  String get dashLastPage => 'Son səhifə';

  @override
  String dashPageOf(int page, int total) {
    return 'Səhifə $page / $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (məs. pathauto)';

  @override
  String get dashAddButton => 'Əlavə et';

  @override
  String get dashAddModuleManually => 'Modulu əl ilə əlavə et';

  @override
  String get dashAddModuleSubtitle =>
      'Machine name ilə birbaşa Drupal.org saytından yüklə.';

  @override
  String get dashAddModuleShort => 'Modul əlavə et';

  @override
  String get dashNoProjectsFound => 'Heç bir layihə tapılmadı.';

  @override
  String get dashFilterAll => 'Bütün Layihələr';

  @override
  String get dashFilterMissing => 'Çatışmayan Tərcümələr';

  @override
  String get dashFilterReview => 'Baxış Növbəsi';

  @override
  String get dashFilterTranslated => 'Tərcümə Edilmiş Layihələr';

  @override
  String get dashFilterReleased => 'Nəşr Edilmiş Layihələr';

  @override
  String get dashBulkDialogIntro =>
      'Seçilmiş filtrdən bir neçə modulu Google Gemini istifadə edərək avtomatik tərcümə edin.';

  @override
  String get dashActiveFilter => 'Aktiv Filtr';

  @override
  String get dashModuleCount => 'Modul Sayı';

  @override
  String dashModulesCountItem(int count) {
    return '$count modul';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12 modullarına üstünlük ver';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Əvvəlcə Drupal 12 dəstəyi olmayan modulları tərcümə edir';

  @override
  String get dashTotalModules => 'Ümumi modullar';

  @override
  String get dashInputTokensEst => 'Giriş tokenləri (təxmini)';

  @override
  String get dashOutputTokensEst => 'Çıxış tokenləri (təxmini)';

  @override
  String get dashBulkFootnote =>
      '* Tərcümə fasilələrin qarşısını almaq üçün resurs-səmərəli partiyalarda icra edilir.';

  @override
  String get dashStartBulkTranslation => 'Kütləvi Tərcüməyə Başla';

  @override
  String dashStaleLoadError(String error) {
    return 'Köhnəlmiş modulları yükləmə xətası: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Köhnəlmiş modul tapılmadı — hər şey aktualdır! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Köhnəlmiş Modulları Yenidən Tərcümə Et';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Son tərcümədən bəri ingilis mənbəyi dəyişmiş bütün tərcümələr Google Gemini istifadə edərək avtomatik yenidən tərcümə ediləcək. Hər modulu əl ilə açmağa ehtiyac yoxdur.';

  @override
  String get dashOutdatedModules => 'Köhnəlmiş modullar';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Tərcümə mövcud mətni əvəz edir və is_reviewed sıfırlayır. 4 modullu partiyalarla icra edilir.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Bütün $count modulu yenidən tərcümə et';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Köhnəlmiş modullar yenidən tərcümə edilir…';

  @override
  String get dashFetchingProjects => 'Layihələr serverdən əldə edilir…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$total modulundan $processed-i emal edildi';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Bu filtr üçün tərcümə oluna bilən layihə tapılmadı.';

  @override
  String get dashStartingTranslation => 'Tərcümə başlayır…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return '$total modulundan $start–$end tərcümə edilir …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$total modulundan $end-i tamamlandı.';
  }

  @override
  String get dashTranslationCompleted => 'Tərcümə uğurla tamamlandı! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '$count modulun kütləvi tərcüməsi uğurlu oldu! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Kütləvi tərcümə xətası: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Bütün $count modul uğurla yenidən tərcümə edildi! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count köhnəlmiş modul uğurla yenidən tərcümə edildi! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Yenidən tərcümə zamanı xəta: $error';
  }

  @override
  String get filterAllShort => 'Hamısı';

  @override
  String get filterMissing => 'Çatışmayan';

  @override
  String get filterTranslated => 'Tərcümə edilmiş';

  @override
  String get filterReviewQueue => 'Baxış Növbəsi';

  @override
  String get filterReleased => 'Nəşr edilmiş';

  @override
  String get filterOutdated => 'Köhnəlmiş';

  @override
  String get filterPriority => 'Prioritet';

  @override
  String get filterIgnored => 'Nəzərə alınmayan';

  @override
  String get commonEdit => 'Redaktə et';

  @override
  String get commonReset => 'Sıfırla';

  @override
  String get commonRefresh => 'Yenilə';

  @override
  String commonErrorPrefix(String error) {
    return 'Xəta: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Bütün nəşr edilmiş tərcümələr sıfırlansın?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return '$langcode üçün nəşr edilmiş kimi işarələnmiş bütün tərcümələr baxış vəziyyətinə sıfırlanacaq. Bu geri qaytarıla bilməz.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count tərcümə baxış vəziyyətinə sıfırlandı.';
  }

  @override
  String get reviewPipelineTitle => 'Baxış Konveyeri';

  @override
  String get reviewPipelineSubtitle =>
      'AI tərcümələri üçün insan keyfiyyət təminatı konveyeri';

  @override
  String get reviewSearchHint => 'Layihələri axtar...';

  @override
  String get reviewResetPublished => 'Nəşr olunanı sıfırla';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Nəticələr: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Gözləyən: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Baxış gözləyən layihə yoxdur.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Bütün tərcümələr artıq təsdiqlənib və ya bu dil kontekstində heç biri mövcud deyil.';

  @override
  String get reviewNoSummary => 'Xülasə yoxdur.';

  @override
  String get reviewStartAudit => 'AUDİTƏ BAŞLA';

  @override
  String get reviewHtmlSourceShort => 'HTML mənbəyi';

  @override
  String get reviewCopySource => 'Mənbəni kopyala';

  @override
  String get reviewModuleDetails => 'Modul Təfərrüatları';

  @override
  String get reviewOriginalTitle => 'Orijinal Başlıq';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org Layihəsi';

  @override
  String get reviewSuggestions => 'Təkliflər';

  @override
  String get reviewNoSuggestions => 'Heç bir təklif mövcud deyil.';

  @override
  String get reviewApply => 'Tətbiq et';

  @override
  String get reviewNoChanges => 'Dəyişiklik yoxdur';

  @override
  String get reviewOriginalBeforeCorrection => 'Orijinal (düzəlişdən əvvəl)';

  @override
  String get reviewCorrectedCurrentVersion => 'Düzəldilmiş (cari versiya)';

  @override
  String get reviewBaseOriginal => 'Baza (Orijinal)';

  @override
  String get reviewYourCorrection => 'Sizin Düzəlişiniz';

  @override
  String get reviewChangesVisual => 'Dəyişikliklərinizə Baxın (Vizual)';

  @override
  String get commonSkip => 'Keç';

  @override
  String get commonIgnore => 'Nəzərə alma';

  @override
  String get reviewEmptyProjectTitle => 'Boş Layihə';

  @override
  String get reviewEmptyProjectBody =>
      'Bu layihə boşdur (başlıq, xülasə və ya mətn yoxdur) və təsdiqlənə bilməz. Zəhmət olmasa onu keçin.';

  @override
  String get reviewApprovedSuccess => 'Tərcümə təsdiqləndi! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ \"$machine\" təsdiqi uğursuz oldu — zəhmət olmasa yenidən cəhd edin.';
  }

  @override
  String get reviewUnignoredSuccess => 'Bərpa edildi. Modul yenidən aktivdir!';

  @override
  String get reviewActionFailed => 'Əməliyyat uğursuz oldu.';

  @override
  String get reviewIgnoreModuleTitle => 'Modul Nəzərə Alınmasın?';

  @override
  String get reviewIgnoreModuleBody =>
      'Bu modul bütün siyahılardan həmişəlik gizlədiləcək. Artıq onunla üzləşməyəcəksiniz.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modul həmişəlik nəzərə alınmır.';

  @override
  String get reviewIgnoreFailed => 'Modulu nəzərə almamaq alınmadı.';

  @override
  String get reviewSuggestionSaved => 'Təklif qaralaması saxlanıldı! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Təklif qaralamasını saxlamaq alınmadı.';

  @override
  String get reviewSuggestionDeleted => 'Təklif silindi.';

  @override
  String get reviewDeleteFailed => 'Silmək alınmadı.';

  @override
  String get reviewSuggestionApplied => 'Təklif tətbiq edildi.';

  @override
  String get reviewPreparingData => 'Baxış məlumatları hazırlanır...';

  @override
  String get reviewDirectEdit => 'Birbaşa Redaktə';

  @override
  String get reviewLivePreview => 'Canlı Önizləmə';

  @override
  String get reviewCompareWith => 'Müqayisə et:';

  @override
  String get reviewProductionVersion => 'İstehsal Versiyası';

  @override
  String get reviewEditorialReview => 'Redaktoriya Baxışı';

  @override
  String get reviewOpenQueue => 'Baxış növbəsini aç';

  @override
  String get reviewCopyPromptShort => 'Təlimatı kopyala';

  @override
  String get reviewUnignoreShort => 'Bərpa et';

  @override
  String get reviewApproveButton => 'TƏSDİQLƏ';

  @override
  String get reviewHideDetails => 'Təfərrüatları gizlət';

  @override
  String get reviewDetailsAndEnglishSource => 'Təfərrüatlar və İngilis Mənbəyi';

  @override
  String reviewPendingCountShort(int count) {
    return '$count gözləyir';
  }

  @override
  String reviewReviewingModule(String name) {
    return '$name baxılır';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Tərcüməni ingilis mənbəyi ilə müqayisə et';

  @override
  String get reviewTranslationLabel => 'Tərcümə';

  @override
  String get reviewComparisonTitle => 'Müqayisə';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Mənbə mətnini + tərcümə təlimatını mübadilə buferinə kopyala';

  @override
  String get reviewUnignoreCaps => 'BƏRPA ET';

  @override
  String get reviewIgnoreCaps => 'NƏZƏRƏ ALMA';

  @override
  String get reviewSkipShortcut => 'KEÇ (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Redaktoriya Baxışı';

  @override
  String get reviewUnignoreTablet => 'BƏRPA ET';

  @override
  String get reviewApproveForProduction =>
      'İSTEHSAL ÜÇÜN TƏSDİQLƏ (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Birbaşa Cilalama';

  @override
  String get reviewTitleField => 'Başlıq';

  @override
  String get reviewSummaryField => 'Xülasə';

  @override
  String get reviewBodyField => 'Mətn Məzmunu';

  @override
  String get reviewSaveShortcut => 'SAXLA (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Canlı Önizləmə (Render Edilir)';

  @override
  String get reviewVoiceFemale => 'Qadın';

  @override
  String get reviewVoiceMale => 'Kişi';

  @override
  String get reviewStopListening => 'Dayandır';

  @override
  String get reviewListen => 'Dinlə';

  @override
  String get reviewAutopTooltip =>
      'Paraqrafları avtomatik formatla (sətir keçidi → <p>)';

  @override
  String get reviewSourceCodeShort => 'MƏNBƏ';

  @override
  String get reviewNoParagraphChange =>
      'Mətndə artıq <p> teqləri var — dəyişiklik yoxdur';

  @override
  String get reviewParagraphsFormatted => 'Paraqraflar formatlandı ¶';

  @override
  String get commonRetry => 'Yenidən cəhd et';

  @override
  String categoriesLoadError(String error) {
    return 'Kateqoriyaları yükləmək alınmadı: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kateqoriyalar uğurla saxlanıldı.';

  @override
  String get categoriesSaveFailed => 'Tərcümələri saxlamaq alınmadı.';

  @override
  String get categoriesFileEmpty => 'Fayl boşdur.';

  @override
  String get categoriesInvalidJson => 'Yanlış JSON formatı.';

  @override
  String get categoriesNoValidUuids => 'Faylda etibarlı UUID qeydi tapılmadı.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count kateqoriya fayldan idxal edildi.';
  }

  @override
  String get categoriesTitle => 'Kateqoriyalar';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Tərcümə edilir: $lang';
  }

  @override
  String get categoriesImportJson => 'JSON İdxal Et';

  @override
  String get categoriesSaving => 'Saxlanılır...';

  @override
  String get categoriesSaveAll => 'Hamısını Saxla';

  @override
  String get categoriesLoading => 'Kateqoriyalar yüklənir...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Tərcümə ($code)';
  }

  @override
  String get categoriesNoneFound => 'Heç bir kateqoriya tapılmadı.';

  @override
  String categoriesTranslateHint(String name) {
    return '\"$name\" tərcümə edin...';
  }

  @override
  String get loginPhotoBy => 'Şəkil: ';

  @override
  String get loginPhotoOn => ' — ';

  @override
  String get loginPleaseSignIn => 'Zəhmət olmasa daxil olun';

  @override
  String get loginUsername => 'İstifadəçi adı';

  @override
  String get loginPassword => 'Şifrə';

  @override
  String get loginRememberMe => 'Məni xatırla';

  @override
  String get loginSignIn => 'DAXİL OL';

  @override
  String get loginNoAccount => 'Hesabınız yoxdur? ';

  @override
  String get loginRegisterNow => 'İndi qeydiyyatdan keç';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonNext => 'Növbəti';

  @override
  String get registerFillRequired =>
      'Zəhmət olmasa bütün tələb olunan sahələri doldurun.';

  @override
  String get registerPasswordMismatch => 'Şifrələr uyğun gəlmir.';

  @override
  String get registerPasswordTooShort =>
      'Şifrə ən azı 8 simvoldan ibarət olmalıdır.';

  @override
  String get registerSelectLanguage => 'Zəhmət olmasa ən azı bir dil seçin.';

  @override
  String get registerFailed => 'Qeydiyyat uğursuz oldu.';

  @override
  String get registerHeaderTitle => 'QEYDİYYAT';

  @override
  String get registerStepAccount => 'Hesab';

  @override
  String get registerStepRole => 'Rol';

  @override
  String get registerStepLanguages => 'Dillər';

  @override
  String get registerStepApiKeys => 'API Açarları';

  @override
  String get registerYourAccount => 'Sizin Hesabınız';

  @override
  String get registerAvatarOptional => 'Avatar (istəyə bağlı)';

  @override
  String get registerUsernameRequired => 'İstifadəçi adı *';

  @override
  String get registerEmailRequired => 'E-poçt Ünvanı *';

  @override
  String get registerPasswordRequired => 'Şifrə *';

  @override
  String get registerPasswordRepeat => 'Şifrəni Təkrarla *';

  @override
  String get registerYourRole => 'Sizin Rolunuz';

  @override
  String get registerRoleExplanation =>
      'Tərcüməçilər mətnləri tərcümə edə bilər, lakin baxış növbəsinə giriş imkanları yoxdur. Rəyçilər tərcümə edilmiş məzmunu yoxlayır və təsdiqləyir.';

  @override
  String get registerRoleTranslator => 'Tərcüməçi';

  @override
  String get registerRoleTranslatorDesc =>
      'Tərcümələr yaradın və redaktə edin.';

  @override
  String get registerRoleReviewer => 'Rəyçi';

  @override
  String get registerRoleReviewerDesc => 'Tərcümələri baxın və təsdiqləyin.';

  @override
  String get registerTargetLanguages => 'Hədəf Dillər';

  @override
  String get registerLanguagesExplanation =>
      'Üzərində işləmək istədiyiniz bütün dilləri seçin.';

  @override
  String get registerNoLanguagesAvailable => 'Heç bir dil mövcud deyil.';

  @override
  String get registerApiKeysTitle => 'API Açarları';

  @override
  String get registerApiKeysExplanation =>
      'Öz API açarlarınızı daxil edin. Hər istifadəçi yalnız öz açarlarından istifadə edir. Bunları daha sonra profilinizdə də əlavə edə bilərsiniz.';

  @override
  String get registerKeysEncryptedNote =>
      'Açarlar şifrələnmiş şəkildə saxlanılır və başqa istifadəçilərlə heç vaxt paylaşılmır.';

  @override
  String get registerOptionalSuffix => ' (istəyə bağlı)';

  @override
  String get registerSuccessTitle => 'Qeydiyyat uğurlu oldu!';

  @override
  String get registerSuccessBody =>
      'Hesabınız yaradıldı və administrator tərəfindən təsdiq gözləyir. Girişiniz aktivləşdirildikdən sonra sizə bildiriş göndəriləcək.';

  @override
  String get registerGoToLogin => 'Girişə Keç';

  @override
  String get registerSubmit => 'Qeydiyyatdan keç';

  @override
  String registerPhotoCredit(String name) {
    return 'Şəkil: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil uğurla yeniləndi!';

  @override
  String get profileUpdateFailed => 'Yeniləmə uğursuz oldu.';

  @override
  String profileSaveError(String error) {
    return 'Saxlama zamanı xəta: $error';
  }

  @override
  String get profilePasswordMismatch => 'Şifrələr uyğun gəlmir!';

  @override
  String get profilePasswordChangeSuccess => 'Şifrə uğurla dəyişdirildi!';

  @override
  String get profilePasswordChangeError =>
      'Şifrəni dəyişmə zamanı xəta: cari şifrə yanlışdır.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar uğurla yükləndi!';

  @override
  String get profileAvatarUploadError => 'Avatar yükləmə zamanı xəta.';

  @override
  String get profileTitle => 'Profil və Ayarlar';

  @override
  String get profileSubtitle =>
      'İstifadəçi profilinizi, tərcümə API-lərinizi (Gemini və DeepL) və hesab təhlükəsizliyinizi idarə edin.';

  @override
  String get profileRoleUser => 'İstifadəçi';

  @override
  String get profileNoEmail => 'E-poçt ünvanı təqdim edilməyib';

  @override
  String get profileTabDetails => 'Profil təfərrüatları';

  @override
  String get profileTabGemini => 'AI tərcüməsi (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL tərcüməsi';

  @override
  String get profileTabPassword => 'Şifrəni dəyiş';

  @override
  String get profileSectionInfo => 'PROFİL MƏLUMATI';

  @override
  String get profileFieldName => 'Ad';

  @override
  String get profileFieldNameHint => 'Tam adınız';

  @override
  String get profileFieldEmail => 'E-poçt ünvanı';

  @override
  String get profileFieldEmailHint => 'E-poçt ünvanınız';

  @override
  String get profileSectionGemini => 'GEMINI HƏMKAR AYARLARI';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API açarı';

  @override
  String get profileFieldGeminiKeyHint =>
      'gemini-3.1-flash API açarınızı daxil edin';

  @override
  String get profileFieldAiPrompt => 'Fərdi AI təlimatı';

  @override
  String get profileFieldAiPromptHint =>
      'İstəyə bağlı: Gemini üçün sistem təlimatını fərdiləşdirin...';

  @override
  String get profileSectionDeepl => 'DEEPL TƏRCÜMƏ AYARLARI';

  @override
  String get profileDeeplDescription =>
      'DeepL, HTML teqlərinin qorunması ilə yüksək keyfiyyətli maşın tərcüməsi təklif edir. Pulsuz hesablar (ayda 500.000 simvol) \":fx\" şəkilçili açar alır.';

  @override
  String get profileFieldDeeplKey => 'DeepL API açarı';

  @override
  String get profileFieldDeeplKeyHint =>
      'məs. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Pulsuz açarlar \":fx\" ilə bitir və api-free.deepl.com istifadə edir. Pro açarlar api.deepl.com istifadə edir. Fərq avtomatik müəyyən edilir.';

  @override
  String get profileSectionSecurity => 'HESAB TƏHLÜKƏSİZLİYİ';

  @override
  String get profileFieldCurrentPassword => 'Cari şifrə';

  @override
  String get profileFieldCurrentPasswordHint => 'Cari şifrənizi daxil edin';

  @override
  String get profileFieldNewPassword => 'Yeni şifrə';

  @override
  String get profileFieldNewPasswordHint => 'Ən azı 6 simvol';

  @override
  String get profileFieldConfirmPassword => 'Yeni şifrəni təsdiqlə';

  @override
  String get profileFieldConfirmPasswordHint => 'Şifrəni təkrarlayın';

  @override
  String get profileChangePasswordButton => 'Şifrəni dəyiş';

  @override
  String get commonDelete => 'Sil';

  @override
  String get settingsRegistrationUpdated => 'Qeydiyyat ayarı yeniləndi';

  @override
  String get settingsUpdateFailed => 'Yeniləmə uğursuz oldu.';

  @override
  String get settingsUserApproved => 'İstifadəçi təsdiqləndi!';

  @override
  String get settingsAccountDeactivated => 'Hesab deaktiv edildi.';

  @override
  String get settingsUserDeleted => 'İstifadəçi silindi.';

  @override
  String get settingsActionFailed => 'Əməliyyat uğursuz oldu.';

  @override
  String get settingsDeleteAccountTitle => 'Hesab silinsin?';

  @override
  String get settingsDeactivateAccountTitle => 'Hesab deaktiv edilsin?';

  @override
  String settingsDeleteAccountBody(String username) {
    return '\"$username\" hesabı həmişəlik silinəcək. Davam edilsin?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return '\"$username\" hesabı bloklanacaq. İstifadəçi artıq daxil ola bilməyəcək, lakin hesab saxlanılacaq.';
  }

  @override
  String get settingsDeactivate => 'Deaktiv et';

  @override
  String settingsSyncSuccess(String count) {
    return '$count tərcümə sinxronlaşdırıldı!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Sinxronizasiya xətası: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count prioritet modul sinxronlaşdırıldı!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Prioritet siyahını sinxronlaşdırma xətası: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Ehtiyat nüsxə uğurlu oldu: $count fayl emal edildi.';
  }

  @override
  String get settingsUploadFailed => 'Yükləmə uğursuz oldu.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSystemConfig => 'SİSTEM KONFİQURASİYASI';

  @override
  String get settingsRegistration => 'Qeydiyyat';

  @override
  String get settingsRegistrationHint =>
      'Qlobal qeydiyyat formasının görünürlüyünü aç/bağla.';

  @override
  String get settingsPendingUsers => 'Gözləyən İstifadəçilər';

  @override
  String get settingsNoNewRequests => 'Yeni sorğu yoxdur.';

  @override
  String get settingsWantsReviewer => 'Rəyçi Olmaq İstəyir';

  @override
  String get settingsAssignRole => 'Rol təyin et';

  @override
  String get settingsRoleTranslator => 'Tərcüməçi';

  @override
  String get settingsRoleReviewer => 'Rəyçi';

  @override
  String get settingsApprove => 'Təsdiqlə';

  @override
  String get settingsReject => 'Rədd et';

  @override
  String get settingsActiveUsers => 'Aktiv İstifadəçilər';

  @override
  String get settingsNoActiveUsers => 'Aktiv istifadəçi yoxdur.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deaktiv et';

  @override
  String get settingsDeleteAccountAction => 'Hesabı sil';

  @override
  String get settingsAppearance => 'Görünüş';

  @override
  String get settingsThemePearl => 'AÇIQ (İNCİ)';

  @override
  String get settingsThemeDark => 'TÜND';

  @override
  String get settingsThemeGlassy => 'ŞÜŞƏVARİ';

  @override
  String get settingsThemeNature => 'TƏBİƏT';

  @override
  String get settingsThemeLiquid => 'MAYE';

  @override
  String get settingsThemeStage => 'SƏHNƏ';

  @override
  String get settingsTypography => 'Tipoqrafiya';

  @override
  String get settingsFontHint => 'İnterfeys şrift ailəsini dəyişdirin.';

  @override
  String get settingsFontClean => 'Təmiz';

  @override
  String get settingsFontFuturistic => 'Futuristik';

  @override
  String get settingsFontTech => 'Texnoloji';

  @override
  String get settingsWorkflowFun => 'İş Axını və Əyləncə';

  @override
  String get settingsConfettiTitle => 'Uğur Kutlaması (Konfeti)';

  @override
  String get settingsConfettiHint =>
      'Uğurla saxlandıqda kiçik bir animasiya göstərir.';

  @override
  String get settingsLargeUiTitle =>
      'Genişləndirilmiş Oxunaqlılıq (Böyük Şrift)';

  @override
  String get settingsLargeUiHint =>
      'Oxunaqlılıq üçün şrift və nişan ölçülərini artırır.';

  @override
  String get settingsAutoPTitle =>
      'Avtomatik Paraqraf Formatlaşdırması (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Baxış Ekranında modul yükləndikdə sadə mətni avtomatik olaraq <p> paraqraflarına bükür. ¶ düyməsini əl ilə klikləməklə eynidir.';

  @override
  String get settingsDatabaseSync => 'Verilənlər Bazası Sinxronizasiyası';

  @override
  String get settingsDatabaseSyncTooltip =>
      'DB qeydlərini JSON tərcümə faylları ilə sinxronlaşdırır.';

  @override
  String get settingsDatabaseSyncHint =>
      'Daxili verilənlər bazası qeydlərini serverdəki tərcümə JSON-ları ilə sinxronlaşdırır.';

  @override
  String get settingsSyncing => 'Sinxronlaşdırılır...';

  @override
  String get settingsSyncNow => 'İndi Sinxronlaşdır';

  @override
  String get settingsSyncD11List => 'D11 Siyahısını Sinxronlaşdır';

  @override
  String get settingsUploadBackup => 'Ehtiyat Nüsxəni Yüklə (.zip)';

  @override
  String get settingsSelectZipFile => 'ZIP Faylı Seç';

  @override
  String get settingsUploading => 'Yüklənir...';

  @override
  String get settingsErrorDiagnostics =>
      'Xəta Diaqnostikası və Sistem Jurnalları';

  @override
  String get settingsLogsCopied => 'Jurnallar mübadilə buferinə kopyalandı! 📋';

  @override
  String get settingsCopyLogs => 'Jurnalları Kopyala';

  @override
  String get settingsLogsRotated =>
      'Jurnallar arxivləşdirildi və rotasiya edildi! 📁';

  @override
  String get settingsRotate => 'Rotasiya et';

  @override
  String get settingsClear => 'Təmizlə';

  @override
  String get settingsLogLimit => 'Jurnal Limiti: ';

  @override
  String get settingsNoLogs => 'Heç bir jurnal qeydə alınmayıb';

  @override
  String get layoutMenu => 'Menyu';

  @override
  String get layoutNavAnalytics => 'Analitika';

  @override
  String get layoutNavReviewQueue => 'Baxış Növbəsi';

  @override
  String get layoutNavGlossary => 'Lüğət';

  @override
  String get layoutNavCategories => 'Kateqoriyalar';

  @override
  String get layoutNavHelp => 'Kömək';

  @override
  String get layoutNavSettings => 'Ayarlar';

  @override
  String get layoutPhotoBy => 'Şəkil: ';

  @override
  String get layoutPhotoOn => ' — ';

  @override
  String get layoutEditProfile => 'Profili Redaktə Et';

  @override
  String get layoutLogout => 'Çıxış';

  @override
  String get layoutThemeLabel => 'MÖVZU';

  @override
  String get layoutThemePearl => 'Açıq';

  @override
  String get layoutThemeDark => 'Tünd';

  @override
  String get layoutThemeGlassy => 'Şüşəvari';

  @override
  String get layoutThemeNature => 'Təbiət';

  @override
  String get layoutThemeLiquid => 'Maye';

  @override
  String get layoutThemeStage => 'Səhnə';

  @override
  String get layoutTargetLanguage => 'HƏDƏF DİL';

  @override
  String get layoutDeeplUsage => 'DEEPL İSTİFADƏSİ';

  @override
  String get layoutUnavailable => 'Mövcud deyil';

  @override
  String get layoutUnlimited => 'limitsiz';

  @override
  String get layoutUsed => 'istifadə edilib';

  @override
  String get layoutTranslate => 'Tərcümə et';

  @override
  String get analyticsSubtitle =>
      'Uyğunluq, tərcümə yığını və həftəlik trendlər.';

  @override
  String get analyticsBacklog => 'Tərcümə yığını';

  @override
  String get analyticsMissing => 'Çatışmayan';

  @override
  String get analyticsStale => 'Köhnəlmiş';

  @override
  String get analyticsInReview => 'Baxışda';

  @override
  String get analyticsReleased => 'Nəşr edilmiş';

  @override
  String get analyticsTranslated => 'Tərcümə edilmiş';

  @override
  String get analyticsTotalModules => 'Ümumi modullar';

  @override
  String get analyticsCompatByVersion => 'Drupal versiyasına görə uyğunluq';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Dil: $lang · nəşr edilmiş / baxışda / çatışmayan';
  }

  @override
  String get analyticsLoadingCounts => 'Say hesablanır …';

  @override
  String get analyticsWindow => 'Pəncərə:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks həftə';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Həftəlik yeni layihə təsvirləri';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Həftəlik köhnəlmiş kimi işarələnənlər ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modul';
  }

  @override
  String get analyticsReviewShort => 'Baxış';

  @override
  String get analyticsNoDataInWindow => 'Bu pəncərədə məlumat yoxdur.';

  @override
  String get analyticsAndMore => '… və daha çox';

  @override
  String glossaryLoadError(String error) {
    return 'Yükləmə xətası: $error';
  }

  @override
  String get glossaryNewTerm => 'Yeni termin yarat';

  @override
  String get glossaryEditTerm => 'Termini redaktə et';

  @override
  String get glossaryFieldSourceWord =>
      'Mənbə söz (baza forması, mətndə göründüyü kimi)';

  @override
  String get glossaryFieldSourceWordHint => 'məs. node';

  @override
  String get glossaryWordForms =>
      'Əlavə söz formaları (cəm, yiyəlik, yönlük …)';

  @override
  String get glossaryWordFormsHint =>
      'məs. content — əlavə etmək üçün Enter basın';

  @override
  String get glossaryAddForm => 'Forma əlavə et';

  @override
  String get glossaryFieldPreferredWord => 'Tərcih edilən tərcümə';

  @override
  String get glossaryFieldPreferredWordHint => 'məs. content';

  @override
  String get glossaryFieldExplanation => 'İzah (ipucunda göstərilir)';

  @override
  String get glossaryFieldExplanationHint =>
      'Bu söz niyə fərqli tərcümə edilməlidir?';

  @override
  String get glossaryCreate => 'Yarat';

  @override
  String get glossaryRequiredFields =>
      'Mənbə söz və tərcih edilən tərcümə tələb olunur.';

  @override
  String get glossaryCreated => 'Termin yaradıldı ✓';

  @override
  String get glossaryUpdated => 'Termin yeniləndi ✓';

  @override
  String glossaryError(String error) {
    return 'Xəta: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Termin silinsin?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" lüğətdən həmişəlik silinəcək.';
  }

  @override
  String get glossaryDeleted => 'Termin silindi.';

  @override
  String get glossaryTitle => 'Tərcümə Lüğəti';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Dil: $lang · $count qeyd';
  }

  @override
  String get glossaryNewShort => 'Yeni';

  @override
  String get glossaryCreateTerm => 'Termin yarat';

  @override
  String get glossaryInfoBanner =>
      'Bu lüğətdəki sözlər Baxış Redaktorunda vurğulanır. Bir ipucu, üzərinə gələndə niyə fərqli bir tərcümənin daha uyğun olduğunu izah edir.';

  @override
  String get glossaryNoEntries => 'Hələ qeyd yoxdur.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'İlk qeydi yaratmaq üçün \"Termin yarat\" düyməsini klikləyin.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Bu dil üçün hələ lüğət qeydi yoxdur.';

  @override
  String get diffNoChanges => 'Məzmun fərqi aşkarlanmadı.';

  @override
  String get diffRemoved => 'Silinib';

  @override
  String get diffAdded => 'Əlavə edilib';

  @override
  String syncBarQuickSync(String count) {
    return 'Sürətli Sinxronizasiya: $count dəyişən modul …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Tam Sinxronizasiya: $current / $total modul';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Tam Sinxronizasiya: $count modul …';
  }
}
