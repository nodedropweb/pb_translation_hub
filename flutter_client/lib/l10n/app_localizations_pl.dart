// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Wczytywanie szczegółów projektu...';

  @override
  String editorLoadError(String error) {
    return 'Nie udało się wczytać danych projektu: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Tłumaczenie z Gemini zakończone sukcesem! ✨';

  @override
  String get editorUnknownError => 'Nieznany błąd';

  @override
  String editorGeminiFailed(String detail) {
    return 'Tłumaczenie Gemini nie powiodło się: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Dodaj swój klucz Google AI w profilu użytkownika (nie w ustawieniach administratora).';

  @override
  String get editorGeminiError =>
      'Błąd podczas tłumaczenia Gemini. Sprawdź swój klucz Google AI w profilu.';

  @override
  String get editorDeeplSuccess =>
      'Tłumaczenie z DeepL zakończone sukcesem! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Tłumaczenie DeepL nie powiodło się: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Błąd podczas tłumaczenia DeepL. Upewnij się, że klucz API DeepL jest ustawiony w Twoim profilu.';

  @override
  String get editorDeeplInvalidKey =>
      'Nieprawidłowy klucz API DeepL. Sprawdź go w swoim profilu.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Limit DeepL został wyczerpany. Sprawdź swój plan.';

  @override
  String get editorReviewReset =>
      'Tłumaczenie zresetowane do statusu do sprawdzenia.';

  @override
  String editorResetError(String error) {
    return 'Resetowanie nie powiodło się: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Moduł został przywrócony do listy aktywnych.';

  @override
  String get editorUnignoreError => 'Nie udało się przywrócić modułu.';

  @override
  String get editorSaveSuccess =>
      'Tłumaczenie zapisane — powrót do kolejki weryfikacji.';

  @override
  String editorSaveError(String error) {
    return 'Nie udało się zapisać: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'Brak kolejnych otwartych projektów na liście.';

  @override
  String get editorChangesDiscarded =>
      'Zmiany odrzucone, wczytywanie następnego projektu...';

  @override
  String get editorEnglishSourceApplied =>
      'Zastosowano oryginał angielski — przetłumacz go teraz.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Nie udało się otworzyć adresu URL: $url';
  }

  @override
  String get commonSave => 'Zapisz';

  @override
  String get commonClose => 'Zamknij';

  @override
  String get editorCloseEnglishSource => 'Zamknij źródło angielskie';

  @override
  String get editorShowEnglishSource => 'Pokaż źródło angielskie';

  @override
  String get editorUnignoreShortTooltip => 'Przywróć moduł';

  @override
  String get editorBackToReviewTooltip => 'Ustaw ponownie jako do sprawdzenia';

  @override
  String get editorAndNext => 'i dalej';

  @override
  String get editorBackToDashboard => 'Powrót do panelu';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Tłumaczenie na $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return 'Pozostało: $count';
  }

  @override
  String get editorUnignoreLongTooltip => 'Przywróć moduł do listy aktywnych';

  @override
  String get editorUnignoreLabel => 'Przywróć';

  @override
  String get editorUnpublishTooltip =>
      'Cofnij publikację i ustaw ponownie jako do sprawdzenia';

  @override
  String get editorBackToReview => 'Powrót do sprawdzania';

  @override
  String get editorSaveAndNext => 'Zapisz i dalej';

  @override
  String get editorEnglishSourceHeader => 'ŹRÓDŁO ANGIELSKIE';

  @override
  String get editorStaleTooltip =>
      'Pokaż wyjaśnienie i zastosuj tekst angielski';

  @override
  String get editorStaleDetailsLabel => 'Nieaktualne — szczegóły';

  @override
  String get editorCopyPromptTooltip => 'Skopiuj źródło + prompt tłumaczenia';

  @override
  String get editorPromptCopied => 'Prompt skopiowany do schowka 📋';

  @override
  String get editorShowPreview => 'Pokaż podgląd';

  @override
  String get editorShowHtmlSource => 'Pokaż kod źródłowy HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'PODSUMOWANIE:\n$summary\n\nTREŚĆ:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Podsumowanie:';

  @override
  String get editorDescriptionLabelColon => 'Opis:';

  @override
  String get editorStaleDialogTitle => 'Źródło angielskie zostało zmienione';

  @override
  String get editorStaleExplanation =>
      'Istniejące tłumaczenie opiera się na nieaktualnym oryginalnym tekście angielskim. Od czasu ostatniego tłumaczenia opiekun modułu zmienił tekst angielski na Drupal.org — treść istniejącego tłumaczenia może więc być już niedokładna lub niekompletna.';

  @override
  String get editorStaleTip =>
      'Wskazówka: kliknij „Użyj oryginału angielskiego”, aby wczytać aktualne źródło angielskie bezpośrednio do edytora. Możesz następnie użyć go jako punktu wyjścia do nowego tłumaczenia. Oryginał angielski jest też widoczny w lewym panelu.';

  @override
  String get editorEnglishSourceShort => 'Źródło angielskie';

  @override
  String get editorPreviousTranslation => 'Poprzednie tłumaczenie';

  @override
  String get editorWhatChangedTitle => 'Co się zmieniło?';

  @override
  String get editorShowDiff => 'Pokaż różnice';

  @override
  String get editorUseEnglish => 'Użyj oryginału angielskiego';

  @override
  String get editorStaleBannerText =>
      'Źródło angielskie zostało zmienione — tłumaczenie jest nieaktualne';

  @override
  String get editorDetailsAndApply => 'Szczegóły i zastosuj';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TŁUMACZENIE ($langName)';
  }

  @override
  String get editorTranslatingEllipsis => 'Tłumaczenie...';

  @override
  String get editorShowEditor => 'Pokaż edytor';

  @override
  String get editorModuleTitleLabel => 'Tytuł modułu (angielski)';

  @override
  String get editorSummaryFieldLabel => 'Podsumowanie';

  @override
  String get editorBodyFieldLabel => 'Treść';

  @override
  String get editorHtmlCleaned => 'Kod HTML wyczyszczony';

  @override
  String get editorLivePreviewHeader => 'PODGLĄD NA ŻYWO';

  @override
  String get editorTidyHtmlTooltip => 'Wyczyść kod HTML (usuń artefakty DeepL)';

  @override
  String get editorVisualMode => 'WIZUALNY';

  @override
  String get editorSourceCodeMode => 'ŹRÓDŁO (HTML)';

  @override
  String get commonCancel => 'Anuluj';

  @override
  String get costDialogTitle => 'Szacunkowy koszt (AI)';

  @override
  String get costDialogIntro =>
      'Wybrany moduł zostanie przetłumaczony przy użyciu Google Gemini AI. Oto szacunkowy podział kosztów tej operacji:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Tokeny wejściowe';

  @override
  String get costRowOutputTokens => 'Tokeny wyjściowe (szacunkowo)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars znaków)';
  }

  @override
  String get costRowPriceInput => 'Cena za 1 mln wejściowych';

  @override
  String get costRowPriceOutput => 'Cena za 1 mln wyjściowych';

  @override
  String get costRowTotalEstimate => 'Szacowany koszt całkowity';

  @override
  String get costDialogFootnote =>
      '* Uwaga: to szacunek oparty na aktualnym modelu cenowym pay-as-you-go Google. Rzeczywiste zużycie może się nieznacznie różnić.';

  @override
  String get costDialogStartTranslation => 'Rozpocznij tłumaczenie';

  @override
  String get htmlToolbarInsertLink => 'Wstaw link';

  @override
  String get htmlToolbarLinkTooltip => 'Wstaw link (a)';

  @override
  String get htmlToolbarInsert => 'Wstaw';

  @override
  String get htmlToolbarHeading2 => 'Nagłówek 2';

  @override
  String get htmlToolbarHeading3 => 'Nagłówek 3';

  @override
  String get htmlToolbarBold => 'Pogrubienie (strong)';

  @override
  String get htmlToolbarItalic => 'Kursywa (em)';

  @override
  String get htmlToolbarBulletList => 'Lista punktowana (ul)';

  @override
  String get htmlToolbarNumberedList => 'Lista numerowana (ol)';

  @override
  String get htmlToolbarQuote => 'Cytat (blockquote)';

  @override
  String get screenshotAltsHeader => 'TEKST ALTERNATYWNY ZRZUTÓW EKRANU';

  @override
  String get screenshotAltsIntro =>
      'Wpisz opisowy tekst alternatywny w języku docelowym dla każdego zrzutu ekranu.';

  @override
  String screenshotLabel(int number) {
    return 'Zrzut ekranu $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Podgląd niedostępny';

  @override
  String get screenshotAltHint =>
      'Wpisz tekst alternatywny w języku docelowym…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Przywrócić wszystkie moduły?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Wszystkie zignorowane moduły wrócą na listę aktywnych i będą ponownie dostępne do tłumaczenia.';

  @override
  String get dashUnignoreAllConfirmAction => 'Przywróć wszystkie';

  @override
  String get dashUnignoreAllSuccess =>
      'Wszystkie zignorowane moduły zostały przywrócone.';

  @override
  String get dashUnignoreAllError => 'Nie udało się przywrócić modułów.';

  @override
  String get dashUnignoreAllButton => 'Przywróć wszystkie moduły';

  @override
  String dashSyncStartError(String error) {
    return 'Nie udało się rozpocząć synchronizacji: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'Rozpoczęto szybką aktualizację (7 dni) ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Błąd szybkiej aktualizacji: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Pomyślnie zsynchronizowano: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Nie znaleziono modułu na Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Masowe tłumaczenie AI';

  @override
  String get dashHeaderTitle => 'Opisy projektów';

  @override
  String get dashHeaderSubtitle =>
      'Tłumacz opisy modułów Drupal na język docelowy. Pomóż uczynić ekosystem bardziej dostępnym.';

  @override
  String get dashHeaderSubtitleShort => 'Tłumacz opisy modułów Drupal.';

  @override
  String get dashLastLabel => 'Ostatnio: ';

  @override
  String get dashContinue => 'Kontynuuj';

  @override
  String get dashContinueShort => 'Kontynuuj';

  @override
  String get dashUnignoreAllButtonLong => 'Przywróć wszystkie moduły';

  @override
  String get dashQuickUpdateTooltip => 'Szybka aktualizacja (ostatnie 7 dni)';

  @override
  String get dashFullSyncTooltip =>
      'Pełna synchronizacja bazy danych z Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Wczytaj ręcznie pojedynczy moduł z Drupal.org';

  @override
  String get dashQuickShort => 'Szybka';

  @override
  String get dashModuleShort => 'Moduł';

  @override
  String get dashFoundLabel => 'Znaleziono: ';

  @override
  String get dashModulesSuffix => ' modułów';

  @override
  String dashPerPage(int count) {
    return '$count na stronę';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / strona';
  }

  @override
  String get dashFirstPage => 'Pierwsza strona';

  @override
  String get dashPrevPage => 'Poprzednia strona';

  @override
  String get dashNextPage => 'Następna strona';

  @override
  String get dashLastPage => 'Ostatnia strona';

  @override
  String dashPageOf(int page, int total) {
    return 'Strona $page z $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (np. pathauto)';

  @override
  String get dashAddButton => 'Dodaj';

  @override
  String get dashAddModuleManually => 'Dodaj moduł ręcznie';

  @override
  String get dashAddModuleSubtitle =>
      'Wczytaj bezpośrednio z Drupal.org na podstawie machine name.';

  @override
  String get dashAddModuleShort => 'Dodaj moduł';

  @override
  String get dashNoProjectsFound => 'Nie znaleziono projektów.';

  @override
  String get dashFilterAll => 'Wszystkie projekty';

  @override
  String get dashFilterMissing => 'Brakujące tłumaczenia';

  @override
  String get dashFilterReview => 'Kolejka weryfikacji';

  @override
  String get dashFilterTranslated => 'Przetłumaczone projekty';

  @override
  String get dashFilterReleased => 'Opublikowane projekty';

  @override
  String get dashBulkDialogIntro =>
      'Automatycznie przetłumacz wiele modułów z wybranego filtru za pomocą Google Gemini.';

  @override
  String get dashActiveFilter => 'Aktywny filtr';

  @override
  String get dashModuleCount => 'Liczba modułów';

  @override
  String dashModulesCountItem(int count) {
    return '$count modułów';
  }

  @override
  String get dashPrioritizeD12Title => 'Priorytetyzuj moduły Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Najpierw tłumaczy moduły bez obsługi Drupal 12';

  @override
  String get dashTotalModules => 'Łączna liczba modułów';

  @override
  String get dashInputTokensEst => 'Tokeny wejściowe (szac.)';

  @override
  String get dashOutputTokensEst => 'Tokeny wyjściowe (szac.)';

  @override
  String get dashBulkFootnote =>
      '* Tłumaczenie jest wykonywane w partiach oszczędzających zasoby, aby zapobiec przekroczeniu czasu.';

  @override
  String get dashStartBulkTranslation => 'Rozpocznij masowe tłumaczenie';

  @override
  String dashStaleLoadError(String error) {
    return 'Błąd podczas wczytywania nieaktualnych modułów: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Nie znaleziono nieaktualnych modułów — wszystko jest aktualne! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Przetłumacz ponownie nieaktualne moduły';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Wszystkie tłumaczenia, których źródło angielskie zmieniło się od ostatniego tłumaczenia, zostaną automatycznie ponownie przetłumaczone za pomocą Google Gemini. Nie trzeba otwierać każdego modułu ręcznie.';

  @override
  String get dashOutdatedModules => 'Nieaktualne moduły';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Tłumaczenie zastępuje istniejący tekst i resetuje is_reviewed. Wykonywane w partiach po 4 moduły.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Przetłumacz ponownie wszystkie $count moduły';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Ponowne tłumaczenie nieaktualnych modułów…';

  @override
  String get dashFetchingProjects => 'Pobieranie projektów z serwera…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return 'Przetworzono $processed z $total modułów';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Nie znaleziono projektów do tłumaczenia dla tego filtru.';

  @override
  String get dashStartingTranslation => 'Rozpoczynanie tłumaczenia…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Tłumaczenie modułu $start–$end z $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return 'Ukończono $end z $total modułów.';
  }

  @override
  String get dashTranslationCompleted => 'Tłumaczenie zakończone pomyślnie! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Masowe tłumaczenie $count modułów zakończone sukcesem! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Błąd masowego tłumaczenia: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Wszystkie $count modułów zostało pomyślnie przetłumaczonych ponownie! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count nieaktualnych modułów zostało pomyślnie przetłumaczonych ponownie! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Błąd podczas ponownego tłumaczenia: $error';
  }

  @override
  String get filterAllShort => 'Wszystkie';

  @override
  String get filterMissing => 'Brakujące';

  @override
  String get filterTranslated => 'Przetłumaczone';

  @override
  String get filterReviewQueue => 'Kolejka weryfikacji';

  @override
  String get filterReleased => 'Opublikowane';

  @override
  String get filterOutdated => 'Nieaktualne';

  @override
  String get filterPriority => 'Priorytet';

  @override
  String get filterIgnored => 'Zignorowane';

  @override
  String get commonEdit => 'Edytuj';

  @override
  String get commonReset => 'Resetuj';

  @override
  String get commonRefresh => 'Odśwież';

  @override
  String commonErrorPrefix(String error) {
    return 'Błąd: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Zresetować wszystkie opublikowane tłumaczenia?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Wszystkie tłumaczenia oznaczone jako opublikowane dla $langcode zostaną zresetowane do statusu do sprawdzenia. Tej operacji nie można cofnąć.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return 'Zresetowano $count tłumaczeń do statusu do sprawdzenia.';
  }

  @override
  String get reviewPipelineTitle => 'Proces weryfikacji';

  @override
  String get reviewPipelineSubtitle => 'Ludzka kontrola jakości tłumaczeń AI';

  @override
  String get reviewSearchHint => 'Szukaj projektów...';

  @override
  String get reviewResetPublished => 'Resetuj opublikowane';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Wyniki: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Oczekujące: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'Brak projektów oczekujących na weryfikację.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Wszystkie tłumaczenia zostały już zweryfikowane lub żadne nie istnieje w tym kontekście językowym.';

  @override
  String get reviewNoSummary => 'Brak podsumowania.';

  @override
  String get reviewStartAudit => 'ROZPOCZNIJ AUDYT';

  @override
  String get reviewHtmlSourceShort => 'Kod HTML';

  @override
  String get reviewCopySource => 'Kopiuj źródło';

  @override
  String get reviewModuleDetails => 'Szczegóły modułu';

  @override
  String get reviewOriginalTitle => 'Tytuł oryginalny';

  @override
  String get reviewDrupalOrgProject => 'Projekt Drupal.org';

  @override
  String get reviewSuggestions => 'Sugestie';

  @override
  String get reviewNoSuggestions => 'Brak dostępnych sugestii.';

  @override
  String get reviewApply => 'Zastosuj';

  @override
  String get reviewNoChanges => 'Brak zmian';

  @override
  String get reviewOriginalBeforeCorrection => 'Oryginał (przed korektą)';

  @override
  String get reviewCorrectedCurrentVersion => 'Poprawione (bieżąca wersja)';

  @override
  String get reviewBaseOriginal => 'Baza (oryginał)';

  @override
  String get reviewYourCorrection => 'Twoja korekta';

  @override
  String get reviewChangesVisual => 'Przejrzyj swoje zmiany (wizualnie)';

  @override
  String get commonSkip => 'Pomiń';

  @override
  String get commonIgnore => 'Ignoruj';

  @override
  String get reviewEmptyProjectTitle => 'Pusty projekt';

  @override
  String get reviewEmptyProjectBody =>
      'Ten projekt jest pusty (brak tytułu, podsumowania lub treści) i nie może zostać zatwierdzony. Pomiń go.';

  @override
  String get reviewApprovedSuccess => 'Tłumaczenie zatwierdzone! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Zatwierdzenie „$machine” nie powiodło się — spróbuj ponownie.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Przywrócono. Moduł jest ponownie aktywny!';

  @override
  String get reviewActionFailed => 'Akcja nie powiodła się.';

  @override
  String get reviewIgnoreModuleTitle => 'Zignorować moduł?';

  @override
  String get reviewIgnoreModuleBody =>
      'Ten moduł zostanie trwale ukryty na wszystkich listach. Nie napotkasz go już więcej.';

  @override
  String get reviewModulePermanentlyIgnored => 'Moduł trwale zignorowany.';

  @override
  String get reviewIgnoreFailed => 'Nie udało się zignorować modułu.';

  @override
  String get reviewSuggestionSaved => 'Szkic sugestii zapisany! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Nie udało się zapisać szkicu sugestii.';

  @override
  String get reviewSuggestionDeleted => 'Sugestia usunięta.';

  @override
  String get reviewDeleteFailed => 'Usuwanie nie powiodło się.';

  @override
  String get reviewSuggestionApplied => 'Sugestia zastosowana.';

  @override
  String get reviewPreparingData => 'Przygotowywanie danych do weryfikacji...';

  @override
  String get reviewDirectEdit => 'Edycja bezpośrednia';

  @override
  String get reviewLivePreview => 'Podgląd na żywo';

  @override
  String get reviewCompareWith => 'Porównaj z:';

  @override
  String get reviewProductionVersion => 'Wersja produkcyjna';

  @override
  String get reviewEditorialReview => 'Weryfikacja redakcyjna';

  @override
  String get reviewOpenQueue => 'Otwórz kolejkę weryfikacji';

  @override
  String get reviewCopyPromptShort => 'Kopiuj prompt';

  @override
  String get reviewUnignoreShort => 'Przywróć';

  @override
  String get reviewApproveButton => 'ZATWIERDŹ';

  @override
  String get reviewHideDetails => 'Ukryj szczegóły';

  @override
  String get reviewDetailsAndEnglishSource => 'Szczegóły i źródło angielskie';

  @override
  String reviewPendingCountShort(int count) {
    return 'Oczekujące: $count';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Weryfikacja: $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Porównaj tłumaczenie ze źródłem angielskim';

  @override
  String get reviewTranslationLabel => 'Tłumaczenie';

  @override
  String get reviewComparisonTitle => 'Porównanie';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Skopiuj tekst źródłowy + prompt tłumaczenia do schowka';

  @override
  String get reviewUnignoreCaps => 'PRZYWRÓĆ';

  @override
  String get reviewIgnoreCaps => 'IGNORUJ';

  @override
  String get reviewSkipShortcut => 'POMIŃ (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Weryfikacja redakcyjna';

  @override
  String get reviewUnignoreTablet => 'PRZYWRÓĆ';

  @override
  String get reviewApproveForProduction =>
      'ZATWIERDŹ DO PRODUKCJI (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Bezpośrednie dopracowanie';

  @override
  String get reviewTitleField => 'Tytuł';

  @override
  String get reviewSummaryField => 'Podsumowanie';

  @override
  String get reviewBodyField => 'Treść';

  @override
  String get reviewSaveShortcut => 'ZAPISZ (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Podgląd na żywo (renderowanie)';

  @override
  String get reviewVoiceFemale => 'Kobiecy';

  @override
  String get reviewVoiceMale => 'Męski';

  @override
  String get reviewStopListening => 'Zatrzymaj';

  @override
  String get reviewListen => 'Odsłuchaj';

  @override
  String get reviewAutopTooltip =>
      'Automatyczne formatowanie akapitów (podziały wierszy → <p>)';

  @override
  String get reviewSourceCodeShort => 'ŹRÓDŁO';

  @override
  String get reviewNoParagraphChange =>
      'Tekst już zawiera znaczniki <p> — bez zmian';

  @override
  String get reviewParagraphsFormatted => 'Akapity sformatowane ¶';

  @override
  String get commonRetry => 'Spróbuj ponownie';

  @override
  String categoriesLoadError(String error) {
    return 'Nie udało się wczytać kategorii: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Kategorie zapisane pomyślnie.';

  @override
  String get categoriesSaveFailed => 'Nie udało się zapisać tłumaczeń.';

  @override
  String get categoriesFileEmpty => 'Plik jest pusty.';

  @override
  String get categoriesInvalidJson => 'Nieprawidłowy format JSON.';

  @override
  String get categoriesNoValidUuids =>
      'Nie znaleziono prawidłowych wpisów UUID w pliku.';

  @override
  String categoriesImportSuccess(int count) {
    return 'Zaimportowano $count kategorii z pliku.';
  }

  @override
  String get categoriesTitle => 'Kategorie';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Tłumaczenie dla: $lang';
  }

  @override
  String get categoriesImportJson => 'Importuj JSON';

  @override
  String get categoriesSaving => 'Zapisywanie...';

  @override
  String get categoriesSaveAll => 'Zapisz wszystko';

  @override
  String get categoriesLoading => 'Wczytywanie kategorii...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Tłumaczenie ($code)';
  }

  @override
  String get categoriesNoneFound => 'Nie znaleziono kategorii.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Przetłumacz „$name”...';
  }

  @override
  String get loginPhotoBy => 'Zdjęcie: ';

  @override
  String get loginPhotoOn => ' na ';

  @override
  String get loginPleaseSignIn => 'Zaloguj się';

  @override
  String get loginUsername => 'Nazwa użytkownika';

  @override
  String get loginPassword => 'Hasło';

  @override
  String get loginRememberMe => 'Zapamiętaj mnie';

  @override
  String get loginSignIn => 'ZALOGUJ SIĘ';

  @override
  String get loginNoAccount => 'Nie masz jeszcze konta? ';

  @override
  String get loginRegisterNow => 'Zarejestruj się teraz';

  @override
  String get commonBack => 'Wstecz';

  @override
  String get commonNext => 'Dalej';

  @override
  String get registerFillRequired => 'Wypełnij wszystkie wymagane pola.';

  @override
  String get registerPasswordMismatch => 'Hasła nie są zgodne.';

  @override
  String get registerPasswordTooShort =>
      'Hasło musi mieć co najmniej 8 znaków.';

  @override
  String get registerSelectLanguage => 'Wybierz co najmniej jeden język.';

  @override
  String get registerFailed => 'Rejestracja nie powiodła się.';

  @override
  String get registerHeaderTitle => 'REJESTRACJA';

  @override
  String get registerStepAccount => 'Konto';

  @override
  String get registerStepRole => 'Rola';

  @override
  String get registerStepLanguages => 'Języki';

  @override
  String get registerStepApiKeys => 'Klucze API';

  @override
  String get registerYourAccount => 'Twoje konto';

  @override
  String get registerAvatarOptional => 'Awatar (opcjonalnie)';

  @override
  String get registerUsernameRequired => 'Nazwa użytkownika *';

  @override
  String get registerEmailRequired => 'Adres e-mail *';

  @override
  String get registerPasswordRequired => 'Hasło *';

  @override
  String get registerPasswordRepeat => 'Powtórz hasło *';

  @override
  String get registerYourRole => 'Twoja rola';

  @override
  String get registerRoleExplanation =>
      'Tłumacze mogą tłumaczyć teksty, ale nie mają dostępu do kolejki weryfikacji. Recenzenci sprawdzają i zatwierdzają przetłumaczoną treść.';

  @override
  String get registerRoleTranslator => 'Tłumacz';

  @override
  String get registerRoleTranslatorDesc => 'Twórz i edytuj tłumaczenia.';

  @override
  String get registerRoleReviewer => 'Recenzent';

  @override
  String get registerRoleReviewerDesc => 'Sprawdzaj i zatwierdzaj tłumaczenia.';

  @override
  String get registerTargetLanguages => 'Języki docelowe';

  @override
  String get registerLanguagesExplanation =>
      'Wybierz wszystkie języki, nad którymi chcesz pracować.';

  @override
  String get registerNoLanguagesAvailable => 'Brak dostępnych języków.';

  @override
  String get registerApiKeysTitle => 'Klucze API';

  @override
  String get registerApiKeysExplanation =>
      'Wprowadź własne klucze API. Każdy użytkownik korzysta wyłącznie z własnych kluczy. Możesz je też dodać później w swoim profilu.';

  @override
  String get registerKeysEncryptedNote =>
      'Klucze są przechowywane w formie zaszyfrowanej i nigdy nie są udostępniane innym użytkownikom.';

  @override
  String get registerOptionalSuffix => ' (opcjonalnie)';

  @override
  String get registerSuccessTitle => 'Rejestracja zakończona sukcesem!';

  @override
  String get registerSuccessBody =>
      'Twoje konto zostało utworzone i oczekuje na zatwierdzenie przez administratora. Otrzymasz powiadomienie po aktywacji dostępu.';

  @override
  String get registerGoToLogin => 'Przejdź do logowania';

  @override
  String get registerSubmit => 'Zarejestruj się';

  @override
  String registerPhotoCredit(String name) {
    return 'Zdjęcie: $name na Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil zaktualizowany pomyślnie!';

  @override
  String get profileUpdateFailed => 'Aktualizacja nie powiodła się.';

  @override
  String profileSaveError(String error) {
    return 'Błąd podczas zapisywania: $error';
  }

  @override
  String get profilePasswordMismatch => 'Hasła nie są zgodne!';

  @override
  String get profilePasswordChangeSuccess => 'Hasło zmienione pomyślnie!';

  @override
  String get profilePasswordChangeError =>
      'Błąd podczas zmiany hasła: nieprawidłowe bieżące hasło.';

  @override
  String get profileAvatarUploadSuccess => 'Awatar przesłany pomyślnie!';

  @override
  String get profileAvatarUploadError => 'Błąd podczas przesyłania awatara.';

  @override
  String get profileTitle => 'Profil i ustawienia';

  @override
  String get profileSubtitle =>
      'Zarządzaj profilem użytkownika, kluczami API do tłumaczeń (Gemini i DeepL) oraz bezpieczeństwem konta.';

  @override
  String get profileRoleUser => 'Użytkownik';

  @override
  String get profileNoEmail => 'Nie podano adresu e-mail';

  @override
  String get profileTabDetails => 'Dane profilu';

  @override
  String get profileTabGemini => 'Tłumaczenie AI (Gemini)';

  @override
  String get profileTabDeepl => 'Tłumaczenie DeepL';

  @override
  String get profileTabPassword => 'Zmień hasło';

  @override
  String get profileSectionInfo => 'INFORMACJE O PROFILU';

  @override
  String get profileFieldName => 'Imię i nazwisko';

  @override
  String get profileFieldNameHint => 'Twoje imię i nazwisko';

  @override
  String get profileFieldEmail => 'Adres e-mail';

  @override
  String get profileFieldEmailHint => 'Twój adres e-mail';

  @override
  String get profileSectionGemini => 'USTAWIENIA GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Klucz API Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Wpisz swój klucz API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Niestandardowy prompt AI';

  @override
  String get profileFieldAiPromptHint =>
      'Opcjonalnie: dostosuj prompt systemowy dla Gemini...';

  @override
  String get profileSectionDeepl => 'USTAWIENIA TŁUMACZENIA DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL oferuje wysokiej jakości tłumaczenie maszynowe z zachowaniem znaczników HTML. Konta darmowe (500 000 znaków/miesiąc) otrzymują klucz z sufiksem „:fx”.';

  @override
  String get profileFieldDeeplKey => 'Klucz API DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'np. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Darmowe klucze kończą się na „:fx” i używają api-free.deepl.com. Klucze Pro używają api.deepl.com. Rozróżnienie odbywa się automatycznie.';

  @override
  String get profileSectionSecurity => 'BEZPIECZEŃSTWO KONTA';

  @override
  String get profileFieldCurrentPassword => 'Bieżące hasło';

  @override
  String get profileFieldCurrentPasswordHint => 'Wpisz swoje bieżące hasło';

  @override
  String get profileFieldNewPassword => 'Nowe hasło';

  @override
  String get profileFieldNewPasswordHint => 'Co najmniej 6 znaków';

  @override
  String get profileFieldConfirmPassword => 'Potwierdź nowe hasło';

  @override
  String get profileFieldConfirmPasswordHint => 'Powtórz hasło';

  @override
  String get profileChangePasswordButton => 'Zmień hasło';

  @override
  String get commonDelete => 'Usuń';

  @override
  String get settingsRegistrationUpdated =>
      'Ustawienie rejestracji zaktualizowane';

  @override
  String get settingsUpdateFailed => 'Aktualizacja nie powiodła się.';

  @override
  String get settingsUserApproved => 'Użytkownik zatwierdzony!';

  @override
  String get settingsAccountDeactivated => 'Konto dezaktywowane.';

  @override
  String get settingsUserDeleted => 'Użytkownik usunięty.';

  @override
  String get settingsActionFailed => 'Akcja nie powiodła się.';

  @override
  String get settingsDeleteAccountTitle => 'Usunąć konto?';

  @override
  String get settingsDeactivateAccountTitle => 'Dezaktywować konto?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Konto „$username” zostanie trwale usunięte. Kontynuować?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Konto „$username” zostanie zablokowane. Użytkownik nie będzie mógł się już zalogować, ale konto zostanie zachowane.';
  }

  @override
  String get settingsDeactivate => 'Dezaktywuj';

  @override
  String settingsSyncSuccess(String count) {
    return 'Zsynchronizowano $count tłumaczeń!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Błąd synchronizacji: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return 'Zsynchronizowano $count modułów priorytetowych!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Błąd synchronizacji listy priorytetowej: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Kopia zapasowa zakończona sukcesem: przetworzono $count plików.';
  }

  @override
  String get settingsUploadFailed => 'Przesyłanie nie powiodło się.';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get settingsSystemConfig => 'KONFIGURACJA SYSTEMU';

  @override
  String get settingsRegistration => 'Rejestracja';

  @override
  String get settingsRegistrationHint =>
      'Przełącz widoczność globalnego formularza rejestracji.';

  @override
  String get settingsPendingUsers => 'Oczekujący użytkownicy';

  @override
  String get settingsNoNewRequests => 'Brak nowych żądań.';

  @override
  String get settingsWantsReviewer => 'Chce zostać recenzentem';

  @override
  String get settingsAssignRole => 'Przypisz rolę';

  @override
  String get settingsRoleTranslator => 'Tłumacz';

  @override
  String get settingsRoleReviewer => 'Recenzent';

  @override
  String get settingsApprove => 'Zatwierdź';

  @override
  String get settingsReject => 'Odrzuć';

  @override
  String get settingsActiveUsers => 'Aktywni użytkownicy';

  @override
  String get settingsNoActiveUsers => 'Brak aktywnych użytkowników.';

  @override
  String get settingsDeactivateAccountTooltip => 'Dezaktywuj';

  @override
  String get settingsDeleteAccountAction => 'Usuń konto';

  @override
  String get settingsAppearance => 'Wygląd';

  @override
  String get settingsThemePearl => 'JASNY (PEARL)';

  @override
  String get settingsThemeDark => 'CIEMNY';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Typografia';

  @override
  String get settingsFontHint => 'Zmień rodzinę czcionek interfejsu.';

  @override
  String get settingsFontClean => 'Clean';

  @override
  String get settingsFontFuturistic => 'Futurystyczna';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Przepływ pracy i zabawa';

  @override
  String get settingsConfettiTitle => 'Świętowanie sukcesu (confetti)';

  @override
  String get settingsConfettiHint =>
      'Pokazuje małą animację przy pomyślnym zapisie.';

  @override
  String get settingsLargeUiTitle => 'Lepsza czytelność (duża czcionka)';

  @override
  String get settingsLargeUiHint =>
      'Zwiększa rozmiar czcionek i etykiet dla lepszej czytelności.';

  @override
  String get settingsAutoPTitle =>
      'Automatyczne formatowanie akapitów (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Automatycznie zawija zwykły tekst w akapity <p>, gdy moduł jest wczytywany w ekranie weryfikacji. Odpowiada ręcznemu kliknięciu przycisku ¶.';

  @override
  String get settingsDatabaseSync => 'Synchronizacja bazy danych';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synchronizuje wpisy bazy danych z plikami JSON tłumaczeń.';

  @override
  String get settingsDatabaseSyncHint =>
      'Synchronizuje wewnętrzne wpisy bazy danych z plikami JSON tłumaczeń na serwerze.';

  @override
  String get settingsSyncing => 'Synchronizowanie...';

  @override
  String get settingsSyncNow => 'Synchronizuj teraz';

  @override
  String get settingsSyncD11List => 'Synchronizuj listę D11';

  @override
  String get settingsUploadBackup => 'Prześlij kopię zapasową (.zip)';

  @override
  String get settingsSelectZipFile => 'Wybierz plik ZIP';

  @override
  String get settingsUploading => 'Przesyłanie...';

  @override
  String get settingsErrorDiagnostics => 'Diagnostyka błędów i logi systemowe';

  @override
  String get settingsLogsCopied => 'Logi skopiowane do schowka! 📋';

  @override
  String get settingsCopyLogs => 'Kopiuj logi';

  @override
  String get settingsLogsRotated => 'Logi zarchiwizowane i zrotowane! 📁';

  @override
  String get settingsRotate => 'Rotuj';

  @override
  String get settingsClear => 'Wyczyść';

  @override
  String get settingsLogLimit => 'Limit logów: ';

  @override
  String get settingsNoLogs => 'Brak zarejestrowanych logów';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Analityka';

  @override
  String get layoutNavReviewQueue => 'Kolejka weryfikacji';

  @override
  String get layoutNavGlossary => 'Glosariusz';

  @override
  String get layoutNavCategories => 'Kategorie';

  @override
  String get layoutNavHelp => 'Pomoc';

  @override
  String get layoutNavSettings => 'Ustawienia';

  @override
  String get layoutPhotoBy => 'Zdjęcie: ';

  @override
  String get layoutPhotoOn => ' na ';

  @override
  String get layoutEditProfile => 'Edytuj profil';

  @override
  String get layoutLogout => 'Wyloguj';

  @override
  String get layoutThemeLabel => 'MOTYW';

  @override
  String get layoutThemePearl => 'Jasny';

  @override
  String get layoutThemeDark => 'Ciemny';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'JĘZYK DOCELOWY';

  @override
  String get layoutDeeplUsage => 'ZUŻYCIE DEEPL';

  @override
  String get layoutUnavailable => 'Niedostępne';

  @override
  String get layoutUnlimited => 'nielimitowane';

  @override
  String get layoutUsed => 'wykorzystano';

  @override
  String get layoutTranslate => 'Tłumacz';

  @override
  String get analyticsSubtitle =>
      'Zgodność, zaległości tłumaczeń i tygodniowe trendy.';

  @override
  String get analyticsBacklog => 'Zaległości tłumaczeń';

  @override
  String get analyticsMissing => 'Brakujące';

  @override
  String get analyticsStale => 'Nieaktualne';

  @override
  String get analyticsInReview => 'W trakcie weryfikacji';

  @override
  String get analyticsReleased => 'Opublikowane';

  @override
  String get analyticsTranslated => 'Przetłumaczone';

  @override
  String get analyticsTotalModules => 'Łączna liczba modułów';

  @override
  String get analyticsCompatByVersion => 'Zgodność według wersji Drupala';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Język: $lang · opublikowane / w weryfikacji / brakujące';
  }

  @override
  String get analyticsLoadingCounts => 'Wczytywanie liczników …';

  @override
  String get analyticsWindow => 'Okres:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks tyg.';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nowe opisy projektów na tydzień';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Oznaczone jako nieaktualne na tydzień ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modułów';
  }

  @override
  String get analyticsReviewShort => 'Weryfikacja';

  @override
  String get analyticsNoDataInWindow => 'Brak danych w tym okresie.';

  @override
  String get analyticsAndMore => '… i więcej';

  @override
  String glossaryLoadError(String error) {
    return 'Błąd podczas wczytywania: $error';
  }

  @override
  String get glossaryNewTerm => 'Utwórz nowy termin';

  @override
  String get glossaryEditTerm => 'Edytuj termin';

  @override
  String get glossaryFieldSourceWord =>
      'Słowo źródłowe (forma podstawowa, jak w tekście)';

  @override
  String get glossaryFieldSourceWordHint => 'np. node';

  @override
  String get glossaryWordForms =>
      'Dodatkowe formy słowa (liczba mnoga, dopełniacz, celownik …)';

  @override
  String get glossaryWordFormsHint => 'np. content — naciśnij Enter, aby dodać';

  @override
  String get glossaryAddForm => 'Dodaj formę';

  @override
  String get glossaryFieldPreferredWord => 'Preferowane tłumaczenie';

  @override
  String get glossaryFieldPreferredWordHint => 'np. content';

  @override
  String get glossaryFieldExplanation =>
      'Wyjaśnienie (wyświetlane w podpowiedzi)';

  @override
  String get glossaryFieldExplanationHint =>
      'Dlaczego to słowo powinno być tłumaczone inaczej?';

  @override
  String get glossaryCreate => 'Utwórz';

  @override
  String get glossaryRequiredFields =>
      'Słowo źródłowe i preferowane tłumaczenie są wymagane.';

  @override
  String get glossaryCreated => 'Termin utworzony ✓';

  @override
  String get glossaryUpdated => 'Termin zaktualizowany ✓';

  @override
  String glossaryError(String error) {
    return 'Błąd: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Usunąć termin?';

  @override
  String glossaryDeleteBody(String word) {
    return '„$word” zostanie trwale usunięte z glosariusza.';
  }

  @override
  String get glossaryDeleted => 'Termin usunięty.';

  @override
  String get glossaryTitle => 'Glosariusz tłumaczeń';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Język: $lang · $count wpisów';
  }

  @override
  String get glossaryNewShort => 'Nowy';

  @override
  String get glossaryCreateTerm => 'Utwórz termin';

  @override
  String get glossaryInfoBanner =>
      'Słowa z tego glosariusza są wyróżniane w edytorze weryfikacji. Podpowiedź po najechaniu kursorem wyjaśnia, dlaczego lepiej pasuje inne tłumaczenie.';

  @override
  String get glossaryNoEntries => 'Brak wpisów.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Kliknij „Utwórz termin”, aby utworzyć pierwszy wpis.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Brak wpisów w glosariuszu dla tego języka.';

  @override
  String get diffNoChanges => 'Nie wykryto różnic w treści.';

  @override
  String get diffRemoved => 'Usunięto';

  @override
  String get diffAdded => 'Dodano';

  @override
  String syncBarQuickSync(String count) {
    return 'Szybka synchronizacja: $count zmienionych modułów …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Pełna synchronizacja: $current / $total modułów';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Pełna synchronizacja: $count modułów …';
  }
}
