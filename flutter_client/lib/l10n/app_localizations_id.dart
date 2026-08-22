// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Memuat detail proyek...';

  @override
  String editorLoadError(String error) {
    return 'Gagal memuat data proyek: $error';
  }

  @override
  String get editorGeminiSuccess => 'Terjemahan dengan Gemini berhasil! ✨';

  @override
  String get editorUnknownError => 'Kesalahan tidak diketahui';

  @override
  String editorGeminiFailed(String detail) {
    return 'Terjemahan Gemini gagal: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Silakan tambahkan kunci Google AI Anda di profil pengguna (bukan di pengaturan admin).';

  @override
  String get editorGeminiError =>
      'Terjadi kesalahan saat terjemahan Gemini. Silakan periksa kunci Google AI Anda di profil.';

  @override
  String get editorDeeplSuccess => 'Terjemahan dengan DeepL berhasil! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Terjemahan DeepL gagal: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Terjadi kesalahan saat terjemahan DeepL. Pastikan kunci API DeepL Anda sudah diatur di profil.';

  @override
  String get editorDeeplInvalidKey =>
      'Kunci API DeepL tidak valid. Silakan periksa di profil Anda.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Kuota DeepL habis. Silakan periksa paket Anda.';

  @override
  String get editorReviewReset => 'Terjemahan direset ke status peninjauan.';

  @override
  String editorResetError(String error) {
    return 'Gagal mereset: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Modul telah dikembalikan ke daftar aktif.';

  @override
  String get editorUnignoreError =>
      'Gagal mengembalikan modul dari status diabaikan.';

  @override
  String get editorSaveSuccess =>
      'Terjemahan disimpan — kembali ke antrean peninjauan.';

  @override
  String editorSaveError(String error) {
    return 'Gagal menyimpan: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'Tidak ada lagi proyek terbuka dalam daftar.';

  @override
  String get editorChangesDiscarded =>
      'Perubahan dibatalkan, memuat proyek berikutnya...';

  @override
  String get editorEnglishSourceApplied =>
      'Teks asli bahasa Inggris diterapkan — silakan terjemahkan sekarang.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Tidak dapat membuka URL: $url';
  }

  @override
  String get commonSave => 'Simpan';

  @override
  String get commonClose => 'Tutup';

  @override
  String get editorCloseEnglishSource => 'Tutup sumber bahasa Inggris';

  @override
  String get editorShowEnglishSource => 'Tampilkan sumber bahasa Inggris';

  @override
  String get editorUnignoreShortTooltip => 'Batalkan pengabaian modul';

  @override
  String get editorBackToReviewTooltip => 'Kembalikan ke peninjauan';

  @override
  String get editorAndNext => '& Berikutnya';

  @override
  String get editorBackToDashboard => 'Kembali ke dasbor';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Menerjemahkan ke $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count tersisa';
  }

  @override
  String get editorUnignoreLongTooltip => 'Kembalikan modul ke daftar aktif';

  @override
  String get editorUnignoreLabel => 'Batalkan pengabaian';

  @override
  String get editorUnpublishTooltip =>
      'Batalkan publikasi dan kembalikan ke peninjauan';

  @override
  String get editorBackToReview => 'Kembali ke peninjauan';

  @override
  String get editorSaveAndNext => 'Simpan & Berikutnya';

  @override
  String get editorEnglishSourceHeader => 'SUMBER BAHASA INGGRIS';

  @override
  String get editorStaleTooltip =>
      'Tampilkan penjelasan & terapkan teks bahasa Inggris';

  @override
  String get editorStaleDetailsLabel => 'Kedaluwarsa — Detail';

  @override
  String get editorCopyPromptTooltip => 'Salin sumber + prompt terjemahan';

  @override
  String get editorPromptCopied => 'Prompt disalin ke papan klip 📋';

  @override
  String get editorShowPreview => 'Tampilkan pratinjau';

  @override
  String get editorShowHtmlSource => 'Tampilkan sumber HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RINGKASAN:\n$summary\n\nISI:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Ringkasan:';

  @override
  String get editorDescriptionLabelColon => 'Deskripsi:';

  @override
  String get editorStaleDialogTitle => 'Sumber bahasa Inggris telah berubah';

  @override
  String get editorStaleExplanation =>
      'Terjemahan yang ada didasarkan pada teks asli bahasa Inggris yang sudah usang. Sejak terjemahan terakhir, pengelola modul telah mengubah teks bahasa Inggris di Drupal.org — sehingga isi terjemahan yang ada mungkin tidak lagi akurat atau lengkap.';

  @override
  String get editorStaleTip =>
      'Tips: klik \"Gunakan teks asli bahasa Inggris\" untuk memuat sumber bahasa Inggris terkini langsung ke editor. Anda kemudian dapat menggunakannya sebagai titik awal untuk terjemahan baru. Teks asli bahasa Inggris juga terlihat di panel kiri.';

  @override
  String get editorEnglishSourceShort => 'Sumber bahasa Inggris';

  @override
  String get editorPreviousTranslation => 'Terjemahan sebelumnya';

  @override
  String get editorWhatChangedTitle => 'Apa yang berubah?';

  @override
  String get editorShowDiff => 'Tampilkan perbedaan';

  @override
  String get editorUseEnglish => 'Gunakan teks asli bahasa Inggris';

  @override
  String get editorStaleBannerText =>
      'Sumber bahasa Inggris telah berubah — terjemahan sudah usang';

  @override
  String get editorDetailsAndApply => 'Detail & terapkan';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TERJEMAHAN $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Menerjemahkan...';

  @override
  String get editorShowEditor => 'Tampilkan editor';

  @override
  String get editorModuleTitleLabel => 'Judul modul (Bahasa Inggris)';

  @override
  String get editorSummaryFieldLabel => 'Ringkasan';

  @override
  String get editorBodyFieldLabel => 'Isi';

  @override
  String get editorHtmlCleaned => 'HTML dibersihkan';

  @override
  String get editorLivePreviewHeader => 'PRATINJAU LANGSUNG';

  @override
  String get editorTidyHtmlTooltip => 'Bersihkan HTML (hapus artefak DeepL)';

  @override
  String get editorVisualMode => 'VISUAL';

  @override
  String get editorSourceCodeMode => 'SUMBER (HTML)';

  @override
  String get commonCancel => 'Batal';

  @override
  String get costDialogTitle => 'Perkiraan Biaya (AI)';

  @override
  String get costDialogIntro =>
      'Modul yang dipilih akan diterjemahkan dengan Google Gemini AI. Berikut adalah perkiraan rincian biaya untuk operasi ini:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Token input';

  @override
  String get costRowOutputTokens => 'Token output (perkiraan)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars karakter)';
  }

  @override
  String get costRowPriceInput => 'Harga per 1 juta input';

  @override
  String get costRowPriceOutput => 'Harga per 1 juta output';

  @override
  String get costRowTotalEstimate => 'Perkiraan total biaya';

  @override
  String get costDialogFootnote =>
      '* Catatan: Ini adalah perkiraan berdasarkan model harga bayar-sesuai-pemakaian Google saat ini. Penggunaan aktual dapat sedikit bervariasi.';

  @override
  String get costDialogStartTranslation => 'Mulai terjemahan';

  @override
  String get htmlToolbarInsertLink => 'Sisipkan tautan';

  @override
  String get htmlToolbarLinkTooltip => 'Sisipkan tautan (a)';

  @override
  String get htmlToolbarInsert => 'Sisipkan';

  @override
  String get htmlToolbarHeading2 => 'Heading 2';

  @override
  String get htmlToolbarHeading3 => 'Heading 3';

  @override
  String get htmlToolbarBold => 'Tebal (strong)';

  @override
  String get htmlToolbarItalic => 'Miring (em)';

  @override
  String get htmlToolbarBulletList => 'Daftar poin (ul)';

  @override
  String get htmlToolbarNumberedList => 'Daftar bernomor (ol)';

  @override
  String get htmlToolbarQuote => 'Kutipan (blockquote)';

  @override
  String get screenshotAltsHeader => 'TEKS ALT TANGKAPAN LAYAR';

  @override
  String get screenshotAltsIntro =>
      'Masukkan teks alt deskriptif dalam bahasa target untuk setiap tangkapan layar.';

  @override
  String screenshotLabel(int number) {
    return 'Tangkapan layar $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Pratinjau tidak tersedia';

  @override
  String get screenshotAltHint => 'Masukkan teks alt dalam bahasa target…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Batalkan pengabaian semua modul?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Semua modul yang diabaikan akan dikembalikan ke daftar aktif dan tersedia kembali untuk diterjemahkan.';

  @override
  String get dashUnignoreAllConfirmAction => 'Batalkan pengabaian semua';

  @override
  String get dashUnignoreAllSuccess =>
      'Semua modul yang diabaikan telah dikembalikan.';

  @override
  String get dashUnignoreAllError => 'Gagal mengembalikan modul.';

  @override
  String get dashUnignoreAllButton => 'Batalkan pengabaian semua modul';

  @override
  String dashSyncStartError(String error) {
    return 'Gagal memulai sinkronisasi: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Pembaruan cepat (7 hari) dimulai ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Kesalahan pembaruan cepat: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Berhasil disinkronkan: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Modul tidak ditemukan di Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Terjemahan Massal AI';

  @override
  String get dashHeaderTitle => 'Deskripsi Proyek';

  @override
  String get dashHeaderSubtitle =>
      'Terjemahkan deskripsi modul Drupal ke bahasa target. Bantu membuat ekosistem lebih mudah diakses.';

  @override
  String get dashHeaderSubtitleShort => 'Terjemahkan deskripsi modul Drupal.';

  @override
  String get dashLastLabel => 'Terakhir: ';

  @override
  String get dashContinue => 'Lanjutkan';

  @override
  String get dashContinueShort => 'Lanjutkan';

  @override
  String get dashUnignoreAllButtonLong => 'Batalkan pengabaian semua modul';

  @override
  String get dashQuickUpdateTooltip => 'Pembaruan cepat (7 hari terakhir)';

  @override
  String get dashFullSyncTooltip =>
      'Sinkronisasi basis data penuh dari Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Muat satu modul secara manual dari Drupal.org';

  @override
  String get dashQuickShort => 'Cepat';

  @override
  String get dashModuleShort => 'Modul';

  @override
  String get dashFoundLabel => 'Ditemukan: ';

  @override
  String get dashModulesSuffix => ' modul';

  @override
  String dashPerPage(int count) {
    return '$count per halaman';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / halaman';
  }

  @override
  String get dashFirstPage => 'Halaman pertama';

  @override
  String get dashPrevPage => 'Halaman sebelumnya';

  @override
  String get dashNextPage => 'Halaman berikutnya';

  @override
  String get dashLastPage => 'Halaman terakhir';

  @override
  String dashPageOf(int page, int total) {
    return 'Halaman $page dari $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (mis. pathauto)';

  @override
  String get dashAddButton => 'Tambah';

  @override
  String get dashAddModuleManually => 'Tambah modul secara manual';

  @override
  String get dashAddModuleSubtitle =>
      'Muat langsung dari Drupal.org berdasarkan machine name.';

  @override
  String get dashAddModuleShort => 'Tambah modul';

  @override
  String get dashNoProjectsFound => 'Tidak ada proyek ditemukan.';

  @override
  String get dashFilterAll => 'Semua Proyek';

  @override
  String get dashFilterMissing => 'Terjemahan Belum Ada';

  @override
  String get dashFilterReview => 'Antrean Peninjauan';

  @override
  String get dashFilterTranslated => 'Proyek Diterjemahkan';

  @override
  String get dashFilterReleased => 'Proyek Dirilis';

  @override
  String get dashBulkDialogIntro =>
      'Terjemahkan beberapa modul secara otomatis dari filter yang dipilih menggunakan Google Gemini.';

  @override
  String get dashActiveFilter => 'Filter Aktif';

  @override
  String get dashModuleCount => 'Jumlah Modul';

  @override
  String dashModulesCountItem(int count) {
    return '$count modul';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioritaskan modul Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Menerjemahkan modul tanpa dukungan Drupal 12 terlebih dahulu';

  @override
  String get dashTotalModules => 'Total modul';

  @override
  String get dashInputTokensEst => 'Token input (perkiraan)';

  @override
  String get dashOutputTokensEst => 'Token output (perkiraan)';

  @override
  String get dashBulkFootnote =>
      '* Terjemahan dijalankan dalam batch hemat sumber daya untuk mencegah timeout.';

  @override
  String get dashStartBulkTranslation => 'Mulai Terjemahan Massal';

  @override
  String dashStaleLoadError(String error) {
    return 'Kesalahan saat memuat modul kedaluwarsa: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Tidak ada modul kedaluwarsa ditemukan — semuanya sudah terkini! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Terjemahkan Ulang Modul Kedaluwarsa';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Semua terjemahan yang sumber bahasa Inggrisnya telah berubah sejak terjemahan terakhir akan diterjemahkan ulang secara otomatis menggunakan Google Gemini. Tidak perlu membuka setiap modul secara manual.';

  @override
  String get dashOutdatedModules => 'Modul kedaluwarsa';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Terjemahan menggantikan teks yang ada dan mereset is_reviewed. Dijalankan dalam batch 4 modul.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Terjemahkan ulang semua $count modul';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Menerjemahkan ulang modul kedaluwarsa…';

  @override
  String get dashFetchingProjects => 'Mengambil proyek dari server…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed dari $total modul diproses';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Tidak ada proyek yang dapat diterjemahkan untuk filter ini.';

  @override
  String get dashStartingTranslation => 'Memulai terjemahan…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Menerjemahkan modul $start–$end dari $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end dari $total modul selesai.';
  }

  @override
  String get dashTranslationCompleted => 'Terjemahan berhasil diselesaikan! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Terjemahan massal $count modul berhasil! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Kesalahan terjemahan massal: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Semua $count modul berhasil diterjemahkan ulang! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count modul kedaluwarsa berhasil diterjemahkan ulang! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Kesalahan saat menerjemahkan ulang: $error';
  }

  @override
  String get filterAllShort => 'Semua';

  @override
  String get filterMissing => 'Belum Ada';

  @override
  String get filterTranslated => 'Diterjemahkan';

  @override
  String get filterReviewQueue => 'Antrean Peninjauan';

  @override
  String get filterReleased => 'Dirilis';

  @override
  String get filterOutdated => 'Kedaluwarsa';

  @override
  String get filterPriority => 'Prioritas';

  @override
  String get filterIgnored => 'Diabaikan';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonReset => 'Reset';

  @override
  String get commonRefresh => 'Segarkan';

  @override
  String commonErrorPrefix(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Reset semua terjemahan yang dipublikasikan?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Semua terjemahan yang ditandai sebagai dipublikasikan untuk $langcode akan direset ke status peninjauan. Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count terjemahan direset ke status peninjauan.';
  }

  @override
  String get reviewPipelineTitle => 'Alur Peninjauan';

  @override
  String get reviewPipelineSubtitle =>
      'Alur jaminan kualitas manusia untuk terjemahan AI';

  @override
  String get reviewSearchHint => 'Cari proyek...';

  @override
  String get reviewResetPublished => 'Reset yang dipublikasikan';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Hasil: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Menunggu: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Tidak ada proyek yang menunggu peninjauan.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Semua terjemahan telah diverifikasi atau tidak ada yang tersedia dalam konteks bahasa ini.';

  @override
  String get reviewNoSummary => 'Tidak ada ringkasan.';

  @override
  String get reviewStartAudit => 'MULAI AUDIT';

  @override
  String get reviewHtmlSourceShort => 'Sumber HTML';

  @override
  String get reviewCopySource => 'Salin sumber';

  @override
  String get reviewModuleDetails => 'Detail Modul';

  @override
  String get reviewOriginalTitle => 'Judul Asli';

  @override
  String get reviewDrupalOrgProject => 'Proyek Drupal.org';

  @override
  String get reviewSuggestions => 'Saran';

  @override
  String get reviewNoSuggestions => 'Tidak ada saran yang tersedia.';

  @override
  String get reviewApply => 'Terapkan';

  @override
  String get reviewNoChanges => 'Tidak ada perubahan';

  @override
  String get reviewOriginalBeforeCorrection => 'Asli (sebelum koreksi)';

  @override
  String get reviewCorrectedCurrentVersion => 'Terkoreksi (versi saat ini)';

  @override
  String get reviewBaseOriginal => 'Dasar (Asli)';

  @override
  String get reviewYourCorrection => 'Koreksi Anda';

  @override
  String get reviewChangesVisual => 'Tinjau Perubahan Anda (Visual)';

  @override
  String get commonSkip => 'Lewati';

  @override
  String get commonIgnore => 'Abaikan';

  @override
  String get reviewEmptyProjectTitle => 'Proyek Kosong';

  @override
  String get reviewEmptyProjectBody =>
      'Proyek ini kosong (tanpa judul, ringkasan, atau isi) dan tidak dapat disetujui. Silakan lewati.';

  @override
  String get reviewApprovedSuccess => 'Terjemahan disetujui! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Persetujuan \"$machine\" gagal — silakan coba lagi.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Pengabaian dibatalkan. Modul aktif kembali!';

  @override
  String get reviewActionFailed => 'Tindakan gagal.';

  @override
  String get reviewIgnoreModuleTitle => 'Abaikan Modul?';

  @override
  String get reviewIgnoreModuleBody =>
      'Modul ini akan disembunyikan secara permanen dari semua daftar. Anda tidak akan terhambat olehnya lagi.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Modul diabaikan secara permanen.';

  @override
  String get reviewIgnoreFailed => 'Gagal mengabaikan modul.';

  @override
  String get reviewSuggestionSaved => 'Draf saran disimpan! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'Gagal menyimpan draf saran.';

  @override
  String get reviewSuggestionDeleted => 'Saran dihapus.';

  @override
  String get reviewDeleteFailed => 'Gagal menghapus.';

  @override
  String get reviewSuggestionApplied => 'Saran diterapkan.';

  @override
  String get reviewPreparingData => 'Menyiapkan data peninjauan...';

  @override
  String get reviewDirectEdit => 'Edit Langsung';

  @override
  String get reviewLivePreview => 'Pratinjau Langsung';

  @override
  String get reviewCompareWith => 'Bandingkan dengan:';

  @override
  String get reviewProductionVersion => 'Versi Produksi';

  @override
  String get reviewEditorialReview => 'Peninjauan Editorial';

  @override
  String get reviewOpenQueue => 'Buka antrean peninjauan';

  @override
  String get reviewCopyPromptShort => 'Salin prompt';

  @override
  String get reviewUnignoreShort => 'Batalkan pengabaian';

  @override
  String get reviewApproveButton => 'SETUJUI';

  @override
  String get reviewHideDetails => 'Sembunyikan detail';

  @override
  String get reviewDetailsAndEnglishSource => 'Detail & Sumber Bahasa Inggris';

  @override
  String reviewPendingCountShort(int count) {
    return '$count menunggu';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Meninjau $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Bandingkan terjemahan dengan sumber bahasa Inggris';

  @override
  String get reviewTranslationLabel => 'Terjemahan';

  @override
  String get reviewComparisonTitle => 'Perbandingan';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Salin teks sumber + prompt terjemahan ke papan klip';

  @override
  String get reviewUnignoreCaps => 'BATALKAN PENGABAIAN';

  @override
  String get reviewIgnoreCaps => 'ABAIKAN';

  @override
  String get reviewSkipShortcut => 'LEWATI (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Peninjauan Editorial';

  @override
  String get reviewUnignoreTablet => 'BATALKAN PENGABAIAN';

  @override
  String get reviewApproveForProduction =>
      'SETUJUI UNTUK PRODUKSI (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Penyempurnaan Langsung';

  @override
  String get reviewTitleField => 'Judul';

  @override
  String get reviewSummaryField => 'Ringkasan';

  @override
  String get reviewBodyField => 'Isi Konten';

  @override
  String get reviewSaveShortcut => 'SIMPAN (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Pratinjau Langsung (Merender)';

  @override
  String get reviewVoiceFemale => 'Perempuan';

  @override
  String get reviewVoiceMale => 'Laki-laki';

  @override
  String get reviewStopListening => 'Berhenti';

  @override
  String get reviewListen => 'Dengarkan';

  @override
  String get reviewAutopTooltip =>
      'Format paragraf otomatis (baris baru → <p>)';

  @override
  String get reviewSourceCodeShort => 'SUMBER';

  @override
  String get reviewNoParagraphChange =>
      'Teks sudah berisi tag <p> — tidak ada perubahan';

  @override
  String get reviewParagraphsFormatted => 'Paragraf diformat ¶';

  @override
  String get commonRetry => 'Coba lagi';

  @override
  String categoriesLoadError(String error) {
    return 'Gagal memuat kategori: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategori berhasil disimpan.';

  @override
  String get categoriesSaveFailed => 'Gagal menyimpan terjemahan.';

  @override
  String get categoriesFileEmpty => 'File kosong.';

  @override
  String get categoriesInvalidJson => 'Format JSON tidak valid.';

  @override
  String get categoriesNoValidUuids =>
      'Tidak ditemukan entri UUID yang valid dalam file.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count kategori diimpor dari file.';
  }

  @override
  String get categoriesTitle => 'Kategori';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Menerjemahkan untuk: $lang';
  }

  @override
  String get categoriesImportJson => 'Impor JSON';

  @override
  String get categoriesSaving => 'Menyimpan...';

  @override
  String get categoriesSaveAll => 'Simpan Semua';

  @override
  String get categoriesLoading => 'Memuat kategori...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Terjemahan ($code)';
  }

  @override
  String get categoriesNoneFound => 'Tidak ada kategori ditemukan.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Terjemahkan \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto oleh ';

  @override
  String get loginPhotoOn => ' di ';

  @override
  String get loginPleaseSignIn => 'Silakan masuk';

  @override
  String get loginUsername => 'Nama pengguna';

  @override
  String get loginPassword => 'Kata sandi';

  @override
  String get loginRememberMe => 'Ingat saya';

  @override
  String get loginSignIn => 'MASUK';

  @override
  String get loginNoAccount => 'Belum punya akun? ';

  @override
  String get loginRegisterNow => 'Daftar sekarang';

  @override
  String get commonBack => 'Kembali';

  @override
  String get commonNext => 'Berikutnya';

  @override
  String get registerFillRequired =>
      'Silakan isi semua kolom yang wajib diisi.';

  @override
  String get registerPasswordMismatch => 'Kata sandi tidak cocok.';

  @override
  String get registerPasswordTooShort =>
      'Kata sandi harus terdiri dari minimal 8 karakter.';

  @override
  String get registerSelectLanguage => 'Silakan pilih setidaknya satu bahasa.';

  @override
  String get registerFailed => 'Pendaftaran gagal.';

  @override
  String get registerHeaderTitle => 'PENDAFTARAN';

  @override
  String get registerStepAccount => 'Akun';

  @override
  String get registerStepRole => 'Peran';

  @override
  String get registerStepLanguages => 'Bahasa';

  @override
  String get registerStepApiKeys => 'Kunci API';

  @override
  String get registerYourAccount => 'Akun Anda';

  @override
  String get registerAvatarOptional => 'Avatar (opsional)';

  @override
  String get registerUsernameRequired => 'Nama pengguna *';

  @override
  String get registerEmailRequired => 'Alamat Email *';

  @override
  String get registerPasswordRequired => 'Kata Sandi *';

  @override
  String get registerPasswordRepeat => 'Ulangi Kata Sandi *';

  @override
  String get registerYourRole => 'Peran Anda';

  @override
  String get registerRoleExplanation =>
      'Penerjemah dapat menerjemahkan teks tetapi tidak memiliki akses ke antrean peninjauan. Peninjau memeriksa dan menyetujui konten yang telah diterjemahkan.';

  @override
  String get registerRoleTranslator => 'Penerjemah';

  @override
  String get registerRoleTranslatorDesc => 'Membuat dan mengedit terjemahan.';

  @override
  String get registerRoleReviewer => 'Peninjau';

  @override
  String get registerRoleReviewerDesc => 'Meninjau dan menyetujui terjemahan.';

  @override
  String get registerTargetLanguages => 'Bahasa Target';

  @override
  String get registerLanguagesExplanation =>
      'Pilih semua bahasa yang ingin Anda kerjakan.';

  @override
  String get registerNoLanguagesAvailable => 'Tidak ada bahasa yang tersedia.';

  @override
  String get registerApiKeysTitle => 'Kunci API';

  @override
  String get registerApiKeysExplanation =>
      'Masukkan kunci API Anda sendiri. Setiap pengguna secara eksklusif menggunakan kuncinya sendiri. Anda juga dapat menambahkannya nanti di profil Anda.';

  @override
  String get registerKeysEncryptedNote =>
      'Kunci disimpan terenkripsi dan tidak pernah dibagikan dengan pengguna lain.';

  @override
  String get registerOptionalSuffix => ' (opsional)';

  @override
  String get registerSuccessTitle => 'Pendaftaran berhasil!';

  @override
  String get registerSuccessBody =>
      'Akun Anda telah dibuat dan menunggu persetujuan dari administrator. Anda akan diberi tahu setelah akses Anda diaktifkan.';

  @override
  String get registerGoToLogin => 'Ke Halaman Masuk';

  @override
  String get registerSubmit => 'Daftar';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto oleh $name di Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil berhasil diperbarui!';

  @override
  String get profileUpdateFailed => 'Pembaruan gagal.';

  @override
  String profileSaveError(String error) {
    return 'Kesalahan saat menyimpan: $error';
  }

  @override
  String get profilePasswordMismatch => 'Kata sandi tidak cocok!';

  @override
  String get profilePasswordChangeSuccess => 'Kata sandi berhasil diubah!';

  @override
  String get profilePasswordChangeError =>
      'Kesalahan saat mengubah kata sandi: kata sandi saat ini salah.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar berhasil diunggah!';

  @override
  String get profileAvatarUploadError => 'Kesalahan saat mengunggah avatar.';

  @override
  String get profileTitle => 'Profil & Pengaturan';

  @override
  String get profileSubtitle =>
      'Kelola profil pengguna Anda, API terjemahan Anda (Gemini & DeepL), dan keamanan akun Anda.';

  @override
  String get profileRoleUser => 'Pengguna';

  @override
  String get profileNoEmail => 'Tidak ada alamat email yang diberikan';

  @override
  String get profileTabDetails => 'Detail profil';

  @override
  String get profileTabGemini => 'Terjemahan AI (Gemini)';

  @override
  String get profileTabDeepl => 'Terjemahan DeepL';

  @override
  String get profileTabPassword => 'Ubah kata sandi';

  @override
  String get profileSectionInfo => 'INFORMASI PROFIL';

  @override
  String get profileFieldName => 'Nama';

  @override
  String get profileFieldNameHint => 'Nama lengkap Anda';

  @override
  String get profileFieldEmail => 'Alamat email';

  @override
  String get profileFieldEmailHint => 'Alamat email Anda';

  @override
  String get profileSectionGemini => 'PENGATURAN GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Kunci API Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Masukkan kunci API gemini-3.1-flash Anda';

  @override
  String get profileFieldAiPrompt => 'Prompt AI kustom';

  @override
  String get profileFieldAiPromptHint =>
      'Opsional: sesuaikan prompt sistem untuk Gemini...';

  @override
  String get profileSectionDeepl => 'PENGATURAN TERJEMAHAN DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL menawarkan terjemahan mesin berkualitas tinggi dengan mempertahankan tag HTML. Akun gratis (500.000 karakter/bulan) mendapatkan kunci dengan akhiran \":fx\".';

  @override
  String get profileFieldDeeplKey => 'Kunci API DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'mis. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Kunci gratis berakhiran \":fx\" dan menggunakan api-free.deepl.com. Kunci Pro menggunakan api.deepl.com. Perbedaannya dideteksi secara otomatis.';

  @override
  String get profileSectionSecurity => 'KEAMANAN AKUN';

  @override
  String get profileFieldCurrentPassword => 'Kata sandi saat ini';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Masukkan kata sandi Anda saat ini';

  @override
  String get profileFieldNewPassword => 'Kata sandi baru';

  @override
  String get profileFieldNewPasswordHint => 'Minimal 6 karakter';

  @override
  String get profileFieldConfirmPassword => 'Konfirmasi kata sandi baru';

  @override
  String get profileFieldConfirmPasswordHint => 'Ulangi kata sandi';

  @override
  String get profileChangePasswordButton => 'Ubah kata sandi';

  @override
  String get commonDelete => 'Hapus';

  @override
  String get settingsRegistrationUpdated => 'Pengaturan pendaftaran diperbarui';

  @override
  String get settingsUpdateFailed => 'Pembaruan gagal.';

  @override
  String get settingsUserApproved => 'Pengguna disetujui!';

  @override
  String get settingsAccountDeactivated => 'Akun dinonaktifkan.';

  @override
  String get settingsUserDeleted => 'Pengguna dihapus.';

  @override
  String get settingsActionFailed => 'Tindakan gagal.';

  @override
  String get settingsDeleteAccountTitle => 'Hapus akun?';

  @override
  String get settingsDeactivateAccountTitle => 'Nonaktifkan akun?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Akun \"$username\" akan dihapus secara permanen. Lanjutkan?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Akun \"$username\" akan dikunci. Pengguna tidak dapat lagi masuk, tetapi akun tetap disimpan.';
  }

  @override
  String get settingsDeactivate => 'Nonaktifkan';

  @override
  String settingsSyncSuccess(String count) {
    return '$count terjemahan disinkronkan!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Kesalahan sinkronisasi: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count modul prioritas disinkronkan!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Kesalahan menyinkronkan daftar prioritas: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Pencadangan berhasil: $count file diproses.';
  }

  @override
  String get settingsUploadFailed => 'Unggahan gagal.';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsSystemConfig => 'KONFIGURASI SISTEM';

  @override
  String get settingsRegistration => 'Pendaftaran';

  @override
  String get settingsRegistrationHint =>
      'Aktifkan/nonaktifkan visibilitas formulir pendaftaran global.';

  @override
  String get settingsPendingUsers => 'Pengguna Tertunda';

  @override
  String get settingsNoNewRequests => 'Tidak ada permintaan baru.';

  @override
  String get settingsWantsReviewer => 'Ingin Menjadi Peninjau';

  @override
  String get settingsAssignRole => 'Tetapkan peran';

  @override
  String get settingsRoleTranslator => 'Penerjemah';

  @override
  String get settingsRoleReviewer => 'Peninjau';

  @override
  String get settingsApprove => 'Setujui';

  @override
  String get settingsReject => 'Tolak';

  @override
  String get settingsActiveUsers => 'Pengguna Aktif';

  @override
  String get settingsNoActiveUsers => 'Tidak ada pengguna aktif.';

  @override
  String get settingsDeactivateAccountTooltip => 'Nonaktifkan';

  @override
  String get settingsDeleteAccountAction => 'Hapus akun';

  @override
  String get settingsAppearance => 'Tampilan';

  @override
  String get settingsThemePearl => 'TERANG (PEARL)';

  @override
  String get settingsThemeDark => 'GELAP';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Tipografi';

  @override
  String get settingsFontHint => 'Ubah keluarga font antarmuka.';

  @override
  String get settingsFontClean => 'Bersih';

  @override
  String get settingsFontFuturistic => 'Futuristik';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Alur Kerja & Kesenangan';

  @override
  String get settingsConfettiTitle => 'Perayaan Sukses (Confetti)';

  @override
  String get settingsConfettiHint =>
      'Menampilkan animasi kecil saat berhasil menyimpan.';

  @override
  String get settingsLargeUiTitle =>
      'Keterbacaan yang Ditingkatkan (Font Besar)';

  @override
  String get settingsLargeUiHint =>
      'Meningkatkan ukuran font dan badge untuk keterbacaan.';

  @override
  String get settingsAutoPTitle => 'Pemformatan Paragraf Otomatis (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Secara otomatis membungkus teks biasa dalam paragraf <p> saat modul dimuat di Layar Peninjauan. Setara dengan mengklik tombol ¶ secara manual.';

  @override
  String get settingsDatabaseSync => 'Sinkronisasi Basis Data';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Menyinkronkan entri basis data dengan file JSON terjemahan.';

  @override
  String get settingsDatabaseSyncHint =>
      'Menyinkronkan entri basis data internal dengan JSON terjemahan di server.';

  @override
  String get settingsSyncing => 'Menyinkronkan...';

  @override
  String get settingsSyncNow => 'Sinkronkan Sekarang';

  @override
  String get settingsSyncD11List => 'Sinkronkan Daftar D11';

  @override
  String get settingsUploadBackup => 'Unggah Cadangan (.zip)';

  @override
  String get settingsSelectZipFile => 'Pilih File ZIP';

  @override
  String get settingsUploading => 'Mengunggah...';

  @override
  String get settingsErrorDiagnostics => 'Diagnostik Kesalahan & Log Sistem';

  @override
  String get settingsLogsCopied => 'Log disalin ke papan klip! 📋';

  @override
  String get settingsCopyLogs => 'Salin Log';

  @override
  String get settingsLogsRotated => 'Log diarsipkan dan dirotasi! 📁';

  @override
  String get settingsRotate => 'Rotasi';

  @override
  String get settingsClear => 'Bersihkan';

  @override
  String get settingsLogLimit => 'Batas Log: ';

  @override
  String get settingsNoLogs => 'Tidak ada log yang tercatat';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Analitik';

  @override
  String get layoutNavReviewQueue => 'Antrean Peninjauan';

  @override
  String get layoutNavGlossary => 'Glosarium';

  @override
  String get layoutNavCategories => 'Kategori';

  @override
  String get layoutNavHelp => 'Bantuan';

  @override
  String get layoutNavSettings => 'Pengaturan';

  @override
  String get layoutPhotoBy => 'Foto oleh ';

  @override
  String get layoutPhotoOn => ' di ';

  @override
  String get layoutEditProfile => 'Edit Profil';

  @override
  String get layoutLogout => 'Keluar';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Terang';

  @override
  String get layoutThemeDark => 'Gelap';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'BAHASA TARGET';

  @override
  String get layoutDeeplUsage => 'PENGGUNAAN DEEPL';

  @override
  String get layoutUnavailable => 'Tidak tersedia';

  @override
  String get layoutUnlimited => 'tidak terbatas';

  @override
  String get layoutUsed => 'terpakai';

  @override
  String get layoutTranslate => 'Terjemahkan';

  @override
  String get analyticsSubtitle =>
      'Kompatibilitas, backlog terjemahan, dan tren mingguan.';

  @override
  String get analyticsBacklog => 'Backlog terjemahan';

  @override
  String get analyticsMissing => 'Belum ada';

  @override
  String get analyticsStale => 'Kedaluwarsa';

  @override
  String get analyticsInReview => 'Dalam peninjauan';

  @override
  String get analyticsReleased => 'Dirilis';

  @override
  String get analyticsTranslated => 'Diterjemahkan';

  @override
  String get analyticsTotalModules => 'Total modul';

  @override
  String get analyticsCompatByVersion =>
      'Kompatibilitas berdasarkan versi Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Bahasa: $lang · dirilis / dalam peninjauan / belum ada';
  }

  @override
  String get analyticsLoadingCounts => 'Memuat hitungan …';

  @override
  String get analyticsWindow => 'Rentang:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks minggu';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Deskripsi proyek baru per minggu';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Ditandai kedaluwarsa per minggu ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modul';
  }

  @override
  String get analyticsReviewShort => 'Peninjauan';

  @override
  String get analyticsNoDataInWindow => 'Tidak ada data dalam rentang ini.';

  @override
  String get analyticsAndMore => '… dan lainnya';

  @override
  String glossaryLoadError(String error) {
    return 'Kesalahan memuat: $error';
  }

  @override
  String get glossaryNewTerm => 'Buat istilah baru';

  @override
  String get glossaryEditTerm => 'Edit istilah';

  @override
  String get glossaryFieldSourceWord =>
      'Kata sumber (bentuk dasar, seperti muncul di teks)';

  @override
  String get glossaryFieldSourceWordHint => 'mis. node';

  @override
  String get glossaryWordForms =>
      'Bentuk kata tambahan (jamak, genitif, datif …)';

  @override
  String get glossaryWordFormsHint =>
      'mis. content — tekan Enter untuk menambahkan';

  @override
  String get glossaryAddForm => 'Tambah bentuk';

  @override
  String get glossaryFieldPreferredWord => 'Terjemahan pilihan';

  @override
  String get glossaryFieldPreferredWordHint => 'mis. content';

  @override
  String get glossaryFieldExplanation => 'Penjelasan (ditampilkan di tooltip)';

  @override
  String get glossaryFieldExplanationHint =>
      'Mengapa kata ini harus diterjemahkan secara berbeda?';

  @override
  String get glossaryCreate => 'Buat';

  @override
  String get glossaryRequiredFields =>
      'Kata sumber dan terjemahan pilihan wajib diisi.';

  @override
  String get glossaryCreated => 'Istilah dibuat ✓';

  @override
  String get glossaryUpdated => 'Istilah diperbarui ✓';

  @override
  String glossaryError(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Hapus istilah?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" akan dihapus secara permanen dari glosarium.';
  }

  @override
  String get glossaryDeleted => 'Istilah dihapus.';

  @override
  String get glossaryTitle => 'Glosarium Terjemahan';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Bahasa: $lang · $count entri';
  }

  @override
  String get glossaryNewShort => 'Baru';

  @override
  String get glossaryCreateTerm => 'Buat istilah';

  @override
  String get glossaryInfoBanner =>
      'Kata-kata dari glosarium ini disorot di Editor Peninjauan. Tooltip menjelaskan saat diarahkan mengapa terjemahan yang berbeda lebih cocok.';

  @override
  String get glossaryNoEntries => 'Belum ada entri.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Klik \"Buat istilah\" untuk membuat entri pertama.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Belum ada entri glosarium untuk bahasa ini.';

  @override
  String get diffNoChanges => 'Tidak ada perbedaan konten yang terdeteksi.';

  @override
  String get diffRemoved => 'Dihapus';

  @override
  String get diffAdded => 'Ditambahkan';

  @override
  String syncBarQuickSync(String count) {
    return 'Sinkronisasi Cepat: $count modul berubah …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sinkronisasi Penuh: $current / $total modul';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sinkronisasi Penuh: $count modul …';
  }
}
