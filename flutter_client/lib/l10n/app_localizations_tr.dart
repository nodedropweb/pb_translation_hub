// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Proje ayrıntıları yükleniyor...';

  @override
  String editorLoadError(String error) {
    return 'Proje verileri yüklenemedi: $error';
  }

  @override
  String get editorGeminiSuccess => 'Gemini ile çeviri başarılı! ✨';

  @override
  String get editorUnknownError => 'Bilinmeyen hata';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini çevirisi başarısız oldu: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Lütfen Google AI anahtarınızı kullanıcı profilinize ekleyin (yönetici ayarlarına değil).';

  @override
  String get editorGeminiError =>
      'Gemini çevirisi sırasında hata oluştu. Lütfen profilinizdeki Google AI anahtarınızı kontrol edin.';

  @override
  String get editorDeeplSuccess => 'DeepL ile çeviri başarılı! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL çevirisi başarısız oldu: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'DeepL çevirisi sırasında hata oluştu. Lütfen DeepL API anahtarınızın profilinizde tanımlı olduğundan emin olun.';

  @override
  String get editorDeeplInvalidKey =>
      'Geçersiz DeepL API anahtarı. Lütfen profilinizden kontrol edin.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL kotanız tükendi. Lütfen planınızı kontrol edin.';

  @override
  String get editorReviewReset => 'Çeviri inceleme durumuna sıfırlandı.';

  @override
  String editorResetError(String error) {
    return 'Sıfırlama başarısız oldu: $error';
  }

  @override
  String get editorUnignoreSuccess => 'Modül etkin listeye geri döndü.';

  @override
  String get editorUnignoreError => 'Modül geri yüklenemedi.';

  @override
  String get editorSaveSuccess =>
      'Çeviri kaydedildi — inceleme kuyruğuna dönülüyor.';

  @override
  String editorSaveError(String error) {
    return 'Kaydetme başarısız oldu: $error';
  }

  @override
  String get editorNoMoreProjects => 'Listede başka açık proje kalmadı.';

  @override
  String get editorChangesDiscarded =>
      'Değişiklikler iptal edildi, sonraki proje yükleniyor...';

  @override
  String get editorEnglishSourceApplied =>
      'İngilizce orijinal metin uygulandı — lütfen şimdi çevirin.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'URL açılamadı: $url';
  }

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonClose => 'Kapat';

  @override
  String get editorCloseEnglishSource => 'İngilizce kaynağı kapat';

  @override
  String get editorShowEnglishSource => 'İngilizce kaynağı göster';

  @override
  String get editorUnignoreShortTooltip => 'Modülü geri yükle';

  @override
  String get editorBackToReviewTooltip => 'İncelemeye geri gönder';

  @override
  String get editorAndNext => 've Sonraki';

  @override
  String get editorBackToDashboard => 'Panele dön';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return '$langName ($langCode) diline çevriliyor';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count kaldı';
  }

  @override
  String get editorUnignoreLongTooltip => 'Modülü etkin listeye geri döndür';

  @override
  String get editorUnignoreLabel => 'Geri yükle';

  @override
  String get editorUnpublishTooltip =>
      'Yayını iptal et ve incelemeye geri gönder';

  @override
  String get editorBackToReview => 'İncelemeye dön';

  @override
  String get editorSaveAndNext => 'Kaydet ve sonraki';

  @override
  String get editorEnglishSourceHeader => 'İNGİLİZCE KAYNAK';

  @override
  String get editorStaleTooltip =>
      'Açıklamayı göster ve İngilizce metni uygula';

  @override
  String get editorStaleDetailsLabel => 'Güncel değil — Ayrıntılar';

  @override
  String get editorCopyPromptTooltip => 'Kaynağı ve çeviri istemini kopyala';

  @override
  String get editorPromptCopied => 'İstem panoya kopyalandı 📋';

  @override
  String get editorShowPreview => 'Önizlemeyi göster';

  @override
  String get editorShowHtmlSource => 'HTML kaynak kodunu göster';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'ÖZET:\n$summary\n\nİÇERİK:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Özet:';

  @override
  String get editorDescriptionLabelColon => 'Açıklama:';

  @override
  String get editorStaleDialogTitle => 'İngilizce kaynak değişti';

  @override
  String get editorStaleExplanation =>
      'Mevcut çeviri, güncelliğini yitirmiş bir İngilizce orijinal metne dayanmaktadır. Son çeviriden bu yana modül sorumlusu, Drupal.org üzerindeki İngilizce metni değiştirdi — bu nedenle mevcut çevirinin içeriği artık doğru veya eksiksiz olmayabilir.';

  @override
  String get editorStaleTip =>
      'İpucu: geçerli İngilizce kaynağı doğrudan düzenleyiciye yüklemek için \"İngilizce orijinali kullan\" seçeneğine tıklayın. Ardından bunu yeni bir çeviri için başlangıç noktası olarak kullanabilirsiniz. İngilizce orijinal metin ayrıca sol paneldedir.';

  @override
  String get editorEnglishSourceShort => 'İngilizce kaynak';

  @override
  String get editorPreviousTranslation => 'Önceki çeviri';

  @override
  String get editorWhatChangedTitle => 'Ne değişti?';

  @override
  String get editorShowDiff => 'Farkları göster';

  @override
  String get editorUseEnglish => 'İngilizce orijinali kullan';

  @override
  String get editorStaleBannerText =>
      'İngilizce kaynak değişti — çeviri güncelliğini yitirdi';

  @override
  String get editorDetailsAndApply => 'Ayrıntılar ve uygulama';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName ÇEVİRİSİ';
  }

  @override
  String get editorTranslatingEllipsis => 'Çevriliyor...';

  @override
  String get editorShowEditor => 'Düzenleyiciyi göster';

  @override
  String get editorModuleTitleLabel => 'Modül başlığı (İngilizce)';

  @override
  String get editorSummaryFieldLabel => 'Özet';

  @override
  String get editorBodyFieldLabel => 'İçerik';

  @override
  String get editorHtmlCleaned => 'HTML temizlendi';

  @override
  String get editorLivePreviewHeader => 'CANLI ÖNİZLEME';

  @override
  String get editorTidyHtmlTooltip =>
      'HTML\'i temizle (DeepL kalıntılarını kaldır)';

  @override
  String get editorVisualMode => 'GÖRSEL';

  @override
  String get editorSourceCodeMode => 'KAYNAK (HTML)';

  @override
  String get commonCancel => 'İptal';

  @override
  String get costDialogTitle => 'Maliyet Tahmini (Yapay Zeka)';

  @override
  String get costDialogIntro =>
      'Seçilen modül, Google Gemini AI ile çevrilecek. Bu işlem için tahmini maliyet dökümü aşağıdadır:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Girdi token\'ları';

  @override
  String get costRowOutputTokens => 'Çıktı token\'ları (tahmini)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars karakter)';
  }

  @override
  String get costRowPriceInput => '1M girdi başına fiyat';

  @override
  String get costRowPriceOutput => '1M çıktı başına fiyat';

  @override
  String get costRowTotalEstimate => 'Tahmini toplam maliyet';

  @override
  String get costDialogFootnote =>
      '* Not: Bu, Google\'ın mevcut kullandıkça öde fiyatlandırma modeline dayalı bir tahmindir. Gerçek kullanım hafifçe farklılık gösterebilir.';

  @override
  String get costDialogStartTranslation => 'Çeviriyi başlat';

  @override
  String get htmlToolbarInsertLink => 'Bağlantı ekle';

  @override
  String get htmlToolbarLinkTooltip => 'Bağlantı ekle (a)';

  @override
  String get htmlToolbarInsert => 'Ekle';

  @override
  String get htmlToolbarHeading2 => 'Başlık 2';

  @override
  String get htmlToolbarHeading3 => 'Başlık 3';

  @override
  String get htmlToolbarBold => 'Kalın (strong)';

  @override
  String get htmlToolbarItalic => 'İtalik (em)';

  @override
  String get htmlToolbarBulletList => 'Madde işaretli liste (ul)';

  @override
  String get htmlToolbarNumberedList => 'Numaralı liste (ol)';

  @override
  String get htmlToolbarQuote => 'Alıntı (blockquote)';

  @override
  String get screenshotAltsHeader => 'EKRAN GÖRÜNTÜSÜ ALTERNATİF METNİ';

  @override
  String get screenshotAltsIntro =>
      'Her ekran görüntüsü için hedef dilde açıklayıcı bir alternatif metin girin.';

  @override
  String screenshotLabel(int number) {
    return 'Ekran görüntüsü $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Önizleme kullanılamıyor';

  @override
  String get screenshotAltHint => 'Hedef dilde alternatif metni girin…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Yok sayılan tüm modüller geri yüklensin mi?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Yok sayılan tüm modüller etkin listeye geri döndürülecek ve yeniden çeviri için kullanılabilir hale gelecek.';

  @override
  String get dashUnignoreAllConfirmAction => 'Tümünü geri yükle';

  @override
  String get dashUnignoreAllSuccess =>
      'Yok sayılan tüm modüller geri yüklendi.';

  @override
  String get dashUnignoreAllError => 'Modüller geri yüklenemedi.';

  @override
  String get dashUnignoreAllButton => 'Yok sayılan tüm modülleri geri yükle';

  @override
  String dashSyncStartError(String error) {
    return 'Senkronizasyon başlatılamadı: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Hızlı güncelleme (7 gün) başlatıldı ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Hızlı güncelleme hatası: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Başarıyla senkronize edildi: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modül Drupal.org\'da bulunamadı.';

  @override
  String get dashAiBulkTranslation => 'Yapay Zeka ile Toplu Çeviri';

  @override
  String get dashHeaderTitle => 'Proje Açıklamaları';

  @override
  String get dashHeaderSubtitle =>
      'Drupal modül açıklamalarını hedef dile çevirin. Ekosistemi daha erişilebilir hale getirmeye yardımcı olun.';

  @override
  String get dashHeaderSubtitleShort => 'Drupal modül açıklamalarını çevirin.';

  @override
  String get dashLastLabel => 'Son: ';

  @override
  String get dashContinue => 'Devam et';

  @override
  String get dashContinueShort => 'Devam et';

  @override
  String get dashUnignoreAllButtonLong =>
      'Yok sayılan tüm modülleri geri yükle';

  @override
  String get dashQuickUpdateTooltip => 'Hızlı güncelleme (son 7 gün)';

  @override
  String get dashFullSyncTooltip =>
      'Drupal.org\'dan tam veritabanı senkronizasyonu';

  @override
  String get dashManualLoadTooltip =>
      'Drupal.org\'dan tek bir modülü manuel olarak yükle';

  @override
  String get dashQuickShort => 'Hızlı';

  @override
  String get dashModuleShort => 'Modül';

  @override
  String get dashFoundLabel => 'Bulunan: ';

  @override
  String get dashModulesSuffix => ' modül';

  @override
  String dashPerPage(int count) {
    return 'Sayfa başına $count';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / sayfa';
  }

  @override
  String get dashFirstPage => 'İlk sayfa';

  @override
  String get dashPrevPage => 'Önceki sayfa';

  @override
  String get dashNextPage => 'Sonraki sayfa';

  @override
  String get dashLastPage => 'Son sayfa';

  @override
  String dashPageOf(int page, int total) {
    return 'Sayfa $page / $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (örn. pathauto)';

  @override
  String get dashAddButton => 'Ekle';

  @override
  String get dashAddModuleManually => 'Modülü manuel olarak ekle';

  @override
  String get dashAddModuleSubtitle =>
      'machine name ile doğrudan Drupal.org\'dan yükleyin.';

  @override
  String get dashAddModuleShort => 'Modül ekle';

  @override
  String get dashNoProjectsFound => 'Proje bulunamadı.';

  @override
  String get dashFilterAll => 'Tüm Projeler';

  @override
  String get dashFilterMissing => 'Eksik Çeviriler';

  @override
  String get dashFilterReview => 'İnceleme Kuyruğu';

  @override
  String get dashFilterTranslated => 'Çevrilmiş Projeler';

  @override
  String get dashFilterReleased => 'Yayınlanmış Projeler';

  @override
  String get dashBulkDialogIntro =>
      'Seçilen filtredeki birden fazla modülü Google Gemini kullanarak otomatik olarak çevirin.';

  @override
  String get dashActiveFilter => 'Etkin Filtre';

  @override
  String get dashModuleCount => 'Modül Sayısı';

  @override
  String dashModulesCountItem(int count) {
    return '$count modül';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12 modüllerine öncelik ver';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Önce Drupal 12 desteği olmayan modülleri çevirir';

  @override
  String get dashTotalModules => 'Toplam modül';

  @override
  String get dashInputTokensEst => 'Girdi token\'ları (tahmini)';

  @override
  String get dashOutputTokensEst => 'Çıktı token\'ları (tahmini)';

  @override
  String get dashBulkFootnote =>
      '* Zaman aşımlarını önlemek için çeviri, kaynak açısından verimli gruplar halinde gerçekleştirilir.';

  @override
  String get dashStartBulkTranslation => 'Toplu Çeviriyi Başlat';

  @override
  String dashStaleLoadError(String error) {
    return 'Güncelliğini yitirmiş modüller yüklenirken hata oluştu: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Güncelliğini yitirmiş modül bulunamadı — her şey güncel! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Güncelliğini Yitirmiş Modülleri Yeniden Çevir';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Son çeviriden bu yana İngilizce kaynağı değişen tüm çeviriler, Google Gemini kullanılarak otomatik olarak yeniden çevrilecek. Her modülü tek tek manuel olarak açmaya gerek yoktur.';

  @override
  String get dashOutdatedModules => 'Güncelliğini yitirmiş modüller';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Çeviri, mevcut metnin yerini alır ve is_reviewed durumunu sıfırlar. 4\'er modüllük gruplar halinde gerçekleştirilir.';

  @override
  String dashRetranslateAllCount(int count) {
    return '$count modülün tümünü yeniden çevir';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Güncelliğini yitirmiş modüller yeniden çevriliyor…';

  @override
  String get dashFetchingProjects => 'Projeler sunucudan alınıyor…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$total modülden $processed tanesi işlendi';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Bu filtre için çevrilebilir proje bulunamadı.';

  @override
  String get dashStartingTranslation => 'Çeviri başlatılıyor…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return '$total modülden $start–$end arası çevriliyor …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$total modülden $end tanesi tamamlandı.';
  }

  @override
  String get dashTranslationCompleted => 'Çeviri başarıyla tamamlandı! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '$count modülün toplu çevirisi başarılı! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Toplu çeviri hatası: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return '$count modülün tümü başarıyla yeniden çevrildi! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count güncelliğini yitirmiş modül başarıyla yeniden çevrildi! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Yeniden çeviri sırasında hata oluştu: $error';
  }

  @override
  String get filterAllShort => 'Tümü';

  @override
  String get filterMissing => 'Eksik';

  @override
  String get filterTranslated => 'Çevrilmiş';

  @override
  String get filterReviewQueue => 'İnceleme Kuyruğu';

  @override
  String get filterReleased => 'Yayınlanmış';

  @override
  String get filterOutdated => 'Güncel Değil';

  @override
  String get filterPriority => 'Öncelikli';

  @override
  String get filterIgnored => 'Yok Sayılmış';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonReset => 'Sıfırla';

  @override
  String get commonRefresh => 'Yenile';

  @override
  String commonErrorPrefix(String error) {
    return 'Hata: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Yayınlanmış tüm çeviriler sıfırlansın mı?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return '$langcode için yayınlanmış olarak işaretlenmiş tüm çeviriler inceleme durumuna sıfırlanacak. Bu işlem geri alınamaz.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count çeviri inceleme durumuna sıfırlandı.';
  }

  @override
  String get reviewPipelineTitle => 'İnceleme Süreci';

  @override
  String get reviewPipelineSubtitle =>
      'Yapay zeka çevirileri için insan kalite güvence süreci';

  @override
  String get reviewSearchHint => 'Proje ara...';

  @override
  String get reviewResetPublished => 'Yayınlananları sıfırla';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Sonuçlar: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Bekleyen: $count';
  }

  @override
  String get reviewNoProjectsPending => 'İncelemeyi bekleyen proje yok.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Tüm çeviriler zaten doğrulanmış veya bu dil bağlamında hiç çeviri bulunmuyor.';

  @override
  String get reviewNoSummary => 'Özet yok.';

  @override
  String get reviewStartAudit => 'DENETİMİ BAŞLAT';

  @override
  String get reviewHtmlSourceShort => 'HTML kaynağı';

  @override
  String get reviewCopySource => 'Kaynağı kopyala';

  @override
  String get reviewModuleDetails => 'Modül Ayrıntıları';

  @override
  String get reviewOriginalTitle => 'Orijinal Başlık';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org Projesi';

  @override
  String get reviewSuggestions => 'Öneriler';

  @override
  String get reviewNoSuggestions => 'Kullanılabilir öneri yok.';

  @override
  String get reviewApply => 'Uygula';

  @override
  String get reviewNoChanges => 'Değişiklik yok';

  @override
  String get reviewOriginalBeforeCorrection => 'Orijinal (düzeltmeden önce)';

  @override
  String get reviewCorrectedCurrentVersion => 'Düzeltilmiş (mevcut sürüm)';

  @override
  String get reviewBaseOriginal => 'Temel (Orijinal)';

  @override
  String get reviewYourCorrection => 'Sizin düzeltmeniz';

  @override
  String get reviewChangesVisual => 'Değişikliklerinizi İnceleyin (Görsel)';

  @override
  String get commonSkip => 'Atla';

  @override
  String get commonIgnore => 'Yok say';

  @override
  String get reviewEmptyProjectTitle => 'Boş Proje';

  @override
  String get reviewEmptyProjectBody =>
      'Bu proje boş (başlık, özet veya içerik yok) ve onaylanamaz. Lütfen atlayın.';

  @override
  String get reviewApprovedSuccess => 'Çeviri onaylandı! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ \"$machine\" onayı başarısız oldu — lütfen tekrar deneyin.';
  }

  @override
  String get reviewUnignoredSuccess => 'Geri yüklendi. Modül tekrar etkin!';

  @override
  String get reviewActionFailed => 'İşlem başarısız oldu.';

  @override
  String get reviewIgnoreModuleTitle => 'Modül yok sayılsın mı?';

  @override
  String get reviewIgnoreModuleBody =>
      'Bu modül tüm listelerden kalıcı olarak gizlenecek. Bir daha bu modülde takılı kalmayacaksınız.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modül kalıcı olarak yok sayıldı.';

  @override
  String get reviewIgnoreFailed => 'Modül yok sayılamadı.';

  @override
  String get reviewSuggestionSaved => 'Öneri taslağı kaydedildi! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'Öneri taslağı kaydedilemedi.';

  @override
  String get reviewSuggestionDeleted => 'Öneri silindi.';

  @override
  String get reviewDeleteFailed => 'Silme başarısız oldu.';

  @override
  String get reviewSuggestionApplied => 'Öneri uygulandı.';

  @override
  String get reviewPreparingData => 'İnceleme verileri hazırlanıyor...';

  @override
  String get reviewDirectEdit => 'Doğrudan Düzenleme';

  @override
  String get reviewLivePreview => 'Canlı Önizleme';

  @override
  String get reviewCompareWith => 'Şununla karşılaştır:';

  @override
  String get reviewProductionVersion => 'Üretim Sürümü';

  @override
  String get reviewEditorialReview => 'Editoryal İnceleme';

  @override
  String get reviewOpenQueue => 'İnceleme kuyruğunu aç';

  @override
  String get reviewCopyPromptShort => 'İstemi kopyala';

  @override
  String get reviewUnignoreShort => 'Geri yükle';

  @override
  String get reviewApproveButton => 'ONAYLA';

  @override
  String get reviewHideDetails => 'Ayrıntıları gizle';

  @override
  String get reviewDetailsAndEnglishSource => 'Ayrıntılar ve İngilizce Kaynak';

  @override
  String reviewPendingCountShort(int count) {
    return '$count bekliyor';
  }

  @override
  String reviewReviewingModule(String name) {
    return '$name inceleniyor';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Çeviriyi İngilizce kaynakla karşılaştır';

  @override
  String get reviewTranslationLabel => 'Çeviri';

  @override
  String get reviewComparisonTitle => 'Karşılaştırma';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Kaynak metni ve çeviri istemini panoya kopyala';

  @override
  String get reviewUnignoreCaps => 'GERİ YÜKLE';

  @override
  String get reviewIgnoreCaps => 'YOK SAY';

  @override
  String get reviewSkipShortcut => 'ATLA (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Editoryal İnceleme';

  @override
  String get reviewUnignoreTablet => 'GERİ YÜKLE';

  @override
  String get reviewApproveForProduction => 'ÜRETİM İÇİN ONAYLA (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Doğrudan İyileştirme';

  @override
  String get reviewTitleField => 'Başlık';

  @override
  String get reviewSummaryField => 'Özet';

  @override
  String get reviewBodyField => 'İçerik';

  @override
  String get reviewSaveShortcut => 'KAYDET (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Canlı Önizleme (İşleniyor)';

  @override
  String get reviewVoiceFemale => 'Kadın';

  @override
  String get reviewVoiceMale => 'Erkek';

  @override
  String get reviewStopListening => 'Durdur';

  @override
  String get reviewListen => 'Dinle';

  @override
  String get reviewAutopTooltip =>
      'Paragrafları otomatik biçimlendir (satır sonları → <p>)';

  @override
  String get reviewSourceCodeShort => 'KAYNAK';

  @override
  String get reviewNoParagraphChange =>
      'Metin zaten <p> etiketleri içeriyor — değişiklik yok';

  @override
  String get reviewParagraphsFormatted => 'Paragraflar biçimlendirildi ¶';

  @override
  String get commonRetry => 'Tekrar dene';

  @override
  String categoriesLoadError(String error) {
    return 'Kategoriler yüklenemedi: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategoriler başarıyla kaydedildi.';

  @override
  String get categoriesSaveFailed => 'Çeviriler kaydedilemedi.';

  @override
  String get categoriesFileEmpty => 'Dosya boş.';

  @override
  String get categoriesInvalidJson => 'Geçersiz JSON biçimi.';

  @override
  String get categoriesNoValidUuids =>
      'Dosyada geçerli UUID girdisi bulunamadı.';

  @override
  String categoriesImportSuccess(int count) {
    return 'Dosyadan $count kategori içe aktarıldı.';
  }

  @override
  String get categoriesTitle => 'Kategoriler';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Şunun için çevriliyor: $lang';
  }

  @override
  String get categoriesImportJson => 'JSON İçe Aktar';

  @override
  String get categoriesSaving => 'Kaydediliyor...';

  @override
  String get categoriesSaveAll => 'Tümünü Kaydet';

  @override
  String get categoriesLoading => 'Kategoriler yükleniyor...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Çeviri ($code)';
  }

  @override
  String get categoriesNoneFound => 'Kategori bulunamadı.';

  @override
  String categoriesTranslateHint(String name) {
    return '\"$name\" çevrilsin...';
  }

  @override
  String get loginPhotoBy => 'Fotoğraf: ';

  @override
  String get loginPhotoOn => ', kaynak: ';

  @override
  String get loginPleaseSignIn => 'Lütfen oturum açın';

  @override
  String get loginUsername => 'Kullanıcı adı';

  @override
  String get loginPassword => 'Şifre';

  @override
  String get loginRememberMe => 'Beni hatırla';

  @override
  String get loginSignIn => 'OTURUM AÇ';

  @override
  String get loginNoAccount => 'Henüz hesabınız yok mu? ';

  @override
  String get loginRegisterNow => 'Şimdi kaydolun';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonNext => 'İleri';

  @override
  String get registerFillRequired => 'Lütfen tüm zorunlu alanları doldurun.';

  @override
  String get registerPasswordMismatch => 'Şifreler eşleşmiyor.';

  @override
  String get registerPasswordTooShort => 'Şifre en az 8 karakter olmalıdır.';

  @override
  String get registerSelectLanguage => 'Lütfen en az bir dil seçin.';

  @override
  String get registerFailed => 'Kayıt başarısız oldu.';

  @override
  String get registerHeaderTitle => 'KAYIT';

  @override
  String get registerStepAccount => 'Hesap';

  @override
  String get registerStepRole => 'Rol';

  @override
  String get registerStepLanguages => 'Diller';

  @override
  String get registerStepApiKeys => 'API Anahtarları';

  @override
  String get registerYourAccount => 'Hesabınız';

  @override
  String get registerAvatarOptional => 'Avatar (isteğe bağlı)';

  @override
  String get registerUsernameRequired => 'Kullanıcı adı *';

  @override
  String get registerEmailRequired => 'E-posta adresi *';

  @override
  String get registerPasswordRequired => 'Şifre *';

  @override
  String get registerPasswordRepeat => 'Şifreyi tekrarlayın *';

  @override
  String get registerYourRole => 'Rolünüz';

  @override
  String get registerRoleExplanation =>
      'Çevirmenler metinleri çevirebilir ancak inceleme kuyruğuna erişemez. İncelemeciler ise çevrilen içeriği kontrol edip onaylar.';

  @override
  String get registerRoleTranslator => 'Çevirmen';

  @override
  String get registerRoleTranslatorDesc => 'Çeviri oluşturur ve düzenler.';

  @override
  String get registerRoleReviewer => 'İncelemeci';

  @override
  String get registerRoleReviewerDesc => 'Çevirileri inceler ve onaylar.';

  @override
  String get registerTargetLanguages => 'Hedef Diller';

  @override
  String get registerLanguagesExplanation =>
      'Üzerinde çalışmak istediğiniz tüm dilleri seçin.';

  @override
  String get registerNoLanguagesAvailable => 'Kullanılabilir dil yok.';

  @override
  String get registerApiKeysTitle => 'API Anahtarları';

  @override
  String get registerApiKeysExplanation =>
      'Kendi API anahtarlarınızı girin. Her kullanıcı yalnızca kendi anahtarlarını kullanır. Bunları daha sonra profilinizden de ekleyebilirsiniz.';

  @override
  String get registerKeysEncryptedNote =>
      'Anahtarlar şifrelenmiş olarak saklanır ve başka kullanıcılarla asla paylaşılmaz.';

  @override
  String get registerOptionalSuffix => ' (isteğe bağlı)';

  @override
  String get registerSuccessTitle => 'Kayıt başarılı!';

  @override
  String get registerSuccessBody =>
      'Hesabınız oluşturuldu ve bir yöneticinin onayını bekliyor. Erişiminiz etkinleştirildiğinde bilgilendirileceksiniz.';

  @override
  String get registerGoToLogin => 'Oturum Açmaya Git';

  @override
  String get registerSubmit => 'Kaydol';

  @override
  String registerPhotoCredit(String name) {
    return 'Fotoğraf: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil başarıyla güncellendi!';

  @override
  String get profileUpdateFailed => 'Güncelleme başarısız oldu.';

  @override
  String profileSaveError(String error) {
    return 'Kaydederken hata oluştu: $error';
  }

  @override
  String get profilePasswordMismatch => 'Şifreler eşleşmiyor!';

  @override
  String get profilePasswordChangeSuccess => 'Şifre başarıyla değiştirildi!';

  @override
  String get profilePasswordChangeError =>
      'Şifre değiştirilirken hata oluştu: mevcut şifre yanlış.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar başarıyla yüklendi!';

  @override
  String get profileAvatarUploadError => 'Avatar yüklenirken hata oluştu.';

  @override
  String get profileTitle => 'Profil ve Ayarlar';

  @override
  String get profileSubtitle =>
      'Kullanıcı profilinizi, çeviri API\'lerinizi (Gemini ve DeepL) ve hesap güvenliğinizi yönetin.';

  @override
  String get profileRoleUser => 'Kullanıcı';

  @override
  String get profileNoEmail => 'E-posta adresi belirtilmemiş';

  @override
  String get profileTabDetails => 'Profil Ayrıntıları';

  @override
  String get profileTabGemini => 'Yapay Zeka Çevirisi (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL Çevirisi';

  @override
  String get profileTabPassword => 'Şifreyi Değiştir';

  @override
  String get profileSectionInfo => 'PROFİL BİLGİLERİ';

  @override
  String get profileFieldName => 'Ad';

  @override
  String get profileFieldNameHint => 'Tam adınız';

  @override
  String get profileFieldEmail => 'E-posta adresi';

  @override
  String get profileFieldEmailHint => 'E-posta adresiniz';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT AYARLARI';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API anahtarı';

  @override
  String get profileFieldGeminiKeyHint =>
      'gemini-3.1-flash API anahtarınızı girin';

  @override
  String get profileFieldAiPrompt => 'Özel Yapay Zeka İstemi';

  @override
  String get profileFieldAiPromptHint =>
      'İsteğe bağlı: Gemini için sistem istemini özelleştirin...';

  @override
  String get profileSectionDeepl => 'DEEPL ÇEVİRİ AYARLARI';

  @override
  String get profileDeeplDescription =>
      'DeepL, HTML etiketlerini koruyarak yüksek kaliteli makine çevirisi sunar. Ücretsiz hesaplar (ayda 500.000 karakter) sonu \":fx\" ile biten bir anahtar alır.';

  @override
  String get profileFieldDeeplKey => 'DeepL API anahtarı';

  @override
  String get profileFieldDeeplKeyHint =>
      'örn. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Ücretsiz anahtarlar \":fx\" ile biter ve api-free.deepl.com kullanır. Pro anahtarlar api.deepl.com kullanır. Bu ayrım otomatik olarak yapılır.';

  @override
  String get profileSectionSecurity => 'HESAP GÜVENLİĞİ';

  @override
  String get profileFieldCurrentPassword => 'Mevcut şifre';

  @override
  String get profileFieldCurrentPasswordHint => 'Mevcut şifrenizi girin';

  @override
  String get profileFieldNewPassword => 'Yeni şifre';

  @override
  String get profileFieldNewPasswordHint => 'En az 6 karakter';

  @override
  String get profileFieldConfirmPassword => 'Yeni şifreyi onayla';

  @override
  String get profileFieldConfirmPasswordHint => 'Şifreyi tekrarlayın';

  @override
  String get profileChangePasswordButton => 'Şifreyi Değiştir';

  @override
  String get commonDelete => 'Sil';

  @override
  String get settingsRegistrationUpdated => 'Kayıt ayarı güncellendi';

  @override
  String get settingsUpdateFailed => 'Güncelleme başarısız oldu.';

  @override
  String get settingsUserApproved => 'Kullanıcı onaylandı!';

  @override
  String get settingsAccountDeactivated => 'Hesap devre dışı bırakıldı.';

  @override
  String get settingsUserDeleted => 'Kullanıcı silindi.';

  @override
  String get settingsActionFailed => 'İşlem başarısız oldu.';

  @override
  String get settingsDeleteAccountTitle => 'Hesap silinsin mi?';

  @override
  String get settingsDeactivateAccountTitle =>
      'Hesap devre dışı bırakılsın mı?';

  @override
  String settingsDeleteAccountBody(String username) {
    return '\"$username\" hesabı kalıcı olarak silinecek. Devam edilsin mi?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return '\"$username\" hesabı kilitlenecek. Kullanıcı artık oturum açamayacak, ancak hesap saklanmaya devam edecek.';
  }

  @override
  String get settingsDeactivate => 'Devre dışı bırak';

  @override
  String settingsSyncSuccess(String count) {
    return '$count çeviri senkronize edildi!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Senkronizasyon hatası: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count öncelikli modül senkronize edildi!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Öncelik listesi senkronize edilirken hata oluştu: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Yedekleme başarılı: $count dosya işlendi.';
  }

  @override
  String get settingsUploadFailed => 'Yükleme başarısız oldu.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSystemConfig => 'SİSTEM YAPILANDIRMASI';

  @override
  String get settingsRegistration => 'Kayıt';

  @override
  String get settingsRegistrationHint =>
      'Genel kayıt formu görünürlüğünü açıp kapatın.';

  @override
  String get settingsPendingUsers => 'Bekleyen Kullanıcılar';

  @override
  String get settingsNoNewRequests => 'Yeni talep yok.';

  @override
  String get settingsWantsReviewer => 'İncelemeci olmak istiyor';

  @override
  String get settingsAssignRole => 'Rol ata';

  @override
  String get settingsRoleTranslator => 'Çevirmen';

  @override
  String get settingsRoleReviewer => 'İncelemeci';

  @override
  String get settingsApprove => 'Onayla';

  @override
  String get settingsReject => 'Reddet';

  @override
  String get settingsActiveUsers => 'Etkin Kullanıcılar';

  @override
  String get settingsNoActiveUsers => 'Etkin kullanıcı yok.';

  @override
  String get settingsDeactivateAccountTooltip => 'Devre dışı bırak';

  @override
  String get settingsDeleteAccountAction => 'Hesabı sil';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsThemePearl => 'AÇIK (İNCİ)';

  @override
  String get settingsThemeDark => 'KOYU';

  @override
  String get settingsThemeGlassy => 'CAMSI';

  @override
  String get settingsThemeNature => 'DOĞA';

  @override
  String get settingsThemeLiquid => 'SIVI';

  @override
  String get settingsThemeStage => 'SAHNE';

  @override
  String get settingsTypography => 'Tipografi';

  @override
  String get settingsFontHint => 'Arayüz yazı tipi ailesini değiştirin.';

  @override
  String get settingsFontClean => 'Sade';

  @override
  String get settingsFontFuturistic => 'Fütüristik';

  @override
  String get settingsFontTech => 'Teknolojik';

  @override
  String get settingsWorkflowFun => 'İş Akışı ve Eğlence';

  @override
  String get settingsConfettiTitle => 'Başarı Kutlaması (Konfeti)';

  @override
  String get settingsConfettiHint =>
      'Başarıyla kaydedildiğinde küçük bir animasyon gösterir.';

  @override
  String get settingsLargeUiTitle => 'Gelişmiş Okunabilirlik (Büyük Yazı Tipi)';

  @override
  String get settingsLargeUiHint =>
      'Daha iyi okunabilirlik için yazı tiplerinin ve rozetlerin boyutunu artırır.';

  @override
  String get settingsAutoPTitle => 'Otomatik Paragraf Biçimlendirme (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'İnceleme Ekranında bir modül yüklendiğinde düz metni otomatik olarak <p> paragraflarına sarar. Manuel olarak ¶ düğmesine tıklamakla eşdeğerdir.';

  @override
  String get settingsDatabaseSync => 'Veritabanı Senkronizasyonu';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Veritabanı kayıtlarını JSON çeviri dosyalarıyla senkronize eder.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sunucudaki dahili veritabanı kayıtlarını çeviri JSON dosyalarıyla senkronize eder.';

  @override
  String get settingsSyncing => 'Senkronize ediliyor...';

  @override
  String get settingsSyncNow => 'Şimdi Senkronize Et';

  @override
  String get settingsSyncD11List => 'D11 Listesini Senkronize Et';

  @override
  String get settingsUploadBackup => 'Yedek Yükle (.zip)';

  @override
  String get settingsSelectZipFile => 'ZIP Dosyası Seç';

  @override
  String get settingsUploading => 'Yükleniyor...';

  @override
  String get settingsErrorDiagnostics => 'Hata Tanılama ve Sistem Günlükleri';

  @override
  String get settingsLogsCopied => 'Günlükler panoya kopyalandı! 📋';

  @override
  String get settingsCopyLogs => 'Günlükleri Kopyala';

  @override
  String get settingsLogsRotated => 'Günlükler arşivlendi ve döndürüldü! 📁';

  @override
  String get settingsRotate => 'Döndür';

  @override
  String get settingsClear => 'Temizle';

  @override
  String get settingsLogLimit => 'Günlük Sınırı: ';

  @override
  String get settingsNoLogs => 'Kayıtlı günlük yok';

  @override
  String get layoutMenu => 'Menü';

  @override
  String get layoutNavAnalytics => 'Analiz';

  @override
  String get layoutNavReviewQueue => 'İnceleme Kuyruğu';

  @override
  String get layoutNavGlossary => 'Sözlük';

  @override
  String get layoutNavCategories => 'Kategoriler';

  @override
  String get layoutNavHelp => 'Yardım';

  @override
  String get layoutNavSettings => 'Ayarlar';

  @override
  String get layoutPhotoBy => 'Fotoğraf: ';

  @override
  String get layoutPhotoOn => ', kaynak: ';

  @override
  String get layoutEditProfile => 'Profili Düzenle';

  @override
  String get layoutLogout => 'Oturumu Kapat';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Açık';

  @override
  String get layoutThemeDark => 'Koyu';

  @override
  String get layoutThemeGlassy => 'Camsı';

  @override
  String get layoutThemeNature => 'Doğa';

  @override
  String get layoutThemeLiquid => 'Sıvı';

  @override
  String get layoutThemeStage => 'Sahne';

  @override
  String get layoutTargetLanguage => 'HEDEF DİL';

  @override
  String get layoutDeeplUsage => 'DEEPL KULLANIMI';

  @override
  String get layoutUnavailable => 'Kullanılamıyor';

  @override
  String get layoutUnlimited => 'sınırsız';

  @override
  String get layoutUsed => 'kullanıldı';

  @override
  String get layoutTranslate => 'Çevir';

  @override
  String get analyticsSubtitle =>
      'Uyumluluk, çeviri iş yükü ve haftalık eğilimler.';

  @override
  String get analyticsBacklog => 'Çeviri İş Yükü';

  @override
  String get analyticsMissing => 'Eksik';

  @override
  String get analyticsStale => 'Güncel Değil';

  @override
  String get analyticsInReview => 'İncelemede';

  @override
  String get analyticsReleased => 'Yayınlanmış';

  @override
  String get analyticsTranslated => 'Çevrilmiş';

  @override
  String get analyticsTotalModules => 'Toplam Modül';

  @override
  String get analyticsCompatByVersion => 'Drupal Sürümüne Göre Uyumluluk';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Dil: $lang · yayınlanmış / incelemede / eksik';
  }

  @override
  String get analyticsLoadingCounts => 'Sayılar yükleniyor …';

  @override
  String get analyticsWindow => 'Zaman Aralığı:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks hafta';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Haftalık yeni proje açıklamaları';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Haftalık güncel değil olarak işaretlenenler ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modül';
  }

  @override
  String get analyticsReviewShort => 'İnceleme';

  @override
  String get analyticsNoDataInWindow => 'Bu zaman aralığında veri yok.';

  @override
  String get analyticsAndMore => '… ve daha fazlası';

  @override
  String glossaryLoadError(String error) {
    return 'Yükleme hatası: $error';
  }

  @override
  String get glossaryNewTerm => 'Yeni terim oluştur';

  @override
  String get glossaryEditTerm => 'Terimi düzenle';

  @override
  String get glossaryFieldSourceWord =>
      'Kaynak sözcük (metinde geçtiği temel biçim)';

  @override
  String get glossaryFieldSourceWordHint => 'örn. node';

  @override
  String get glossaryWordForms =>
      'Diğer sözcük biçimleri (çoğul, tamlayan, yönelme durumu vb.)';

  @override
  String get glossaryWordFormsHint =>
      'örn. content — eklemek için Enter\'a basın';

  @override
  String get glossaryAddForm => 'Biçim ekle';

  @override
  String get glossaryFieldPreferredWord => 'Tercih edilen çeviri';

  @override
  String get glossaryFieldPreferredWordHint => 'örn. içerik';

  @override
  String get glossaryFieldExplanation => 'Açıklama (araç ipucunda gösterilir)';

  @override
  String get glossaryFieldExplanationHint =>
      'Bu sözcük neden farklı çevrilmelidir?';

  @override
  String get glossaryCreate => 'Oluştur';

  @override
  String get glossaryRequiredFields =>
      'Kaynak sözcük ve tercih edilen çeviri zorunludur.';

  @override
  String get glossaryCreated => 'Terim oluşturuldu ✓';

  @override
  String get glossaryUpdated => 'Terim güncellendi ✓';

  @override
  String glossaryError(String error) {
    return 'Hata: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Terim silinsin mi?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" sözlükten kalıcı olarak kaldırılacak.';
  }

  @override
  String get glossaryDeleted => 'Terim silindi.';

  @override
  String get glossaryTitle => 'Çeviri Sözlüğü';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Dil: $lang · $count giriş';
  }

  @override
  String get glossaryNewShort => 'Yeni';

  @override
  String get glossaryCreateTerm => 'Terim oluştur';

  @override
  String get glossaryInfoBanner =>
      'Bu sözlükteki sözcükler İnceleme Düzenleyicisinde renkli olarak vurgulanır. Fare ile üzerine gelindiğinde, başka bir çevirinin neden daha uygun olduğunu açıklayan bir araç ipucu görüntülenir.';

  @override
  String get glossaryNoEntries => 'Henüz giriş yok.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'İlk girişi oluşturmak için \"Terim oluştur\" seçeneğine tıklayın.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Bu dil için henüz sözlük girişi yok.';

  @override
  String get diffNoChanges => 'İçerik farkı tespit edilmedi.';

  @override
  String get diffRemoved => 'Kaldırıldı';

  @override
  String get diffAdded => 'Eklendi';

  @override
  String syncBarQuickSync(String count) {
    return 'Hızlı Senkronizasyon: $count modül değiştirildi …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Tam Senkronizasyon: $current / $total modül';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Tam Senkronizasyon: $count modül …';
  }
}
