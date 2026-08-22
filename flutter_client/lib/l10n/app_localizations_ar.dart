// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'جارٍ تحميل تفاصيل المشروع...';

  @override
  String editorLoadError(String error) {
    return 'فشل تحميل بيانات المشروع: $error';
  }

  @override
  String get editorGeminiSuccess => 'تمت الترجمة باستخدام Gemini بنجاح! ✨';

  @override
  String get editorUnknownError => 'خطأ غير معروف';

  @override
  String editorGeminiFailed(String detail) {
    return 'فشلت ترجمة Gemini: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'يرجى إضافة مفتاح Google AI الخاص بك في ملفك الشخصي (وليس في إعدادات المسؤول).';

  @override
  String get editorGeminiError =>
      'حدث خطأ أثناء ترجمة Gemini. يرجى التحقق من مفتاح Google AI في ملفك الشخصي.';

  @override
  String get editorDeeplSuccess => 'تمت الترجمة باستخدام DeepL بنجاح! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'فشلت ترجمة DeepL: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'حدث خطأ أثناء ترجمة DeepL. يرجى التأكد من تعيين مفتاح DeepL API في ملفك الشخصي.';

  @override
  String get editorDeeplInvalidKey =>
      'مفتاح DeepL API غير صالح. يرجى التحقق منه في ملفك الشخصي.';

  @override
  String get editorDeeplQuotaExceeded =>
      'تم استنفاد حصة DeepL. يرجى التحقق من خطتك.';

  @override
  String get editorReviewReset => 'تمت إعادة تعيين الترجمة إلى حالة المراجعة.';

  @override
  String editorResetError(String error) {
    return 'فشلت إعادة التعيين: $error';
  }

  @override
  String get editorUnignoreSuccess => 'تمت إعادة الوحدة إلى القائمة النشطة.';

  @override
  String get editorUnignoreError => 'فشل إلغاء تجاهل الوحدة.';

  @override
  String get editorSaveSuccess =>
      'تم حفظ الترجمة — العودة إلى قائمة انتظار المراجعة.';

  @override
  String editorSaveError(String error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String get editorNoMoreProjects => 'لا توجد مشاريع مفتوحة أخرى في القائمة.';

  @override
  String get editorChangesDiscarded =>
      'تم تجاهل التغييرات، جارٍ تحميل المشروع التالي...';

  @override
  String get editorEnglishSourceApplied =>
      'تم تطبيق النص الإنجليزي الأصلي — يرجى ترجمته الآن.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'تعذر فتح الرابط: $url';
  }

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get editorCloseEnglishSource => 'إغلاق المصدر الإنجليزي';

  @override
  String get editorShowEnglishSource => 'إظهار المصدر الإنجليزي';

  @override
  String get editorUnignoreShortTooltip => 'إلغاء تجاهل الوحدة';

  @override
  String get editorBackToReviewTooltip => 'إعادة إلى المراجعة';

  @override
  String get editorAndNext => 'والتالي';

  @override
  String get editorBackToDashboard => 'العودة إلى لوحة التحكم';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'جارٍ الترجمة إلى $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count متبقٍ';
  }

  @override
  String get editorUnignoreLongTooltip => 'إعادة الوحدة إلى القائمة النشطة';

  @override
  String get editorUnignoreLabel => 'إلغاء التجاهل';

  @override
  String get editorUnpublishTooltip => 'إلغاء النشر وإعادة إلى المراجعة';

  @override
  String get editorBackToReview => 'العودة إلى المراجعة';

  @override
  String get editorSaveAndNext => 'حفظ والتالي';

  @override
  String get editorEnglishSourceHeader => 'المصدر الإنجليزي';

  @override
  String get editorStaleTooltip => 'إظهار التفسير وتطبيق النص الإنجليزي';

  @override
  String get editorStaleDetailsLabel => 'قديم — التفاصيل';

  @override
  String get editorCopyPromptTooltip => 'نسخ المصدر + تعليمة الترجمة';

  @override
  String get editorPromptCopied => 'تم نسخ التعليمة إلى الحافظة 📋';

  @override
  String get editorShowPreview => 'إظهار المعاينة';

  @override
  String get editorShowHtmlSource => 'إظهار مصدر HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'الملخص:\n$summary\n\nالمحتوى:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'الملخص:';

  @override
  String get editorDescriptionLabelColon => 'الوصف:';

  @override
  String get editorStaleDialogTitle => 'تغيّر المصدر الإنجليزي';

  @override
  String get editorStaleExplanation =>
      'تستند الترجمة الحالية إلى نص إنجليزي أصلي قديم. منذ آخر ترجمة، قام مشرف الوحدة بتغيير النص الإنجليزي على Drupal.org — لذا قد لا يكون محتوى الترجمة الحالية دقيقًا أو كاملًا بعد الآن.';

  @override
  String get editorStaleTip =>
      'نصيحة: انقر على \"استخدام النص الإنجليزي الأصلي\" لتحميل المصدر الإنجليزي الحالي مباشرة إلى المحرر. يمكنك بعد ذلك استخدامه كنقطة انطلاق لترجمة جديدة. يظهر النص الإنجليزي الأصلي أيضًا في اللوحة اليسرى.';

  @override
  String get editorEnglishSourceShort => 'المصدر الإنجليزي';

  @override
  String get editorPreviousTranslation => 'الترجمة السابقة';

  @override
  String get editorWhatChangedTitle => 'ما الذي تغيّر؟';

  @override
  String get editorShowDiff => 'إظهار الفروقات';

  @override
  String get editorUseEnglish => 'استخدام النص الإنجليزي الأصلي';

  @override
  String get editorStaleBannerText =>
      'تغيّر المصدر الإنجليزي — الترجمة أصبحت قديمة';

  @override
  String get editorDetailsAndApply => 'التفاصيل والتطبيق';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'ترجمة $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'جارٍ الترجمة...';

  @override
  String get editorShowEditor => 'إظهار المحرر';

  @override
  String get editorModuleTitleLabel => 'عنوان الوحدة (بالإنجليزية)';

  @override
  String get editorSummaryFieldLabel => 'الملخص';

  @override
  String get editorBodyFieldLabel => 'المحتوى';

  @override
  String get editorHtmlCleaned => 'تم تنظيف HTML';

  @override
  String get editorLivePreviewHeader => 'معاينة مباشرة';

  @override
  String get editorTidyHtmlTooltip => 'تنظيف HTML (إزالة آثار DeepL)';

  @override
  String get editorVisualMode => 'مرئي';

  @override
  String get editorSourceCodeMode => 'المصدر (HTML)';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get costDialogTitle => 'تقدير التكلفة (الذكاء الاصطناعي)';

  @override
  String get costDialogIntro =>
      'ستتم ترجمة الوحدة المحددة باستخدام Google Gemini AI. فيما يلي تفصيل تقديري لتكلفة هذه العملية:';

  @override
  String get costRowModel => 'النموذج';

  @override
  String get costRowInputTokens => 'رموز الإدخال';

  @override
  String get costRowOutputTokens => 'رموز الإخراج (تقديري)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars حرفًا)';
  }

  @override
  String get costRowPriceInput => 'السعر لكل مليون إدخال';

  @override
  String get costRowPriceOutput => 'السعر لكل مليون إخراج';

  @override
  String get costRowTotalEstimate => 'التكلفة الإجمالية التقديرية';

  @override
  String get costDialogFootnote =>
      '* ملاحظة: هذا تقدير يستند إلى نموذج تسعير الدفع أولاً بأول الحالي من Google. قد يختلف الاستخدام الفعلي قليلًا.';

  @override
  String get costDialogStartTranslation => 'بدء الترجمة';

  @override
  String get htmlToolbarInsertLink => 'إدراج رابط';

  @override
  String get htmlToolbarLinkTooltip => 'إدراج رابط (a)';

  @override
  String get htmlToolbarInsert => 'إدراج';

  @override
  String get htmlToolbarHeading2 => 'عنوان 2';

  @override
  String get htmlToolbarHeading3 => 'عنوان 3';

  @override
  String get htmlToolbarBold => 'عريض (strong)';

  @override
  String get htmlToolbarItalic => 'مائل (em)';

  @override
  String get htmlToolbarBulletList => 'قائمة نقطية (ul)';

  @override
  String get htmlToolbarNumberedList => 'قائمة مرقمة (ol)';

  @override
  String get htmlToolbarQuote => 'اقتباس (blockquote)';

  @override
  String get screenshotAltsHeader => 'النص البديل للقطات الشاشة';

  @override
  String get screenshotAltsIntro =>
      'أدخل نصًا بديلًا وصفيًا باللغة الهدف لكل لقطة شاشة.';

  @override
  String screenshotLabel(int number) {
    return 'لقطة الشاشة $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'المعاينة غير متاحة';

  @override
  String get screenshotAltHint => 'أدخل النص البديل باللغة الهدف…';

  @override
  String get dashUnignoreAllConfirmTitle => 'إلغاء تجاهل جميع الوحدات؟';

  @override
  String get dashUnignoreAllConfirmBody =>
      'ستتم إعادة جميع الوحدات المتجاهلة إلى القائمة النشطة وستصبح متاحة للترجمة مرة أخرى.';

  @override
  String get dashUnignoreAllConfirmAction => 'إلغاء تجاهل الكل';

  @override
  String get dashUnignoreAllSuccess => 'تم إلغاء تجاهل جميع الوحدات المتجاهلة.';

  @override
  String get dashUnignoreAllError => 'فشل إلغاء تجاهل الوحدات.';

  @override
  String get dashUnignoreAllButton => 'إلغاء تجاهل جميع الوحدات';

  @override
  String dashSyncStartError(String error) {
    return 'فشل بدء المزامنة: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'بدأ التحديث السريع (7 أيام) ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'خطأ في التحديث السريع: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'تمت المزامنة بنجاح: $name';
  }

  @override
  String get dashManualSyncNotFound =>
      'لم يتم العثور على الوحدة على Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'ترجمة جماعية بالذكاء الاصطناعي';

  @override
  String get dashHeaderTitle => 'أوصاف المشاريع';

  @override
  String get dashHeaderSubtitle =>
      'ترجم أوصاف وحدات Drupal إلى اللغة الهدف. ساعد في جعل النظام البيئي أكثر سهولة في الوصول إليه.';

  @override
  String get dashHeaderSubtitleShort => 'ترجم أوصاف وحدات Drupal.';

  @override
  String get dashLastLabel => 'الأخير: ';

  @override
  String get dashContinue => 'متابعة';

  @override
  String get dashContinueShort => 'متابعة';

  @override
  String get dashUnignoreAllButtonLong => 'إلغاء تجاهل جميع الوحدات';

  @override
  String get dashQuickUpdateTooltip => 'تحديث سريع (آخر 7 أيام)';

  @override
  String get dashFullSyncTooltip =>
      'مزامنة كاملة لقاعدة البيانات من Drupal.org';

  @override
  String get dashManualLoadTooltip => 'تحميل وحدة واحدة يدويًا من Drupal.org';

  @override
  String get dashQuickShort => 'سريع';

  @override
  String get dashModuleShort => 'وحدة';

  @override
  String get dashFoundLabel => 'تم العثور على: ';

  @override
  String get dashModulesSuffix => ' وحدة';

  @override
  String dashPerPage(int count) {
    return '$count لكل صفحة';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / صفحة';
  }

  @override
  String get dashFirstPage => 'الصفحة الأولى';

  @override
  String get dashPrevPage => 'الصفحة السابقة';

  @override
  String get dashNextPage => 'الصفحة التالية';

  @override
  String get dashLastPage => 'الصفحة الأخيرة';

  @override
  String dashPageOf(int page, int total) {
    return 'الصفحة $page من $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (مثال: pathauto)';

  @override
  String get dashAddButton => 'إضافة';

  @override
  String get dashAddModuleManually => 'إضافة وحدة يدويًا';

  @override
  String get dashAddModuleSubtitle =>
      'تحميل مباشرة من Drupal.org باستخدام machine name.';

  @override
  String get dashAddModuleShort => 'إضافة وحدة';

  @override
  String get dashNoProjectsFound => 'لم يتم العثور على مشاريع.';

  @override
  String get dashFilterAll => 'جميع المشاريع';

  @override
  String get dashFilterMissing => 'الترجمات المفقودة';

  @override
  String get dashFilterReview => 'قائمة انتظار المراجعة';

  @override
  String get dashFilterTranslated => 'المشاريع المترجمة';

  @override
  String get dashFilterReleased => 'المشاريع المنشورة';

  @override
  String get dashBulkDialogIntro =>
      'ترجم عدة وحدات تلقائيًا من الفلتر المحدد باستخدام Google Gemini.';

  @override
  String get dashActiveFilter => 'الفلتر النشط';

  @override
  String get dashModuleCount => 'عدد الوحدات';

  @override
  String dashModulesCountItem(int count) {
    return '$count وحدة';
  }

  @override
  String get dashPrioritizeD12Title => 'إعطاء الأولوية لوحدات Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'يترجم الوحدات التي لا تدعم Drupal 12 أولًا';

  @override
  String get dashTotalModules => 'إجمالي الوحدات';

  @override
  String get dashInputTokensEst => 'رموز الإدخال (تقديري)';

  @override
  String get dashOutputTokensEst => 'رموز الإخراج (تقديري)';

  @override
  String get dashBulkFootnote =>
      '* يتم تنفيذ الترجمة على دفعات موفّرة للموارد لمنع انتهاء المهلة.';

  @override
  String get dashStartBulkTranslation => 'بدء الترجمة الجماعية';

  @override
  String dashStaleLoadError(String error) {
    return 'خطأ في تحميل الوحدات القديمة: $error';
  }

  @override
  String get dashNoStaleModules =>
      'لم يتم العثور على وحدات قديمة — كل شيء محدّث! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'إعادة ترجمة الوحدات القديمة';

  @override
  String get dashRetranslateOutdatedIntro =>
      'سيتم إعادة ترجمة جميع الترجمات التي تغيّر مصدرها الإنجليزي منذ آخر ترجمة تلقائيًا باستخدام Google Gemini. لا حاجة لفتح كل وحدة يدويًا.';

  @override
  String get dashOutdatedModules => 'الوحدات القديمة';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* تستبدل الترجمة النص الحالي وتعيد ضبط is_reviewed. يتم التنفيذ على دفعات من 4 وحدات.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'إعادة ترجمة جميع الوحدات البالغ عددها $count';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'جارٍ إعادة ترجمة الوحدات القديمة…';

  @override
  String get dashFetchingProjects => 'جارٍ جلب المشاريع من الخادم…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return 'تمت معالجة $processed من أصل $total وحدة';
  }

  @override
  String get dashNoTranslatableProjects =>
      'لم يتم العثور على مشاريع قابلة للترجمة لهذا الفلتر.';

  @override
  String get dashStartingTranslation => 'جارٍ بدء الترجمة…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'جارٍ ترجمة الوحدات $start–$end من أصل $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return 'تم إكمال $end من أصل $total وحدة.';
  }

  @override
  String get dashTranslationCompleted => 'تمت الترجمة بنجاح! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'نجحت الترجمة الجماعية لعدد $count وحدة! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'خطأ في الترجمة الجماعية: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'تمت إعادة ترجمة جميع الوحدات البالغ عددها $count بنجاح! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return 'تمت إعادة ترجمة $count وحدة قديمة بنجاح! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'خطأ أثناء إعادة الترجمة: $error';
  }

  @override
  String get filterAllShort => 'الكل';

  @override
  String get filterMissing => 'مفقودة';

  @override
  String get filterTranslated => 'مترجمة';

  @override
  String get filterReviewQueue => 'قائمة انتظار المراجعة';

  @override
  String get filterReleased => 'منشورة';

  @override
  String get filterOutdated => 'قديمة';

  @override
  String get filterPriority => 'أولوية';

  @override
  String get filterIgnored => 'متجاهلة';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonReset => 'إعادة تعيين';

  @override
  String get commonRefresh => 'تحديث';

  @override
  String commonErrorPrefix(String error) {
    return 'خطأ: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'إعادة تعيين جميع الترجمات المنشورة؟';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'ستتم إعادة تعيين جميع الترجمات المميزة كمنشورة للغة $langcode إلى حالة المراجعة. لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return 'تمت إعادة تعيين $count ترجمة إلى حالة المراجعة.';
  }

  @override
  String get reviewPipelineTitle => 'خط أنابيب المراجعة';

  @override
  String get reviewPipelineSubtitle =>
      'خط أنابيب لضمان الجودة البشرية لترجمات الذكاء الاصطناعي';

  @override
  String get reviewSearchHint => 'ابحث عن المشاريع...';

  @override
  String get reviewResetPublished => 'إعادة تعيين المنشورة';

  @override
  String reviewResultsCount(int count, int total) {
    return 'النتائج: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'قيد الانتظار: $count';
  }

  @override
  String get reviewNoProjectsPending => 'لا توجد مشاريع في انتظار المراجعة.';

  @override
  String get reviewAllVerifiedOrNone =>
      'تم التحقق من جميع الترجمات بالفعل أو لا توجد أي ترجمة في سياق هذه اللغة.';

  @override
  String get reviewNoSummary => 'لا يوجد ملخص.';

  @override
  String get reviewStartAudit => 'بدء التدقيق';

  @override
  String get reviewHtmlSourceShort => 'مصدر HTML';

  @override
  String get reviewCopySource => 'نسخ المصدر';

  @override
  String get reviewModuleDetails => 'تفاصيل الوحدة';

  @override
  String get reviewOriginalTitle => 'العنوان الأصلي';

  @override
  String get reviewDrupalOrgProject => 'مشروع Drupal.org';

  @override
  String get reviewSuggestions => 'الاقتراحات';

  @override
  String get reviewNoSuggestions => 'لا توجد اقتراحات متاحة.';

  @override
  String get reviewApply => 'تطبيق';

  @override
  String get reviewNoChanges => 'لا توجد تغييرات';

  @override
  String get reviewOriginalBeforeCorrection => 'الأصلي (قبل التصحيح)';

  @override
  String get reviewCorrectedCurrentVersion => 'المصحح (النسخة الحالية)';

  @override
  String get reviewBaseOriginal => 'الأساس (الأصلي)';

  @override
  String get reviewYourCorrection => 'تصحيحك';

  @override
  String get reviewChangesVisual => 'مراجعة تغييراتك (مرئي)';

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonIgnore => 'تجاهل';

  @override
  String get reviewEmptyProjectTitle => 'مشروع فارغ';

  @override
  String get reviewEmptyProjectBody =>
      'هذا المشروع فارغ (بلا عنوان أو ملخص أو محتوى) ولا يمكن الموافقة عليه. يرجى تخطيه.';

  @override
  String get reviewApprovedSuccess => 'تمت الموافقة على الترجمة! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ فشلت الموافقة على \"$machine\" — يرجى إعادة المحاولة.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'تم إلغاء التجاهل. الوحدة نشطة مرة أخرى!';

  @override
  String get reviewActionFailed => 'فشل الإجراء.';

  @override
  String get reviewIgnoreModuleTitle => 'تجاهل الوحدة؟';

  @override
  String get reviewIgnoreModuleBody =>
      'سيتم إخفاء هذه الوحدة نهائيًا من جميع القوائم. لن تتعثر بها بعد الآن.';

  @override
  String get reviewModulePermanentlyIgnored => 'تم تجاهل الوحدة نهائيًا.';

  @override
  String get reviewIgnoreFailed => 'فشل تجاهل الوحدة.';

  @override
  String get reviewSuggestionSaved => 'تم حفظ مسودة الاقتراح! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'فشل حفظ مسودة الاقتراح.';

  @override
  String get reviewSuggestionDeleted => 'تم حذف الاقتراح.';

  @override
  String get reviewDeleteFailed => 'فشل الحذف.';

  @override
  String get reviewSuggestionApplied => 'تم تطبيق الاقتراح.';

  @override
  String get reviewPreparingData => 'جارٍ تجهيز بيانات المراجعة...';

  @override
  String get reviewDirectEdit => 'تعديل مباشر';

  @override
  String get reviewLivePreview => 'معاينة مباشرة';

  @override
  String get reviewCompareWith => 'قارن مع:';

  @override
  String get reviewProductionVersion => 'نسخة الإنتاج';

  @override
  String get reviewEditorialReview => 'المراجعة التحريرية';

  @override
  String get reviewOpenQueue => 'فتح قائمة انتظار المراجعة';

  @override
  String get reviewCopyPromptShort => 'نسخ التعليمة';

  @override
  String get reviewUnignoreShort => 'إلغاء التجاهل';

  @override
  String get reviewApproveButton => 'موافقة';

  @override
  String get reviewHideDetails => 'إخفاء التفاصيل';

  @override
  String get reviewDetailsAndEnglishSource => 'التفاصيل والمصدر الإنجليزي';

  @override
  String reviewPendingCountShort(int count) {
    return '$count قيد الانتظار';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'جارٍ مراجعة $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'قارن الترجمة بالمصدر الإنجليزي';

  @override
  String get reviewTranslationLabel => 'الترجمة';

  @override
  String get reviewComparisonTitle => 'المقارنة';

  @override
  String get reviewCopyPromptLongTooltip =>
      'نسخ نص المصدر + تعليمة الترجمة إلى الحافظة';

  @override
  String get reviewUnignoreCaps => 'إلغاء التجاهل';

  @override
  String get reviewIgnoreCaps => 'تجاهل';

  @override
  String get reviewSkipShortcut => 'تخطي (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'المراجعة التحريرية';

  @override
  String get reviewUnignoreTablet => 'إلغاء التجاهل';

  @override
  String get reviewApproveForProduction => 'الموافقة للإنتاج (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'تنقيح مباشر';

  @override
  String get reviewTitleField => 'العنوان';

  @override
  String get reviewSummaryField => 'الملخص';

  @override
  String get reviewBodyField => 'محتوى النص';

  @override
  String get reviewSaveShortcut => 'حفظ (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'معاينة مباشرة (جارٍ العرض)';

  @override
  String get reviewVoiceFemale => 'أنثى';

  @override
  String get reviewVoiceMale => 'ذكر';

  @override
  String get reviewStopListening => 'إيقاف';

  @override
  String get reviewListen => 'استماع';

  @override
  String get reviewAutopTooltip => 'تنسيق الفقرات تلقائيًا (سطر جديد → <p>)';

  @override
  String get reviewSourceCodeShort => 'المصدر';

  @override
  String get reviewNoParagraphChange =>
      'يحتوي النص بالفعل على وسوم <p> — لا يوجد تغيير';

  @override
  String get reviewParagraphsFormatted => 'تم تنسيق الفقرات ¶';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String categoriesLoadError(String error) {
    return 'فشل تحميل الفئات: $error';
  }

  @override
  String get categoriesSaveSuccess => 'تم حفظ الفئات بنجاح.';

  @override
  String get categoriesSaveFailed => 'فشل حفظ الترجمات.';

  @override
  String get categoriesFileEmpty => 'الملف فارغ.';

  @override
  String get categoriesInvalidJson => 'تنسيق JSON غير صالح.';

  @override
  String get categoriesNoValidUuids =>
      'لم يتم العثور على إدخالات UUID صالحة في الملف.';

  @override
  String categoriesImportSuccess(int count) {
    return 'تم استيراد $count فئة من الملف.';
  }

  @override
  String get categoriesTitle => 'الفئات';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'جارٍ الترجمة إلى: $lang';
  }

  @override
  String get categoriesImportJson => 'استيراد JSON';

  @override
  String get categoriesSaving => 'جارٍ الحفظ...';

  @override
  String get categoriesSaveAll => 'حفظ الكل';

  @override
  String get categoriesLoading => 'جارٍ تحميل الفئات...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'الترجمة ($code)';
  }

  @override
  String get categoriesNoneFound => 'لم يتم العثور على فئات.';

  @override
  String categoriesTranslateHint(String name) {
    return 'ترجم \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'صورة بواسطة ';

  @override
  String get loginPhotoOn => ' على ';

  @override
  String get loginPleaseSignIn => 'يرجى تسجيل الدخول';

  @override
  String get loginUsername => 'اسم المستخدم';

  @override
  String get loginPassword => 'كلمة المرور';

  @override
  String get loginRememberMe => 'تذكرني';

  @override
  String get loginSignIn => 'تسجيل الدخول';

  @override
  String get loginNoAccount => 'ليس لديك حساب بعد؟ ';

  @override
  String get loginRegisterNow => 'سجّل الآن';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonNext => 'التالي';

  @override
  String get registerFillRequired => 'يرجى ملء جميع الحقول المطلوبة.';

  @override
  String get registerPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get registerPasswordTooShort =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.';

  @override
  String get registerSelectLanguage => 'يرجى اختيار لغة واحدة على الأقل.';

  @override
  String get registerFailed => 'فشل التسجيل.';

  @override
  String get registerHeaderTitle => 'التسجيل';

  @override
  String get registerStepAccount => 'الحساب';

  @override
  String get registerStepRole => 'الدور';

  @override
  String get registerStepLanguages => 'اللغات';

  @override
  String get registerStepApiKeys => 'مفاتيح API';

  @override
  String get registerYourAccount => 'حسابك';

  @override
  String get registerAvatarOptional => 'الصورة الرمزية (اختياري)';

  @override
  String get registerUsernameRequired => 'اسم المستخدم *';

  @override
  String get registerEmailRequired => 'البريد الإلكتروني *';

  @override
  String get registerPasswordRequired => 'كلمة المرور *';

  @override
  String get registerPasswordRepeat => 'تكرار كلمة المرور *';

  @override
  String get registerYourRole => 'دورك';

  @override
  String get registerRoleExplanation =>
      'يمكن للمترجمين ترجمة النصوص لكن ليس لديهم وصول إلى قائمة انتظار المراجعة. يقوم المراجعون بفحص المحتوى المترجم والموافقة عليه.';

  @override
  String get registerRoleTranslator => 'مترجم';

  @override
  String get registerRoleTranslatorDesc => 'إنشاء الترجمات وتعديلها.';

  @override
  String get registerRoleReviewer => 'مراجع';

  @override
  String get registerRoleReviewerDesc => 'مراجعة الترجمات والموافقة عليها.';

  @override
  String get registerTargetLanguages => 'اللغات الهدف';

  @override
  String get registerLanguagesExplanation =>
      'اختر جميع اللغات التي تريد العمل عليها.';

  @override
  String get registerNoLanguagesAvailable => 'لا توجد لغات متاحة.';

  @override
  String get registerApiKeysTitle => 'مفاتيح API';

  @override
  String get registerApiKeysExplanation =>
      'أدخل مفاتيح API الخاصة بك. يستخدم كل مستخدم مفاتيحه الخاصة حصريًا. يمكنك أيضًا إضافتها لاحقًا في ملفك الشخصي.';

  @override
  String get registerKeysEncryptedNote =>
      'يتم تخزين المفاتيح مشفرة ولا تتم مشاركتها أبدًا مع مستخدمين آخرين.';

  @override
  String get registerOptionalSuffix => ' (اختياري)';

  @override
  String get registerSuccessTitle => 'تم التسجيل بنجاح!';

  @override
  String get registerSuccessBody =>
      'تم إنشاء حسابك وهو في انتظار موافقة المسؤول. سيتم إعلامك بمجرد تفعيل وصولك.';

  @override
  String get registerGoToLogin => 'الانتقال إلى تسجيل الدخول';

  @override
  String get registerSubmit => 'تسجيل';

  @override
  String registerPhotoCredit(String name) {
    return 'صورة بواسطة $name على Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get profileUpdateFailed => 'فشل التحديث.';

  @override
  String profileSaveError(String error) {
    return 'خطأ أثناء الحفظ: $error';
  }

  @override
  String get profilePasswordMismatch => 'كلمتا المرور غير متطابقتين!';

  @override
  String get profilePasswordChangeSuccess => 'تم تغيير كلمة المرور بنجاح!';

  @override
  String get profilePasswordChangeError =>
      'خطأ أثناء تغيير كلمة المرور: كلمة المرور الحالية غير صحيحة.';

  @override
  String get profileAvatarUploadSuccess => 'تم رفع الصورة الرمزية بنجاح!';

  @override
  String get profileAvatarUploadError => 'خطأ أثناء رفع الصورة الرمزية.';

  @override
  String get profileTitle => 'الملف الشخصي والإعدادات';

  @override
  String get profileSubtitle =>
      'إدارة ملفك الشخصي، وواجهات برمجة تطبيقات الترجمة الخاصة بك (Gemini وDeepL)، وأمان حسابك.';

  @override
  String get profileRoleUser => 'مستخدم';

  @override
  String get profileNoEmail => 'لم يتم تقديم عنوان بريد إلكتروني';

  @override
  String get profileTabDetails => 'تفاصيل الملف الشخصي';

  @override
  String get profileTabGemini => 'الترجمة بالذكاء الاصطناعي (Gemini)';

  @override
  String get profileTabDeepl => 'ترجمة DeepL';

  @override
  String get profileTabPassword => 'تغيير كلمة المرور';

  @override
  String get profileSectionInfo => 'معلومات الملف الشخصي';

  @override
  String get profileFieldName => 'الاسم';

  @override
  String get profileFieldNameHint => 'اسمك الكامل';

  @override
  String get profileFieldEmail => 'عنوان البريد الإلكتروني';

  @override
  String get profileFieldEmailHint => 'عنوان بريدك الإلكتروني';

  @override
  String get profileSectionGemini => 'إعدادات مساعد Gemini';

  @override
  String get profileFieldGeminiKey => 'مفتاح Google Gemini API';

  @override
  String get profileFieldGeminiKeyHint =>
      'أدخل مفتاح API الخاص بـ gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'تعليمة ذكاء اصطناعي مخصصة';

  @override
  String get profileFieldAiPromptHint =>
      'اختياري: تخصيص تعليمة النظام لـ Gemini...';

  @override
  String get profileSectionDeepl => 'إعدادات ترجمة DeepL';

  @override
  String get profileDeeplDescription =>
      'تقدم DeepL ترجمة آلية عالية الجودة مع الحفاظ على وسوم HTML. تحصل الحسابات المجانية (500,000 حرف/شهر) على مفتاح ينتهي باللاحقة \":fx\".';

  @override
  String get profileFieldDeeplKey => 'مفتاح DeepL API';

  @override
  String get profileFieldDeeplKeyHint =>
      'مثال: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'تنتهي المفاتيح المجانية بـ \":fx\" وتستخدم api-free.deepl.com. تستخدم مفاتيح Pro api.deepl.com. يتم تحديد الفرق تلقائيًا.';

  @override
  String get profileSectionSecurity => 'أمان الحساب';

  @override
  String get profileFieldCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get profileFieldCurrentPasswordHint => 'أدخل كلمة مرورك الحالية';

  @override
  String get profileFieldNewPassword => 'كلمة المرور الجديدة';

  @override
  String get profileFieldNewPasswordHint => '6 أحرف على الأقل';

  @override
  String get profileFieldConfirmPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get profileFieldConfirmPasswordHint => 'كرر كلمة المرور';

  @override
  String get profileChangePasswordButton => 'تغيير كلمة المرور';

  @override
  String get commonDelete => 'حذف';

  @override
  String get settingsRegistrationUpdated => 'تم تحديث إعداد التسجيل';

  @override
  String get settingsUpdateFailed => 'فشل التحديث.';

  @override
  String get settingsUserApproved => 'تمت الموافقة على المستخدم!';

  @override
  String get settingsAccountDeactivated => 'تم إلغاء تفعيل الحساب.';

  @override
  String get settingsUserDeleted => 'تم حذف المستخدم.';

  @override
  String get settingsActionFailed => 'فشل الإجراء.';

  @override
  String get settingsDeleteAccountTitle => 'حذف الحساب؟';

  @override
  String get settingsDeactivateAccountTitle => 'إلغاء تفعيل الحساب؟';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'سيتم حذف الحساب \"$username\" نهائيًا. هل تريد المتابعة؟';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'سيتم قفل الحساب \"$username\". لن يتمكن المستخدم من تسجيل الدخول بعد الآن، لكن سيتم الاحتفاظ بالحساب.';
  }

  @override
  String get settingsDeactivate => 'إلغاء التفعيل';

  @override
  String settingsSyncSuccess(String count) {
    return 'تمت مزامنة $count ترجمة!';
  }

  @override
  String settingsSyncError(String error) {
    return 'خطأ في المزامنة: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return 'تمت مزامنة $count وحدة ذات أولوية!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'خطأ في مزامنة قائمة الأولويات: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'نجحت عملية النسخ الاحتياطي: تمت معالجة $count ملف.';
  }

  @override
  String get settingsUploadFailed => 'فشل الرفع.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSystemConfig => 'تكوين النظام';

  @override
  String get settingsRegistration => 'التسجيل';

  @override
  String get settingsRegistrationHint => 'تبديل ظهور نموذج التسجيل العام.';

  @override
  String get settingsPendingUsers => 'المستخدمون المعلّقون';

  @override
  String get settingsNoNewRequests => 'لا توجد طلبات جديدة.';

  @override
  String get settingsWantsReviewer => 'يريد أن يكون مراجعًا';

  @override
  String get settingsAssignRole => 'تعيين دور';

  @override
  String get settingsRoleTranslator => 'مترجم';

  @override
  String get settingsRoleReviewer => 'مراجع';

  @override
  String get settingsApprove => 'موافقة';

  @override
  String get settingsReject => 'رفض';

  @override
  String get settingsActiveUsers => 'المستخدمون النشطون';

  @override
  String get settingsNoActiveUsers => 'لا يوجد مستخدمون نشطون.';

  @override
  String get settingsDeactivateAccountTooltip => 'إلغاء التفعيل';

  @override
  String get settingsDeleteAccountAction => 'حذف الحساب';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsThemePearl => 'فاتح (لؤلؤي)';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeGlassy => 'زجاجي';

  @override
  String get settingsThemeNature => 'طبيعة';

  @override
  String get settingsThemeLiquid => 'سائل';

  @override
  String get settingsThemeStage => 'مسرح';

  @override
  String get settingsTypography => 'الطباعة';

  @override
  String get settingsFontHint => 'تعديل عائلة خط الواجهة.';

  @override
  String get settingsFontClean => 'نظيف';

  @override
  String get settingsFontFuturistic => 'مستقبلي';

  @override
  String get settingsFontTech => 'تقني';

  @override
  String get settingsWorkflowFun => 'سير العمل والمرح';

  @override
  String get settingsConfettiTitle => 'احتفال بالنجاح (قصاصات ورقية)';

  @override
  String get settingsConfettiHint =>
      'يعرض رسمًا متحركًا صغيرًا عند الحفظ بنجاح.';

  @override
  String get settingsLargeUiTitle => 'قابلية قراءة محسّنة (خط كبير)';

  @override
  String get settingsLargeUiHint =>
      'يزيد من حجم الخطوط والشارات لتحسين القراءة.';

  @override
  String get settingsAutoPTitle => 'تنسيق الفقرات التلقائي (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'يقوم تلقائيًا بتغليف النص العادي في فقرات <p> عند تحميل وحدة في شاشة المراجعة. يعادل النقر على زر ¶ يدويًا.';

  @override
  String get settingsDatabaseSync => 'مزامنة قاعدة البيانات';

  @override
  String get settingsDatabaseSyncTooltip =>
      'يزامن إدخالات قاعدة البيانات مع ملفات JSON للترجمة.';

  @override
  String get settingsDatabaseSyncHint =>
      'يزامن إدخالات قاعدة البيانات الداخلية مع ملفات JSON الخاصة بالترجمة على الخادم.';

  @override
  String get settingsSyncing => 'جارٍ المزامنة...';

  @override
  String get settingsSyncNow => 'مزامنة الآن';

  @override
  String get settingsSyncD11List => 'مزامنة قائمة D11';

  @override
  String get settingsUploadBackup => 'رفع نسخة احتياطية (.zip)';

  @override
  String get settingsSelectZipFile => 'اختر ملف ZIP';

  @override
  String get settingsUploading => 'جارٍ الرفع...';

  @override
  String get settingsErrorDiagnostics => 'تشخيص الأخطاء وسجلات النظام';

  @override
  String get settingsLogsCopied => 'تم نسخ السجلات إلى الحافظة! 📋';

  @override
  String get settingsCopyLogs => 'نسخ السجلات';

  @override
  String get settingsLogsRotated => 'تمت أرشفة السجلات وتدويرها! 📁';

  @override
  String get settingsRotate => 'تدوير';

  @override
  String get settingsClear => 'مسح';

  @override
  String get settingsLogLimit => 'حد السجل: ';

  @override
  String get settingsNoLogs => 'لا توجد سجلات مسجلة';

  @override
  String get layoutMenu => 'القائمة';

  @override
  String get layoutNavAnalytics => 'التحليلات';

  @override
  String get layoutNavReviewQueue => 'قائمة انتظار المراجعة';

  @override
  String get layoutNavGlossary => 'المسرد';

  @override
  String get layoutNavCategories => 'الفئات';

  @override
  String get layoutNavHelp => 'المساعدة';

  @override
  String get layoutNavSettings => 'الإعدادات';

  @override
  String get layoutPhotoBy => 'صورة بواسطة ';

  @override
  String get layoutPhotoOn => ' على ';

  @override
  String get layoutEditProfile => 'تعديل الملف الشخصي';

  @override
  String get layoutLogout => 'تسجيل الخروج';

  @override
  String get layoutThemeLabel => 'المظهر';

  @override
  String get layoutThemePearl => 'فاتح';

  @override
  String get layoutThemeDark => 'داكن';

  @override
  String get layoutThemeGlassy => 'زجاجي';

  @override
  String get layoutThemeNature => 'طبيعة';

  @override
  String get layoutThemeLiquid => 'سائل';

  @override
  String get layoutThemeStage => 'مسرح';

  @override
  String get layoutTargetLanguage => 'اللغة الهدف';

  @override
  String get layoutDeeplUsage => 'استخدام DeepL';

  @override
  String get layoutUnavailable => 'غير متاح';

  @override
  String get layoutUnlimited => 'غير محدود';

  @override
  String get layoutUsed => 'مستخدَم';

  @override
  String get layoutTranslate => 'ترجمة';

  @override
  String get analyticsSubtitle =>
      'التوافق، تراكم الترجمات، والاتجاهات الأسبوعية.';

  @override
  String get analyticsBacklog => 'تراكم الترجمات';

  @override
  String get analyticsMissing => 'مفقودة';

  @override
  String get analyticsStale => 'قديمة';

  @override
  String get analyticsInReview => 'قيد المراجعة';

  @override
  String get analyticsReleased => 'منشورة';

  @override
  String get analyticsTranslated => 'مترجمة';

  @override
  String get analyticsTotalModules => 'إجمالي الوحدات';

  @override
  String get analyticsCompatByVersion => 'التوافق حسب إصدار Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'اللغة: $lang · منشورة / قيد المراجعة / مفقودة';
  }

  @override
  String get analyticsLoadingCounts => 'جارٍ تحميل الأعداد …';

  @override
  String get analyticsWindow => 'النافذة الزمنية:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks أسبوعًا';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'أوصاف المشاريع الجديدة أسبوعيًا';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'المُعلَّمة كقديمة أسبوعيًا ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count وحدة';
  }

  @override
  String get analyticsReviewShort => 'مراجعة';

  @override
  String get analyticsNoDataInWindow =>
      'لا توجد بيانات في هذه النافذة الزمنية.';

  @override
  String get analyticsAndMore => '… والمزيد';

  @override
  String glossaryLoadError(String error) {
    return 'خطأ في التحميل: $error';
  }

  @override
  String get glossaryNewTerm => 'إنشاء مصطلح جديد';

  @override
  String get glossaryEditTerm => 'تعديل المصطلح';

  @override
  String get glossaryFieldSourceWord =>
      'الكلمة المصدر (الصيغة الأساسية، كما تظهر في النص)';

  @override
  String get glossaryFieldSourceWordHint => 'مثال: node';

  @override
  String get glossaryWordForms => 'صيغ كلمات إضافية (جمع، إضافة، جر …)';

  @override
  String get glossaryWordFormsHint => 'مثال: content — اضغط Enter للإضافة';

  @override
  String get glossaryAddForm => 'إضافة صيغة';

  @override
  String get glossaryFieldPreferredWord => 'الترجمة المفضلة';

  @override
  String get glossaryFieldPreferredWordHint => 'مثال: content';

  @override
  String get glossaryFieldExplanation => 'التفسير (يُعرض في التلميح)';

  @override
  String get glossaryFieldExplanationHint =>
      'لماذا يجب ترجمة هذه الكلمة بشكل مختلف؟';

  @override
  String get glossaryCreate => 'إنشاء';

  @override
  String get glossaryRequiredFields =>
      'الكلمة المصدر والترجمة المفضلة مطلوبتان.';

  @override
  String get glossaryCreated => 'تم إنشاء المصطلح ✓';

  @override
  String get glossaryUpdated => 'تم تحديث المصطلح ✓';

  @override
  String glossaryError(String error) {
    return 'خطأ: $error';
  }

  @override
  String get glossaryDeleteTitle => 'حذف المصطلح؟';

  @override
  String glossaryDeleteBody(String word) {
    return 'سيتم حذف \"$word\" نهائيًا من المسرد.';
  }

  @override
  String get glossaryDeleted => 'تم حذف المصطلح.';

  @override
  String get glossaryTitle => 'مسرد الترجمة';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'اللغة: $lang · $count إدخال';
  }

  @override
  String get glossaryNewShort => 'جديد';

  @override
  String get glossaryCreateTerm => 'إنشاء مصطلح';

  @override
  String get glossaryInfoBanner =>
      'يتم تمييز الكلمات من هذا المسرد في محرر المراجعة. يشرح تلميح عند التحويم لماذا تناسب ترجمة مختلفة بشكل أفضل.';

  @override
  String get glossaryNoEntries => 'لا توجد إدخالات بعد.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'انقر على \"إنشاء مصطلح\" لإنشاء الإدخال الأول.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'لا توجد إدخالات مسرد لهذه اللغة بعد.';

  @override
  String get diffNoChanges => 'لم يتم اكتشاف اختلافات في المحتوى.';

  @override
  String get diffRemoved => 'محذوف';

  @override
  String get diffAdded => 'مضاف';

  @override
  String syncBarQuickSync(String count) {
    return 'مزامنة سريعة: $count وحدة تغيّرت …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'مزامنة كاملة: $current / $total وحدة';
  }

  @override
  String syncBarFullSync(String count) {
    return 'مزامنة كاملة: $count وحدة …';
  }
}
