// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'プロジェクトの詳細を読み込んでいます...';

  @override
  String editorLoadError(String error) {
    return 'プロジェクトデータの読み込みに失敗しました：$error';
  }

  @override
  String get editorGeminiSuccess => 'Gemini による翻訳が完了しました！✨';

  @override
  String get editorUnknownError => '不明なエラー';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini の翻訳に失敗しました：$detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'ユーザープロフィールで Google AI キーを追加してください（管理設定ではありません）。';

  @override
  String get editorGeminiError =>
      'Gemini 翻訳中にエラーが発生しました。プロフィールの Google AI キーを確認してください。';

  @override
  String get editorDeeplSuccess => 'DeepL による翻訳が完了しました！🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL の翻訳に失敗しました：$detail';
  }

  @override
  String get editorDeeplGenericError =>
      'DeepL 翻訳中にエラーが発生しました。プロフィールで DeepL API キーが設定されていることを確認してください。';

  @override
  String get editorDeeplInvalidKey => 'DeepL API キーが無効です。プロフィールで確認してください。';

  @override
  String get editorDeeplQuotaExceeded => 'DeepL の利用枠を使い切りました。プランをご確認ください。';

  @override
  String get editorReviewReset => '翻訳をレビュー状態にリセットしました。';

  @override
  String editorResetError(String error) {
    return 'リセットに失敗しました：$error';
  }

  @override
  String get editorUnignoreSuccess => 'モジュールがアクティブリストに戻りました。';

  @override
  String get editorUnignoreError => 'モジュールの復元に失敗しました。';

  @override
  String get editorSaveSuccess => '翻訳を保存しました — レビューキューに戻ります。';

  @override
  String editorSaveError(String error) {
    return '保存に失敗しました：$error';
  }

  @override
  String get editorNoMoreProjects => 'リストに他の未処理プロジェクトはありません。';

  @override
  String get editorChangesDiscarded => '変更を破棄しました。次のプロジェクトを読み込んでいます...';

  @override
  String get editorEnglishSourceApplied => '英語の原文を適用しました — 今すぐ翻訳してください。';

  @override
  String editorCannotOpenUrl(String url) {
    return 'URL を開けませんでした：$url';
  }

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '閉じる';

  @override
  String get editorCloseEnglishSource => '英語原文を閉じる';

  @override
  String get editorShowEnglishSource => '英語原文を表示';

  @override
  String get editorUnignoreShortTooltip => 'モジュールを復元';

  @override
  String get editorBackToReviewTooltip => 'レビューに戻す';

  @override
  String get editorAndNext => '＆次へ';

  @override
  String get editorBackToDashboard => 'ダッシュボードに戻る';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return '$langName（$langCode）へ翻訳中';
  }

  @override
  String editorRemainingCount(int count) {
    return '残り $count 件';
  }

  @override
  String get editorUnignoreLongTooltip => 'モジュールをアクティブリストに戻す';

  @override
  String get editorUnignoreLabel => '復元';

  @override
  String get editorUnpublishTooltip => '公開を取り消してレビューに戻す';

  @override
  String get editorBackToReview => 'レビューに戻る';

  @override
  String get editorSaveAndNext => '保存して次へ';

  @override
  String get editorEnglishSourceHeader => '英語原文';

  @override
  String get editorStaleTooltip => '説明を表示して英語テキストを適用';

  @override
  String get editorStaleDetailsLabel => '更新が必要 — 詳細';

  @override
  String get editorCopyPromptTooltip => '原文＋翻訳プロンプトをコピー';

  @override
  String get editorPromptCopied => 'プロンプトをクリップボードにコピーしました 📋';

  @override
  String get editorShowPreview => 'プレビューを表示';

  @override
  String get editorShowHtmlSource => 'HTML ソースを表示';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return '概要：\n$summary\n\n本文：\n$body';
  }

  @override
  String get editorSummaryLabelColon => '概要：';

  @override
  String get editorDescriptionLabelColon => '説明：';

  @override
  String get editorStaleDialogTitle => '英語原文が変更されました';

  @override
  String get editorStaleExplanation =>
      '既存の翻訳は、更新前の古い英語原文に基づいています。前回の翻訳以降、モジュールのメンテナーが Drupal.org 上の英語テキストを変更したため、既存の翻訳内容が正確でない、または不完全である可能性があります。';

  @override
  String get editorStaleTip =>
      'ヒント：「英語原文を使用」をクリックすると、現在の英語原文を直接エディターに読み込めます。これを新しい翻訳の出発点として利用できます。英語原文は左側パネルにも表示されます。';

  @override
  String get editorEnglishSourceShort => '英語原文';

  @override
  String get editorPreviousTranslation => '以前の翻訳';

  @override
  String get editorWhatChangedTitle => '何が変わったか？';

  @override
  String get editorShowDiff => '差分を表示';

  @override
  String get editorUseEnglish => '英語原文を使用';

  @override
  String get editorStaleBannerText => '英語原文が変更されました — 翻訳が古くなっています';

  @override
  String get editorDetailsAndApply => '詳細と適用';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName 翻訳';
  }

  @override
  String get editorTranslatingEllipsis => '翻訳中...';

  @override
  String get editorShowEditor => 'エディターを表示';

  @override
  String get editorModuleTitleLabel => 'モジュールタイトル（英語）';

  @override
  String get editorSummaryFieldLabel => '概要';

  @override
  String get editorBodyFieldLabel => '本文';

  @override
  String get editorHtmlCleaned => 'HTML を整理しました';

  @override
  String get editorLivePreviewHeader => 'ライブプレビュー';

  @override
  String get editorTidyHtmlTooltip => 'HTML を整理する（DeepL の余分なマークアップを除去）';

  @override
  String get editorVisualMode => 'ビジュアル';

  @override
  String get editorSourceCodeMode => 'ソース（HTML）';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get costDialogTitle => '費用見積もり（AI）';

  @override
  String get costDialogIntro =>
      '選択したモジュールは Google Gemini AI で翻訳されます。この操作の費用見積もりの内訳は次のとおりです：';

  @override
  String get costRowModel => 'モデル';

  @override
  String get costRowInputTokens => '入力トークン数';

  @override
  String get costRowOutputTokens => '出力トークン数（見積もり）';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens（約 $chars 文字）';
  }

  @override
  String get costRowPriceInput => '入力 100 万トークンあたりの価格';

  @override
  String get costRowPriceOutput => '出力 100 万トークンあたりの価格';

  @override
  String get costRowTotalEstimate => '見積もり合計費用';

  @override
  String get costDialogFootnote =>
      '※ 注：これは現在の Google の従量課金モデルに基づく見積もりです。実際の使用量は多少異なる場合があります。';

  @override
  String get costDialogStartTranslation => '翻訳を開始';

  @override
  String get htmlToolbarInsertLink => 'リンクを挿入';

  @override
  String get htmlToolbarLinkTooltip => 'リンクを挿入（a）';

  @override
  String get htmlToolbarInsert => '挿入';

  @override
  String get htmlToolbarHeading2 => '見出し 2';

  @override
  String get htmlToolbarHeading3 => '見出し 3';

  @override
  String get htmlToolbarBold => '太字（strong）';

  @override
  String get htmlToolbarItalic => '斜体（em）';

  @override
  String get htmlToolbarBulletList => '箇条書きリスト（ul）';

  @override
  String get htmlToolbarNumberedList => '番号付きリスト（ol）';

  @override
  String get htmlToolbarQuote => '引用（blockquote）';

  @override
  String get screenshotAltsHeader => 'スクリーンショットの代替テキスト';

  @override
  String get screenshotAltsIntro =>
      '各スクリーンショットについて、対象言語でわかりやすい代替テキストを入力してください。';

  @override
  String screenshotLabel(int number) {
    return 'スクリーンショット $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'プレビューは利用できません';

  @override
  String get screenshotAltHint => '対象言語で代替テキストを入力してください…';

  @override
  String get dashUnignoreAllConfirmTitle => '無視したすべてのモジュールを復元しますか？';

  @override
  String get dashUnignoreAllConfirmBody =>
      '無視されたすべてのモジュールがアクティブリストに戻り、再び翻訳可能になります。';

  @override
  String get dashUnignoreAllConfirmAction => 'すべて復元';

  @override
  String get dashUnignoreAllSuccess => '無視されていたすべてのモジュールを復元しました。';

  @override
  String get dashUnignoreAllError => 'モジュールの復元に失敗しました。';

  @override
  String get dashUnignoreAllButton => '無視したすべてのモジュールを復元';

  @override
  String dashSyncStartError(String error) {
    return '同期の開始に失敗しました：$error';
  }

  @override
  String get dashQuickUpdateStarted => 'クイック更新（7日間）を開始しました ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'クイック更新エラー：$error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return '同期に成功しました：$name';
  }

  @override
  String get dashManualSyncNotFound => 'Drupal.org でモジュールが見つかりません。';

  @override
  String get dashAiBulkTranslation => 'AI 一括翻訳';

  @override
  String get dashHeaderTitle => 'プロジェクトの説明';

  @override
  String get dashHeaderSubtitle =>
      'Drupal モジュールの説明を対象言語に翻訳しましょう。エコシステムをより利用しやすくするお手伝いをしてください。';

  @override
  String get dashHeaderSubtitleShort => 'Drupal モジュールの説明を翻訳します。';

  @override
  String get dashLastLabel => '最終：';

  @override
  String get dashContinue => '続ける';

  @override
  String get dashContinueShort => '続ける';

  @override
  String get dashUnignoreAllButtonLong => '無視したすべてのモジュールを復元';

  @override
  String get dashQuickUpdateTooltip => 'クイック更新（過去7日間）';

  @override
  String get dashFullSyncTooltip => 'Drupal.org からデータベースを完全同期';

  @override
  String get dashManualLoadTooltip => 'Drupal.org から単一モジュールを手動で読み込む';

  @override
  String get dashQuickShort => 'クイック';

  @override
  String get dashModuleShort => 'モジュール';

  @override
  String get dashFoundLabel => '検出：';

  @override
  String get dashModulesSuffix => ' 件のモジュール';

  @override
  String dashPerPage(int count) {
    return '$count 件／ページ';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count 件／ページ';
  }

  @override
  String get dashFirstPage => '最初のページ';

  @override
  String get dashPrevPage => '前のページ';

  @override
  String get dashNextPage => '次のページ';

  @override
  String get dashLastPage => '最後のページ';

  @override
  String dashPageOf(int page, int total) {
    return '$total ページ中 $page ページ目';
  }

  @override
  String get dashMachineNameHint => 'machine_name（例：pathauto）';

  @override
  String get dashAddButton => '追加';

  @override
  String get dashAddModuleManually => 'モジュールを手動で追加';

  @override
  String get dashAddModuleSubtitle =>
      'machine name を指定して Drupal.org から直接読み込みます。';

  @override
  String get dashAddModuleShort => 'モジュールを追加';

  @override
  String get dashNoProjectsFound => 'プロジェクトが見つかりませんでした。';

  @override
  String get dashFilterAll => 'すべてのプロジェクト';

  @override
  String get dashFilterMissing => '未翻訳';

  @override
  String get dashFilterReview => 'レビューキュー';

  @override
  String get dashFilterTranslated => '翻訳済みプロジェクト';

  @override
  String get dashFilterReleased => '公開済みプロジェクト';

  @override
  String get dashBulkDialogIntro =>
      '選択したフィルターの複数モジュールを Google Gemini で自動翻訳します。';

  @override
  String get dashActiveFilter => '有効なフィルター';

  @override
  String get dashModuleCount => 'モジュール数';

  @override
  String dashModulesCountItem(int count) {
    return '$count 件のモジュール';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12 モジュールを優先';

  @override
  String get dashPrioritizeD12Subtitle => 'Drupal 12 未対応のモジュールを優先的に翻訳します';

  @override
  String get dashTotalModules => 'モジュール総数';

  @override
  String get dashInputTokensEst => '入力トークン数（見積もり）';

  @override
  String get dashOutputTokensEst => '出力トークン数（見積もり）';

  @override
  String get dashBulkFootnote => '※ タイムアウトを防ぐため、翻訳はリソース効率の良いバッチ単位で実行されます。';

  @override
  String get dashStartBulkTranslation => '一括翻訳を開始';

  @override
  String dashStaleLoadError(String error) {
    return '古くなったモジュールの読み込み中にエラーが発生しました：$error';
  }

  @override
  String get dashNoStaleModules => '古くなったモジュールは見つかりませんでした — すべて最新です！✨';

  @override
  String get dashRetranslateOutdatedTitle => '古くなったモジュールを再翻訳';

  @override
  String get dashRetranslateOutdatedIntro =>
      '前回の翻訳以降に英語原文が変更された翻訳はすべて、Google Gemini によって自動的に再翻訳されます。モジュールを1つずつ手動で開く必要はありません。';

  @override
  String get dashOutdatedModules => '古くなったモジュール';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '※ 翻訳は既存のテキストを置き換え、is_reviewed をリセットします。4 モジュールずつのバッチで実行されます。';

  @override
  String dashRetranslateAllCount(int count) {
    return '$count 件のモジュールをすべて再翻訳';
  }

  @override
  String get dashRetranslatingOutdatedTitle => '古くなったモジュールを再翻訳しています…';

  @override
  String get dashFetchingProjects => 'サーバーからプロジェクトを取得しています…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$total 件中 $processed 件のモジュールを処理済み';
  }

  @override
  String get dashNoTranslatableProjects => 'このフィルターに該当する翻訳可能なプロジェクトが見つかりません。';

  @override
  String get dashStartingTranslation => '翻訳を開始しています…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'モジュール $start〜$end / $total を翻訳中 …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$total 件中 $end 件のモジュールが完了しました。';
  }

  @override
  String get dashTranslationCompleted => '翻訳が正常に完了しました！✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '$count 件のモジュールの一括翻訳に成功しました！✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return '一括翻訳エラー：$error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return '$count 件すべてのモジュールを正常に再翻訳しました！✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count 件の古いモジュールを正常に再翻訳しました！✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return '再翻訳中にエラーが発生しました：$error';
  }

  @override
  String get filterAllShort => 'すべて';

  @override
  String get filterMissing => '未翻訳';

  @override
  String get filterTranslated => '翻訳済み';

  @override
  String get filterReviewQueue => 'レビューキュー';

  @override
  String get filterReleased => '公開済み';

  @override
  String get filterOutdated => '更新が必要';

  @override
  String get filterPriority => '優先';

  @override
  String get filterIgnored => '無視済み';

  @override
  String get commonEdit => '編集';

  @override
  String get commonReset => 'リセット';

  @override
  String get commonRefresh => '更新';

  @override
  String commonErrorPrefix(String error) {
    return 'エラー：$error';
  }

  @override
  String get reviewResetAllConfirmTitle => '公開済みの翻訳をすべてリセットしますか？';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return '$langcode で公開済みとしてマークされたすべての翻訳がレビュー状態にリセットされます。この操作は元に戻せません。';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count 件の翻訳をレビュー状態にリセットしました。';
  }

  @override
  String get reviewPipelineTitle => 'レビューパイプライン';

  @override
  String get reviewPipelineSubtitle => 'AI 翻訳のための人間による品質保証パイプライン';

  @override
  String get reviewSearchHint => 'プロジェクトを検索...';

  @override
  String get reviewResetPublished => '公開済みをリセット';

  @override
  String reviewResultsCount(int count, int total) {
    return '結果：$count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return '保留中：$count';
  }

  @override
  String get reviewNoProjectsPending => 'レビュー待ちのプロジェクトはありません。';

  @override
  String get reviewAllVerifiedOrNone =>
      'すべての翻訳がすでに検証済みか、この言語コンテキストには翻訳が存在しません。';

  @override
  String get reviewNoSummary => '概要がありません。';

  @override
  String get reviewStartAudit => '監査を開始';

  @override
  String get reviewHtmlSourceShort => 'HTML ソース';

  @override
  String get reviewCopySource => '原文をコピー';

  @override
  String get reviewModuleDetails => 'モジュールの詳細';

  @override
  String get reviewOriginalTitle => '原題';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org プロジェクト';

  @override
  String get reviewSuggestions => '提案';

  @override
  String get reviewNoSuggestions => '利用可能な提案はありません。';

  @override
  String get reviewApply => '適用';

  @override
  String get reviewNoChanges => '変更なし';

  @override
  String get reviewOriginalBeforeCorrection => 'オリジナル（修正前）';

  @override
  String get reviewCorrectedCurrentVersion => '修正済み（現在のバージョン）';

  @override
  String get reviewBaseOriginal => 'ベース（オリジナル）';

  @override
  String get reviewYourCorrection => 'あなたの修正';

  @override
  String get reviewChangesVisual => '変更内容を確認（ビジュアル）';

  @override
  String get commonSkip => 'スキップ';

  @override
  String get commonIgnore => '無視';

  @override
  String get reviewEmptyProjectTitle => '空のプロジェクト';

  @override
  String get reviewEmptyProjectBody =>
      'このプロジェクトは空です（タイトル、概要、本文のいずれもありません）。承認できないため、スキップしてください。';

  @override
  String get reviewApprovedSuccess => '翻訳が承認されました！🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️「$machine」の承認に失敗しました — もう一度お試しください。';
  }

  @override
  String get reviewUnignoredSuccess => '復元しました。モジュールが再びアクティブになりました！';

  @override
  String get reviewActionFailed => '操作に失敗しました。';

  @override
  String get reviewIgnoreModuleTitle => 'このモジュールを無視しますか？';

  @override
  String get reviewIgnoreModuleBody =>
      'このモジュールはすべてのリストから完全に非表示になります。もうこのモジュールで詰まることはありません。';

  @override
  String get reviewModulePermanentlyIgnored => 'モジュールを完全に無視しました。';

  @override
  String get reviewIgnoreFailed => 'モジュールの無視に失敗しました。';

  @override
  String get reviewSuggestionSaved => '提案の下書きを保存しました！💾';

  @override
  String get reviewSaveSuggestionFailed => '提案の下書きの保存に失敗しました。';

  @override
  String get reviewSuggestionDeleted => '提案を削除しました。';

  @override
  String get reviewDeleteFailed => '削除に失敗しました。';

  @override
  String get reviewSuggestionApplied => '提案を適用しました。';

  @override
  String get reviewPreparingData => 'レビューデータを準備しています...';

  @override
  String get reviewDirectEdit => '直接編集';

  @override
  String get reviewLivePreview => 'ライブプレビュー';

  @override
  String get reviewCompareWith => '比較対象：';

  @override
  String get reviewProductionVersion => '本番バージョン';

  @override
  String get reviewEditorialReview => '編集レビュー';

  @override
  String get reviewOpenQueue => 'レビューキューを開く';

  @override
  String get reviewCopyPromptShort => 'プロンプトをコピー';

  @override
  String get reviewUnignoreShort => '復元';

  @override
  String get reviewApproveButton => '承認';

  @override
  String get reviewHideDetails => '詳細を非表示';

  @override
  String get reviewDetailsAndEnglishSource => '詳細と英語原文';

  @override
  String reviewPendingCountShort(int count) {
    return '$count 件保留中';
  }

  @override
  String reviewReviewingModule(String name) {
    return '$name をレビュー中';
  }

  @override
  String get reviewCompareTranslationTooltip => '翻訳を英語原文と比較';

  @override
  String get reviewTranslationLabel => '翻訳';

  @override
  String get reviewComparisonTitle => '比較';

  @override
  String get reviewCopyPromptLongTooltip => '原文＋翻訳プロンプトをクリップボードにコピー';

  @override
  String get reviewUnignoreCaps => '復元';

  @override
  String get reviewIgnoreCaps => '無視';

  @override
  String get reviewSkipShortcut => 'スキップ（Ctrl+→）';

  @override
  String get reviewEditorialReviewShort => '編集レビュー';

  @override
  String get reviewUnignoreTablet => '復元';

  @override
  String get reviewApproveForProduction => '本番へ承認（Ctrl+Enter）';

  @override
  String get reviewDirectRefinement => '直接ブラッシュアップ';

  @override
  String get reviewTitleField => 'タイトル';

  @override
  String get reviewSummaryField => '概要';

  @override
  String get reviewBodyField => '本文コンテンツ';

  @override
  String get reviewSaveShortcut => '保存（Ctrl+Alt+S）';

  @override
  String get reviewLivePreviewRendering => 'ライブプレビュー（描画中）';

  @override
  String get reviewVoiceFemale => '女性の声';

  @override
  String get reviewVoiceMale => '男性の声';

  @override
  String get reviewStopListening => '停止';

  @override
  String get reviewListen => '読み上げ';

  @override
  String get reviewAutopTooltip => '段落を自動フォーマット（改行 → <p>）';

  @override
  String get reviewSourceCodeShort => 'ソース';

  @override
  String get reviewNoParagraphChange => 'テキストにはすでに <p> タグが含まれています — 変更なし';

  @override
  String get reviewParagraphsFormatted => '段落をフォーマットしました ¶';

  @override
  String get commonRetry => '再試行';

  @override
  String categoriesLoadError(String error) {
    return 'カテゴリーの読み込みに失敗しました：$error';
  }

  @override
  String get categoriesSaveSuccess => 'カテゴリーを保存しました。';

  @override
  String get categoriesSaveFailed => '翻訳の保存に失敗しました。';

  @override
  String get categoriesFileEmpty => 'ファイルが空です。';

  @override
  String get categoriesInvalidJson => 'JSON 形式が無効です。';

  @override
  String get categoriesNoValidUuids => 'ファイル内に有効な UUID エントリが見つかりませんでした。';

  @override
  String categoriesImportSuccess(int count) {
    return 'ファイルから $count 件のカテゴリーをインポートしました。';
  }

  @override
  String get categoriesTitle => 'カテゴリー';

  @override
  String categoriesTranslatingFor(String lang) {
    return '翻訳対象言語：$lang';
  }

  @override
  String get categoriesImportJson => 'JSON をインポート';

  @override
  String get categoriesSaving => '保存中...';

  @override
  String get categoriesSaveAll => 'すべて保存';

  @override
  String get categoriesLoading => 'カテゴリーを読み込んでいます...';

  @override
  String categoriesTranslationColumn(String code) {
    return '翻訳（$code）';
  }

  @override
  String get categoriesNoneFound => 'カテゴリーが見つかりませんでした。';

  @override
  String categoriesTranslateHint(String name) {
    return '「$name」を翻訳...';
  }

  @override
  String get loginPhotoBy => '撮影：';

  @override
  String get loginPhotoOn => '／掲載元：';

  @override
  String get loginPleaseSignIn => 'サインインしてください';

  @override
  String get loginUsername => 'ユーザー名';

  @override
  String get loginPassword => 'パスワード';

  @override
  String get loginRememberMe => 'ログイン状態を保持する';

  @override
  String get loginSignIn => 'サインイン';

  @override
  String get loginNoAccount => 'アカウントをお持ちでないですか？ ';

  @override
  String get loginRegisterNow => '今すぐ登録';

  @override
  String get commonBack => '戻る';

  @override
  String get commonNext => '次へ';

  @override
  String get registerFillRequired => '必須項目をすべて入力してください。';

  @override
  String get registerPasswordMismatch => 'パスワードが一致しません。';

  @override
  String get registerPasswordTooShort => 'パスワードは8文字以上にしてください。';

  @override
  String get registerSelectLanguage => '少なくとも1つの言語を選択してください。';

  @override
  String get registerFailed => '登録に失敗しました。';

  @override
  String get registerHeaderTitle => '新規登録';

  @override
  String get registerStepAccount => 'アカウント';

  @override
  String get registerStepRole => '役割';

  @override
  String get registerStepLanguages => '言語';

  @override
  String get registerStepApiKeys => 'API キー';

  @override
  String get registerYourAccount => 'あなたのアカウント';

  @override
  String get registerAvatarOptional => 'アバター（任意）';

  @override
  String get registerUsernameRequired => 'ユーザー名 *';

  @override
  String get registerEmailRequired => 'メールアドレス *';

  @override
  String get registerPasswordRequired => 'パスワード *';

  @override
  String get registerPasswordRepeat => 'パスワード（確認）*';

  @override
  String get registerYourRole => 'あなたの役割';

  @override
  String get registerRoleExplanation =>
      '翻訳者はテキストを翻訳できますが、レビューキューにはアクセスできません。レビュー担当者は翻訳されたコンテンツを確認・承認します。';

  @override
  String get registerRoleTranslator => '翻訳者';

  @override
  String get registerRoleTranslatorDesc => '翻訳の作成と編集を行います。';

  @override
  String get registerRoleReviewer => 'レビュー担当者';

  @override
  String get registerRoleReviewerDesc => '翻訳をレビューし承認します。';

  @override
  String get registerTargetLanguages => '対象言語';

  @override
  String get registerLanguagesExplanation => '作業したいすべての言語を選択してください。';

  @override
  String get registerNoLanguagesAvailable => '利用可能な言語がありません。';

  @override
  String get registerApiKeysTitle => 'API キー';

  @override
  String get registerApiKeysExplanation =>
      'ご自身の API キーを入力してください。各ユーザーは自分自身のキーのみを使用します。プロフィールで後から追加することもできます。';

  @override
  String get registerKeysEncryptedNote => 'キーは暗号化して保存され、他のユーザーと共有されることはありません。';

  @override
  String get registerOptionalSuffix => '（任意）';

  @override
  String get registerSuccessTitle => '登録が完了しました！';

  @override
  String get registerSuccessBody => 'アカウントが作成され、管理者の承認待ちです。アクセスが有効になると通知が届きます。';

  @override
  String get registerGoToLogin => 'サインインへ進む';

  @override
  String get registerSubmit => '登録';

  @override
  String registerPhotoCredit(String name) {
    return '写真：$name（Unsplash）';
  }

  @override
  String get profileUpdateSuccess => 'プロフィールを更新しました！';

  @override
  String get profileUpdateFailed => '更新に失敗しました。';

  @override
  String profileSaveError(String error) {
    return '保存中にエラーが発生しました：$error';
  }

  @override
  String get profilePasswordMismatch => 'パスワードが一致しません！';

  @override
  String get profilePasswordChangeSuccess => 'パスワードを変更しました！';

  @override
  String get profilePasswordChangeError =>
      'パスワードの変更中にエラーが発生しました：現在のパスワードが正しくありません。';

  @override
  String get profileAvatarUploadSuccess => 'アバターをアップロードしました！';

  @override
  String get profileAvatarUploadError => 'アバターのアップロード中にエラーが発生しました。';

  @override
  String get profileTitle => 'プロフィールと設定';

  @override
  String get profileSubtitle =>
      'ユーザープロフィール、翻訳 API（Gemini と DeepL）、アカウントのセキュリティを管理します。';

  @override
  String get profileRoleUser => 'ユーザー';

  @override
  String get profileNoEmail => 'メールアドレスが登録されていません';

  @override
  String get profileTabDetails => 'プロフィール詳細';

  @override
  String get profileTabGemini => 'AI 翻訳（Gemini）';

  @override
  String get profileTabDeepl => 'DeepL 翻訳';

  @override
  String get profileTabPassword => 'パスワードを変更';

  @override
  String get profileSectionInfo => 'プロフィール情報';

  @override
  String get profileFieldName => '名前';

  @override
  String get profileFieldNameHint => 'フルネーム';

  @override
  String get profileFieldEmail => 'メールアドレス';

  @override
  String get profileFieldEmailHint => 'あなたのメールアドレス';

  @override
  String get profileSectionGemini => 'GEMINI コパイロット設定';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API キー';

  @override
  String get profileFieldGeminiKeyHint => 'gemini-3.1-flash の API キーを入力してください';

  @override
  String get profileFieldAiPrompt => 'カスタム AI プロンプト';

  @override
  String get profileFieldAiPromptHint => '任意：Gemini のシステムプロンプトをカスタマイズ...';

  @override
  String get profileSectionDeepl => 'DEEPL 翻訳設定';

  @override
  String get profileDeeplDescription =>
      'DeepL は HTML タグを保持したまま、高品質な機械翻訳を提供します。無料アカウント（月50万文字）には末尾が「:fx」のキーが発行されます。';

  @override
  String get profileFieldDeeplKey => 'DeepL API キー';

  @override
  String get profileFieldDeeplKeyHint =>
      '例：xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      '無料キーは末尾が「:fx」で api-free.deepl.com を使用します。Pro キーは api.deepl.com を使用します。この判別は自動的に行われます。';

  @override
  String get profileSectionSecurity => 'アカウントのセキュリティ';

  @override
  String get profileFieldCurrentPassword => '現在のパスワード';

  @override
  String get profileFieldCurrentPasswordHint => '現在のパスワードを入力してください';

  @override
  String get profileFieldNewPassword => '新しいパスワード';

  @override
  String get profileFieldNewPasswordHint => '6文字以上';

  @override
  String get profileFieldConfirmPassword => '新しいパスワード（確認）';

  @override
  String get profileFieldConfirmPasswordHint => 'パスワードを再入力してください';

  @override
  String get profileChangePasswordButton => 'パスワードを変更';

  @override
  String get commonDelete => '削除';

  @override
  String get settingsRegistrationUpdated => '登録設定を更新しました';

  @override
  String get settingsUpdateFailed => '更新に失敗しました。';

  @override
  String get settingsUserApproved => 'ユーザーを承認しました！';

  @override
  String get settingsAccountDeactivated => 'アカウントを無効化しました。';

  @override
  String get settingsUserDeleted => 'ユーザーを削除しました。';

  @override
  String get settingsActionFailed => '操作に失敗しました。';

  @override
  String get settingsDeleteAccountTitle => 'アカウントを削除しますか？';

  @override
  String get settingsDeactivateAccountTitle => 'アカウントを無効化しますか？';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'アカウント「$username」は完全に削除されます。続けますか？';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'アカウント「$username」はロックされます。ユーザーはログインできなくなりますが、アカウント自体は保持されます。';
  }

  @override
  String get settingsDeactivate => '無効化';

  @override
  String settingsSyncSuccess(String count) {
    return '$count 件の翻訳を同期しました！';
  }

  @override
  String settingsSyncError(String error) {
    return '同期エラー：$error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count 件の優先モジュールを同期しました！';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return '優先リストの同期中にエラーが発生しました：$error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'バックアップ成功：$count 件のファイルを処理しました。';
  }

  @override
  String get settingsUploadFailed => 'アップロードに失敗しました。';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsSystemConfig => 'システム設定';

  @override
  String get settingsRegistration => '登録';

  @override
  String get settingsRegistrationHint => '登録フォームの表示をグローバルに切り替えます。';

  @override
  String get settingsPendingUsers => '承認待ちユーザー';

  @override
  String get settingsNoNewRequests => '新しいリクエストはありません。';

  @override
  String get settingsWantsReviewer => 'レビュー担当者を希望';

  @override
  String get settingsAssignRole => '役割を割り当て';

  @override
  String get settingsRoleTranslator => '翻訳者';

  @override
  String get settingsRoleReviewer => 'レビュー担当者';

  @override
  String get settingsApprove => '承認';

  @override
  String get settingsReject => '却下';

  @override
  String get settingsActiveUsers => 'アクティブなユーザー';

  @override
  String get settingsNoActiveUsers => 'アクティブなユーザーはいません。';

  @override
  String get settingsDeactivateAccountTooltip => '無効化';

  @override
  String get settingsDeleteAccountAction => 'アカウントを削除';

  @override
  String get settingsAppearance => '外観';

  @override
  String get settingsThemePearl => 'ライト（パール）';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsThemeGlassy => 'グラス';

  @override
  String get settingsThemeNature => 'ネイチャー';

  @override
  String get settingsThemeLiquid => 'リキッド';

  @override
  String get settingsThemeStage => 'ステージ';

  @override
  String get settingsTypography => 'タイポグラフィ';

  @override
  String get settingsFontHint => 'インターフェースのフォントを変更します。';

  @override
  String get settingsFontClean => 'クリーン';

  @override
  String get settingsFontFuturistic => 'フューチャリスティック';

  @override
  String get settingsFontTech => 'テック';

  @override
  String get settingsWorkflowFun => 'ワークフロー＆お楽しみ';

  @override
  String get settingsConfettiTitle => '成功セレブレーション（紙吹雪）';

  @override
  String get settingsConfettiHint => '保存に成功すると小さなアニメーションを表示します。';

  @override
  String get settingsLargeUiTitle => '視認性向上（大きな文字）';

  @override
  String get settingsLargeUiHint => '文字とバッジのサイズを大きくして視認性を高めます。';

  @override
  String get settingsAutoPTitle => '段落の自動整形（¶ Auto-P）';

  @override
  String get settingsAutoPHint =>
      'レビュー画面でモジュールを読み込む際、プレーンテキストを自動的に <p> 段落で囲みます。¶ ボタンを手動でクリックするのと同じ効果です。';

  @override
  String get settingsDatabaseSync => 'データベース同期';

  @override
  String get settingsDatabaseSyncTooltip => 'データベースのエントリを JSON 翻訳ファイルと同期します。';

  @override
  String get settingsDatabaseSyncHint => 'サーバー上の内部データベースエントリを翻訳 JSON と同期します。';

  @override
  String get settingsSyncing => '同期中...';

  @override
  String get settingsSyncNow => '今すぐ同期';

  @override
  String get settingsSyncD11List => 'D11 リストを同期';

  @override
  String get settingsUploadBackup => 'バックアップをアップロード（.zip）';

  @override
  String get settingsSelectZipFile => 'ZIP ファイルを選択';

  @override
  String get settingsUploading => 'アップロード中...';

  @override
  String get settingsErrorDiagnostics => 'エラー診断とシステムログ';

  @override
  String get settingsLogsCopied => 'ログをクリップボードにコピーしました！📋';

  @override
  String get settingsCopyLogs => 'ログをコピー';

  @override
  String get settingsLogsRotated => 'ログをアーカイブしてローテーションしました！📁';

  @override
  String get settingsRotate => 'ローテーション';

  @override
  String get settingsClear => 'クリア';

  @override
  String get settingsLogLimit => 'ログ上限：';

  @override
  String get settingsNoLogs => '記録されたログはありません';

  @override
  String get layoutMenu => 'メニュー';

  @override
  String get layoutNavAnalytics => '分析';

  @override
  String get layoutNavReviewQueue => 'レビューキュー';

  @override
  String get layoutNavGlossary => '用語集';

  @override
  String get layoutNavCategories => 'カテゴリー';

  @override
  String get layoutNavHelp => 'ヘルプ';

  @override
  String get layoutNavSettings => '設定';

  @override
  String get layoutPhotoBy => '撮影：';

  @override
  String get layoutPhotoOn => '／掲載元：';

  @override
  String get layoutEditProfile => 'プロフィールを編集';

  @override
  String get layoutLogout => 'ログアウト';

  @override
  String get layoutThemeLabel => 'テーマ';

  @override
  String get layoutThemePearl => 'ライト';

  @override
  String get layoutThemeDark => 'ダーク';

  @override
  String get layoutThemeGlassy => 'グラス';

  @override
  String get layoutThemeNature => 'ネイチャー';

  @override
  String get layoutThemeLiquid => 'リキッド';

  @override
  String get layoutThemeStage => 'ステージ';

  @override
  String get layoutTargetLanguage => '対象言語';

  @override
  String get layoutDeeplUsage => 'DEEPL 使用状況';

  @override
  String get layoutUnavailable => '利用不可';

  @override
  String get layoutUnlimited => '無制限';

  @override
  String get layoutUsed => '使用済み';

  @override
  String get layoutTranslate => '翻訳';

  @override
  String get analyticsSubtitle => '互換性、翻訳の未処理件数、週次の推移。';

  @override
  String get analyticsBacklog => '翻訳の未処理件数';

  @override
  String get analyticsMissing => '未翻訳';

  @override
  String get analyticsStale => '更新が必要';

  @override
  String get analyticsInReview => 'レビュー中';

  @override
  String get analyticsReleased => '公開済み';

  @override
  String get analyticsTranslated => '翻訳済み';

  @override
  String get analyticsTotalModules => 'モジュール総数';

  @override
  String get analyticsCompatByVersion => 'Drupal バージョン別の互換性';

  @override
  String analyticsLanguageLegend(String lang) {
    return '言語：$lang ・公開済み／レビュー中／未翻訳';
  }

  @override
  String get analyticsLoadingCounts => '件数を読み込んでいます…';

  @override
  String get analyticsWindow => '期間：';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks 週間';
  }

  @override
  String get analyticsNewDescriptionsPerWeek => '週ごとの新規プロジェクト説明';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return '週ごとに更新要とマークされた件数（$lang）';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count 件のモジュール';
  }

  @override
  String get analyticsReviewShort => 'レビュー';

  @override
  String get analyticsNoDataInWindow => 'この期間のデータはありません。';

  @override
  String get analyticsAndMore => '……ほか';

  @override
  String glossaryLoadError(String error) {
    return '読み込みエラー：$error';
  }

  @override
  String get glossaryNewTerm => '新しい用語を作成';

  @override
  String get glossaryEditTerm => '用語を編集';

  @override
  String get glossaryFieldSourceWord => '原語（テキスト中に現れる基本形）';

  @override
  String get glossaryFieldSourceWordHint => '例：node（ノード）';

  @override
  String get glossaryWordForms => 'その他の語形（複数形、属格、与格など）';

  @override
  String get glossaryWordFormsHint => '例：content（コンテンツ）— Enter キーで追加';

  @override
  String get glossaryAddForm => '語形を追加';

  @override
  String get glossaryFieldPreferredWord => '推奨訳語';

  @override
  String get glossaryFieldPreferredWordHint => '例：コンテンツ';

  @override
  String get glossaryFieldExplanation => '説明（ツールチップに表示されます）';

  @override
  String get glossaryFieldExplanationHint => 'なぜこの語は別の訳語にするべきですか？';

  @override
  String get glossaryCreate => '作成';

  @override
  String get glossaryRequiredFields => '原語と推奨訳語は必須です。';

  @override
  String get glossaryCreated => '用語を作成しました ✓';

  @override
  String get glossaryUpdated => '用語を更新しました ✓';

  @override
  String glossaryError(String error) {
    return 'エラー：$error';
  }

  @override
  String get glossaryDeleteTitle => '用語を削除しますか？';

  @override
  String glossaryDeleteBody(String word) {
    return '「$word」は用語集から完全に削除されます。';
  }

  @override
  String get glossaryDeleted => '用語を削除しました。';

  @override
  String get glossaryTitle => '翻訳用語集';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return '言語：$lang ・$count 件';
  }

  @override
  String get glossaryNewShort => '新規';

  @override
  String get glossaryCreateTerm => '用語を作成';

  @override
  String get glossaryInfoBanner =>
      'この用語集に登録された単語はレビューエディターでハイライト表示されます。ホバー時のツールチップで、なぜ別の訳語が適しているかを説明します。';

  @override
  String get glossaryNoEntries => 'まだ登録がありません。';

  @override
  String get glossaryNoEntriesEditorHint => '「用語を作成」をクリックして最初のエントリを作成してください。';

  @override
  String get glossaryNoEntriesForLanguage => 'この言語にはまだ用語集の登録がありません。';

  @override
  String get diffNoChanges => '内容に差分は検出されませんでした。';

  @override
  String get diffRemoved => '削除';

  @override
  String get diffAdded => '追加';

  @override
  String syncBarQuickSync(String count) {
    return 'クイック同期：変更されたモジュール $count 件 …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return '完全同期：$current / $total モジュール';
  }

  @override
  String syncBarFullSync(String count) {
    return '完全同期：$count モジュール …';
  }
}
