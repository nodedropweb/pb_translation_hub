// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Загрузка данных проекта...';

  @override
  String editorLoadError(String error) {
    return 'Не удалось загрузить данные проекта: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Перевод с помощью Gemini выполнен успешно! ✨';

  @override
  String get editorUnknownError => 'Неизвестная ошибка';

  @override
  String editorGeminiFailed(String detail) {
    return 'Ошибка перевода Gemini: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Добавьте свой ключ Google AI в профиле пользователя (не в настройках администратора).';

  @override
  String get editorGeminiError =>
      'Ошибка при переводе с помощью Gemini. Проверьте ключ Google AI в своём профиле.';

  @override
  String get editorDeeplSuccess =>
      'Перевод с помощью DeepL выполнен успешно! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Ошибка перевода DeepL: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Ошибка при переводе с помощью DeepL. Убедитесь, что в вашем профиле задан API-ключ DeepL.';

  @override
  String get editorDeeplInvalidKey =>
      'Недействительный API-ключ DeepL. Проверьте его в своём профиле.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Квота DeepL исчерпана. Проверьте свой тарифный план.';

  @override
  String get editorReviewReset => 'Перевод сброшен в статус проверки.';

  @override
  String editorResetError(String error) {
    return 'Не удалось выполнить сброс: $error';
  }

  @override
  String get editorUnignoreSuccess => 'Модуль возвращён в активный список.';

  @override
  String get editorUnignoreError => 'Не удалось восстановить модуль.';

  @override
  String get editorSaveSuccess =>
      'Перевод сохранён — возврат в очередь проверки.';

  @override
  String editorSaveError(String error) {
    return 'Не удалось сохранить: $error';
  }

  @override
  String get editorNoMoreProjects => 'В списке больше нет открытых проектов.';

  @override
  String get editorChangesDiscarded =>
      'Изменения отменены, загружается следующий проект...';

  @override
  String get editorEnglishSourceApplied =>
      'Применён оригинал на английском — переведите его сейчас.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Не удалось открыть URL: $url';
  }

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get editorCloseEnglishSource => 'Закрыть английский оригинал';

  @override
  String get editorShowEnglishSource => 'Показать английский оригинал';

  @override
  String get editorUnignoreShortTooltip => 'Восстановить модуль';

  @override
  String get editorBackToReviewTooltip => 'Вернуть на проверку';

  @override
  String get editorAndNext => 'и Далее';

  @override
  String get editorBackToDashboard => 'Вернуться на панель';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Перевод на $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return 'Осталось: $count';
  }

  @override
  String get editorUnignoreLongTooltip => 'Вернуть модуль в активный список';

  @override
  String get editorUnignoreLabel => 'Восстановить';

  @override
  String get editorUnpublishTooltip =>
      'Отменить публикацию и вернуть на проверку';

  @override
  String get editorBackToReview => 'Вернуться к проверке';

  @override
  String get editorSaveAndNext => 'Сохранить и далее';

  @override
  String get editorEnglishSourceHeader => 'АНГЛИЙСКИЙ ОРИГИНАЛ';

  @override
  String get editorStaleTooltip =>
      'Показать объяснение и применить английский текст';

  @override
  String get editorStaleDetailsLabel => 'Устарело — Подробности';

  @override
  String get editorCopyPromptTooltip =>
      'Скопировать оригинал и промпт для перевода';

  @override
  String get editorPromptCopied => 'Промпт скопирован в буфер обмена 📋';

  @override
  String get editorShowPreview => 'Показать предпросмотр';

  @override
  String get editorShowHtmlSource => 'Показать исходный HTML-код';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'КРАТКОЕ ОПИСАНИЕ:\n$summary\n\nОСНОВНОЙ ТЕКСТ:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Краткое описание:';

  @override
  String get editorDescriptionLabelColon => 'Описание:';

  @override
  String get editorStaleDialogTitle => 'Английский оригинал изменился';

  @override
  String get editorStaleExplanation =>
      'Существующий перевод основан на устаревшем английском оригинале. С момента последнего перевода сопровождающий модуля изменил английский текст на Drupal.org — поэтому содержимое существующего перевода может быть неточным или неполным.';

  @override
  String get editorStaleTip =>
      'Совет: нажмите «Использовать английский оригинал», чтобы загрузить текущий английский текст прямо в редактор. Затем вы можете использовать его как основу для нового перевода. Английский оригинал также отображается на панели слева.';

  @override
  String get editorEnglishSourceShort => 'Английский оригинал';

  @override
  String get editorPreviousTranslation => 'Предыдущий перевод';

  @override
  String get editorWhatChangedTitle => 'Что изменилось?';

  @override
  String get editorShowDiff => 'Показать различия';

  @override
  String get editorUseEnglish => 'Использовать английский оригинал';

  @override
  String get editorStaleBannerText =>
      'Английский оригинал изменился — перевод устарел';

  @override
  String get editorDetailsAndApply => 'Подробности и применение';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'ПЕРЕВОД НА $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Перевод...';

  @override
  String get editorShowEditor => 'Показать редактор';

  @override
  String get editorModuleTitleLabel => 'Название модуля (на английском)';

  @override
  String get editorSummaryFieldLabel => 'Краткое описание';

  @override
  String get editorBodyFieldLabel => 'Основной текст';

  @override
  String get editorHtmlCleaned => 'HTML очищен';

  @override
  String get editorLivePreviewHeader => 'ПРЕДПРОСМОТР В РЕАЛЬНОМ ВРЕМЕНИ';

  @override
  String get editorTidyHtmlTooltip => 'Очистить HTML (удалить артефакты DeepL)';

  @override
  String get editorVisualMode => 'ВИЗУАЛЬНЫЙ';

  @override
  String get editorSourceCodeMode => 'ИСХОДНЫЙ КОД (HTML)';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get costDialogTitle => 'Оценка стоимости (ИИ)';

  @override
  String get costDialogIntro =>
      'Выбранный модуль будет переведён с помощью Google Gemini AI. Ниже приведена предварительная разбивка стоимости этой операции:';

  @override
  String get costRowModel => 'Модель';

  @override
  String get costRowInputTokens => 'Входные токены';

  @override
  String get costRowOutputTokens => 'Выходные токены (оценка)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars символов)';
  }

  @override
  String get costRowPriceInput => 'Цена за 1 млн входных токенов';

  @override
  String get costRowPriceOutput => 'Цена за 1 млн выходных токенов';

  @override
  String get costRowTotalEstimate => 'Ориентировочная общая стоимость';

  @override
  String get costDialogFootnote =>
      '* Примечание: это оценка, основанная на текущей модели оплаты по факту использования Google. Фактические расходы могут немного отличаться.';

  @override
  String get costDialogStartTranslation => 'Начать перевод';

  @override
  String get htmlToolbarInsertLink => 'Вставить ссылку';

  @override
  String get htmlToolbarLinkTooltip => 'Вставить ссылку (a)';

  @override
  String get htmlToolbarInsert => 'Вставить';

  @override
  String get htmlToolbarHeading2 => 'Заголовок 2';

  @override
  String get htmlToolbarHeading3 => 'Заголовок 3';

  @override
  String get htmlToolbarBold => 'Жирный (strong)';

  @override
  String get htmlToolbarItalic => 'Курсив (em)';

  @override
  String get htmlToolbarBulletList => 'Маркированный список (ul)';

  @override
  String get htmlToolbarNumberedList => 'Нумерованный список (ol)';

  @override
  String get htmlToolbarQuote => 'Цитата (blockquote)';

  @override
  String get screenshotAltsHeader => 'АЛЬТЕРНАТИВНЫЙ ТЕКСТ ДЛЯ СКРИНШОТОВ';

  @override
  String get screenshotAltsIntro =>
      'Введите описательный альтернативный текст на целевом языке для каждого скриншота.';

  @override
  String screenshotLabel(int number) {
    return 'Скриншот $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Предпросмотр недоступен';

  @override
  String get screenshotAltHint =>
      'Введите альтернативный текст на целевом языке…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Восстановить все игнорируемые модули?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Все игнорируемые модули будут возвращены в активный список и снова станут доступны для перевода.';

  @override
  String get dashUnignoreAllConfirmAction => 'Восстановить все';

  @override
  String get dashUnignoreAllSuccess => 'Все игнорируемые модули восстановлены.';

  @override
  String get dashUnignoreAllError => 'Не удалось восстановить модули.';

  @override
  String get dashUnignoreAllButton => 'Восстановить все игнорируемые модули';

  @override
  String dashSyncStartError(String error) {
    return 'Не удалось начать синхронизацию: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Быстрое обновление (7 дней) начато ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Ошибка быстрого обновления: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Успешно синхронизировано: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Модуль не найден на Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Массовый перевод с помощью ИИ';

  @override
  String get dashHeaderTitle => 'Описания проектов';

  @override
  String get dashHeaderSubtitle =>
      'Переводите описания модулей Drupal на целевой язык. Помогите сделать экосистему более доступной.';

  @override
  String get dashHeaderSubtitleShort => 'Переводите описания модулей Drupal.';

  @override
  String get dashLastLabel => 'Последний: ';

  @override
  String get dashContinue => 'Продолжить';

  @override
  String get dashContinueShort => 'Продолжить';

  @override
  String get dashUnignoreAllButtonLong =>
      'Восстановить все игнорируемые модули';

  @override
  String get dashQuickUpdateTooltip => 'Быстрое обновление (последние 7 дней)';

  @override
  String get dashFullSyncTooltip =>
      'Полная синхронизация базы данных с Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Загрузить отдельный модуль с Drupal.org вручную';

  @override
  String get dashQuickShort => 'Быстро';

  @override
  String get dashModuleShort => 'Модуль';

  @override
  String get dashFoundLabel => 'Найдено: ';

  @override
  String get dashModulesSuffix => ' модулей';

  @override
  String dashPerPage(int count) {
    return '$count на странице';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / стр.';
  }

  @override
  String get dashFirstPage => 'Первая страница';

  @override
  String get dashPrevPage => 'Предыдущая страница';

  @override
  String get dashNextPage => 'Следующая страница';

  @override
  String get dashLastPage => 'Последняя страница';

  @override
  String dashPageOf(int page, int total) {
    return 'Страница $page из $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (например, pathauto)';

  @override
  String get dashAddButton => 'Добавить';

  @override
  String get dashAddModuleManually => 'Добавить модуль вручную';

  @override
  String get dashAddModuleSubtitle =>
      'Загрузить напрямую с Drupal.org по machine name.';

  @override
  String get dashAddModuleShort => 'Добавить модуль';

  @override
  String get dashNoProjectsFound => 'Проекты не найдены.';

  @override
  String get dashFilterAll => 'Все проекты';

  @override
  String get dashFilterMissing => 'Отсутствующие переводы';

  @override
  String get dashFilterReview => 'Очередь проверки';

  @override
  String get dashFilterTranslated => 'Переведённые проекты';

  @override
  String get dashFilterReleased => 'Опубликованные проекты';

  @override
  String get dashBulkDialogIntro =>
      'Автоматически переведите несколько модулей из выбранного фильтра с помощью Google Gemini.';

  @override
  String get dashActiveFilter => 'Активный фильтр';

  @override
  String get dashModuleCount => 'Количество модулей';

  @override
  String dashModulesCountItem(int count) {
    return '$count модулей';
  }

  @override
  String get dashPrioritizeD12Title => 'Приоритизировать модули Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Сначала переводит модули без поддержки Drupal 12';

  @override
  String get dashTotalModules => 'Всего модулей';

  @override
  String get dashInputTokensEst => 'Входные токены (оценка)';

  @override
  String get dashOutputTokensEst => 'Выходные токены (оценка)';

  @override
  String get dashBulkFootnote =>
      '* Перевод выполняется пакетами с эффективным использованием ресурсов, чтобы избежать тайм-аутов.';

  @override
  String get dashStartBulkTranslation => 'Начать массовый перевод';

  @override
  String dashStaleLoadError(String error) {
    return 'Ошибка загрузки устаревших модулей: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Устаревших модулей не найдено — всё актуально! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Повторно перевести устаревшие модули';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Все переводы, английский оригинал которых изменился с момента последнего перевода, будут автоматически переведены заново с помощью Google Gemini. Не нужно открывать каждый модуль вручную.';

  @override
  String get dashOutdatedModules => 'Устаревшие модули';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Перевод заменяет существующий текст и сбрасывает флаг is_reviewed. Выполняется пакетами по 4 модуля.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Повторно перевести все $count модулей';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Повторный перевод устаревших модулей…';

  @override
  String get dashFetchingProjects => 'Получение проектов с сервера…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return 'Обработано $processed из $total модулей';
  }

  @override
  String get dashNoTranslatableProjects =>
      'По этому фильтру не найдено проектов, доступных для перевода.';

  @override
  String get dashStartingTranslation => 'Запуск перевода…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Перевод модуля $start–$end из $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return 'Завершено $end из $total модулей.';
  }

  @override
  String get dashTranslationCompleted => 'Перевод успешно завершён! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Массовый перевод $count модулей выполнен успешно! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Ошибка массового перевода: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Все $count модулей успешно переведены заново! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count устаревших модулей успешно переведены заново! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Ошибка при повторном переводе: $error';
  }

  @override
  String get filterAllShort => 'Все';

  @override
  String get filterMissing => 'Отсутствуют';

  @override
  String get filterTranslated => 'Переведены';

  @override
  String get filterReviewQueue => 'Очередь проверки';

  @override
  String get filterReleased => 'Опубликованы';

  @override
  String get filterOutdated => 'Устарели';

  @override
  String get filterPriority => 'Приоритет';

  @override
  String get filterIgnored => 'Игнорируются';

  @override
  String get commonEdit => 'Изменить';

  @override
  String get commonReset => 'Сбросить';

  @override
  String get commonRefresh => 'Обновить';

  @override
  String commonErrorPrefix(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Сбросить все опубликованные переводы?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Все переводы, отмеченные как опубликованные для $langcode, будут сброшены в статус проверки. Это действие нельзя отменить.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count переводов сброшено в статус проверки.';
  }

  @override
  String get reviewPipelineTitle => 'Конвейер проверки';

  @override
  String get reviewPipelineSubtitle =>
      'Конвейер контроля качества переводов ИИ силами человека';

  @override
  String get reviewSearchHint => 'Поиск проектов...';

  @override
  String get reviewResetPublished => 'Сбросить опубликованные';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Результаты: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Ожидают: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Нет проектов, ожидающих проверки.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Все переводы уже проверены, либо в этом языковом контексте их не существует.';

  @override
  String get reviewNoSummary => 'Нет краткого описания.';

  @override
  String get reviewStartAudit => 'НАЧАТЬ ПРОВЕРКУ';

  @override
  String get reviewHtmlSourceShort => 'Исходный HTML';

  @override
  String get reviewCopySource => 'Скопировать оригинал';

  @override
  String get reviewModuleDetails => 'Сведения о модуле';

  @override
  String get reviewOriginalTitle => 'Исходное название';

  @override
  String get reviewDrupalOrgProject => 'Проект на Drupal.org';

  @override
  String get reviewSuggestions => 'Предложения';

  @override
  String get reviewNoSuggestions => 'Нет доступных предложений.';

  @override
  String get reviewApply => 'Применить';

  @override
  String get reviewNoChanges => 'Без изменений';

  @override
  String get reviewOriginalBeforeCorrection => 'Исходный вариант (до правки)';

  @override
  String get reviewCorrectedCurrentVersion => 'Исправлено (текущая версия)';

  @override
  String get reviewBaseOriginal => 'База (оригинал)';

  @override
  String get reviewYourCorrection => 'Ваша правка';

  @override
  String get reviewChangesVisual => 'Просмотр изменений (визуально)';

  @override
  String get commonSkip => 'Пропустить';

  @override
  String get commonIgnore => 'Игнорировать';

  @override
  String get reviewEmptyProjectTitle => 'Пустой проект';

  @override
  String get reviewEmptyProjectBody =>
      'Этот проект пуст (нет ни названия, ни краткого описания, ни основного текста), поэтому его нельзя одобрить. Пожалуйста, пропустите его.';

  @override
  String get reviewApprovedSuccess => 'Перевод одобрен! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Не удалось одобрить «$machine» — попробуйте ещё раз.';
  }

  @override
  String get reviewUnignoredSuccess => 'Восстановлено. Модуль снова активен!';

  @override
  String get reviewActionFailed => 'Действие не выполнено.';

  @override
  String get reviewIgnoreModuleTitle => 'Игнорировать модуль?';

  @override
  String get reviewIgnoreModuleBody =>
      'Этот модуль будет навсегда скрыт из всех списков. Вы больше не будете на нём застревать.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Модуль навсегда проигнорирован.';

  @override
  String get reviewIgnoreFailed => 'Не удалось проигнорировать модуль.';

  @override
  String get reviewSuggestionSaved => 'Черновик предложения сохранён! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Не удалось сохранить черновик предложения.';

  @override
  String get reviewSuggestionDeleted => 'Предложение удалено.';

  @override
  String get reviewDeleteFailed => 'Не удалось удалить.';

  @override
  String get reviewSuggestionApplied => 'Предложение применено.';

  @override
  String get reviewPreparingData => 'Подготовка данных для проверки...';

  @override
  String get reviewDirectEdit => 'Прямое редактирование';

  @override
  String get reviewLivePreview => 'Предпросмотр в реальном времени';

  @override
  String get reviewCompareWith => 'Сравнить с:';

  @override
  String get reviewProductionVersion => 'Опубликованная версия';

  @override
  String get reviewEditorialReview => 'Редакторская проверка';

  @override
  String get reviewOpenQueue => 'Открыть очередь проверки';

  @override
  String get reviewCopyPromptShort => 'Скопировать промпт';

  @override
  String get reviewUnignoreShort => 'Восстановить';

  @override
  String get reviewApproveButton => 'ОДОБРИТЬ';

  @override
  String get reviewHideDetails => 'Скрыть подробности';

  @override
  String get reviewDetailsAndEnglishSource =>
      'Подробности и английский оригинал';

  @override
  String reviewPendingCountShort(int count) {
    return 'Ожидает: $count';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Проверка: $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Сравнить перевод с английским оригиналом';

  @override
  String get reviewTranslationLabel => 'Перевод';

  @override
  String get reviewComparisonTitle => 'Сравнение';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Скопировать исходный текст и промпт для перевода в буфер обмена';

  @override
  String get reviewUnignoreCaps => 'ВОССТАНОВИТЬ';

  @override
  String get reviewIgnoreCaps => 'ИГНОРИРОВАТЬ';

  @override
  String get reviewSkipShortcut => 'ПРОПУСТИТЬ (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Редакторская проверка';

  @override
  String get reviewUnignoreTablet => 'ВОССТАНОВИТЬ';

  @override
  String get reviewApproveForProduction =>
      'ОДОБРИТЬ ДЛЯ ПУБЛИКАЦИИ (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Прямая доработка';

  @override
  String get reviewTitleField => 'Название';

  @override
  String get reviewSummaryField => 'Краткое описание';

  @override
  String get reviewBodyField => 'Основной текст';

  @override
  String get reviewSaveShortcut => 'СОХРАНИТЬ (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Предпросмотр в реальном времени (рендеринг)';

  @override
  String get reviewVoiceFemale => 'Женский';

  @override
  String get reviewVoiceMale => 'Мужской';

  @override
  String get reviewStopListening => 'Стоп';

  @override
  String get reviewListen => 'Прослушать';

  @override
  String get reviewAutopTooltip =>
      'Автоформатирование абзацев (переносы строк → <p>)';

  @override
  String get reviewSourceCodeShort => 'ИСХОДНЫЙ КОД';

  @override
  String get reviewNoParagraphChange =>
      'Текст уже содержит теги <p> — изменений нет';

  @override
  String get reviewParagraphsFormatted => 'Абзацы отформатированы ¶';

  @override
  String get commonRetry => 'Повторить';

  @override
  String categoriesLoadError(String error) {
    return 'Не удалось загрузить категории: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Категории успешно сохранены.';

  @override
  String get categoriesSaveFailed => 'Не удалось сохранить переводы.';

  @override
  String get categoriesFileEmpty => 'Файл пуст.';

  @override
  String get categoriesInvalidJson => 'Неверный формат JSON.';

  @override
  String get categoriesNoValidUuids =>
      'В файле не найдено ни одной допустимой записи UUID.';

  @override
  String categoriesImportSuccess(int count) {
    return 'Из файла импортировано $count категорий.';
  }

  @override
  String get categoriesTitle => 'Категории';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Перевод для: $lang';
  }

  @override
  String get categoriesImportJson => 'Импорт JSON';

  @override
  String get categoriesSaving => 'Сохранение...';

  @override
  String get categoriesSaveAll => 'Сохранить все';

  @override
  String get categoriesLoading => 'Загрузка категорий...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Перевод ($code)';
  }

  @override
  String get categoriesNoneFound => 'Категории не найдены.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Перевести «$name»...';
  }

  @override
  String get loginPhotoBy => 'Фото: ';

  @override
  String get loginPhotoOn => ', ';

  @override
  String get loginPleaseSignIn => 'Пожалуйста, войдите';

  @override
  String get loginUsername => 'Имя пользователя';

  @override
  String get loginPassword => 'Пароль';

  @override
  String get loginRememberMe => 'Запомнить меня';

  @override
  String get loginSignIn => 'ВОЙТИ';

  @override
  String get loginNoAccount => 'Ещё нет учётной записи? ';

  @override
  String get loginRegisterNow => 'Зарегистрироваться';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonNext => 'Далее';

  @override
  String get registerFillRequired =>
      'Пожалуйста, заполните все обязательные поля.';

  @override
  String get registerPasswordMismatch => 'Пароли не совпадают.';

  @override
  String get registerPasswordTooShort =>
      'Пароль должен содержать не менее 8 символов.';

  @override
  String get registerSelectLanguage =>
      'Пожалуйста, выберите хотя бы один язык.';

  @override
  String get registerFailed => 'Регистрация не удалась.';

  @override
  String get registerHeaderTitle => 'РЕГИСТРАЦИЯ';

  @override
  String get registerStepAccount => 'Аккаунт';

  @override
  String get registerStepRole => 'Роль';

  @override
  String get registerStepLanguages => 'Языки';

  @override
  String get registerStepApiKeys => 'API-ключи';

  @override
  String get registerYourAccount => 'Ваш аккаунт';

  @override
  String get registerAvatarOptional => 'Аватар (необязательно)';

  @override
  String get registerUsernameRequired => 'Имя пользователя *';

  @override
  String get registerEmailRequired => 'Адрес электронной почты *';

  @override
  String get registerPasswordRequired => 'Пароль *';

  @override
  String get registerPasswordRepeat => 'Повторите пароль *';

  @override
  String get registerYourRole => 'Ваша роль';

  @override
  String get registerRoleExplanation =>
      'Переводчики могут переводить тексты, но не имеют доступа к очереди проверки. Проверяющие проверяют и одобряют переведённый контент.';

  @override
  String get registerRoleTranslator => 'Переводчик';

  @override
  String get registerRoleTranslatorDesc =>
      'Создание и редактирование переводов.';

  @override
  String get registerRoleReviewer => 'Проверяющий';

  @override
  String get registerRoleReviewerDesc => 'Проверка и одобрение переводов.';

  @override
  String get registerTargetLanguages => 'Целевые языки';

  @override
  String get registerLanguagesExplanation =>
      'Выберите все языки, с которыми хотите работать.';

  @override
  String get registerNoLanguagesAvailable => 'Нет доступных языков.';

  @override
  String get registerApiKeysTitle => 'API-ключи';

  @override
  String get registerApiKeysExplanation =>
      'Введите собственные API-ключи. Каждый пользователь использует исключительно свои ключи. Их также можно добавить позже в профиле.';

  @override
  String get registerKeysEncryptedNote =>
      'Ключи хранятся в зашифрованном виде и никогда не передаются другим пользователям.';

  @override
  String get registerOptionalSuffix => ' (необязательно)';

  @override
  String get registerSuccessTitle => 'Регистрация прошла успешно!';

  @override
  String get registerSuccessBody =>
      'Ваш аккаунт создан и ожидает одобрения администратором. Вы получите уведомление, как только доступ будет активирован.';

  @override
  String get registerGoToLogin => 'Перейти к входу';

  @override
  String get registerSubmit => 'Зарегистрироваться';

  @override
  String registerPhotoCredit(String name) {
    return 'Фото: $name, Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Профиль успешно обновлён!';

  @override
  String get profileUpdateFailed => 'Не удалось обновить.';

  @override
  String profileSaveError(String error) {
    return 'Ошибка при сохранении: $error';
  }

  @override
  String get profilePasswordMismatch => 'Пароли не совпадают!';

  @override
  String get profilePasswordChangeSuccess => 'Пароль успешно изменён!';

  @override
  String get profilePasswordChangeError =>
      'Ошибка при смене пароля: неверный текущий пароль.';

  @override
  String get profileAvatarUploadSuccess => 'Аватар успешно загружен!';

  @override
  String get profileAvatarUploadError => 'Ошибка при загрузке аватара.';

  @override
  String get profileTitle => 'Профиль и настройки';

  @override
  String get profileSubtitle =>
      'Управляйте своим профилем пользователя, API для перевода (Gemini и DeepL) и безопасностью аккаунта.';

  @override
  String get profileRoleUser => 'Пользователь';

  @override
  String get profileNoEmail => 'Адрес электронной почты не указан';

  @override
  String get profileTabDetails => 'Данные профиля';

  @override
  String get profileTabGemini => 'ИИ-перевод (Gemini)';

  @override
  String get profileTabDeepl => 'Перевод DeepL';

  @override
  String get profileTabPassword => 'Смена пароля';

  @override
  String get profileSectionInfo => 'ИНФОРМАЦИЯ О ПРОФИЛЕ';

  @override
  String get profileFieldName => 'Имя';

  @override
  String get profileFieldNameHint => 'Ваше полное имя';

  @override
  String get profileFieldEmail => 'Адрес электронной почты';

  @override
  String get profileFieldEmailHint => 'Ваш адрес электронной почты';

  @override
  String get profileSectionGemini => 'НАСТРОЙКИ GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'API-ключ Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Введите ваш API-ключ gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Пользовательский промпт для ИИ';

  @override
  String get profileFieldAiPromptHint =>
      'Необязательно: настройте системный промпт для Gemini...';

  @override
  String get profileSectionDeepl => 'НАСТРОЙКИ ПЕРЕВОДА DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL предлагает высококачественный машинный перевод с сохранением HTML-тегов. Бесплатные аккаунты (500 000 символов/месяц) получают ключ с суффиксом «:fx».';

  @override
  String get profileFieldDeeplKey => 'API-ключ DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'например, xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Бесплатные ключи оканчиваются на «:fx» и используют api-free.deepl.com. Ключи Pro используют api.deepl.com. Различие определяется автоматически.';

  @override
  String get profileSectionSecurity => 'БЕЗОПАСНОСТЬ АККАУНТА';

  @override
  String get profileFieldCurrentPassword => 'Текущий пароль';

  @override
  String get profileFieldCurrentPasswordHint => 'Введите ваш текущий пароль';

  @override
  String get profileFieldNewPassword => 'Новый пароль';

  @override
  String get profileFieldNewPasswordHint => 'Не менее 6 символов';

  @override
  String get profileFieldConfirmPassword => 'Подтвердите новый пароль';

  @override
  String get profileFieldConfirmPasswordHint => 'Повторите пароль';

  @override
  String get profileChangePasswordButton => 'Сменить пароль';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get settingsRegistrationUpdated => 'Настройка регистрации обновлена';

  @override
  String get settingsUpdateFailed => 'Не удалось обновить.';

  @override
  String get settingsUserApproved => 'Пользователь одобрен!';

  @override
  String get settingsAccountDeactivated => 'Аккаунт деактивирован.';

  @override
  String get settingsUserDeleted => 'Пользователь удалён.';

  @override
  String get settingsActionFailed => 'Действие не выполнено.';

  @override
  String get settingsDeleteAccountTitle => 'Удалить аккаунт?';

  @override
  String get settingsDeactivateAccountTitle => 'Деактивировать аккаунт?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Аккаунт «$username» будет удалён без возможности восстановления. Продолжить?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Аккаунт «$username» будет заблокирован. Пользователь больше не сможет войти, но аккаунт будет сохранён.';
  }

  @override
  String get settingsDeactivate => 'Деактивировать';

  @override
  String settingsSyncSuccess(String count) {
    return 'Синхронизировано переводов: $count!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Ошибка синхронизации: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return 'Синхронизировано приоритетных модулей: $count!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Ошибка синхронизации приоритетного списка: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Резервное копирование выполнено успешно: обработано файлов — $count.';
  }

  @override
  String get settingsUploadFailed => 'Не удалось загрузить.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsSystemConfig => 'КОНФИГУРАЦИЯ СИСТЕМЫ';

  @override
  String get settingsRegistration => 'Регистрация';

  @override
  String get settingsRegistrationHint =>
      'Включить или отключить глобальную видимость формы регистрации.';

  @override
  String get settingsPendingUsers => 'Пользователи, ожидающие подтверждения';

  @override
  String get settingsNoNewRequests => 'Новых заявок нет.';

  @override
  String get settingsWantsReviewer => 'Хочет стать проверяющим';

  @override
  String get settingsAssignRole => 'Назначить роль';

  @override
  String get settingsRoleTranslator => 'Переводчик';

  @override
  String get settingsRoleReviewer => 'Проверяющий';

  @override
  String get settingsApprove => 'Одобрить';

  @override
  String get settingsReject => 'Отклонить';

  @override
  String get settingsActiveUsers => 'Активные пользователи';

  @override
  String get settingsNoActiveUsers => 'Активных пользователей нет.';

  @override
  String get settingsDeactivateAccountTooltip => 'Деактивировать';

  @override
  String get settingsDeleteAccountAction => 'Удалить аккаунт';

  @override
  String get settingsAppearance => 'Внешний вид';

  @override
  String get settingsThemePearl => 'СВЕТЛАЯ (ЖЕМЧУГ)';

  @override
  String get settingsThemeDark => 'ТЁМНАЯ';

  @override
  String get settingsThemeGlassy => 'СТЕКЛО';

  @override
  String get settingsThemeNature => 'ПРИРОДА';

  @override
  String get settingsThemeLiquid => 'ЖИДКОСТЬ';

  @override
  String get settingsThemeStage => 'СЦЕНА';

  @override
  String get settingsTypography => 'Типографика';

  @override
  String get settingsFontHint => 'Изменить шрифт интерфейса.';

  @override
  String get settingsFontClean => 'Чистый';

  @override
  String get settingsFontFuturistic => 'Футуристичный';

  @override
  String get settingsFontTech => 'Технологичный';

  @override
  String get settingsWorkflowFun => 'Рабочий процесс и развлечения';

  @override
  String get settingsConfettiTitle => 'Праздничная анимация успеха (конфетти)';

  @override
  String get settingsConfettiHint =>
      'Показывать небольшую анимацию при успешном сохранении.';

  @override
  String get settingsLargeUiTitle => 'Улучшенная читаемость (крупный шрифт)';

  @override
  String get settingsLargeUiHint =>
      'Увеличивает размер шрифтов и значков для лучшей читаемости.';

  @override
  String get settingsAutoPTitle =>
      'Автоматическое форматирование абзацев (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Автоматически оборачивает обычный текст в абзацы <p> при загрузке модуля в окне проверки. Эквивалентно ручному нажатию кнопки ¶.';

  @override
  String get settingsDatabaseSync => 'Синхронизация базы данных';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Синхронизирует записи БД с JSON-файлами переводов.';

  @override
  String get settingsDatabaseSyncHint =>
      'Синхронизирует внутренние записи базы данных с JSON-файлами переводов на сервере.';

  @override
  String get settingsSyncing => 'Синхронизация...';

  @override
  String get settingsSyncNow => 'Синхронизировать сейчас';

  @override
  String get settingsSyncD11List => 'Синхронизировать список D11';

  @override
  String get settingsUploadBackup => 'Загрузить резервную копию (.zip)';

  @override
  String get settingsSelectZipFile => 'Выбрать ZIP-файл';

  @override
  String get settingsUploading => 'Загрузка...';

  @override
  String get settingsErrorDiagnostics =>
      'Диагностика ошибок и системные журналы';

  @override
  String get settingsLogsCopied => 'Журналы скопированы в буфер обмена! 📋';

  @override
  String get settingsCopyLogs => 'Скопировать журналы';

  @override
  String get settingsLogsRotated => 'Журналы заархивированы и обновлены! 📁';

  @override
  String get settingsRotate => 'Обновить архив';

  @override
  String get settingsClear => 'Очистить';

  @override
  String get settingsLogLimit => 'Лимит журнала: ';

  @override
  String get settingsNoLogs => 'Записей в журнале нет';

  @override
  String get layoutMenu => 'Меню';

  @override
  String get layoutNavAnalytics => 'Аналитика';

  @override
  String get layoutNavReviewQueue => 'Очередь проверки';

  @override
  String get layoutNavGlossary => 'Глоссарий';

  @override
  String get layoutNavCategories => 'Категории';

  @override
  String get layoutNavHelp => 'Справка';

  @override
  String get layoutNavSettings => 'Настройки';

  @override
  String get layoutPhotoBy => 'Фото: ';

  @override
  String get layoutPhotoOn => ', ';

  @override
  String get layoutEditProfile => 'Редактировать профиль';

  @override
  String get layoutLogout => 'Выйти';

  @override
  String get layoutThemeLabel => 'ТЕМА';

  @override
  String get layoutThemePearl => 'Светлая';

  @override
  String get layoutThemeDark => 'Тёмная';

  @override
  String get layoutThemeGlassy => 'Стекло';

  @override
  String get layoutThemeNature => 'Природа';

  @override
  String get layoutThemeLiquid => 'Жидкость';

  @override
  String get layoutThemeStage => 'Сцена';

  @override
  String get layoutTargetLanguage => 'ЦЕЛЕВОЙ ЯЗЫК';

  @override
  String get layoutDeeplUsage => 'ИСПОЛЬЗОВАНИЕ DEEPL';

  @override
  String get layoutUnavailable => 'Недоступно';

  @override
  String get layoutUnlimited => 'без ограничений';

  @override
  String get layoutUsed => 'использовано';

  @override
  String get layoutTranslate => 'Перевод';

  @override
  String get analyticsSubtitle =>
      'Совместимость, объём непереведённого контента и недельные тенденции.';

  @override
  String get analyticsBacklog => 'Объём непереведённого контента';

  @override
  String get analyticsMissing => 'Отсутствуют';

  @override
  String get analyticsStale => 'Устарели';

  @override
  String get analyticsInReview => 'На проверке';

  @override
  String get analyticsReleased => 'Опубликованы';

  @override
  String get analyticsTranslated => 'Переведены';

  @override
  String get analyticsTotalModules => 'Всего модулей';

  @override
  String get analyticsCompatByVersion => 'Совместимость по версиям Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Язык: $lang · опубликовано / на проверке / отсутствует';
  }

  @override
  String get analyticsLoadingCounts => 'Загрузка счётчиков…';

  @override
  String get analyticsWindow => 'Период:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks нед.';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Новые описания проектов по неделям';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Отмечено устаревшим по неделям ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count модулей';
  }

  @override
  String get analyticsReviewShort => 'Проверка';

  @override
  String get analyticsNoDataInWindow => 'За этот период данных нет.';

  @override
  String get analyticsAndMore => '… и другие';

  @override
  String glossaryLoadError(String error) {
    return 'Ошибка загрузки: $error';
  }

  @override
  String get glossaryNewTerm => 'Создать новый термин';

  @override
  String get glossaryEditTerm => 'Изменить термин';

  @override
  String get glossaryFieldSourceWord =>
      'Исходное слово (базовая форма, как оно встречается в тексте)';

  @override
  String get glossaryFieldSourceWordHint => 'например, node';

  @override
  String get glossaryWordForms =>
      'Другие формы слова (множественное число, родительный, дательный падеж и т. д.)';

  @override
  String get glossaryWordFormsHint =>
      'например, content — нажмите Enter, чтобы добавить';

  @override
  String get glossaryAddForm => 'Добавить форму';

  @override
  String get glossaryFieldPreferredWord => 'Предпочтительный перевод';

  @override
  String get glossaryFieldPreferredWordHint => 'например, контент';

  @override
  String get glossaryFieldExplanation =>
      'Пояснение (отображается во всплывающей подсказке)';

  @override
  String get glossaryFieldExplanationHint =>
      'Почему это слово следует переводить иначе?';

  @override
  String get glossaryCreate => 'Создать';

  @override
  String get glossaryRequiredFields =>
      'Исходное слово и предпочтительный перевод обязательны.';

  @override
  String get glossaryCreated => 'Термин создан ✓';

  @override
  String get glossaryUpdated => 'Термин обновлён ✓';

  @override
  String glossaryError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Удалить термин?';

  @override
  String glossaryDeleteBody(String word) {
    return '«$word» будет безвозвратно удалено из глоссария.';
  }

  @override
  String get glossaryDeleted => 'Термин удалён.';

  @override
  String get glossaryTitle => 'Глоссарий переводов';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Язык: $lang · записей: $count';
  }

  @override
  String get glossaryNewShort => 'Создать';

  @override
  String get glossaryCreateTerm => 'Создать термин';

  @override
  String get glossaryInfoBanner =>
      'Слова из этого глоссария выделяются в редакторе проверки. Всплывающая подсказка при наведении объясняет, почему подходит другой перевод.';

  @override
  String get glossaryNoEntries => 'Записей пока нет.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Нажмите «Создать термин», чтобы создать первую запись.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Для этого языка пока нет записей в глоссарии.';

  @override
  String get diffNoChanges => 'Различий в содержимом не обнаружено.';

  @override
  String get diffRemoved => 'Удалено';

  @override
  String get diffAdded => 'Добавлено';

  @override
  String syncBarQuickSync(String count) {
    return 'Быстрая синхронизация: изменено модулей — $count …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Полная синхронизация: $current / $total модулей';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Полная синхронизация: $count модулей …';
  }
}
