// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Loading project details...';

  @override
  String editorLoadError(String error) {
    return 'Failed to load project data: $error';
  }

  @override
  String get editorGeminiSuccess => 'Translation with Gemini successful! ✨';

  @override
  String get editorUnknownError => 'Unknown error';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini translation failed: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Please add your Google AI key in your user profile (not in the admin settings).';

  @override
  String get editorGeminiError =>
      'Error during Gemini translation. Please check your Google AI key in your profile.';

  @override
  String get editorDeeplSuccess => 'Translation with DeepL successful! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL translation failed: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Error during DeepL translation. Please make sure your DeepL API key is set in your profile.';

  @override
  String get editorDeeplInvalidKey =>
      'Invalid DeepL API key. Please check it in your profile.';

  @override
  String get editorDeeplQuotaExceeded =>
      'DeepL quota exhausted. Please check your plan.';

  @override
  String get editorReviewReset => 'Translation reset to review status.';

  @override
  String editorResetError(String error) {
    return 'Failed to reset: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Module has been returned to the active list.';

  @override
  String get editorUnignoreError => 'Failed to unignore the module.';

  @override
  String get editorSaveSuccess =>
      'Translation saved — back to the review queue.';

  @override
  String editorSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get editorNoMoreProjects => 'No more open projects in the list.';

  @override
  String get editorChangesDiscarded =>
      'Changes discarded, loading next project...';

  @override
  String get editorEnglishSourceApplied =>
      'English original applied — please translate it now.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Could not open URL: $url';
  }

  @override
  String get commonSave => 'Save';

  @override
  String get commonClose => 'Close';

  @override
  String get editorCloseEnglishSource => 'Close English source';

  @override
  String get editorShowEnglishSource => 'Show English source';

  @override
  String get editorUnignoreShortTooltip => 'Unignore module';

  @override
  String get editorBackToReviewTooltip => 'Set back to review';

  @override
  String get editorAndNext => '& Next';

  @override
  String get editorBackToDashboard => 'Back to dashboard';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Translating to $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count remaining';
  }

  @override
  String get editorUnignoreLongTooltip => 'Return module to active list';

  @override
  String get editorUnignoreLabel => 'Unignore';

  @override
  String get editorUnpublishTooltip =>
      'Revoke publication and set back to review';

  @override
  String get editorBackToReview => 'Back to review';

  @override
  String get editorSaveAndNext => 'Save & Next';

  @override
  String get editorEnglishSourceHeader => 'ENGLISH SOURCE';

  @override
  String get editorStaleTooltip => 'Show explanation & apply English text';

  @override
  String get editorStaleDetailsLabel => 'Outdated — Details';

  @override
  String get editorCopyPromptTooltip => 'Copy source + translation prompt';

  @override
  String get editorPromptCopied => 'Prompt copied to clipboard 📋';

  @override
  String get editorShowPreview => 'Show preview';

  @override
  String get editorShowHtmlSource => 'Show HTML source';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'SUMMARY:\n$summary\n\nBODY:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Summary:';

  @override
  String get editorDescriptionLabelColon => 'Description:';

  @override
  String get editorStaleDialogTitle => 'English source has changed';

  @override
  String get editorStaleExplanation =>
      'The existing translation is based on an outdated English original text. Since the last translation, the module maintainer has changed the English text on Drupal.org — the content of the existing translation may therefore no longer be accurate or complete.';

  @override
  String get editorStaleTip =>
      'Tip: click \"Use English original\" to load the current English source directly into the editor. You can then use it as a starting point for a fresh translation. The English original is also visible in the left-hand panel.';

  @override
  String get editorEnglishSourceShort => 'English source';

  @override
  String get editorPreviousTranslation => 'Previous translation';

  @override
  String get editorWhatChangedTitle => 'What changed?';

  @override
  String get editorShowDiff => 'Show diff';

  @override
  String get editorUseEnglish => 'Use English original';

  @override
  String get editorStaleBannerText =>
      'English source has changed — translation is outdated';

  @override
  String get editorDetailsAndApply => 'Details & apply';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName TRANSLATION';
  }

  @override
  String get editorTranslatingEllipsis => 'Translating...';

  @override
  String get editorShowEditor => 'Show editor';

  @override
  String get editorModuleTitleLabel => 'Module title (English)';

  @override
  String get editorSummaryFieldLabel => 'Summary';

  @override
  String get editorBodyFieldLabel => 'Body';

  @override
  String get editorHtmlCleaned => 'HTML cleaned up';

  @override
  String get editorLivePreviewHeader => 'LIVE PREVIEW';

  @override
  String get editorTidyHtmlTooltip => 'Clean up HTML (remove DeepL artifacts)';

  @override
  String get editorVisualMode => 'VISUAL';

  @override
  String get editorSourceCodeMode => 'SOURCE (HTML)';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get costDialogTitle => 'Cost Estimate (AI)';

  @override
  String get costDialogIntro =>
      'The selected module will be translated with Google Gemini AI. Here is the estimated cost breakdown for this operation:';

  @override
  String get costRowModel => 'Model';

  @override
  String get costRowInputTokens => 'Input tokens';

  @override
  String get costRowOutputTokens => 'Output tokens (estimate)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars characters)';
  }

  @override
  String get costRowPriceInput => 'Price per 1M input';

  @override
  String get costRowPriceOutput => 'Price per 1M output';

  @override
  String get costRowTotalEstimate => 'Estimated total cost';

  @override
  String get costDialogFootnote =>
      '* Note: This is an estimate based on the current Google pay-as-you-go pricing model. Actual usage may vary slightly.';

  @override
  String get costDialogStartTranslation => 'Start translation';

  @override
  String get htmlToolbarInsertLink => 'Insert link';

  @override
  String get htmlToolbarLinkTooltip => 'Insert link (a)';

  @override
  String get htmlToolbarInsert => 'Insert';

  @override
  String get htmlToolbarHeading2 => 'Heading 2';

  @override
  String get htmlToolbarHeading3 => 'Heading 3';

  @override
  String get htmlToolbarBold => 'Bold (strong)';

  @override
  String get htmlToolbarItalic => 'Italic (em)';

  @override
  String get htmlToolbarBulletList => 'Bullet list (ul)';

  @override
  String get htmlToolbarNumberedList => 'Numbered list (ol)';

  @override
  String get htmlToolbarQuote => 'Quote (blockquote)';

  @override
  String get screenshotAltsHeader => 'SCREENSHOT ALT TEXT';

  @override
  String get screenshotAltsIntro =>
      'Enter a descriptive alt text in the target language for each screenshot.';

  @override
  String screenshotLabel(int number) {
    return 'Screenshot $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Preview unavailable';

  @override
  String get screenshotAltHint => 'Enter alt text in the target language…';

  @override
  String get dashUnignoreAllConfirmTitle => 'Unignore all modules?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'All ignored modules will be returned to the active list and will be available for translation again.';

  @override
  String get dashUnignoreAllConfirmAction => 'Unignore all';

  @override
  String get dashUnignoreAllSuccess =>
      'All ignored modules have been unignored.';

  @override
  String get dashUnignoreAllError => 'Failed to unignore modules.';

  @override
  String get dashUnignoreAllButton => 'Unignore all modules';

  @override
  String dashSyncStartError(String error) {
    return 'Failed to start sync: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Quick update (7 days) started ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Quick update error: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Successfully synced: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Module not found on Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'AI Bulk Translation';

  @override
  String get dashHeaderTitle => 'Project Descriptions';

  @override
  String get dashHeaderSubtitle =>
      'Translate Drupal module descriptions into the target language. Help make the ecosystem more accessible.';

  @override
  String get dashHeaderSubtitleShort => 'Translate Drupal module descriptions.';

  @override
  String get dashLastLabel => 'Last: ';

  @override
  String get dashContinue => 'Continue';

  @override
  String get dashContinueShort => 'Continue';

  @override
  String get dashUnignoreAllButtonLong => 'Unignore all modules';

  @override
  String get dashQuickUpdateTooltip => 'Quick update (last 7 days)';

  @override
  String get dashFullSyncTooltip => 'Full database sync from Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Manually load a single module from Drupal.org';

  @override
  String get dashQuickShort => 'Quick';

  @override
  String get dashModuleShort => 'Module';

  @override
  String get dashFoundLabel => 'Found: ';

  @override
  String get dashModulesSuffix => ' modules';

  @override
  String dashPerPage(int count) {
    return '$count per page';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / page';
  }

  @override
  String get dashFirstPage => 'First page';

  @override
  String get dashPrevPage => 'Previous page';

  @override
  String get dashNextPage => 'Next page';

  @override
  String get dashLastPage => 'Last page';

  @override
  String dashPageOf(int page, int total) {
    return 'Page $page of $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (e.g. pathauto)';

  @override
  String get dashAddButton => 'Add';

  @override
  String get dashAddModuleManually => 'Add module manually';

  @override
  String get dashAddModuleSubtitle =>
      'Load directly from Drupal.org by machine name.';

  @override
  String get dashAddModuleShort => 'Add module';

  @override
  String get dashNoProjectsFound => 'No projects found.';

  @override
  String get dashFilterAll => 'All Projects';

  @override
  String get dashFilterMissing => 'Missing Translations';

  @override
  String get dashFilterReview => 'Review Queue';

  @override
  String get dashFilterTranslated => 'Translated Projects';

  @override
  String get dashFilterReleased => 'Released Projects';

  @override
  String get dashBulkDialogIntro =>
      'Automatically translate multiple modules from the selected filter using Google Gemini.';

  @override
  String get dashActiveFilter => 'Active Filter';

  @override
  String get dashModuleCount => 'Module Count';

  @override
  String dashModulesCountItem(int count) {
    return '$count modules';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioritise Drupal 12 modules';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Translates modules without Drupal 12 support first';

  @override
  String get dashTotalModules => 'Total modules';

  @override
  String get dashInputTokensEst => 'Input tokens (est.)';

  @override
  String get dashOutputTokensEst => 'Output tokens (est.)';

  @override
  String get dashBulkFootnote =>
      '* Translation is executed in resource-efficient batches to prevent timeouts.';

  @override
  String get dashStartBulkTranslation => 'Start Bulk Translation';

  @override
  String dashStaleLoadError(String error) {
    return 'Error loading outdated modules: $error';
  }

  @override
  String get dashNoStaleModules =>
      'No outdated modules found — everything is up to date! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Re-translate Outdated Modules';

  @override
  String get dashRetranslateOutdatedIntro =>
      'All translations whose English source has changed since the last translation will be automatically re-translated using Google Gemini. No need to open each module manually.';

  @override
  String get dashOutdatedModules => 'Outdated modules';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* Translation replaces existing text and resets is_reviewed. Executed in batches of 4 modules.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Re-translate all $count modules';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Re-translating outdated modules…';

  @override
  String get dashFetchingProjects => 'Fetching projects from server…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed of $total modules processed';
  }

  @override
  String get dashNoTranslatableProjects =>
      'No translatable projects found for this filter.';

  @override
  String get dashStartingTranslation => 'Starting translation…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Translating module $start–$end of $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end of $total modules completed.';
  }

  @override
  String get dashTranslationCompleted =>
      'Translation completed successfully! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Bulk translation of $count modules successful! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Bulk translation error: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'All $count modules successfully re-translated! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count outdated modules successfully re-translated! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Error during re-translation: $error';
  }

  @override
  String get filterAllShort => 'All';

  @override
  String get filterMissing => 'Missing';

  @override
  String get filterTranslated => 'Translated';

  @override
  String get filterReviewQueue => 'Review Queue';

  @override
  String get filterReleased => 'Released';

  @override
  String get filterOutdated => 'Outdated';

  @override
  String get filterPriority => 'Priority';

  @override
  String get filterIgnored => 'Ignored';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonReset => 'Reset';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String commonErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get reviewResetAllConfirmTitle => 'Reset all published translations?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'All translations marked as published for $langcode will be reset to review state. This cannot be undone.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count translations reset to review state.';
  }

  @override
  String get reviewPipelineTitle => 'Review Pipeline';

  @override
  String get reviewPipelineSubtitle =>
      'Human quality assurance pipeline for AI translations';

  @override
  String get reviewSearchHint => 'Search projects...';

  @override
  String get reviewResetPublished => 'Reset published';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Results: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Pending: $count';
  }

  @override
  String get reviewNoProjectsPending => 'No projects pending review.';

  @override
  String get reviewAllVerifiedOrNone =>
      'All translations have already been verified or none exist in this language context.';

  @override
  String get reviewNoSummary => 'No summary.';

  @override
  String get reviewStartAudit => 'START AUDIT';

  @override
  String get reviewHtmlSourceShort => 'HTML source';

  @override
  String get reviewCopySource => 'Copy source';

  @override
  String get reviewModuleDetails => 'Module Details';

  @override
  String get reviewOriginalTitle => 'Original Title';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org Project';

  @override
  String get reviewSuggestions => 'Suggestions';

  @override
  String get reviewNoSuggestions => 'No suggestions available.';

  @override
  String get reviewApply => 'Apply';

  @override
  String get reviewNoChanges => 'No changes';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (before correction)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corrected (current version)';

  @override
  String get reviewBaseOriginal => 'Base (Original)';

  @override
  String get reviewYourCorrection => 'Your Correction';

  @override
  String get reviewChangesVisual => 'Review Your Changes (Visual)';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonIgnore => 'Ignore';

  @override
  String get reviewEmptyProjectTitle => 'Empty Project';

  @override
  String get reviewEmptyProjectBody =>
      'This project is empty (no title, summary, or body) and cannot be approved. Please skip it.';

  @override
  String get reviewApprovedSuccess => 'Translation approved! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ Approval of \"$machine\" failed — please retry.';
  }

  @override
  String get reviewUnignoredSuccess => 'Unignored. Module is active again!';

  @override
  String get reviewActionFailed => 'Action failed.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignore Module?';

  @override
  String get reviewIgnoreModuleBody =>
      'This module will be permanently hidden from all lists. You will no longer get stuck on it.';

  @override
  String get reviewModulePermanentlyIgnored => 'Module permanently ignored.';

  @override
  String get reviewIgnoreFailed => 'Failed to ignore module.';

  @override
  String get reviewSuggestionSaved => 'Suggestion draft saved! 💾';

  @override
  String get reviewSaveSuggestionFailed => 'Failed to save suggestion draft.';

  @override
  String get reviewSuggestionDeleted => 'Suggestion deleted.';

  @override
  String get reviewDeleteFailed => 'Failed to delete.';

  @override
  String get reviewSuggestionApplied => 'Suggestion applied.';

  @override
  String get reviewPreparingData => 'Preparing review data...';

  @override
  String get reviewDirectEdit => 'Direct Edit';

  @override
  String get reviewLivePreview => 'Live Preview';

  @override
  String get reviewCompareWith => 'Compare with:';

  @override
  String get reviewProductionVersion => 'Production Version';

  @override
  String get reviewEditorialReview => 'Editorial Review';

  @override
  String get reviewOpenQueue => 'Open review queue';

  @override
  String get reviewCopyPromptShort => 'Copy prompt';

  @override
  String get reviewUnignoreShort => 'Unignore';

  @override
  String get reviewApproveButton => 'APPROVE';

  @override
  String get reviewHideDetails => 'Hide details';

  @override
  String get reviewDetailsAndEnglishSource => 'Details & English Source';

  @override
  String reviewPendingCountShort(int count) {
    return '$count pending';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Reviewing $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Compare translation with English source';

  @override
  String get reviewTranslationLabel => 'Translation';

  @override
  String get reviewComparisonTitle => 'Comparison';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copy source text + translation prompt to clipboard';

  @override
  String get reviewUnignoreCaps => 'UNIGNORE';

  @override
  String get reviewIgnoreCaps => 'IGNORE';

  @override
  String get reviewSkipShortcut => 'SKIP (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Editorial Review';

  @override
  String get reviewUnignoreTablet => 'UNIGNORE';

  @override
  String get reviewApproveForProduction =>
      'APPROVE FOR PRODUCTION (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Direct Refinement';

  @override
  String get reviewTitleField => 'Title';

  @override
  String get reviewSummaryField => 'Summary';

  @override
  String get reviewBodyField => 'Body Content';

  @override
  String get reviewSaveShortcut => 'SAVE (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Live Preview (Rendering)';

  @override
  String get reviewVoiceFemale => 'Female';

  @override
  String get reviewVoiceMale => 'Male';

  @override
  String get reviewStopListening => 'Stop';

  @override
  String get reviewListen => 'Listen';

  @override
  String get reviewAutopTooltip => 'Auto-format paragraphs (line breaks → <p>)';

  @override
  String get reviewSourceCodeShort => 'SOURCE';

  @override
  String get reviewNoParagraphChange =>
      'Text already contains <p> tags — no change';

  @override
  String get reviewParagraphsFormatted => 'Paragraphs formatted ¶';

  @override
  String get commonRetry => 'Retry';

  @override
  String categoriesLoadError(String error) {
    return 'Failed to load categories: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categories saved successfully.';

  @override
  String get categoriesSaveFailed => 'Failed to save translations.';

  @override
  String get categoriesFileEmpty => 'File is empty.';

  @override
  String get categoriesInvalidJson => 'Invalid JSON format.';

  @override
  String get categoriesNoValidUuids => 'No valid UUID entries found in file.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categories imported from file.';
  }

  @override
  String get categoriesTitle => 'Categories';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Translating for: $lang';
  }

  @override
  String get categoriesImportJson => 'Import JSON';

  @override
  String get categoriesSaving => 'Saving...';

  @override
  String get categoriesSaveAll => 'Save All';

  @override
  String get categoriesLoading => 'Loading categories...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Translation ($code)';
  }

  @override
  String get categoriesNoneFound => 'No categories found.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Translate \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Photo by ';

  @override
  String get loginPhotoOn => ' on ';

  @override
  String get loginPleaseSignIn => 'Please sign in';

  @override
  String get loginUsername => 'Username';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginRememberMe => 'Remember me';

  @override
  String get loginSignIn => 'SIGN IN';

  @override
  String get loginNoAccount => 'No account yet? ';

  @override
  String get loginRegisterNow => 'Register now';

  @override
  String get commonBack => 'Back';

  @override
  String get commonNext => 'Next';

  @override
  String get registerFillRequired => 'Please fill in all required fields.';

  @override
  String get registerPasswordMismatch => 'Passwords do not match.';

  @override
  String get registerPasswordTooShort =>
      'Password must be at least 8 characters.';

  @override
  String get registerSelectLanguage => 'Please select at least one language.';

  @override
  String get registerFailed => 'Registration failed.';

  @override
  String get registerHeaderTitle => 'REGISTRATION';

  @override
  String get registerStepAccount => 'Account';

  @override
  String get registerStepRole => 'Role';

  @override
  String get registerStepLanguages => 'Languages';

  @override
  String get registerStepApiKeys => 'API Keys';

  @override
  String get registerYourAccount => 'Your Account';

  @override
  String get registerAvatarOptional => 'Avatar (optional)';

  @override
  String get registerUsernameRequired => 'Username *';

  @override
  String get registerEmailRequired => 'Email Address *';

  @override
  String get registerPasswordRequired => 'Password *';

  @override
  String get registerPasswordRepeat => 'Repeat Password *';

  @override
  String get registerYourRole => 'Your Role';

  @override
  String get registerRoleExplanation =>
      'Translators can translate texts but have no access to the review queue. Reviewers check and approve translated content.';

  @override
  String get registerRoleTranslator => 'Translator';

  @override
  String get registerRoleTranslatorDesc => 'Create and edit translations.';

  @override
  String get registerRoleReviewer => 'Reviewer';

  @override
  String get registerRoleReviewerDesc => 'Review and approve translations.';

  @override
  String get registerTargetLanguages => 'Target Languages';

  @override
  String get registerLanguagesExplanation =>
      'Choose all languages you want to work on.';

  @override
  String get registerNoLanguagesAvailable => 'No languages available.';

  @override
  String get registerApiKeysTitle => 'API Keys';

  @override
  String get registerApiKeysExplanation =>
      'Enter your own API keys. Each user exclusively uses their own keys. You can also add these later in your profile.';

  @override
  String get registerKeysEncryptedNote =>
      'Keys are stored encrypted and never shared with other users.';

  @override
  String get registerOptionalSuffix => ' (optional)';

  @override
  String get registerSuccessTitle => 'Registration successful!';

  @override
  String get registerSuccessBody =>
      'Your account has been created and is waiting for approval by an administrator. You will be notified once your access has been activated.';

  @override
  String get registerGoToLogin => 'Go to Sign In';

  @override
  String get registerSubmit => 'Register';

  @override
  String registerPhotoCredit(String name) {
    return 'Photo by $name on Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profile updated successfully!';

  @override
  String get profileUpdateFailed => 'Update failed.';

  @override
  String profileSaveError(String error) {
    return 'Error while saving: $error';
  }

  @override
  String get profilePasswordMismatch => 'Passwords do not match!';

  @override
  String get profilePasswordChangeSuccess => 'Password changed successfully!';

  @override
  String get profilePasswordChangeError =>
      'Error while changing password: incorrect current password.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar uploaded successfully!';

  @override
  String get profileAvatarUploadError => 'Error while uploading avatar.';

  @override
  String get profileTitle => 'Profile & Settings';

  @override
  String get profileSubtitle =>
      'Manage your user profile, your translation APIs (Gemini & DeepL), and your account security.';

  @override
  String get profileRoleUser => 'User';

  @override
  String get profileNoEmail => 'No email address provided';

  @override
  String get profileTabDetails => 'Profile details';

  @override
  String get profileTabGemini => 'AI translation (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL translation';

  @override
  String get profileTabPassword => 'Change password';

  @override
  String get profileSectionInfo => 'PROFILE INFORMATION';

  @override
  String get profileFieldName => 'Name';

  @override
  String get profileFieldNameHint => 'Your full name';

  @override
  String get profileFieldEmail => 'Email address';

  @override
  String get profileFieldEmailHint => 'Your email address';

  @override
  String get profileSectionGemini => 'GEMINI CO-PILOT SETTINGS';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API key';

  @override
  String get profileFieldGeminiKeyHint => 'Enter your gemini-3.1-flash API key';

  @override
  String get profileFieldAiPrompt => 'Custom AI prompt';

  @override
  String get profileFieldAiPromptHint =>
      'Optional: customize the system prompt for Gemini...';

  @override
  String get profileSectionDeepl => 'DEEPL TRANSLATION SETTINGS';

  @override
  String get profileDeeplDescription =>
      'DeepL offers high-quality machine translation with HTML tag preservation. Free accounts (500,000 characters/month) get a key with the suffix \":fx\".';

  @override
  String get profileFieldDeeplKey => 'DeepL API key';

  @override
  String get profileFieldDeeplKeyHint =>
      'e.g. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Free keys end in \":fx\" and use api-free.deepl.com. Pro keys use api.deepl.com. The distinction is made automatically.';

  @override
  String get profileSectionSecurity => 'ACCOUNT SECURITY';

  @override
  String get profileFieldCurrentPassword => 'Current password';

  @override
  String get profileFieldCurrentPasswordHint => 'Enter your current password';

  @override
  String get profileFieldNewPassword => 'New password';

  @override
  String get profileFieldNewPasswordHint => 'At least 6 characters';

  @override
  String get profileFieldConfirmPassword => 'Confirm new password';

  @override
  String get profileFieldConfirmPasswordHint => 'Repeat password';

  @override
  String get profileChangePasswordButton => 'Change password';

  @override
  String get commonDelete => 'Delete';

  @override
  String get settingsRegistrationUpdated => 'Registration setting updated';

  @override
  String get settingsUpdateFailed => 'Update failed.';

  @override
  String get settingsUserApproved => 'User approved!';

  @override
  String get settingsAccountDeactivated => 'Account deactivated.';

  @override
  String get settingsUserDeleted => 'User deleted.';

  @override
  String get settingsActionFailed => 'Action failed.';

  @override
  String get settingsDeleteAccountTitle => 'Delete account?';

  @override
  String get settingsDeactivateAccountTitle => 'Deactivate account?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'The account \"$username\" will be permanently deleted. Continue?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'The account \"$username\" will be locked. The user cannot log in anymore, but the account is kept.';
  }

  @override
  String get settingsDeactivate => 'Deactivate';

  @override
  String settingsSyncSuccess(String count) {
    return '$count translations synced!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Sync error: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count priority modules synced!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Error syncing priority list: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup successful: $count files processed.';
  }

  @override
  String get settingsUploadFailed => 'Upload failed.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSystemConfig => 'SYSTEM CONFIGURATION';

  @override
  String get settingsRegistration => 'Registration';

  @override
  String get settingsRegistrationHint =>
      'Toggle the global registration form visibility.';

  @override
  String get settingsPendingUsers => 'Pending Users';

  @override
  String get settingsNoNewRequests => 'No new requests.';

  @override
  String get settingsWantsReviewer => 'Wants to be Reviewer';

  @override
  String get settingsAssignRole => 'Assign role';

  @override
  String get settingsRoleTranslator => 'Translator';

  @override
  String get settingsRoleReviewer => 'Reviewer';

  @override
  String get settingsApprove => 'Approve';

  @override
  String get settingsReject => 'Reject';

  @override
  String get settingsActiveUsers => 'Active Users';

  @override
  String get settingsNoActiveUsers => 'No active users.';

  @override
  String get settingsDeactivateAccountTooltip => 'Deactivate';

  @override
  String get settingsDeleteAccountAction => 'Delete account';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemePearl => 'LIGHT (PEARL)';

  @override
  String get settingsThemeDark => 'DARK';

  @override
  String get settingsThemeGlassy => 'GLASSY';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUID';

  @override
  String get settingsThemeStage => 'STAGE';

  @override
  String get settingsTypography => 'Typography';

  @override
  String get settingsFontHint => 'Modify interface font family.';

  @override
  String get settingsFontClean => 'Clean';

  @override
  String get settingsFontFuturistic => 'Futuristic';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Workflow & Fun';

  @override
  String get settingsConfettiTitle => 'Success Celebration (Confetti)';

  @override
  String get settingsConfettiHint =>
      'Shows a small animation when successfully saving.';

  @override
  String get settingsLargeUiTitle => 'Enhanced Readability (Large Font)';

  @override
  String get settingsLargeUiHint =>
      'Increases the fonts and badges sizing for readability.';

  @override
  String get settingsAutoPTitle => 'Automatic Paragraph Formatting (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Automatically wraps plain text in <p> paragraphs when a module is loaded in the Review Screen. Equivalent to clicking the ¶ button manually.';

  @override
  String get settingsDatabaseSync => 'Database Sync';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synchronizes db entries with json translation files.';

  @override
  String get settingsDatabaseSyncHint =>
      'Syncs internal database entries with translation JSONs on the server.';

  @override
  String get settingsSyncing => 'Syncing...';

  @override
  String get settingsSyncNow => 'Sync Now';

  @override
  String get settingsSyncD11List => 'Sync D11 List';

  @override
  String get settingsUploadBackup => 'Upload Backup (.zip)';

  @override
  String get settingsSelectZipFile => 'Select ZIP File';

  @override
  String get settingsUploading => 'Uploading...';

  @override
  String get settingsErrorDiagnostics => 'Error Diagnostics & System Logs';

  @override
  String get settingsLogsCopied => 'Logs copied to clipboard! 📋';

  @override
  String get settingsCopyLogs => 'Copy Logs';

  @override
  String get settingsLogsRotated => 'Logs archived and rotated! 📁';

  @override
  String get settingsRotate => 'Rotate';

  @override
  String get settingsClear => 'Clear';

  @override
  String get settingsLogLimit => 'Log Limit: ';

  @override
  String get settingsNoLogs => 'No logs recorded';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Analytics';

  @override
  String get layoutNavReviewQueue => 'Review Queue';

  @override
  String get layoutNavGlossary => 'Glossary';

  @override
  String get layoutNavCategories => 'Categories';

  @override
  String get layoutNavHelp => 'Help';

  @override
  String get layoutNavSettings => 'Settings';

  @override
  String get layoutPhotoBy => 'Photo by ';

  @override
  String get layoutPhotoOn => ' on ';

  @override
  String get layoutEditProfile => 'Edit Profile';

  @override
  String get layoutLogout => 'Logout';

  @override
  String get layoutThemeLabel => 'THEME';

  @override
  String get layoutThemePearl => 'Light';

  @override
  String get layoutThemeDark => 'Dark';

  @override
  String get layoutThemeGlassy => 'Glassy';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquid';

  @override
  String get layoutThemeStage => 'Stage';

  @override
  String get layoutTargetLanguage => 'TARGET LANGUAGE';

  @override
  String get layoutDeeplUsage => 'DEEPL USAGE';

  @override
  String get layoutUnavailable => 'Unavailable';

  @override
  String get layoutUnlimited => 'unlimited';

  @override
  String get layoutUsed => 'used';

  @override
  String get layoutTranslate => 'Translate';

  @override
  String get analyticsSubtitle =>
      'Compatibility, translation backlog and weekly trends.';

  @override
  String get analyticsBacklog => 'Translation backlog';

  @override
  String get analyticsMissing => 'Missing';

  @override
  String get analyticsStale => 'Stale';

  @override
  String get analyticsInReview => 'In review';

  @override
  String get analyticsReleased => 'Released';

  @override
  String get analyticsTranslated => 'Translated';

  @override
  String get analyticsTotalModules => 'Total modules';

  @override
  String get analyticsCompatByVersion => 'Compatibility by Drupal version';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Language: $lang · released / in review / missing';
  }

  @override
  String get analyticsLoadingCounts => 'Loading counts …';

  @override
  String get analyticsWindow => 'Window:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks weeks';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'New project descriptions per week';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marked outdated per week ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modules';
  }

  @override
  String get analyticsReviewShort => 'Review';

  @override
  String get analyticsNoDataInWindow => 'No data in window.';

  @override
  String get analyticsAndMore => '… and more';

  @override
  String glossaryLoadError(String error) {
    return 'Error loading: $error';
  }

  @override
  String get glossaryNewTerm => 'Create new term';

  @override
  String get glossaryEditTerm => 'Edit term';

  @override
  String get glossaryFieldSourceWord =>
      'Source word (base form, as it appears in text)';

  @override
  String get glossaryFieldSourceWordHint => 'e.g. node';

  @override
  String get glossaryWordForms =>
      'Additional word forms (plural, genitive, dative …)';

  @override
  String get glossaryWordFormsHint => 'e.g. content — press Enter to add';

  @override
  String get glossaryAddForm => 'Add form';

  @override
  String get glossaryFieldPreferredWord => 'Preferred translation';

  @override
  String get glossaryFieldPreferredWordHint => 'e.g. content';

  @override
  String get glossaryFieldExplanation => 'Explanation (shown in the tooltip)';

  @override
  String get glossaryFieldExplanationHint =>
      'Why should this word be translated differently?';

  @override
  String get glossaryCreate => 'Create';

  @override
  String get glossaryRequiredFields =>
      'Source word and preferred translation are required.';

  @override
  String get glossaryCreated => 'Term created ✓';

  @override
  String get glossaryUpdated => 'Term updated ✓';

  @override
  String glossaryError(String error) {
    return 'Error: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Delete term?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" will be permanently removed from the glossary.';
  }

  @override
  String get glossaryDeleted => 'Term deleted.';

  @override
  String get glossaryTitle => 'Translation Glossary';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Language: $lang · $count entries';
  }

  @override
  String get glossaryNewShort => 'New';

  @override
  String get glossaryCreateTerm => 'Create term';

  @override
  String get glossaryInfoBanner =>
      'Words from this glossary are highlighted in the Review Editor. A tooltip explains on hover why a different translation fits better.';

  @override
  String get glossaryNoEntries => 'No entries yet.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Click \"Create term\" to create the first entry.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'No glossary entries for this language yet.';

  @override
  String get diffNoChanges => 'No content differences detected.';

  @override
  String get diffRemoved => 'Removed';

  @override
  String get diffAdded => 'Added';

  @override
  String syncBarQuickSync(String count) {
    return 'Quick Sync: $count changed modules …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Full Sync: $current / $total modules';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Full Sync: $count modules …';
  }
}
