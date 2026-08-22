// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Завантаження даних проєкту...';

  @override
  String editorLoadError(String error) {
    return 'Не вдалося завантажити дані проєкту: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Переклад за допомогою Gemini виконано успішно! ✨';

  @override
  String get editorUnknownError => 'Невідома помилка';

  @override
  String editorGeminiFailed(String detail) {
    return 'Переклад через Gemini не вдався: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Додайте свій ключ Google AI у профілі користувача (не в налаштуваннях адміністратора).';

  @override
  String get editorGeminiError =>
      'Помилка під час перекладу через Gemini. Перевірте свій ключ Google AI у профілі.';

  @override
  String get editorDeeplSuccess =>
      'Переклад за допомогою DeepL виконано успішно! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Переклад через DeepL не вдався: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Помилка під час перекладу через DeepL. Переконайтеся, що ваш ключ DeepL API вказано у профілі.';

  @override
  String get editorDeeplInvalidKey =>
      'Недійсний ключ DeepL API. Перевірте його у профілі.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Квоту DeepL вичерпано. Перевірте свій тарифний план.';

  @override
  String get editorReviewReset => 'Переклад повернуто до статусу перевірки.';

  @override
  String editorResetError(String error) {
    return 'Не вдалося скинути: $error';
  }

  @override
  String get editorUnignoreSuccess => 'Модуль повернуто до активного списку.';

  @override
  String get editorUnignoreError => 'Не вдалося скасувати ігнорування модуля.';

  @override
  String get editorSaveSuccess =>
      'Переклад збережено — повернення до черги перевірки.';

  @override
  String editorSaveError(String error) {
    return 'Не вдалося зберегти: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'У списку більше немає відкритих проєктів.';

  @override
  String get editorChangesDiscarded =>
      'Зміни скасовано, завантаження наступного проєкту...';

  @override
  String get editorEnglishSourceApplied =>
      'Застосовано англійський оригінал — тепер перекладіть його.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Не вдалося відкрити URL: $url';
  }

  @override
  String get commonSave => 'Зберегти';

  @override
  String get commonClose => 'Закрити';

  @override
  String get editorCloseEnglishSource => 'Закрити англійське джерело';

  @override
  String get editorShowEnglishSource => 'Показати англійське джерело';

  @override
  String get editorUnignoreShortTooltip => 'Скасувати ігнорування модуля';

  @override
  String get editorBackToReviewTooltip => 'Повернути на перевірку';

  @override
  String get editorAndNext => 'і далі';

  @override
  String get editorBackToDashboard => 'Назад до панелі керування';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Переклад на $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return 'залишилося: $count';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Повернути модуль до активного списку';

  @override
  String get editorUnignoreLabel => 'Скасувати ігнорування';

  @override
  String get editorUnpublishTooltip =>
      'Скасувати публікацію та повернути на перевірку';

  @override
  String get editorBackToReview => 'Повернути на перевірку';

  @override
  String get editorSaveAndNext => 'Зберегти і далі';

  @override
  String get editorEnglishSourceHeader => 'АНГЛІЙСЬКЕ ДЖЕРЕЛО';

  @override
  String get editorStaleTooltip =>
      'Показати пояснення та застосувати англійський текст';

  @override
  String get editorStaleDetailsLabel => 'Застаріло — деталі';

  @override
  String get editorCopyPromptTooltip =>
      'Скопіювати джерело + промпт для перекладу';

  @override
  String get editorPromptCopied => 'Промпт скопійовано в буфер обміну 📋';

  @override
  String get editorShowPreview => 'Показати попередній перегляд';

  @override
  String get editorShowHtmlSource => 'Показати вихідний код HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'КОРОТКИЙ ОПИС:\n$summary\n\nОСНОВНИЙ ТЕКСТ:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Короткий опис:';

  @override
  String get editorDescriptionLabelColon => 'Опис:';

  @override
  String get editorStaleDialogTitle => 'Англійське джерело змінилося';

  @override
  String get editorStaleExplanation =>
      'Наявний переклад базується на застарілому англійському оригіналі. Після останнього перекладу супровідник модуля змінив англійський текст на Drupal.org — тож зміст наявного перекладу може бути неточним або неповним.';

  @override
  String get editorStaleTip =>
      'Порада: натисніть \"Використати англійський оригінал\", щоб завантажити поточне англійське джерело безпосередньо в редактор. Потім ви зможете використати його як основу для нового перекладу. Англійський оригінал також відображається на лівій панелі.';

  @override
  String get editorEnglishSourceShort => 'Англійське джерело';

  @override
  String get editorPreviousTranslation => 'Попередній переклад';

  @override
  String get editorWhatChangedTitle => 'Що змінилося?';

  @override
  String get editorShowDiff => 'Показати різницю';

  @override
  String get editorUseEnglish => 'Використати англійський оригінал';

  @override
  String get editorStaleBannerText =>
      'Англійське джерело змінилося — переклад застарів';

  @override
  String get editorDetailsAndApply => 'Деталі та застосування';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'ПЕРЕКЛАД: $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Переклад...';

  @override
  String get editorShowEditor => 'Показати редактор';

  @override
  String get editorModuleTitleLabel => 'Назва модуля (англійською)';

  @override
  String get editorSummaryFieldLabel => 'Короткий опис';

  @override
  String get editorBodyFieldLabel => 'Основний текст';

  @override
  String get editorHtmlCleaned => 'HTML очищено';

  @override
  String get editorLivePreviewHeader => 'ПОПЕРЕДНІЙ ПЕРЕГЛЯД';

  @override
  String get editorTidyHtmlTooltip =>
      'Очистити HTML (видалити артефакти DeepL)';

  @override
  String get editorVisualMode => 'ВІЗУАЛЬНИЙ';

  @override
  String get editorSourceCodeMode => 'ДЖЕРЕЛО (HTML)';

  @override
  String get commonCancel => 'Скасувати';

  @override
  String get costDialogTitle => 'Оцінка вартості (ШІ)';

  @override
  String get costDialogIntro =>
      'Вибраний модуль буде перекладено за допомогою Google Gemini AI. Нижче наведено орієнтовну розбивку вартості цієї операції:';

  @override
  String get costRowModel => 'Модель';

  @override
  String get costRowInputTokens => 'Вхідні токени';

  @override
  String get costRowOutputTokens => 'Вихідні токени (оцінка)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars символів)';
  }

  @override
  String get costRowPriceInput => 'Ціна за 1 млн вхідних токенів';

  @override
  String get costRowPriceOutput => 'Ціна за 1 млн вихідних токенів';

  @override
  String get costRowTotalEstimate => 'Орієнтовна загальна вартість';

  @override
  String get costDialogFootnote =>
      '* Примітка: це орієнтовна оцінка на основі поточної моделі оплати Google за фактичне використання. Реальні витрати можуть дещо відрізнятися.';

  @override
  String get costDialogStartTranslation => 'Почати переклад';

  @override
  String get htmlToolbarInsertLink => 'Вставити посилання';

  @override
  String get htmlToolbarLinkTooltip => 'Вставити посилання (a)';

  @override
  String get htmlToolbarInsert => 'Вставити';

  @override
  String get htmlToolbarHeading2 => 'Заголовок 2';

  @override
  String get htmlToolbarHeading3 => 'Заголовок 3';

  @override
  String get htmlToolbarBold => 'Жирний (strong)';

  @override
  String get htmlToolbarItalic => 'Курсив (em)';

  @override
  String get htmlToolbarBulletList => 'Маркований список (ul)';

  @override
  String get htmlToolbarNumberedList => 'Нумерований список (ol)';

  @override
  String get htmlToolbarQuote => 'Цитата (blockquote)';

  @override
  String get screenshotAltsHeader => 'АЛЬТЕРНАТИВНИЙ ТЕКСТ ДО СКРІНШОТІВ';

  @override
  String get screenshotAltsIntro =>
      'Введіть описовий альтернативний текст цільовою мовою для кожного скріншота.';

  @override
  String screenshotLabel(int number) {
    return 'Скріншот $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Попередній перегляд недоступний';

  @override
  String get screenshotAltHint =>
      'Введіть альтернативний текст цільовою мовою…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Скасувати ігнорування всіх модулів?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Усі проігноровані модулі буде повернуто до активного списку та знову доступно для перекладу.';

  @override
  String get dashUnignoreAllConfirmAction => 'Скасувати ігнорування всіх';

  @override
  String get dashUnignoreAllSuccess => 'Ігнорування всіх модулів скасовано.';

  @override
  String get dashUnignoreAllError =>
      'Не вдалося скасувати ігнорування модулів.';

  @override
  String get dashUnignoreAllButton => 'Скасувати ігнорування всіх модулів';

  @override
  String dashSyncStartError(String error) {
    return 'Не вдалося запустити синхронізацію: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Швидке оновлення (7 днів) розпочато ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Помилка швидкого оновлення: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Успішно синхронізовано: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Модуль не знайдено на Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Масовий переклад через ШІ';

  @override
  String get dashHeaderTitle => 'Описи проєктів';

  @override
  String get dashHeaderSubtitle =>
      'Перекладайте описи модулів Drupal цільовою мовою. Допоможіть зробити екосистему доступнішою.';

  @override
  String get dashHeaderSubtitleShort => 'Перекладайте описи модулів Drupal.';

  @override
  String get dashLastLabel => 'Останній: ';

  @override
  String get dashContinue => 'Продовжити';

  @override
  String get dashContinueShort => 'Продовжити';

  @override
  String get dashUnignoreAllButtonLong => 'Скасувати ігнорування всіх модулів';

  @override
  String get dashQuickUpdateTooltip => 'Швидке оновлення (останні 7 днів)';

  @override
  String get dashFullSyncTooltip =>
      'Повна синхронізація бази даних з Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Вручну завантажити один модуль з Drupal.org';

  @override
  String get dashQuickShort => 'Швидко';

  @override
  String get dashModuleShort => 'Модуль';

  @override
  String get dashFoundLabel => 'Знайдено: ';

  @override
  String get dashModulesSuffix => ' модулів';

  @override
  String dashPerPage(int count) {
    return '$count на сторінку';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / стор.';
  }

  @override
  String get dashFirstPage => 'Перша сторінка';

  @override
  String get dashPrevPage => 'Попередня сторінка';

  @override
  String get dashNextPage => 'Наступна сторінка';

  @override
  String get dashLastPage => 'Остання сторінка';

  @override
  String dashPageOf(int page, int total) {
    return 'Сторінка $page з $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (напр., pathauto)';

  @override
  String get dashAddButton => 'Додати';

  @override
  String get dashAddModuleManually => 'Додати модуль вручну';

  @override
  String get dashAddModuleSubtitle =>
      'Завантажити безпосередньо з Drupal.org за машинною назвою.';

  @override
  String get dashAddModuleShort => 'Додати модуль';

  @override
  String get dashNoProjectsFound => 'Проєктів не знайдено.';

  @override
  String get dashFilterAll => 'Усі проєкти';

  @override
  String get dashFilterMissing => 'Відсутні переклади';

  @override
  String get dashFilterReview => 'Черга перевірки';

  @override
  String get dashFilterTranslated => 'Перекладені проєкти';

  @override
  String get dashFilterReleased => 'Опубліковані проєкти';

  @override
  String get dashBulkDialogIntro =>
      'Автоматично перекладіть кілька модулів із вибраного фільтра за допомогою Google Gemini.';

  @override
  String get dashActiveFilter => 'Активний фільтр';

  @override
  String get dashModuleCount => 'Кількість модулів';

  @override
  String dashModulesCountItem(int count) {
    return '$count модулів';
  }

  @override
  String get dashPrioritizeD12Title => 'Пріоритезувати модулі Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Спочатку перекладає модулі без підтримки Drupal 12';

  @override
  String get dashTotalModules => 'Усього модулів';

  @override
  String get dashInputTokensEst => 'Вхідні токени (оцінка)';

  @override
  String get dashOutputTokensEst => 'Вихідні токени (оцінка)';

  @override
  String get dashBulkFootnote =>
      '* Переклад виконується пакетами, ефективними за ресурсами, щоб уникнути тайм-аутів.';

  @override
  String get dashStartBulkTranslation => 'Почати масовий переклад';

  @override
  String dashStaleLoadError(String error) {
    return 'Помилка завантаження застарілих модулів: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Застарілих модулів не знайдено — усе актуально! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Повторно перекласти застарілі модулі';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Усі переклади, англійське джерело яких змінилося з часу останнього перекладу, буде автоматично перекладено повторно за допомогою Google Gemini. Немає потреби відкривати кожен модуль вручну.';

  @override
  String get dashOutdatedModules => 'Застарілі модулі';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Переклад замінює наявний текст і скидає статус is_reviewed. Виконується пакетами по 4 модулі.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Повторно перекласти всі $count модулів';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Повторний переклад застарілих модулів…';

  @override
  String get dashFetchingProjects => 'Отримання проєктів із сервера…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return 'Оброблено $processed з $total модулів';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Для цього фільтра не знайдено проєктів, доступних для перекладу.';

  @override
  String get dashStartingTranslation => 'Запуск перекладу…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Переклад модуля $start–$end з $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return 'Завершено $end із $total модулів.';
  }

  @override
  String get dashTranslationCompleted => 'Переклад успішно завершено! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Масовий переклад $count модулів виконано успішно! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Помилка масового перекладу: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Усі $count модулів успішно перекладено повторно! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count застарілих модулів успішно перекладено повторно! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Помилка під час повторного перекладу: $error';
  }

  @override
  String get filterAllShort => 'Усі';

  @override
  String get filterMissing => 'Відсутні';

  @override
  String get filterTranslated => 'Перекладено';

  @override
  String get filterReviewQueue => 'Черга перевірки';

  @override
  String get filterReleased => 'Опубліковано';

  @override
  String get filterOutdated => 'Застаріло';

  @override
  String get filterPriority => 'Пріоритет';

  @override
  String get filterIgnored => 'Проігноровано';

  @override
  String get commonEdit => 'Редагувати';

  @override
  String get commonReset => 'Скинути';

  @override
  String get commonRefresh => 'Оновити';

  @override
  String commonErrorPrefix(String error) {
    return 'Помилка: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Скинути всі опубліковані переклади?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Усі переклади, позначені як опубліковані для $langcode, буде повернуто до стану перевірки. Цю дію неможливо скасувати.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count перекладів повернуто до стану перевірки.';
  }

  @override
  String get reviewPipelineTitle => 'Конвеєр перевірки';

  @override
  String get reviewPipelineSubtitle =>
      'Процес контролю якості перекладів ШІ силами людей';

  @override
  String get reviewSearchHint => 'Пошук проєктів...';

  @override
  String get reviewResetPublished => 'Скинути опубліковані';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Результати: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Очікує: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Немає проєктів, що очікують перевірки.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Усі переклади вже перевірено або в цьому мовному контексті їх ще не існує.';

  @override
  String get reviewNoSummary => 'Немає короткого опису.';

  @override
  String get reviewStartAudit => 'ПОЧАТИ АУДИТ';

  @override
  String get reviewHtmlSourceShort => 'Вихідний код HTML';

  @override
  String get reviewCopySource => 'Копіювати джерело';

  @override
  String get reviewModuleDetails => 'Деталі модуля';

  @override
  String get reviewOriginalTitle => 'Оригінальна назва';

  @override
  String get reviewDrupalOrgProject => 'Проєкт на Drupal.org';

  @override
  String get reviewSuggestions => 'Пропозиції';

  @override
  String get reviewNoSuggestions => 'Пропозицій немає.';

  @override
  String get reviewApply => 'Застосувати';

  @override
  String get reviewNoChanges => 'Без змін';

  @override
  String get reviewOriginalBeforeCorrection => 'Оригінал (до виправлення)';

  @override
  String get reviewCorrectedCurrentVersion => 'Виправлено (поточна версія)';

  @override
  String get reviewBaseOriginal => 'Базовий (оригінал)';

  @override
  String get reviewYourCorrection => 'Ваше виправлення';

  @override
  String get reviewChangesVisual => 'Перегляньте свої зміни (візуально)';

  @override
  String get commonSkip => 'Пропустити';

  @override
  String get commonIgnore => 'Ігнорувати';

  @override
  String get reviewEmptyProjectTitle => 'Порожній проєкт';

  @override
  String get reviewEmptyProjectBody =>
      'Цей проєкт порожній (немає назви, короткого опису чи основного тексту) і не може бути затверджений. Пропустіть його.';

  @override
  String get reviewApprovedSuccess => 'Переклад затверджено! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Не вдалося затвердити \"$machine\" — спробуйте ще раз.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Ігнорування скасовано. Модуль знову активний!';

  @override
  String get reviewActionFailed => 'Дію не вдалося виконати.';

  @override
  String get reviewIgnoreModuleTitle => 'Ігнорувати модуль?';

  @override
  String get reviewIgnoreModuleBody =>
      'Цей модуль буде остаточно приховано з усіх списків. Він більше не заважатиме вам.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Модуль остаточно проігноровано.';

  @override
  String get reviewIgnoreFailed => 'Не вдалося проігнорувати модуль.';

  @override
  String get reviewSuggestionSaved => 'Чернетку пропозиції збережено! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Не вдалося зберегти чернетку пропозиції.';

  @override
  String get reviewSuggestionDeleted => 'Пропозицію видалено.';

  @override
  String get reviewDeleteFailed => 'Не вдалося видалити.';

  @override
  String get reviewSuggestionApplied => 'Пропозицію застосовано.';

  @override
  String get reviewPreparingData => 'Підготовка даних для перевірки...';

  @override
  String get reviewDirectEdit => 'Пряме редагування';

  @override
  String get reviewLivePreview => 'Попередній перегляд наживо';

  @override
  String get reviewCompareWith => 'Порівняти з:';

  @override
  String get reviewProductionVersion => 'Виробнича версія';

  @override
  String get reviewEditorialReview => 'Редакційна перевірка';

  @override
  String get reviewOpenQueue => 'Відкрити чергу перевірки';

  @override
  String get reviewCopyPromptShort => 'Копіювати промпт';

  @override
  String get reviewUnignoreShort => 'Скасувати ігнорування';

  @override
  String get reviewApproveButton => 'ЗАТВЕРДИТИ';

  @override
  String get reviewHideDetails => 'Приховати деталі';

  @override
  String get reviewDetailsAndEnglishSource => 'Деталі та англійське джерело';

  @override
  String reviewPendingCountShort(int count) {
    return '$count очікує';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Перевірка: $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Порівняти переклад з англійським джерелом';

  @override
  String get reviewTranslationLabel => 'Переклад';

  @override
  String get reviewComparisonTitle => 'Порівняння';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Скопіювати вихідний текст + промпт для перекладу в буфер обміну';

  @override
  String get reviewUnignoreCaps => 'СКАСУВАТИ ІГНОРУВАННЯ';

  @override
  String get reviewIgnoreCaps => 'ІГНОРУВАТИ';

  @override
  String get reviewSkipShortcut => 'ПРОПУСТИТИ (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Редакційна перевірка';

  @override
  String get reviewUnignoreTablet => 'СКАСУВАТИ ІГНОРУВАННЯ';

  @override
  String get reviewApproveForProduction =>
      'ЗАТВЕРДИТИ ДЛЯ ПУБЛІКАЦІЇ (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Пряме доопрацювання';

  @override
  String get reviewTitleField => 'Назва';

  @override
  String get reviewSummaryField => 'Короткий опис';

  @override
  String get reviewBodyField => 'Вміст основного тексту';

  @override
  String get reviewSaveShortcut => 'ЗБЕРЕГТИ (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Попередній перегляд наживо (рендеринг)';

  @override
  String get reviewVoiceFemale => 'Жіночий';

  @override
  String get reviewVoiceMale => 'Чоловічий';

  @override
  String get reviewStopListening => 'Зупинити';

  @override
  String get reviewListen => 'Прослухати';

  @override
  String get reviewAutopTooltip =>
      'Автоматичне форматування абзаців (розриви рядків → <p>)';

  @override
  String get reviewSourceCodeShort => 'ДЖЕРЕЛО';

  @override
  String get reviewNoParagraphChange => 'Текст уже містить теги <p> — без змін';

  @override
  String get reviewParagraphsFormatted => 'Абзаци відформатовано ¶';

  @override
  String get commonRetry => 'Повторити';

  @override
  String categoriesLoadError(String error) {
    return 'Не вдалося завантажити категорії: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Категорії успішно збережено.';

  @override
  String get categoriesSaveFailed => 'Не вдалося зберегти переклади.';

  @override
  String get categoriesFileEmpty => 'Файл порожній.';

  @override
  String get categoriesInvalidJson => 'Недійсний формат JSON.';

  @override
  String get categoriesNoValidUuids =>
      'У файлі не знайдено дійсних записів UUID.';

  @override
  String categoriesImportSuccess(int count) {
    return 'З файлу імпортовано $count категорій.';
  }

  @override
  String get categoriesTitle => 'Категорії';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Переклад для: $lang';
  }

  @override
  String get categoriesImportJson => 'Імпортувати JSON';

  @override
  String get categoriesSaving => 'Збереження...';

  @override
  String get categoriesSaveAll => 'Зберегти все';

  @override
  String get categoriesLoading => 'Завантаження категорій...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Переклад ($code)';
  }

  @override
  String get categoriesNoneFound => 'Категорій не знайдено.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Перекладіть \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Фото: ';

  @override
  String get loginPhotoOn => ' на ';

  @override
  String get loginPleaseSignIn => 'Будь ласка, увійдіть';

  @override
  String get loginUsername => 'Ім\'я користувача';

  @override
  String get loginPassword => 'Пароль';

  @override
  String get loginRememberMe => 'Запам\'ятати мене';

  @override
  String get loginSignIn => 'УВІЙТИ';

  @override
  String get loginNoAccount => 'Ще немає облікового запису? ';

  @override
  String get loginRegisterNow => 'Зареєструватися';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonNext => 'Далі';

  @override
  String get registerFillRequired => 'Заповніть усі обов\'язкові поля.';

  @override
  String get registerPasswordMismatch => 'Паролі не збігаються.';

  @override
  String get registerPasswordTooShort =>
      'Пароль має містити щонайменше 8 символів.';

  @override
  String get registerSelectLanguage => 'Виберіть принаймні одну мову.';

  @override
  String get registerFailed => 'Реєстрація не вдалася.';

  @override
  String get registerHeaderTitle => 'РЕЄСТРАЦІЯ';

  @override
  String get registerStepAccount => 'Обліковий запис';

  @override
  String get registerStepRole => 'Роль';

  @override
  String get registerStepLanguages => 'Мови';

  @override
  String get registerStepApiKeys => 'Ключі API';

  @override
  String get registerYourAccount => 'Ваш обліковий запис';

  @override
  String get registerAvatarOptional => 'Аватар (необов\'язково)';

  @override
  String get registerUsernameRequired => 'Ім\'я користувача *';

  @override
  String get registerEmailRequired => 'Електронна адреса *';

  @override
  String get registerPasswordRequired => 'Пароль *';

  @override
  String get registerPasswordRepeat => 'Повторіть пароль *';

  @override
  String get registerYourRole => 'Ваша роль';

  @override
  String get registerRoleExplanation =>
      'Перекладачі можуть перекладати тексти, але не мають доступу до черги перевірки. Рецензенти перевіряють та затверджують перекладений контент.';

  @override
  String get registerRoleTranslator => 'Перекладач';

  @override
  String get registerRoleTranslatorDesc =>
      'Створення та редагування перекладів.';

  @override
  String get registerRoleReviewer => 'Рецензент';

  @override
  String get registerRoleReviewerDesc =>
      'Перевірка та затвердження перекладів.';

  @override
  String get registerTargetLanguages => 'Цільові мови';

  @override
  String get registerLanguagesExplanation =>
      'Виберіть усі мови, з якими ви хочете працювати.';

  @override
  String get registerNoLanguagesAvailable => 'Немає доступних мов.';

  @override
  String get registerApiKeysTitle => 'Ключі API';

  @override
  String get registerApiKeysExplanation =>
      'Введіть власні ключі API. Кожен користувач використовує виключно власні ключі. Ви також можете додати їх пізніше у своєму профілі.';

  @override
  String get registerKeysEncryptedNote =>
      'Ключі зберігаються в зашифрованому вигляді та ніколи не передаються іншим користувачам.';

  @override
  String get registerOptionalSuffix => ' (необов\'язково)';

  @override
  String get registerSuccessTitle => 'Реєстрацію успішно завершено!';

  @override
  String get registerSuccessBody =>
      'Ваш обліковий запис створено, він очікує на схвалення адміністратором. Ви отримаєте сповіщення, коли ваш доступ буде активовано.';

  @override
  String get registerGoToLogin => 'Перейти до входу';

  @override
  String get registerSubmit => 'Зареєструватися';

  @override
  String registerPhotoCredit(String name) {
    return 'Фото: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Профіль успішно оновлено!';

  @override
  String get profileUpdateFailed => 'Оновлення не вдалося.';

  @override
  String profileSaveError(String error) {
    return 'Помилка під час збереження: $error';
  }

  @override
  String get profilePasswordMismatch => 'Паролі не збігаються!';

  @override
  String get profilePasswordChangeSuccess => 'Пароль успішно змінено!';

  @override
  String get profilePasswordChangeError =>
      'Помилка під час зміни пароля: неправильний поточний пароль.';

  @override
  String get profileAvatarUploadSuccess => 'Аватар успішно завантажено!';

  @override
  String get profileAvatarUploadError =>
      'Помилка під час завантаження аватара.';

  @override
  String get profileTitle => 'Профіль і налаштування';

  @override
  String get profileSubtitle =>
      'Керуйте своїм профілем користувача, API перекладу (Gemini і DeepL) та безпекою облікового запису.';

  @override
  String get profileRoleUser => 'Користувач';

  @override
  String get profileNoEmail => 'Електронну адресу не вказано';

  @override
  String get profileTabDetails => 'Дані профілю';

  @override
  String get profileTabGemini => 'Переклад через ШІ (Gemini)';

  @override
  String get profileTabDeepl => 'Переклад через DeepL';

  @override
  String get profileTabPassword => 'Змінити пароль';

  @override
  String get profileSectionInfo => 'ІНФОРМАЦІЯ ПРОФІЛЮ';

  @override
  String get profileFieldName => 'Ім\'я';

  @override
  String get profileFieldNameHint => 'Ваше повне ім\'я';

  @override
  String get profileFieldEmail => 'Електронна адреса';

  @override
  String get profileFieldEmailHint => 'Ваша електронна адреса';

  @override
  String get profileSectionGemini => 'НАЛАШТУВАННЯ GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Ключ API Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Введіть свій ключ API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Власний промпт для ШІ';

  @override
  String get profileFieldAiPromptHint =>
      'Необов\'язково: налаштуйте системний промпт для Gemini...';

  @override
  String get profileSectionDeepl => 'НАЛАШТУВАННЯ ПЕРЕКЛАДУ DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL пропонує високоякісний машинний переклад зі збереженням тегів HTML. Безплатні облікові записи (500 000 символів/місяць) отримують ключ із суфіксом \":fx\".';

  @override
  String get profileFieldDeeplKey => 'Ключ API DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'напр., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Безплатні ключі закінчуються на \":fx\" і використовують api-free.deepl.com. Ключі Pro використовують api.deepl.com. Розрізнення відбувається автоматично.';

  @override
  String get profileSectionSecurity => 'БЕЗПЕКА ОБЛІКОВОГО ЗАПИСУ';

  @override
  String get profileFieldCurrentPassword => 'Поточний пароль';

  @override
  String get profileFieldCurrentPasswordHint => 'Введіть свій поточний пароль';

  @override
  String get profileFieldNewPassword => 'Новий пароль';

  @override
  String get profileFieldNewPasswordHint => 'Щонайменше 6 символів';

  @override
  String get profileFieldConfirmPassword => 'Підтвердьте новий пароль';

  @override
  String get profileFieldConfirmPasswordHint => 'Повторіть пароль';

  @override
  String get profileChangePasswordButton => 'Змінити пароль';

  @override
  String get commonDelete => 'Видалити';

  @override
  String get settingsRegistrationUpdated => 'Налаштування реєстрації оновлено';

  @override
  String get settingsUpdateFailed => 'Оновлення не вдалося.';

  @override
  String get settingsUserApproved => 'Користувача затверджено!';

  @override
  String get settingsAccountDeactivated => 'Обліковий запис деактивовано.';

  @override
  String get settingsUserDeleted => 'Користувача видалено.';

  @override
  String get settingsActionFailed => 'Дію не вдалося виконати.';

  @override
  String get settingsDeleteAccountTitle => 'Видалити обліковий запис?';

  @override
  String get settingsDeactivateAccountTitle => 'Деактивувати обліковий запис?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Обліковий запис \"$username\" буде остаточно видалено. Продовжити?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Обліковий запис \"$username\" буде заблоковано. Користувач більше не зможе увійти, але обліковий запис залишиться.';
  }

  @override
  String get settingsDeactivate => 'Деактивувати';

  @override
  String settingsSyncSuccess(String count) {
    return 'Синхронізовано $count перекладів!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Помилка синхронізації: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return 'Синхронізовано $count пріоритетних модулів!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Помилка синхронізації списку пріоритетів: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Резервне копіювання успішне: оброблено $count файлів.';
  }

  @override
  String get settingsUploadFailed => 'Завантаження не вдалося.';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get settingsSystemConfig => 'СИСТЕМНА КОНФІГУРАЦІЯ';

  @override
  String get settingsRegistration => 'Реєстрація';

  @override
  String get settingsRegistrationHint =>
      'Увімкнути або вимкнути видимість глобальної форми реєстрації.';

  @override
  String get settingsPendingUsers => 'Користувачі, що очікують';

  @override
  String get settingsNoNewRequests => 'Нових запитів немає.';

  @override
  String get settingsWantsReviewer => 'Хоче стати рецензентом';

  @override
  String get settingsAssignRole => 'Призначити роль';

  @override
  String get settingsRoleTranslator => 'Перекладач';

  @override
  String get settingsRoleReviewer => 'Рецензент';

  @override
  String get settingsApprove => 'Затвердити';

  @override
  String get settingsReject => 'Відхилити';

  @override
  String get settingsActiveUsers => 'Активні користувачі';

  @override
  String get settingsNoActiveUsers => 'Активних користувачів немає.';

  @override
  String get settingsDeactivateAccountTooltip => 'Деактивувати';

  @override
  String get settingsDeleteAccountAction => 'Видалити обліковий запис';

  @override
  String get settingsAppearance => 'Зовнішній вигляд';

  @override
  String get settingsThemePearl => 'СВІТЛА (PEARL)';

  @override
  String get settingsThemeDark => 'ТЕМНА';

  @override
  String get settingsThemeGlassy => 'СКЛЯНА';

  @override
  String get settingsThemeNature => 'ПРИРОДА';

  @override
  String get settingsThemeLiquid => 'РІДИННА';

  @override
  String get settingsThemeStage => 'СЦЕНА';

  @override
  String get settingsTypography => 'Типографіка';

  @override
  String get settingsFontHint => 'Змінити шрифт інтерфейсу.';

  @override
  String get settingsFontClean => 'Чистий';

  @override
  String get settingsFontFuturistic => 'Футуристичний';

  @override
  String get settingsFontTech => 'Технічний';

  @override
  String get settingsWorkflowFun => 'Робочий процес і розваги';

  @override
  String get settingsConfettiTitle => 'Святкування успіху (конфеті)';

  @override
  String get settingsConfettiHint =>
      'Показує невелику анімацію під час успішного збереження.';

  @override
  String get settingsLargeUiTitle => 'Покращена читабельність (великий шрифт)';

  @override
  String get settingsLargeUiHint =>
      'Збільшує розмір шрифтів і бейджів для кращої читабельності.';

  @override
  String get settingsAutoPTitle =>
      'Автоматичне форматування абзаців (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Автоматично обгортає звичайний текст у теги абзаців <p> під час завантаження модуля на екрані перевірки. Аналогічно ручному натисканню кнопки ¶.';

  @override
  String get settingsDatabaseSync => 'Синхронізація бази даних';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Синхронізує записи бази даних із файлами перекладу JSON.';

  @override
  String get settingsDatabaseSyncHint =>
      'Синхронізує внутрішні записи бази даних із файлами JSON перекладу на сервері.';

  @override
  String get settingsSyncing => 'Синхронізація...';

  @override
  String get settingsSyncNow => 'Синхронізувати зараз';

  @override
  String get settingsSyncD11List => 'Синхронізувати список D11';

  @override
  String get settingsUploadBackup => 'Завантажити резервну копію (.zip)';

  @override
  String get settingsSelectZipFile => 'Виберіть ZIP-файл';

  @override
  String get settingsUploading => 'Завантаження...';

  @override
  String get settingsErrorDiagnostics =>
      'Діагностика помилок і системні журнали';

  @override
  String get settingsLogsCopied => 'Журнали скопійовано в буфер обміну! 📋';

  @override
  String get settingsCopyLogs => 'Копіювати журнали';

  @override
  String get settingsLogsRotated => 'Журнали заархівовано та ротовано! 📁';

  @override
  String get settingsRotate => 'Ротувати';

  @override
  String get settingsClear => 'Очистити';

  @override
  String get settingsLogLimit => 'Ліміт журналу: ';

  @override
  String get settingsNoLogs => 'Журналів не зафіксовано';

  @override
  String get layoutMenu => 'Меню';

  @override
  String get layoutNavAnalytics => 'Аналітика';

  @override
  String get layoutNavReviewQueue => 'Черга перевірки';

  @override
  String get layoutNavGlossary => 'Глосарій';

  @override
  String get layoutNavCategories => 'Категорії';

  @override
  String get layoutNavHelp => 'Довідка';

  @override
  String get layoutNavSettings => 'Налаштування';

  @override
  String get layoutPhotoBy => 'Фото: ';

  @override
  String get layoutPhotoOn => ' на ';

  @override
  String get layoutEditProfile => 'Редагувати профіль';

  @override
  String get layoutLogout => 'Вийти';

  @override
  String get layoutThemeLabel => 'ТЕМА';

  @override
  String get layoutThemePearl => 'Світла';

  @override
  String get layoutThemeDark => 'Темна';

  @override
  String get layoutThemeGlassy => 'Скляна';

  @override
  String get layoutThemeNature => 'Природа';

  @override
  String get layoutThemeLiquid => 'Рідинна';

  @override
  String get layoutThemeStage => 'Сцена';

  @override
  String get layoutTargetLanguage => 'ЦІЛЬОВА МОВА';

  @override
  String get layoutDeeplUsage => 'ВИКОРИСТАННЯ DEEPL';

  @override
  String get layoutUnavailable => 'Недоступно';

  @override
  String get layoutUnlimited => 'необмежено';

  @override
  String get layoutUsed => 'використано';

  @override
  String get layoutTranslate => 'Перекласти';

  @override
  String get analyticsSubtitle =>
      'Сумісність, накопичений обсяг перекладу та тижневі тенденції.';

  @override
  String get analyticsBacklog => 'Незавершені переклади';

  @override
  String get analyticsMissing => 'Відсутні';

  @override
  String get analyticsStale => 'Застарілі';

  @override
  String get analyticsInReview => 'На перевірці';

  @override
  String get analyticsReleased => 'Опубліковано';

  @override
  String get analyticsTranslated => 'Перекладено';

  @override
  String get analyticsTotalModules => 'Усього модулів';

  @override
  String get analyticsCompatByVersion => 'Сумісність за версією Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Мова: $lang · опубліковано / на перевірці / відсутні';
  }

  @override
  String get analyticsLoadingCounts => 'Завантаження підрахунків …';

  @override
  String get analyticsWindow => 'Період:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks тижнів';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Нові описи проєктів на тиждень';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Позначено як застаріле на тиждень ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count модулів';
  }

  @override
  String get analyticsReviewShort => 'Перевірка';

  @override
  String get analyticsNoDataInWindow => 'Немає даних за цей період.';

  @override
  String get analyticsAndMore => '… і більше';

  @override
  String glossaryLoadError(String error) {
    return 'Помилка завантаження: $error';
  }

  @override
  String get glossaryNewTerm => 'Створити новий термін';

  @override
  String get glossaryEditTerm => 'Редагувати термін';

  @override
  String get glossaryFieldSourceWord =>
      'Вихідне слово (базова форма, як воно з\'являється в тексті)';

  @override
  String get glossaryFieldSourceWordHint => 'напр., node';

  @override
  String get glossaryWordForms =>
      'Додаткові словоформи (множина, родовий, давальний …)';

  @override
  String get glossaryWordFormsHint =>
      'напр., content — натисніть Enter, щоб додати';

  @override
  String get glossaryAddForm => 'Додати форму';

  @override
  String get glossaryFieldPreferredWord => 'Бажаний переклад';

  @override
  String get glossaryFieldPreferredWordHint => 'напр., content';

  @override
  String get glossaryFieldExplanation =>
      'Пояснення (відображається в підказці)';

  @override
  String get glossaryFieldExplanationHint =>
      'Чому це слово слід перекладати інакше?';

  @override
  String get glossaryCreate => 'Створити';

  @override
  String get glossaryRequiredFields =>
      'Вихідне слово та бажаний переклад є обов\'язковими.';

  @override
  String get glossaryCreated => 'Термін створено ✓';

  @override
  String get glossaryUpdated => 'Термін оновлено ✓';

  @override
  String glossaryError(String error) {
    return 'Помилка: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Видалити термін?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" буде остаточно видалено з глосарія.';
  }

  @override
  String get glossaryDeleted => 'Термін видалено.';

  @override
  String get glossaryTitle => 'Глосарій перекладу';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Мова: $lang · записів: $count';
  }

  @override
  String get glossaryNewShort => 'Новий';

  @override
  String get glossaryCreateTerm => 'Створити термін';

  @override
  String get glossaryInfoBanner =>
      'Слова з цього глосарія виділяються в редакторі перевірки. Підказка при наведенні пояснює, чому інший переклад підходить краще.';

  @override
  String get glossaryNoEntries => 'Записів ще немає.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Натисніть \"Створити термін\", щоб створити перший запис.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Для цієї мови ще немає записів у глосарії.';

  @override
  String get diffNoChanges => 'Відмінностей у вмісті не виявлено.';

  @override
  String get diffRemoved => 'Видалено';

  @override
  String get diffAdded => 'Додано';

  @override
  String syncBarQuickSync(String count) {
    return 'Швидка синхронізація: $count змінених модулів …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Повна синхронізація: $current / $total модулів';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Повна синхронізація: $count модулів …';
  }
}
