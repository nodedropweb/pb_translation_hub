// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'PB 翻译中心';

  @override
  String get editorLoadingProject => '正在加载项目详情...';

  @override
  String editorLoadError(String error) {
    return '加载项目数据失败：$error';
  }

  @override
  String get editorGeminiSuccess => '已使用 Gemini 成功翻译！✨';

  @override
  String get editorUnknownError => '未知错误';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini 翻译失败：$detail';
  }

  @override
  String get editorGeminiKeyMissing => '请在您的用户资料中添加 Google AI 密钥（不是在管理设置中）。';

  @override
  String get editorGeminiError => 'Gemini 翻译出错。请检查您资料中的 Google AI 密钥。';

  @override
  String get editorDeeplSuccess => '已使用 DeepL 成功翻译！🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL 翻译失败：$detail';
  }

  @override
  String get editorDeeplGenericError => 'DeepL 翻译出错。请确保您的资料中已设置 DeepL API 密钥。';

  @override
  String get editorDeeplInvalidKey => 'DeepL API 密钥无效。请在您的资料中检查。';

  @override
  String get editorDeeplQuotaExceeded => 'DeepL 配额已用尽。请检查您的套餐。';

  @override
  String get editorReviewReset => '翻译已重置为审核状态。';

  @override
  String editorResetError(String error) {
    return '重置失败：$error';
  }

  @override
  String get editorUnignoreSuccess => '模块已恢复到活动列表。';

  @override
  String get editorUnignoreError => '恢复模块失败。';

  @override
  String get editorSaveSuccess => '翻译已保存 — 返回审核队列。';

  @override
  String editorSaveError(String error) {
    return '保存失败：$error';
  }

  @override
  String get editorNoMoreProjects => '列表中没有更多待处理的项目了。';

  @override
  String get editorChangesDiscarded => '已放弃更改，正在加载下一个项目...';

  @override
  String get editorEnglishSourceApplied => '已应用英文原文 — 请现在翻译。';

  @override
  String editorCannotOpenUrl(String url) {
    return '无法打开网址：$url';
  }

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '关闭';

  @override
  String get editorCloseEnglishSource => '关闭英文原文';

  @override
  String get editorShowEnglishSource => '显示英文原文';

  @override
  String get editorUnignoreShortTooltip => '恢复模块';

  @override
  String get editorBackToReviewTooltip => '重新设为审核状态';

  @override
  String get editorAndNext => '并转到下一个';

  @override
  String get editorBackToDashboard => '返回仪表盘';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return '正在翻译为 $langName（$langCode）';
  }

  @override
  String editorRemainingCount(int count) {
    return '剩余 $count 个';
  }

  @override
  String get editorUnignoreLongTooltip => '将模块恢复到活动列表';

  @override
  String get editorUnignoreLabel => '恢复';

  @override
  String get editorUnpublishTooltip => '撤销发布并重新设为审核状态';

  @override
  String get editorBackToReview => '返回审核';

  @override
  String get editorSaveAndNext => '保存并转到下一个';

  @override
  String get editorEnglishSourceHeader => '英文原文';

  @override
  String get editorStaleTooltip => '显示说明并应用英文文本';

  @override
  String get editorStaleDetailsLabel => '已过时 — 详情';

  @override
  String get editorCopyPromptTooltip => '复制原文和翻译提示语';

  @override
  String get editorPromptCopied => '提示语已复制到剪贴板 📋';

  @override
  String get editorShowPreview => '显示预览';

  @override
  String get editorShowHtmlSource => '显示 HTML 源代码';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return '摘要：\n$summary\n\n正文：\n$body';
  }

  @override
  String get editorSummaryLabelColon => '摘要：';

  @override
  String get editorDescriptionLabelColon => '描述：';

  @override
  String get editorStaleDialogTitle => '英文原文已更改';

  @override
  String get editorStaleExplanation =>
      '现有翻译基于已过时的英文原文。自上次翻译以来，模块维护者已在 Drupal.org 上更改了英文文本 — 因此现有翻译的内容可能不再准确或完整。';

  @override
  String get editorStaleTip =>
      '提示：点击“使用英文原文”可将当前英文原文直接加载到编辑器中。然后您可以以此为起点重新翻译。英文原文也会显示在左侧面板中。';

  @override
  String get editorEnglishSourceShort => '英文原文';

  @override
  String get editorPreviousTranslation => '先前的翻译';

  @override
  String get editorWhatChangedTitle => '发生了什么变化？';

  @override
  String get editorShowDiff => '显示差异';

  @override
  String get editorUseEnglish => '使用英文原文';

  @override
  String get editorStaleBannerText => '英文原文已更改 — 翻译已过时';

  @override
  String get editorDetailsAndApply => '详情与应用';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName 翻译';
  }

  @override
  String get editorTranslatingEllipsis => '翻译中...';

  @override
  String get editorShowEditor => '显示编辑器';

  @override
  String get editorModuleTitleLabel => '模块标题（英文）';

  @override
  String get editorSummaryFieldLabel => '摘要';

  @override
  String get editorBodyFieldLabel => '正文';

  @override
  String get editorHtmlCleaned => 'HTML 已清理';

  @override
  String get editorLivePreviewHeader => '实时预览';

  @override
  String get editorTidyHtmlTooltip => '清理 HTML（移除 DeepL 产生的多余标记）';

  @override
  String get editorVisualMode => '可视化';

  @override
  String get editorSourceCodeMode => '源代码（HTML）';

  @override
  String get commonCancel => '取消';

  @override
  String get costDialogTitle => '费用估算（AI）';

  @override
  String get costDialogIntro => '所选模块将使用 Google Gemini AI 进行翻译。以下是此操作的预估费用明细：';

  @override
  String get costRowModel => '模型';

  @override
  String get costRowInputTokens => '输入令牌数';

  @override
  String get costRowOutputTokens => '输出令牌数（估算）';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens（约 $chars 个字符）';
  }

  @override
  String get costRowPriceInput => '每百万输入令牌价格';

  @override
  String get costRowPriceOutput => '每百万输出令牌价格';

  @override
  String get costRowTotalEstimate => '预估总费用';

  @override
  String get costDialogFootnote => '* 注意：此为基于当前 Google 按量计费模式的估算，实际用量可能略有差异。';

  @override
  String get costDialogStartTranslation => '开始翻译';

  @override
  String get htmlToolbarInsertLink => '插入链接';

  @override
  String get htmlToolbarLinkTooltip => '插入链接（a）';

  @override
  String get htmlToolbarInsert => '插入';

  @override
  String get htmlToolbarHeading2 => '二级标题';

  @override
  String get htmlToolbarHeading3 => '三级标题';

  @override
  String get htmlToolbarBold => '加粗（strong）';

  @override
  String get htmlToolbarItalic => '斜体（em）';

  @override
  String get htmlToolbarBulletList => '项目符号列表（ul）';

  @override
  String get htmlToolbarNumberedList => '编号列表（ol）';

  @override
  String get htmlToolbarQuote => '引用（blockquote）';

  @override
  String get screenshotAltsHeader => '截图替代文本';

  @override
  String get screenshotAltsIntro => '请为每张截图输入目标语言的描述性替代文本。';

  @override
  String screenshotLabel(int number) {
    return '截图 $number';
  }

  @override
  String get screenshotPreviewUnavailable => '预览不可用';

  @override
  String get screenshotAltHint => '请输入目标语言的替代文本……';

  @override
  String get dashUnignoreAllConfirmTitle => '恢复所有已忽略的模块？';

  @override
  String get dashUnignoreAllConfirmBody => '所有被忽略的模块都将恢复到活动列表，并可再次进行翻译。';

  @override
  String get dashUnignoreAllConfirmAction => '全部恢复';

  @override
  String get dashUnignoreAllSuccess => '所有被忽略的模块均已恢复。';

  @override
  String get dashUnignoreAllError => '恢复模块失败。';

  @override
  String get dashUnignoreAllButton => '恢复所有已忽略的模块';

  @override
  String dashSyncStartError(String error) {
    return '启动同步失败：$error';
  }

  @override
  String get dashQuickUpdateStarted => '快速更新（7 天）已开始 ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return '快速更新出错：$error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return '同步成功：$name';
  }

  @override
  String get dashManualSyncNotFound => '在 Drupal.org 上未找到该模块。';

  @override
  String get dashAiBulkTranslation => 'AI 批量翻译';

  @override
  String get dashHeaderTitle => '项目描述';

  @override
  String get dashHeaderSubtitle => '将 Drupal 模块描述翻译成目标语言，帮助让生态系统更易于访问。';

  @override
  String get dashHeaderSubtitleShort => '翻译 Drupal 模块描述。';

  @override
  String get dashLastLabel => '最近：';

  @override
  String get dashContinue => '继续';

  @override
  String get dashContinueShort => '继续';

  @override
  String get dashUnignoreAllButtonLong => '恢复所有已忽略的模块';

  @override
  String get dashQuickUpdateTooltip => '快速更新（最近 7 天）';

  @override
  String get dashFullSyncTooltip => '从 Drupal.org 完整同步数据库';

  @override
  String get dashManualLoadTooltip => '从 Drupal.org 手动加载单个模块';

  @override
  String get dashQuickShort => '快速';

  @override
  String get dashModuleShort => '模块';

  @override
  String get dashFoundLabel => '找到：';

  @override
  String get dashModulesSuffix => ' 个模块';

  @override
  String dashPerPage(int count) {
    return '每页 $count 条';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count 条/页';
  }

  @override
  String get dashFirstPage => '首页';

  @override
  String get dashPrevPage => '上一页';

  @override
  String get dashNextPage => '下一页';

  @override
  String get dashLastPage => '末页';

  @override
  String dashPageOf(int page, int total) {
    return '第 $page 页，共 $total 页';
  }

  @override
  String get dashMachineNameHint => '机器名（例如 pathauto）';

  @override
  String get dashAddButton => '添加';

  @override
  String get dashAddModuleManually => '手动添加模块';

  @override
  String get dashAddModuleSubtitle => '通过机器名直接从 Drupal.org 加载。';

  @override
  String get dashAddModuleShort => '添加模块';

  @override
  String get dashNoProjectsFound => '未找到任何项目。';

  @override
  String get dashFilterAll => '所有项目';

  @override
  String get dashFilterMissing => '缺失翻译';

  @override
  String get dashFilterReview => '审核队列';

  @override
  String get dashFilterTranslated => '已翻译项目';

  @override
  String get dashFilterReleased => '已发布项目';

  @override
  String get dashBulkDialogIntro => '使用 Google Gemini 自动翻译所选筛选条件下的多个模块。';

  @override
  String get dashActiveFilter => '当前筛选';

  @override
  String get dashModuleCount => '模块数量';

  @override
  String dashModulesCountItem(int count) {
    return '$count 个模块';
  }

  @override
  String get dashPrioritizeD12Title => '优先处理 Drupal 12 模块';

  @override
  String get dashPrioritizeD12Subtitle => '优先翻译尚不支持 Drupal 12 的模块';

  @override
  String get dashTotalModules => '模块总数';

  @override
  String get dashInputTokensEst => '输入令牌数（估算）';

  @override
  String get dashOutputTokensEst => '输出令牌数（估算）';

  @override
  String get dashBulkFootnote => '* 翻译将分批高效执行，以避免超时。';

  @override
  String get dashStartBulkTranslation => '开始批量翻译';

  @override
  String dashStaleLoadError(String error) {
    return '加载过时模块时出错：$error';
  }

  @override
  String get dashNoStaleModules => '未发现过时的模块 — 一切都是最新的！✨';

  @override
  String get dashRetranslateOutdatedTitle => '重新翻译过时的模块';

  @override
  String get dashRetranslateOutdatedIntro =>
      '自上次翻译以来英文原文发生变化的所有翻译，都将自动使用 Google Gemini 重新翻译。无需逐个手动打开每个模块。';

  @override
  String get dashOutdatedModules => '过时的模块';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* 翻译将替换现有文本并重置 is_reviewed 状态。将以每批 4 个模块的方式执行。';

  @override
  String dashRetranslateAllCount(int count) {
    return '重新翻译全部 $count 个模块';
  }

  @override
  String get dashRetranslatingOutdatedTitle => '正在重新翻译过时的模块……';

  @override
  String get dashFetchingProjects => '正在从服务器获取项目……';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '已处理 $processed/$total 个模块';
  }

  @override
  String get dashNoTranslatableProjects => '在此筛选条件下未找到可翻译的项目。';

  @override
  String get dashStartingTranslation => '正在开始翻译……';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return '正在翻译第 $start–$end 个模块，共 $total 个……';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '已完成 $end/$total 个模块。';
  }

  @override
  String get dashTranslationCompleted => '翻译已成功完成！✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '已成功批量翻译 $count 个模块！✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return '批量翻译出错：$error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return '全部 $count 个模块均已成功重新翻译！✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count 个过时模块已成功重新翻译！✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return '重新翻译时出错：$error';
  }

  @override
  String get filterAllShort => '全部';

  @override
  String get filterMissing => '缺失';

  @override
  String get filterTranslated => '已翻译';

  @override
  String get filterReviewQueue => '审核队列';

  @override
  String get filterReleased => '已发布';

  @override
  String get filterOutdated => '已过时';

  @override
  String get filterPriority => '优先';

  @override
  String get filterIgnored => '已忽略';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonReset => '重置';

  @override
  String get commonRefresh => '刷新';

  @override
  String commonErrorPrefix(String error) {
    return '错误：$error';
  }

  @override
  String get reviewResetAllConfirmTitle => '重置所有已发布的翻译？';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return '所有标记为 $langcode 已发布的翻译都将重置为审核状态。此操作无法撤销。';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '已将 $count 条翻译重置为审核状态。';
  }

  @override
  String get reviewPipelineTitle => '审核流程';

  @override
  String get reviewPipelineSubtitle => '针对 AI 翻译的人工质量保证流程';

  @override
  String get reviewSearchHint => '搜索项目...';

  @override
  String get reviewResetPublished => '重置已发布内容';

  @override
  String reviewResultsCount(int count, int total) {
    return '结果：$count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return '待处理：$count';
  }

  @override
  String get reviewNoProjectsPending => '没有待审核的项目。';

  @override
  String get reviewAllVerifiedOrNone => '所有翻译均已验证，或在此语言环境下不存在任何翻译。';

  @override
  String get reviewNoSummary => '无摘要。';

  @override
  String get reviewStartAudit => '开始审核';

  @override
  String get reviewHtmlSourceShort => 'HTML 源代码';

  @override
  String get reviewCopySource => '复制原文';

  @override
  String get reviewModuleDetails => '模块详情';

  @override
  String get reviewOriginalTitle => '原始标题';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org 项目';

  @override
  String get reviewSuggestions => '建议';

  @override
  String get reviewNoSuggestions => '暂无可用建议。';

  @override
  String get reviewApply => '应用';

  @override
  String get reviewNoChanges => '无变化';

  @override
  String get reviewOriginalBeforeCorrection => '原始版本（修改前）';

  @override
  String get reviewCorrectedCurrentVersion => '已修正（当前版本）';

  @override
  String get reviewBaseOriginal => '基准（原始）';

  @override
  String get reviewYourCorrection => '您的修改';

  @override
  String get reviewChangesVisual => '查看您的更改（可视化）';

  @override
  String get commonSkip => '跳过';

  @override
  String get commonIgnore => '忽略';

  @override
  String get reviewEmptyProjectTitle => '空项目';

  @override
  String get reviewEmptyProjectBody => '此项目为空（没有标题、摘要或正文），无法批准。请跳过它。';

  @override
  String get reviewApprovedSuccess => '翻译已批准！🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ “$machine” 的批准失败 — 请重试。';
  }

  @override
  String get reviewUnignoredSuccess => '已恢复。模块再次处于活动状态！';

  @override
  String get reviewActionFailed => '操作失败。';

  @override
  String get reviewIgnoreModuleTitle => '忽略此模块？';

  @override
  String get reviewIgnoreModuleBody => '此模块将从所有列表中永久隐藏。您将不会再被它卡住。';

  @override
  String get reviewModulePermanentlyIgnored => '模块已被永久忽略。';

  @override
  String get reviewIgnoreFailed => '忽略模块失败。';

  @override
  String get reviewSuggestionSaved => '建议草稿已保存！💾';

  @override
  String get reviewSaveSuggestionFailed => '保存建议草稿失败。';

  @override
  String get reviewSuggestionDeleted => '建议已删除。';

  @override
  String get reviewDeleteFailed => '删除失败。';

  @override
  String get reviewSuggestionApplied => '建议已应用。';

  @override
  String get reviewPreparingData => '正在准备审核数据...';

  @override
  String get reviewDirectEdit => '直接编辑';

  @override
  String get reviewLivePreview => '实时预览';

  @override
  String get reviewCompareWith => '与以下内容比较：';

  @override
  String get reviewProductionVersion => '生产版本';

  @override
  String get reviewEditorialReview => '编辑审核';

  @override
  String get reviewOpenQueue => '打开审核队列';

  @override
  String get reviewCopyPromptShort => '复制提示语';

  @override
  String get reviewUnignoreShort => '恢复';

  @override
  String get reviewApproveButton => '批准';

  @override
  String get reviewHideDetails => '隐藏详情';

  @override
  String get reviewDetailsAndEnglishSource => '详情与英文原文';

  @override
  String reviewPendingCountShort(int count) {
    return '$count 项待处理';
  }

  @override
  String reviewReviewingModule(String name) {
    return '正在审核 $name';
  }

  @override
  String get reviewCompareTranslationTooltip => '将翻译与英文原文进行比较';

  @override
  String get reviewTranslationLabel => '翻译';

  @override
  String get reviewComparisonTitle => '比较';

  @override
  String get reviewCopyPromptLongTooltip => '将原文和翻译提示语复制到剪贴板';

  @override
  String get reviewUnignoreCaps => '恢复';

  @override
  String get reviewIgnoreCaps => '忽略';

  @override
  String get reviewSkipShortcut => '跳过（Ctrl+→）';

  @override
  String get reviewEditorialReviewShort => '编辑审核';

  @override
  String get reviewUnignoreTablet => '恢复';

  @override
  String get reviewApproveForProduction => '批准发布到生产环境（Ctrl+回车）';

  @override
  String get reviewDirectRefinement => '直接优化';

  @override
  String get reviewTitleField => '标题';

  @override
  String get reviewSummaryField => '摘要';

  @override
  String get reviewBodyField => '正文内容';

  @override
  String get reviewSaveShortcut => '保存（Ctrl+Alt+S）';

  @override
  String get reviewLivePreviewRendering => '实时预览（渲染中）';

  @override
  String get reviewVoiceFemale => '女声';

  @override
  String get reviewVoiceMale => '男声';

  @override
  String get reviewStopListening => '停止';

  @override
  String get reviewListen => '朗读';

  @override
  String get reviewAutopTooltip => '自动格式化段落（换行符 → <p>）';

  @override
  String get reviewSourceCodeShort => '源代码';

  @override
  String get reviewNoParagraphChange => '文本中已包含 <p> 标签 — 无需更改';

  @override
  String get reviewParagraphsFormatted => '段落已格式化 ¶';

  @override
  String get commonRetry => '重试';

  @override
  String categoriesLoadError(String error) {
    return '加载分类失败：$error';
  }

  @override
  String get categoriesSaveSuccess => '分类已成功保存。';

  @override
  String get categoriesSaveFailed => '保存翻译失败。';

  @override
  String get categoriesFileEmpty => '文件为空。';

  @override
  String get categoriesInvalidJson => 'JSON 格式无效。';

  @override
  String get categoriesNoValidUuids => '在文件中未找到有效的 UUID 条目。';

  @override
  String categoriesImportSuccess(int count) {
    return '已从文件导入 $count 个分类。';
  }

  @override
  String get categoriesTitle => '分类';

  @override
  String categoriesTranslatingFor(String lang) {
    return '正在为以下语言翻译：$lang';
  }

  @override
  String get categoriesImportJson => '导入 JSON';

  @override
  String get categoriesSaving => '正在保存...';

  @override
  String get categoriesSaveAll => '保存全部';

  @override
  String get categoriesLoading => '正在加载分类...';

  @override
  String categoriesTranslationColumn(String code) {
    return '翻译（$code）';
  }

  @override
  String get categoriesNoneFound => '未找到分类。';

  @override
  String categoriesTranslateHint(String name) {
    return '翻译“$name”...';
  }

  @override
  String get loginPhotoBy => '摄影：';

  @override
  String get loginPhotoOn => '，来自 ';

  @override
  String get loginPleaseSignIn => '请登录';

  @override
  String get loginUsername => '用户名';

  @override
  String get loginPassword => '密码';

  @override
  String get loginRememberMe => '记住我';

  @override
  String get loginSignIn => '登录';

  @override
  String get loginNoAccount => '还没有账户？';

  @override
  String get loginRegisterNow => '立即注册';

  @override
  String get commonBack => '返回';

  @override
  String get commonNext => '下一步';

  @override
  String get registerFillRequired => '请填写所有必填字段。';

  @override
  String get registerPasswordMismatch => '两次输入的密码不一致。';

  @override
  String get registerPasswordTooShort => '密码长度至少为 8 个字符。';

  @override
  String get registerSelectLanguage => '请至少选择一种语言。';

  @override
  String get registerFailed => '注册失败。';

  @override
  String get registerHeaderTitle => '注册';

  @override
  String get registerStepAccount => '账户';

  @override
  String get registerStepRole => '角色';

  @override
  String get registerStepLanguages => '语言';

  @override
  String get registerStepApiKeys => 'API 密钥';

  @override
  String get registerYourAccount => '您的账户';

  @override
  String get registerAvatarOptional => '头像（可选）';

  @override
  String get registerUsernameRequired => '用户名 *';

  @override
  String get registerEmailRequired => '电子邮件地址 *';

  @override
  String get registerPasswordRequired => '密码 *';

  @override
  String get registerPasswordRepeat => '重复密码 *';

  @override
  String get registerYourRole => '您的角色';

  @override
  String get registerRoleExplanation => '译者可以翻译文本，但无权访问审核队列。审核员负责检查并批准已翻译的内容。';

  @override
  String get registerRoleTranslator => '译者';

  @override
  String get registerRoleTranslatorDesc => '创建和编辑翻译。';

  @override
  String get registerRoleReviewer => '审核员';

  @override
  String get registerRoleReviewerDesc => '审核并批准翻译。';

  @override
  String get registerTargetLanguages => '目标语言';

  @override
  String get registerLanguagesExplanation => '请选择您想从事翻译工作的所有语言。';

  @override
  String get registerNoLanguagesAvailable => '暂无可用语言。';

  @override
  String get registerApiKeysTitle => 'API 密钥';

  @override
  String get registerApiKeysExplanation =>
      '请输入您自己的 API 密钥。每位用户只使用自己的密钥。您也可以稍后在个人资料中添加。';

  @override
  String get registerKeysEncryptedNote => '密钥以加密方式存储，绝不会与其他用户共享。';

  @override
  String get registerOptionalSuffix => '（可选）';

  @override
  String get registerSuccessTitle => '注册成功！';

  @override
  String get registerSuccessBody => '您的账户已创建，正在等待管理员批准。账户激活后您将收到通知。';

  @override
  String get registerGoToLogin => '前往登录';

  @override
  String get registerSubmit => '注册';

  @override
  String registerPhotoCredit(String name) {
    return '摄影：$name，来自 Unsplash';
  }

  @override
  String get profileUpdateSuccess => '资料更新成功！';

  @override
  String get profileUpdateFailed => '更新失败。';

  @override
  String profileSaveError(String error) {
    return '保存时出错：$error';
  }

  @override
  String get profilePasswordMismatch => '两次输入的密码不一致！';

  @override
  String get profilePasswordChangeSuccess => '密码修改成功！';

  @override
  String get profilePasswordChangeError => '修改密码时出错：当前密码不正确。';

  @override
  String get profileAvatarUploadSuccess => '头像上传成功！';

  @override
  String get profileAvatarUploadError => '上传头像时出错。';

  @override
  String get profileTitle => '个人资料与设置';

  @override
  String get profileSubtitle => '管理您的用户资料、翻译 API（Gemini 和 DeepL）以及账户安全。';

  @override
  String get profileRoleUser => '用户';

  @override
  String get profileNoEmail => '未提供电子邮件地址';

  @override
  String get profileTabDetails => '资料详情';

  @override
  String get profileTabGemini => 'AI 翻译（Gemini）';

  @override
  String get profileTabDeepl => 'DeepL 翻译';

  @override
  String get profileTabPassword => '修改密码';

  @override
  String get profileSectionInfo => '个人资料信息';

  @override
  String get profileFieldName => '姓名';

  @override
  String get profileFieldNameHint => '您的全名';

  @override
  String get profileFieldEmail => '电子邮件地址';

  @override
  String get profileFieldEmailHint => '您的电子邮件地址';

  @override
  String get profileSectionGemini => 'GEMINI 协作助手设置';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API 密钥';

  @override
  String get profileFieldGeminiKeyHint => '请输入您的 gemini-3.1-flash API 密钥';

  @override
  String get profileFieldAiPrompt => '自定义 AI 提示语';

  @override
  String get profileFieldAiPromptHint => '可选：自定义 Gemini 的系统提示语...';

  @override
  String get profileSectionDeepl => 'DEEPL 翻译设置';

  @override
  String get profileDeeplDescription =>
      'DeepL 提供高质量的机器翻译并保留 HTML 标签。免费账户（每月 50 万字符）会获得一个以“:fx”结尾的密钥。';

  @override
  String get profileFieldDeeplKey => 'DeepL API 密钥';

  @override
  String get profileFieldDeeplKeyHint =>
      '例如 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      '免费密钥以“:fx”结尾，使用 api-free.deepl.com；专业版密钥使用 api.deepl.com。系统会自动进行区分。';

  @override
  String get profileSectionSecurity => '账户安全';

  @override
  String get profileFieldCurrentPassword => '当前密码';

  @override
  String get profileFieldCurrentPasswordHint => '请输入您的当前密码';

  @override
  String get profileFieldNewPassword => '新密码';

  @override
  String get profileFieldNewPasswordHint => '至少 6 个字符';

  @override
  String get profileFieldConfirmPassword => '确认新密码';

  @override
  String get profileFieldConfirmPasswordHint => '请重复输入密码';

  @override
  String get profileChangePasswordButton => '修改密码';

  @override
  String get commonDelete => '删除';

  @override
  String get settingsRegistrationUpdated => '注册设置已更新';

  @override
  String get settingsUpdateFailed => '更新失败。';

  @override
  String get settingsUserApproved => '用户已批准！';

  @override
  String get settingsAccountDeactivated => '账户已停用。';

  @override
  String get settingsUserDeleted => '用户已删除。';

  @override
  String get settingsActionFailed => '操作失败。';

  @override
  String get settingsDeleteAccountTitle => '删除账户？';

  @override
  String get settingsDeactivateAccountTitle => '停用账户？';

  @override
  String settingsDeleteAccountBody(String username) {
    return '账户“$username”将被永久删除。是否继续？';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return '账户“$username”将被锁定。该用户将无法再登录，但账户会被保留。';
  }

  @override
  String get settingsDeactivate => '停用';

  @override
  String settingsSyncSuccess(String count) {
    return '已同步 $count 条翻译！';
  }

  @override
  String settingsSyncError(String error) {
    return '同步出错：$error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '已同步 $count 个优先模块！';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return '同步优先列表时出错：$error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return '备份成功：已处理 $count 个文件。';
  }

  @override
  String get settingsUploadFailed => '上传失败。';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSystemConfig => '系统配置';

  @override
  String get settingsRegistration => '注册';

  @override
  String get settingsRegistrationHint => '全局开启或关闭注册表单。';

  @override
  String get settingsPendingUsers => '待处理用户';

  @override
  String get settingsNoNewRequests => '没有新的申请。';

  @override
  String get settingsWantsReviewer => '希望成为审核员';

  @override
  String get settingsAssignRole => '分配角色';

  @override
  String get settingsRoleTranslator => '译者';

  @override
  String get settingsRoleReviewer => '审核员';

  @override
  String get settingsApprove => '批准';

  @override
  String get settingsReject => '拒绝';

  @override
  String get settingsActiveUsers => '活跃用户';

  @override
  String get settingsNoActiveUsers => '没有活跃用户。';

  @override
  String get settingsDeactivateAccountTooltip => '停用';

  @override
  String get settingsDeleteAccountAction => '删除账户';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsThemePearl => '浅色（珍珠）';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsThemeGlassy => '玻璃质感';

  @override
  String get settingsThemeNature => '自然';

  @override
  String get settingsThemeLiquid => '流动';

  @override
  String get settingsThemeStage => '舞台';

  @override
  String get settingsTypography => '字体排印';

  @override
  String get settingsFontHint => '修改界面字体。';

  @override
  String get settingsFontClean => '简洁';

  @override
  String get settingsFontFuturistic => '未来感';

  @override
  String get settingsFontTech => '科技感';

  @override
  String get settingsWorkflowFun => '工作流程与趣味';

  @override
  String get settingsConfettiTitle => '成功庆祝动画（彩纸）';

  @override
  String get settingsConfettiHint => '成功保存时显示一段小动画。';

  @override
  String get settingsLargeUiTitle => '增强可读性（大号字体）';

  @override
  String get settingsLargeUiHint => '增大字体和徽章尺寸以提高可读性。';

  @override
  String get settingsAutoPTitle => '自动段落格式化（¶ 自动加 P 标签）';

  @override
  String get settingsAutoPHint => '在审核界面加载模块时，自动将纯文本包裹为 <p> 段落标签。等同于手动点击 ¶ 按钮。';

  @override
  String get settingsDatabaseSync => '数据库同步';

  @override
  String get settingsDatabaseSyncTooltip => '将数据库条目与 JSON 翻译文件进行同步。';

  @override
  String get settingsDatabaseSyncHint => '将服务器上内部数据库条目与翻译 JSON 文件同步。';

  @override
  String get settingsSyncing => '正在同步...';

  @override
  String get settingsSyncNow => '立即同步';

  @override
  String get settingsSyncD11List => '同步 D11 列表';

  @override
  String get settingsUploadBackup => '上传备份（.zip）';

  @override
  String get settingsSelectZipFile => '选择 ZIP 文件';

  @override
  String get settingsUploading => '正在上传...';

  @override
  String get settingsErrorDiagnostics => '错误诊断与系统日志';

  @override
  String get settingsLogsCopied => '日志已复制到剪贴板！📋';

  @override
  String get settingsCopyLogs => '复制日志';

  @override
  String get settingsLogsRotated => '日志已归档并轮转！📁';

  @override
  String get settingsRotate => '轮转';

  @override
  String get settingsClear => '清除';

  @override
  String get settingsLogLimit => '日志上限：';

  @override
  String get settingsNoLogs => '没有记录的日志';

  @override
  String get layoutMenu => '菜单';

  @override
  String get layoutNavAnalytics => '统计分析';

  @override
  String get layoutNavReviewQueue => '审核队列';

  @override
  String get layoutNavGlossary => '术语表';

  @override
  String get layoutNavCategories => '分类';

  @override
  String get layoutNavHelp => '帮助';

  @override
  String get layoutNavSettings => '设置';

  @override
  String get layoutPhotoBy => '摄影：';

  @override
  String get layoutPhotoOn => '，来自 ';

  @override
  String get layoutEditProfile => '编辑资料';

  @override
  String get layoutLogout => '退出登录';

  @override
  String get layoutThemeLabel => '主题';

  @override
  String get layoutThemePearl => '浅色';

  @override
  String get layoutThemeDark => '深色';

  @override
  String get layoutThemeGlassy => '玻璃质感';

  @override
  String get layoutThemeNature => '自然';

  @override
  String get layoutThemeLiquid => '流动';

  @override
  String get layoutThemeStage => '舞台';

  @override
  String get layoutTargetLanguage => '目标语言';

  @override
  String get layoutDeeplUsage => 'DEEPL 使用量';

  @override
  String get layoutUnavailable => '不可用';

  @override
  String get layoutUnlimited => '无限制';

  @override
  String get layoutUsed => '已用';

  @override
  String get layoutTranslate => '翻译';

  @override
  String get analyticsSubtitle => '兼容性、翻译积压和每周趋势。';

  @override
  String get analyticsBacklog => '翻译积压';

  @override
  String get analyticsMissing => '缺失';

  @override
  String get analyticsStale => '已过时';

  @override
  String get analyticsInReview => '审核中';

  @override
  String get analyticsReleased => '已发布';

  @override
  String get analyticsTranslated => '已翻译';

  @override
  String get analyticsTotalModules => '模块总数';

  @override
  String get analyticsCompatByVersion => '按 Drupal 版本划分的兼容性';

  @override
  String analyticsLanguageLegend(String lang) {
    return '语言：$lang · 已发布 / 审核中 / 缺失';
  }

  @override
  String get analyticsLoadingCounts => '正在加载统计数据……';

  @override
  String get analyticsWindow => '时间范围：';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks 周';
  }

  @override
  String get analyticsNewDescriptionsPerWeek => '每周新增的项目描述';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return '每周被标记为过时的数量（$lang）';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count 个模块';
  }

  @override
  String get analyticsReviewShort => '审核';

  @override
  String get analyticsNoDataInWindow => '此时间范围内没有数据。';

  @override
  String get analyticsAndMore => '……以及更多';

  @override
  String glossaryLoadError(String error) {
    return '加载出错：$error';
  }

  @override
  String get glossaryNewTerm => '创建新术语';

  @override
  String get glossaryEditTerm => '编辑术语';

  @override
  String get glossaryFieldSourceWord => '源词（基本形式，即在文本中出现的形式）';

  @override
  String get glossaryFieldSourceWordHint => '例如 node（节点）';

  @override
  String get glossaryWordForms => '其他词形（复数、属格、与格等）';

  @override
  String get glossaryWordFormsHint => '例如 content（内容）— 按 Enter 键添加';

  @override
  String get glossaryAddForm => '添加词形';

  @override
  String get glossaryFieldPreferredWord => '首选译名';

  @override
  String get glossaryFieldPreferredWordHint => '例如 content（内容）';

  @override
  String get glossaryFieldExplanation => '说明（显示在工具提示中）';

  @override
  String get glossaryFieldExplanationHint => '为什么这个词应该采用不同的翻译？';

  @override
  String get glossaryCreate => '创建';

  @override
  String get glossaryRequiredFields => '源词和首选译名为必填项。';

  @override
  String get glossaryCreated => '术语已创建 ✓';

  @override
  String get glossaryUpdated => '术语已更新 ✓';

  @override
  String glossaryError(String error) {
    return '错误：$error';
  }

  @override
  String get glossaryDeleteTitle => '删除术语？';

  @override
  String glossaryDeleteBody(String word) {
    return '“$word”将从术语表中永久删除。';
  }

  @override
  String get glossaryDeleted => '术语已删除。';

  @override
  String get glossaryTitle => '翻译术语表';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return '语言：$lang · $count 条';
  }

  @override
  String get glossaryNewShort => '新建';

  @override
  String get glossaryCreateTerm => '创建术语';

  @override
  String get glossaryInfoBanner =>
      '此术语表中的词语会在审核编辑器中高亮显示，鼠标悬停时工具提示会说明为何更适合采用其他译法。';

  @override
  String get glossaryNoEntries => '暂无条目。';

  @override
  String get glossaryNoEntriesEditorHint => '点击“创建术语”以创建第一个条目。';

  @override
  String get glossaryNoEntriesForLanguage => '该语言暂无术语表条目。';

  @override
  String get diffNoChanges => '未检测到内容差异。';

  @override
  String get diffRemoved => '已删除';

  @override
  String get diffAdded => '已添加';

  @override
  String syncBarQuickSync(String count) {
    return '快速同步：已更改 $count 个模块……';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return '完整同步：$current / $total 个模块';
  }

  @override
  String syncBarFullSync(String count) {
    return '完整同步：$count 个模块……';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appTitle => 'PB 翻译中心';

  @override
  String get editorLoadingProject => '正在加载项目详情...';

  @override
  String editorLoadError(String error) {
    return '加载项目数据失败：$error';
  }

  @override
  String get editorGeminiSuccess => '已使用 Gemini 成功翻译！✨';

  @override
  String get editorUnknownError => '未知错误';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini 翻译失败：$detail';
  }

  @override
  String get editorGeminiKeyMissing => '请在您的用户资料中添加 Google AI 密钥（不是在管理设置中）。';

  @override
  String get editorGeminiError => 'Gemini 翻译出错。请检查您资料中的 Google AI 密钥。';

  @override
  String get editorDeeplSuccess => '已使用 DeepL 成功翻译！🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL 翻译失败：$detail';
  }

  @override
  String get editorDeeplGenericError => 'DeepL 翻译出错。请确保您的资料中已设置 DeepL API 密钥。';

  @override
  String get editorDeeplInvalidKey => 'DeepL API 密钥无效。请在您的资料中检查。';

  @override
  String get editorDeeplQuotaExceeded => 'DeepL 配额已用尽。请检查您的套餐。';

  @override
  String get editorReviewReset => '翻译已重置为审核状态。';

  @override
  String editorResetError(String error) {
    return '重置失败：$error';
  }

  @override
  String get editorUnignoreSuccess => '模块已恢复到活动列表。';

  @override
  String get editorUnignoreError => '恢复模块失败。';

  @override
  String get editorSaveSuccess => '翻译已保存 — 返回审核队列。';

  @override
  String editorSaveError(String error) {
    return '保存失败：$error';
  }

  @override
  String get editorNoMoreProjects => '列表中没有更多待处理的项目了。';

  @override
  String get editorChangesDiscarded => '已放弃更改，正在加载下一个项目...';

  @override
  String get editorEnglishSourceApplied => '已应用英文原文 — 请现在翻译。';

  @override
  String editorCannotOpenUrl(String url) {
    return '无法打开网址：$url';
  }

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '关闭';

  @override
  String get editorCloseEnglishSource => '关闭英文原文';

  @override
  String get editorShowEnglishSource => '显示英文原文';

  @override
  String get editorUnignoreShortTooltip => '恢复模块';

  @override
  String get editorBackToReviewTooltip => '重新设为审核状态';

  @override
  String get editorAndNext => '并转到下一个';

  @override
  String get editorBackToDashboard => '返回仪表盘';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return '正在翻译为 $langName（$langCode）';
  }

  @override
  String editorRemainingCount(int count) {
    return '剩余 $count 个';
  }

  @override
  String get editorUnignoreLongTooltip => '将模块恢复到活动列表';

  @override
  String get editorUnignoreLabel => '恢复';

  @override
  String get editorUnpublishTooltip => '撤销发布并重新设为审核状态';

  @override
  String get editorBackToReview => '返回审核';

  @override
  String get editorSaveAndNext => '保存并转到下一个';

  @override
  String get editorEnglishSourceHeader => '英文原文';

  @override
  String get editorStaleTooltip => '显示说明并应用英文文本';

  @override
  String get editorStaleDetailsLabel => '已过时 — 详情';

  @override
  String get editorCopyPromptTooltip => '复制原文和翻译提示语';

  @override
  String get editorPromptCopied => '提示语已复制到剪贴板 📋';

  @override
  String get editorShowPreview => '显示预览';

  @override
  String get editorShowHtmlSource => '显示 HTML 源代码';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return '摘要：\n$summary\n\n正文：\n$body';
  }

  @override
  String get editorSummaryLabelColon => '摘要：';

  @override
  String get editorDescriptionLabelColon => '描述：';

  @override
  String get editorStaleDialogTitle => '英文原文已更改';

  @override
  String get editorStaleExplanation =>
      '现有翻译基于已过时的英文原文。自上次翻译以来，模块维护者已在 Drupal.org 上更改了英文文本 — 因此现有翻译的内容可能不再准确或完整。';

  @override
  String get editorStaleTip =>
      '提示：点击“使用英文原文”可将当前英文原文直接加载到编辑器中。然后您可以以此为起点重新翻译。英文原文也会显示在左侧面板中。';

  @override
  String get editorEnglishSourceShort => '英文原文';

  @override
  String get editorPreviousTranslation => '先前的翻译';

  @override
  String get editorWhatChangedTitle => '发生了什么变化？';

  @override
  String get editorShowDiff => '显示差异';

  @override
  String get editorUseEnglish => '使用英文原文';

  @override
  String get editorStaleBannerText => '英文原文已更改 — 翻译已过时';

  @override
  String get editorDetailsAndApply => '详情与应用';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName 翻译';
  }

  @override
  String get editorTranslatingEllipsis => '翻译中...';

  @override
  String get editorShowEditor => '显示编辑器';

  @override
  String get editorModuleTitleLabel => '模块标题（英文）';

  @override
  String get editorSummaryFieldLabel => '摘要';

  @override
  String get editorBodyFieldLabel => '正文';

  @override
  String get editorHtmlCleaned => 'HTML 已清理';

  @override
  String get editorLivePreviewHeader => '实时预览';

  @override
  String get editorTidyHtmlTooltip => '清理 HTML（移除 DeepL 产生的多余标记）';

  @override
  String get editorVisualMode => '可视化';

  @override
  String get editorSourceCodeMode => '源代码（HTML）';

  @override
  String get commonCancel => '取消';

  @override
  String get costDialogTitle => '费用估算（AI）';

  @override
  String get costDialogIntro => '所选模块将使用 Google Gemini AI 进行翻译。以下是此操作的预估费用明细：';

  @override
  String get costRowModel => '模型';

  @override
  String get costRowInputTokens => '输入令牌数';

  @override
  String get costRowOutputTokens => '输出令牌数（估算）';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens（约 $chars 个字符）';
  }

  @override
  String get costRowPriceInput => '每百万输入令牌价格';

  @override
  String get costRowPriceOutput => '每百万输出令牌价格';

  @override
  String get costRowTotalEstimate => '预估总费用';

  @override
  String get costDialogFootnote => '* 注意：此为基于当前 Google 按量计费模式的估算，实际用量可能略有差异。';

  @override
  String get costDialogStartTranslation => '开始翻译';

  @override
  String get htmlToolbarInsertLink => '插入链接';

  @override
  String get htmlToolbarLinkTooltip => '插入链接（a）';

  @override
  String get htmlToolbarInsert => '插入';

  @override
  String get htmlToolbarHeading2 => '二级标题';

  @override
  String get htmlToolbarHeading3 => '三级标题';

  @override
  String get htmlToolbarBold => '加粗（strong）';

  @override
  String get htmlToolbarItalic => '斜体（em）';

  @override
  String get htmlToolbarBulletList => '项目符号列表（ul）';

  @override
  String get htmlToolbarNumberedList => '编号列表（ol）';

  @override
  String get htmlToolbarQuote => '引用（blockquote）';

  @override
  String get screenshotAltsHeader => '截图替代文本';

  @override
  String get screenshotAltsIntro => '请为每张截图输入目标语言的描述性替代文本。';

  @override
  String screenshotLabel(int number) {
    return '截图 $number';
  }

  @override
  String get screenshotPreviewUnavailable => '预览不可用';

  @override
  String get screenshotAltHint => '请输入目标语言的替代文本……';

  @override
  String get dashUnignoreAllConfirmTitle => '恢复所有已忽略的模块？';

  @override
  String get dashUnignoreAllConfirmBody => '所有被忽略的模块都将恢复到活动列表，并可再次进行翻译。';

  @override
  String get dashUnignoreAllConfirmAction => '全部恢复';

  @override
  String get dashUnignoreAllSuccess => '所有被忽略的模块均已恢复。';

  @override
  String get dashUnignoreAllError => '恢复模块失败。';

  @override
  String get dashUnignoreAllButton => '恢复所有已忽略的模块';

  @override
  String dashSyncStartError(String error) {
    return '启动同步失败：$error';
  }

  @override
  String get dashQuickUpdateStarted => '快速更新（7 天）已开始 ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return '快速更新出错：$error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return '同步成功：$name';
  }

  @override
  String get dashManualSyncNotFound => '在 Drupal.org 上未找到该模块。';

  @override
  String get dashAiBulkTranslation => 'AI 批量翻译';

  @override
  String get dashHeaderTitle => '项目描述';

  @override
  String get dashHeaderSubtitle => '将 Drupal 模块描述翻译成目标语言，帮助让生态系统更易于访问。';

  @override
  String get dashHeaderSubtitleShort => '翻译 Drupal 模块描述。';

  @override
  String get dashLastLabel => '最近：';

  @override
  String get dashContinue => '继续';

  @override
  String get dashContinueShort => '继续';

  @override
  String get dashUnignoreAllButtonLong => '恢复所有已忽略的模块';

  @override
  String get dashQuickUpdateTooltip => '快速更新（最近 7 天）';

  @override
  String get dashFullSyncTooltip => '从 Drupal.org 完整同步数据库';

  @override
  String get dashManualLoadTooltip => '从 Drupal.org 手动加载单个模块';

  @override
  String get dashQuickShort => '快速';

  @override
  String get dashModuleShort => '模块';

  @override
  String get dashFoundLabel => '找到：';

  @override
  String get dashModulesSuffix => ' 个模块';

  @override
  String dashPerPage(int count) {
    return '每页 $count 条';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count 条/页';
  }

  @override
  String get dashFirstPage => '首页';

  @override
  String get dashPrevPage => '上一页';

  @override
  String get dashNextPage => '下一页';

  @override
  String get dashLastPage => '末页';

  @override
  String dashPageOf(int page, int total) {
    return '第 $page 页，共 $total 页';
  }

  @override
  String get dashMachineNameHint => '机器名（例如 pathauto）';

  @override
  String get dashAddButton => '添加';

  @override
  String get dashAddModuleManually => '手动添加模块';

  @override
  String get dashAddModuleSubtitle => '通过机器名直接从 Drupal.org 加载。';

  @override
  String get dashAddModuleShort => '添加模块';

  @override
  String get dashNoProjectsFound => '未找到任何项目。';

  @override
  String get dashFilterAll => '所有项目';

  @override
  String get dashFilterMissing => '缺失翻译';

  @override
  String get dashFilterReview => '审核队列';

  @override
  String get dashFilterTranslated => '已翻译项目';

  @override
  String get dashFilterReleased => '已发布项目';

  @override
  String get dashBulkDialogIntro => '使用 Google Gemini 自动翻译所选筛选条件下的多个模块。';

  @override
  String get dashActiveFilter => '当前筛选';

  @override
  String get dashModuleCount => '模块数量';

  @override
  String dashModulesCountItem(int count) {
    return '$count 个模块';
  }

  @override
  String get dashPrioritizeD12Title => '优先处理 Drupal 12 模块';

  @override
  String get dashPrioritizeD12Subtitle => '优先翻译尚不支持 Drupal 12 的模块';

  @override
  String get dashTotalModules => '模块总数';

  @override
  String get dashInputTokensEst => '输入令牌数（估算）';

  @override
  String get dashOutputTokensEst => '输出令牌数（估算）';

  @override
  String get dashBulkFootnote => '* 翻译将分批高效执行，以避免超时。';

  @override
  String get dashStartBulkTranslation => '开始批量翻译';

  @override
  String dashStaleLoadError(String error) {
    return '加载过时模块时出错：$error';
  }

  @override
  String get dashNoStaleModules => '未发现过时的模块 — 一切都是最新的！✨';

  @override
  String get dashRetranslateOutdatedTitle => '重新翻译过时的模块';

  @override
  String get dashRetranslateOutdatedIntro =>
      '自上次翻译以来英文原文发生变化的所有翻译，都将自动使用 Google Gemini 重新翻译。无需逐个手动打开每个模块。';

  @override
  String get dashOutdatedModules => '过时的模块';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* 翻译将替换现有文本并重置 is_reviewed 状态。将以每批 4 个模块的方式执行。';

  @override
  String dashRetranslateAllCount(int count) {
    return '重新翻译全部 $count 个模块';
  }

  @override
  String get dashRetranslatingOutdatedTitle => '正在重新翻译过时的模块……';

  @override
  String get dashFetchingProjects => '正在从服务器获取项目……';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '已处理 $processed/$total 个模块';
  }

  @override
  String get dashNoTranslatableProjects => '在此筛选条件下未找到可翻译的项目。';

  @override
  String get dashStartingTranslation => '正在开始翻译……';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return '正在翻译第 $start–$end 个模块，共 $total 个……';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '已完成 $end/$total 个模块。';
  }

  @override
  String get dashTranslationCompleted => '翻译已成功完成！✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '已成功批量翻译 $count 个模块！✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return '批量翻译出错：$error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return '全部 $count 个模块均已成功重新翻译！✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count 个过时模块已成功重新翻译！✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return '重新翻译时出错：$error';
  }

  @override
  String get filterAllShort => '全部';

  @override
  String get filterMissing => '缺失';

  @override
  String get filterTranslated => '已翻译';

  @override
  String get filterReviewQueue => '审核队列';

  @override
  String get filterReleased => '已发布';

  @override
  String get filterOutdated => '已过时';

  @override
  String get filterPriority => '优先';

  @override
  String get filterIgnored => '已忽略';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonReset => '重置';

  @override
  String get commonRefresh => '刷新';

  @override
  String commonErrorPrefix(String error) {
    return '错误：$error';
  }

  @override
  String get reviewResetAllConfirmTitle => '重置所有已发布的翻译？';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return '所有标记为 $langcode 已发布的翻译都将重置为审核状态。此操作无法撤销。';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '已将 $count 条翻译重置为审核状态。';
  }

  @override
  String get reviewPipelineTitle => '审核流程';

  @override
  String get reviewPipelineSubtitle => '针对 AI 翻译的人工质量保证流程';

  @override
  String get reviewSearchHint => '搜索项目...';

  @override
  String get reviewResetPublished => '重置已发布内容';

  @override
  String reviewResultsCount(int count, int total) {
    return '结果：$count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return '待处理：$count';
  }

  @override
  String get reviewNoProjectsPending => '没有待审核的项目。';

  @override
  String get reviewAllVerifiedOrNone => '所有翻译均已验证，或在此语言环境下不存在任何翻译。';

  @override
  String get reviewNoSummary => '无摘要。';

  @override
  String get reviewStartAudit => '开始审核';

  @override
  String get reviewHtmlSourceShort => 'HTML 源代码';

  @override
  String get reviewCopySource => '复制原文';

  @override
  String get reviewModuleDetails => '模块详情';

  @override
  String get reviewOriginalTitle => '原始标题';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org 项目';

  @override
  String get reviewSuggestions => '建议';

  @override
  String get reviewNoSuggestions => '暂无可用建议。';

  @override
  String get reviewApply => '应用';

  @override
  String get reviewNoChanges => '无变化';

  @override
  String get reviewOriginalBeforeCorrection => '原始版本（修改前）';

  @override
  String get reviewCorrectedCurrentVersion => '已修正（当前版本）';

  @override
  String get reviewBaseOriginal => '基准（原始）';

  @override
  String get reviewYourCorrection => '您的修改';

  @override
  String get reviewChangesVisual => '查看您的更改（可视化）';

  @override
  String get commonSkip => '跳过';

  @override
  String get commonIgnore => '忽略';

  @override
  String get reviewEmptyProjectTitle => '空项目';

  @override
  String get reviewEmptyProjectBody => '此项目为空（没有标题、摘要或正文），无法批准。请跳过它。';

  @override
  String get reviewApprovedSuccess => '翻译已批准！🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ “$machine” 的批准失败 — 请重试。';
  }

  @override
  String get reviewUnignoredSuccess => '已恢复。模块再次处于活动状态！';

  @override
  String get reviewActionFailed => '操作失败。';

  @override
  String get reviewIgnoreModuleTitle => '忽略此模块？';

  @override
  String get reviewIgnoreModuleBody => '此模块将从所有列表中永久隐藏。您将不会再被它卡住。';

  @override
  String get reviewModulePermanentlyIgnored => '模块已被永久忽略。';

  @override
  String get reviewIgnoreFailed => '忽略模块失败。';

  @override
  String get reviewSuggestionSaved => '建议草稿已保存！💾';

  @override
  String get reviewSaveSuggestionFailed => '保存建议草稿失败。';

  @override
  String get reviewSuggestionDeleted => '建议已删除。';

  @override
  String get reviewDeleteFailed => '删除失败。';

  @override
  String get reviewSuggestionApplied => '建议已应用。';

  @override
  String get reviewPreparingData => '正在准备审核数据...';

  @override
  String get reviewDirectEdit => '直接编辑';

  @override
  String get reviewLivePreview => '实时预览';

  @override
  String get reviewCompareWith => '与以下内容比较：';

  @override
  String get reviewProductionVersion => '生产版本';

  @override
  String get reviewEditorialReview => '编辑审核';

  @override
  String get reviewOpenQueue => '打开审核队列';

  @override
  String get reviewCopyPromptShort => '复制提示语';

  @override
  String get reviewUnignoreShort => '恢复';

  @override
  String get reviewApproveButton => '批准';

  @override
  String get reviewHideDetails => '隐藏详情';

  @override
  String get reviewDetailsAndEnglishSource => '详情与英文原文';

  @override
  String reviewPendingCountShort(int count) {
    return '$count 项待处理';
  }

  @override
  String reviewReviewingModule(String name) {
    return '正在审核 $name';
  }

  @override
  String get reviewCompareTranslationTooltip => '将翻译与英文原文进行比较';

  @override
  String get reviewTranslationLabel => '翻译';

  @override
  String get reviewComparisonTitle => '比较';

  @override
  String get reviewCopyPromptLongTooltip => '将原文和翻译提示语复制到剪贴板';

  @override
  String get reviewUnignoreCaps => '恢复';

  @override
  String get reviewIgnoreCaps => '忽略';

  @override
  String get reviewSkipShortcut => '跳过（Ctrl+→）';

  @override
  String get reviewEditorialReviewShort => '编辑审核';

  @override
  String get reviewUnignoreTablet => '恢复';

  @override
  String get reviewApproveForProduction => '批准发布到生产环境（Ctrl+回车）';

  @override
  String get reviewDirectRefinement => '直接优化';

  @override
  String get reviewTitleField => '标题';

  @override
  String get reviewSummaryField => '摘要';

  @override
  String get reviewBodyField => '正文内容';

  @override
  String get reviewSaveShortcut => '保存（Ctrl+Alt+S）';

  @override
  String get reviewLivePreviewRendering => '实时预览（渲染中）';

  @override
  String get reviewVoiceFemale => '女声';

  @override
  String get reviewVoiceMale => '男声';

  @override
  String get reviewStopListening => '停止';

  @override
  String get reviewListen => '朗读';

  @override
  String get reviewAutopTooltip => '自动格式化段落（换行符 → <p>）';

  @override
  String get reviewSourceCodeShort => '源代码';

  @override
  String get reviewNoParagraphChange => '文本中已包含 <p> 标签 — 无需更改';

  @override
  String get reviewParagraphsFormatted => '段落已格式化 ¶';

  @override
  String get commonRetry => '重试';

  @override
  String categoriesLoadError(String error) {
    return '加载分类失败：$error';
  }

  @override
  String get categoriesSaveSuccess => '分类已成功保存。';

  @override
  String get categoriesSaveFailed => '保存翻译失败。';

  @override
  String get categoriesFileEmpty => '文件为空。';

  @override
  String get categoriesInvalidJson => 'JSON 格式无效。';

  @override
  String get categoriesNoValidUuids => '在文件中未找到有效的 UUID 条目。';

  @override
  String categoriesImportSuccess(int count) {
    return '已从文件导入 $count 个分类。';
  }

  @override
  String get categoriesTitle => '分类';

  @override
  String categoriesTranslatingFor(String lang) {
    return '正在为以下语言翻译：$lang';
  }

  @override
  String get categoriesImportJson => '导入 JSON';

  @override
  String get categoriesSaving => '正在保存...';

  @override
  String get categoriesSaveAll => '保存全部';

  @override
  String get categoriesLoading => '正在加载分类...';

  @override
  String categoriesTranslationColumn(String code) {
    return '翻译（$code）';
  }

  @override
  String get categoriesNoneFound => '未找到分类。';

  @override
  String categoriesTranslateHint(String name) {
    return '翻译“$name”...';
  }

  @override
  String get loginPhotoBy => '摄影：';

  @override
  String get loginPhotoOn => '，来自 ';

  @override
  String get loginPleaseSignIn => '请登录';

  @override
  String get loginUsername => '用户名';

  @override
  String get loginPassword => '密码';

  @override
  String get loginRememberMe => '记住我';

  @override
  String get loginSignIn => '登录';

  @override
  String get loginNoAccount => '还没有账户？';

  @override
  String get loginRegisterNow => '立即注册';

  @override
  String get commonBack => '返回';

  @override
  String get commonNext => '下一步';

  @override
  String get registerFillRequired => '请填写所有必填字段。';

  @override
  String get registerPasswordMismatch => '两次输入的密码不一致。';

  @override
  String get registerPasswordTooShort => '密码长度至少为 8 个字符。';

  @override
  String get registerSelectLanguage => '请至少选择一种语言。';

  @override
  String get registerFailed => '注册失败。';

  @override
  String get registerHeaderTitle => '注册';

  @override
  String get registerStepAccount => '账户';

  @override
  String get registerStepRole => '角色';

  @override
  String get registerStepLanguages => '语言';

  @override
  String get registerStepApiKeys => 'API 密钥';

  @override
  String get registerYourAccount => '您的账户';

  @override
  String get registerAvatarOptional => '头像（可选）';

  @override
  String get registerUsernameRequired => '用户名 *';

  @override
  String get registerEmailRequired => '电子邮件地址 *';

  @override
  String get registerPasswordRequired => '密码 *';

  @override
  String get registerPasswordRepeat => '重复密码 *';

  @override
  String get registerYourRole => '您的角色';

  @override
  String get registerRoleExplanation => '译者可以翻译文本，但无权访问审核队列。审核员负责检查并批准已翻译的内容。';

  @override
  String get registerRoleTranslator => '译者';

  @override
  String get registerRoleTranslatorDesc => '创建和编辑翻译。';

  @override
  String get registerRoleReviewer => '审核员';

  @override
  String get registerRoleReviewerDesc => '审核并批准翻译。';

  @override
  String get registerTargetLanguages => '目标语言';

  @override
  String get registerLanguagesExplanation => '请选择您想从事翻译工作的所有语言。';

  @override
  String get registerNoLanguagesAvailable => '暂无可用语言。';

  @override
  String get registerApiKeysTitle => 'API 密钥';

  @override
  String get registerApiKeysExplanation =>
      '请输入您自己的 API 密钥。每位用户只使用自己的密钥。您也可以稍后在个人资料中添加。';

  @override
  String get registerKeysEncryptedNote => '密钥以加密方式存储，绝不会与其他用户共享。';

  @override
  String get registerOptionalSuffix => '（可选）';

  @override
  String get registerSuccessTitle => '注册成功！';

  @override
  String get registerSuccessBody => '您的账户已创建，正在等待管理员批准。账户激活后您将收到通知。';

  @override
  String get registerGoToLogin => '前往登录';

  @override
  String get registerSubmit => '注册';

  @override
  String registerPhotoCredit(String name) {
    return '摄影：$name，来自 Unsplash';
  }

  @override
  String get profileUpdateSuccess => '资料更新成功！';

  @override
  String get profileUpdateFailed => '更新失败。';

  @override
  String profileSaveError(String error) {
    return '保存时出错：$error';
  }

  @override
  String get profilePasswordMismatch => '两次输入的密码不一致！';

  @override
  String get profilePasswordChangeSuccess => '密码修改成功！';

  @override
  String get profilePasswordChangeError => '修改密码时出错：当前密码不正确。';

  @override
  String get profileAvatarUploadSuccess => '头像上传成功！';

  @override
  String get profileAvatarUploadError => '上传头像时出错。';

  @override
  String get profileTitle => '个人资料与设置';

  @override
  String get profileSubtitle => '管理您的用户资料、翻译 API（Gemini 和 DeepL）以及账户安全。';

  @override
  String get profileRoleUser => '用户';

  @override
  String get profileNoEmail => '未提供电子邮件地址';

  @override
  String get profileTabDetails => '资料详情';

  @override
  String get profileTabGemini => 'AI 翻译（Gemini）';

  @override
  String get profileTabDeepl => 'DeepL 翻译';

  @override
  String get profileTabPassword => '修改密码';

  @override
  String get profileSectionInfo => '个人资料信息';

  @override
  String get profileFieldName => '姓名';

  @override
  String get profileFieldNameHint => '您的全名';

  @override
  String get profileFieldEmail => '电子邮件地址';

  @override
  String get profileFieldEmailHint => '您的电子邮件地址';

  @override
  String get profileSectionGemini => 'GEMINI 协作助手设置';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API 密钥';

  @override
  String get profileFieldGeminiKeyHint => '请输入您的 gemini-3.1-flash API 密钥';

  @override
  String get profileFieldAiPrompt => '自定义 AI 提示语';

  @override
  String get profileFieldAiPromptHint => '可选：自定义 Gemini 的系统提示语...';

  @override
  String get profileSectionDeepl => 'DEEPL 翻译设置';

  @override
  String get profileDeeplDescription =>
      'DeepL 提供高质量的机器翻译并保留 HTML 标签。免费账户（每月 50 万字符）会获得一个以“:fx”结尾的密钥。';

  @override
  String get profileFieldDeeplKey => 'DeepL API 密钥';

  @override
  String get profileFieldDeeplKeyHint =>
      '例如 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      '免费密钥以“:fx”结尾，使用 api-free.deepl.com；专业版密钥使用 api.deepl.com。系统会自动进行区分。';

  @override
  String get profileSectionSecurity => '账户安全';

  @override
  String get profileFieldCurrentPassword => '当前密码';

  @override
  String get profileFieldCurrentPasswordHint => '请输入您的当前密码';

  @override
  String get profileFieldNewPassword => '新密码';

  @override
  String get profileFieldNewPasswordHint => '至少 6 个字符';

  @override
  String get profileFieldConfirmPassword => '确认新密码';

  @override
  String get profileFieldConfirmPasswordHint => '请重复输入密码';

  @override
  String get profileChangePasswordButton => '修改密码';

  @override
  String get commonDelete => '删除';

  @override
  String get settingsRegistrationUpdated => '注册设置已更新';

  @override
  String get settingsUpdateFailed => '更新失败。';

  @override
  String get settingsUserApproved => '用户已批准！';

  @override
  String get settingsAccountDeactivated => '账户已停用。';

  @override
  String get settingsUserDeleted => '用户已删除。';

  @override
  String get settingsActionFailed => '操作失败。';

  @override
  String get settingsDeleteAccountTitle => '删除账户？';

  @override
  String get settingsDeactivateAccountTitle => '停用账户？';

  @override
  String settingsDeleteAccountBody(String username) {
    return '账户“$username”将被永久删除。是否继续？';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return '账户“$username”将被锁定。该用户将无法再登录，但账户会被保留。';
  }

  @override
  String get settingsDeactivate => '停用';

  @override
  String settingsSyncSuccess(String count) {
    return '已同步 $count 条翻译！';
  }

  @override
  String settingsSyncError(String error) {
    return '同步出错：$error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '已同步 $count 个优先模块！';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return '同步优先列表时出错：$error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return '备份成功：已处理 $count 个文件。';
  }

  @override
  String get settingsUploadFailed => '上传失败。';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSystemConfig => '系统配置';

  @override
  String get settingsRegistration => '注册';

  @override
  String get settingsRegistrationHint => '全局开启或关闭注册表单。';

  @override
  String get settingsPendingUsers => '待处理用户';

  @override
  String get settingsNoNewRequests => '没有新的申请。';

  @override
  String get settingsWantsReviewer => '希望成为审核员';

  @override
  String get settingsAssignRole => '分配角色';

  @override
  String get settingsRoleTranslator => '译者';

  @override
  String get settingsRoleReviewer => '审核员';

  @override
  String get settingsApprove => '批准';

  @override
  String get settingsReject => '拒绝';

  @override
  String get settingsActiveUsers => '活跃用户';

  @override
  String get settingsNoActiveUsers => '没有活跃用户。';

  @override
  String get settingsDeactivateAccountTooltip => '停用';

  @override
  String get settingsDeleteAccountAction => '删除账户';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsThemePearl => '浅色（珍珠）';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsThemeGlassy => '玻璃质感';

  @override
  String get settingsThemeNature => '自然';

  @override
  String get settingsThemeLiquid => '流动';

  @override
  String get settingsThemeStage => '舞台';

  @override
  String get settingsTypography => '字体排印';

  @override
  String get settingsFontHint => '修改界面字体。';

  @override
  String get settingsFontClean => '简洁';

  @override
  String get settingsFontFuturistic => '未来感';

  @override
  String get settingsFontTech => '科技感';

  @override
  String get settingsWorkflowFun => '工作流程与趣味';

  @override
  String get settingsConfettiTitle => '成功庆祝动画（彩纸）';

  @override
  String get settingsConfettiHint => '成功保存时显示一段小动画。';

  @override
  String get settingsLargeUiTitle => '增强可读性（大号字体）';

  @override
  String get settingsLargeUiHint => '增大字体和徽章尺寸以提高可读性。';

  @override
  String get settingsAutoPTitle => '自动段落格式化（¶ 自动加 P 标签）';

  @override
  String get settingsAutoPHint => '在审核界面加载模块时，自动将纯文本包裹为 <p> 段落标签。等同于手动点击 ¶ 按钮。';

  @override
  String get settingsDatabaseSync => '数据库同步';

  @override
  String get settingsDatabaseSyncTooltip => '将数据库条目与 JSON 翻译文件进行同步。';

  @override
  String get settingsDatabaseSyncHint => '将服务器上内部数据库条目与翻译 JSON 文件同步。';

  @override
  String get settingsSyncing => '正在同步...';

  @override
  String get settingsSyncNow => '立即同步';

  @override
  String get settingsSyncD11List => '同步 D11 列表';

  @override
  String get settingsUploadBackup => '上传备份（.zip）';

  @override
  String get settingsSelectZipFile => '选择 ZIP 文件';

  @override
  String get settingsUploading => '正在上传...';

  @override
  String get settingsErrorDiagnostics => '错误诊断与系统日志';

  @override
  String get settingsLogsCopied => '日志已复制到剪贴板！📋';

  @override
  String get settingsCopyLogs => '复制日志';

  @override
  String get settingsLogsRotated => '日志已归档并轮转！📁';

  @override
  String get settingsRotate => '轮转';

  @override
  String get settingsClear => '清除';

  @override
  String get settingsLogLimit => '日志上限：';

  @override
  String get settingsNoLogs => '没有记录的日志';

  @override
  String get layoutMenu => '菜单';

  @override
  String get layoutNavAnalytics => '统计分析';

  @override
  String get layoutNavReviewQueue => '审核队列';

  @override
  String get layoutNavGlossary => '术语表';

  @override
  String get layoutNavCategories => '分类';

  @override
  String get layoutNavHelp => '帮助';

  @override
  String get layoutNavSettings => '设置';

  @override
  String get layoutPhotoBy => '摄影：';

  @override
  String get layoutPhotoOn => '，来自 ';

  @override
  String get layoutEditProfile => '编辑资料';

  @override
  String get layoutLogout => '退出登录';

  @override
  String get layoutThemeLabel => '主题';

  @override
  String get layoutThemePearl => '浅色';

  @override
  String get layoutThemeDark => '深色';

  @override
  String get layoutThemeGlassy => '玻璃质感';

  @override
  String get layoutThemeNature => '自然';

  @override
  String get layoutThemeLiquid => '流动';

  @override
  String get layoutThemeStage => '舞台';

  @override
  String get layoutTargetLanguage => '目标语言';

  @override
  String get layoutDeeplUsage => 'DEEPL 使用量';

  @override
  String get layoutUnavailable => '不可用';

  @override
  String get layoutUnlimited => '无限制';

  @override
  String get layoutUsed => '已用';

  @override
  String get layoutTranslate => '翻译';

  @override
  String get analyticsSubtitle => '兼容性、翻译积压和每周趋势。';

  @override
  String get analyticsBacklog => '翻译积压';

  @override
  String get analyticsMissing => '缺失';

  @override
  String get analyticsStale => '已过时';

  @override
  String get analyticsInReview => '审核中';

  @override
  String get analyticsReleased => '已发布';

  @override
  String get analyticsTranslated => '已翻译';

  @override
  String get analyticsTotalModules => '模块总数';

  @override
  String get analyticsCompatByVersion => '按 Drupal 版本划分的兼容性';

  @override
  String analyticsLanguageLegend(String lang) {
    return '语言：$lang · 已发布 / 审核中 / 缺失';
  }

  @override
  String get analyticsLoadingCounts => '正在加载统计数据……';

  @override
  String get analyticsWindow => '时间范围：';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks 周';
  }

  @override
  String get analyticsNewDescriptionsPerWeek => '每周新增的项目描述';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return '每周被标记为过时的数量（$lang）';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count 个模块';
  }

  @override
  String get analyticsReviewShort => '审核';

  @override
  String get analyticsNoDataInWindow => '此时间范围内没有数据。';

  @override
  String get analyticsAndMore => '……以及更多';

  @override
  String glossaryLoadError(String error) {
    return '加载出错：$error';
  }

  @override
  String get glossaryNewTerm => '创建新术语';

  @override
  String get glossaryEditTerm => '编辑术语';

  @override
  String get glossaryFieldSourceWord => '源词（基本形式，即在文本中出现的形式）';

  @override
  String get glossaryFieldSourceWordHint => '例如 node（节点）';

  @override
  String get glossaryWordForms => '其他词形（复数、属格、与格等）';

  @override
  String get glossaryWordFormsHint => '例如 content（内容）— 按 Enter 键添加';

  @override
  String get glossaryAddForm => '添加词形';

  @override
  String get glossaryFieldPreferredWord => '首选译名';

  @override
  String get glossaryFieldPreferredWordHint => '例如 content（内容）';

  @override
  String get glossaryFieldExplanation => '说明（显示在工具提示中）';

  @override
  String get glossaryFieldExplanationHint => '为什么这个词应该采用不同的翻译？';

  @override
  String get glossaryCreate => '创建';

  @override
  String get glossaryRequiredFields => '源词和首选译名为必填项。';

  @override
  String get glossaryCreated => '术语已创建 ✓';

  @override
  String get glossaryUpdated => '术语已更新 ✓';

  @override
  String glossaryError(String error) {
    return '错误：$error';
  }

  @override
  String get glossaryDeleteTitle => '删除术语？';

  @override
  String glossaryDeleteBody(String word) {
    return '“$word”将从术语表中永久删除。';
  }

  @override
  String get glossaryDeleted => '术语已删除。';

  @override
  String get glossaryTitle => '翻译术语表';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return '语言：$lang · $count 条';
  }

  @override
  String get glossaryNewShort => '新建';

  @override
  String get glossaryCreateTerm => '创建术语';

  @override
  String get glossaryInfoBanner =>
      '此术语表中的词语会在审核编辑器中高亮显示，鼠标悬停时工具提示会说明为何更适合采用其他译法。';

  @override
  String get glossaryNoEntries => '暂无条目。';

  @override
  String get glossaryNoEntriesEditorHint => '点击“创建术语”以创建第一个条目。';

  @override
  String get glossaryNoEntriesForLanguage => '该语言暂无术语表条目。';

  @override
  String get diffNoChanges => '未检测到内容差异。';

  @override
  String get diffRemoved => '已删除';

  @override
  String get diffAdded => '已添加';

  @override
  String syncBarQuickSync(String count) {
    return '快速同步：已更改 $count 个模块……';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return '完整同步：$current / $total 个模块';
  }

  @override
  String syncBarFullSync(String count) {
    return '完整同步：$count 个模块……';
  }
}
