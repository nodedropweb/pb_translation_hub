// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => '프로젝트 상세 정보를 불러오는 중...';

  @override
  String editorLoadError(String error) {
    return '프로젝트 데이터를 불러오지 못했습니다: $error';
  }

  @override
  String get editorGeminiSuccess => 'Gemini 번역 성공! ✨';

  @override
  String get editorUnknownError => '알 수 없는 오류';

  @override
  String editorGeminiFailed(String detail) {
    return 'Gemini 번역 실패: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      '관리자 설정이 아닌 사용자 프로필에서 Google AI 키를 추가해 주세요.';

  @override
  String get editorGeminiError =>
      'Gemini 번역 중 오류가 발생했습니다. 프로필에서 Google AI 키를 확인해 주세요.';

  @override
  String get editorDeeplSuccess => 'DeepL 번역 성공! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'DeepL 번역 실패: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'DeepL 번역 중 오류가 발생했습니다. 프로필에 DeepL API 키가 설정되어 있는지 확인해 주세요.';

  @override
  String get editorDeeplInvalidKey => 'DeepL API 키가 유효하지 않습니다. 프로필에서 확인해 주세요.';

  @override
  String get editorDeeplQuotaExceeded => 'DeepL 할당량이 모두 소진되었습니다. 요금제를 확인해 주세요.';

  @override
  String get editorReviewReset => '번역이 검토 상태로 재설정되었습니다.';

  @override
  String editorResetError(String error) {
    return '재설정에 실패했습니다: $error';
  }

  @override
  String get editorUnignoreSuccess => '모듈이 활성 목록으로 되돌려졌습니다.';

  @override
  String get editorUnignoreError => '모듈의 무시를 해제하지 못했습니다.';

  @override
  String get editorSaveSuccess => '번역이 저장되었습니다 — 검토 대기열로 돌아갑니다.';

  @override
  String editorSaveError(String error) {
    return '저장하지 못했습니다: $error';
  }

  @override
  String get editorNoMoreProjects => '목록에 더 이상 열려 있는 프로젝트가 없습니다.';

  @override
  String get editorChangesDiscarded => '변경 사항이 취소되었습니다. 다음 프로젝트를 불러오는 중...';

  @override
  String get editorEnglishSourceApplied => '영어 원문이 적용되었습니다 — 지금 번역해 주세요.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'URL을 열 수 없습니다: $url';
  }

  @override
  String get commonSave => '저장';

  @override
  String get commonClose => '닫기';

  @override
  String get editorCloseEnglishSource => '영어 원문 닫기';

  @override
  String get editorShowEnglishSource => '영어 원문 표시';

  @override
  String get editorUnignoreShortTooltip => '모듈 무시 해제';

  @override
  String get editorBackToReviewTooltip => '검토 상태로 되돌리기';

  @override
  String get editorAndNext => '& 다음';

  @override
  String get editorBackToDashboard => '대시보드로 돌아가기';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return '$langName ($langCode)로 번역 중';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count개 남음';
  }

  @override
  String get editorUnignoreLongTooltip => '모듈을 활성 목록으로 되돌리기';

  @override
  String get editorUnignoreLabel => '무시 해제';

  @override
  String get editorUnpublishTooltip => '게시 취소 후 검토 상태로 되돌리기';

  @override
  String get editorBackToReview => '검토로 돌아가기';

  @override
  String get editorSaveAndNext => '저장 및 다음';

  @override
  String get editorEnglishSourceHeader => '영어 원문';

  @override
  String get editorStaleTooltip => '설명 표시 및 영어 텍스트 적용';

  @override
  String get editorStaleDetailsLabel => '오래됨 — 세부 정보';

  @override
  String get editorCopyPromptTooltip => '원문 + 번역 프롬프트 복사';

  @override
  String get editorPromptCopied => '프롬프트가 클립보드에 복사되었습니다 📋';

  @override
  String get editorShowPreview => '미리보기 표시';

  @override
  String get editorShowHtmlSource => 'HTML 소스 표시';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return '요약:\n$summary\n\n본문:\n$body';
  }

  @override
  String get editorSummaryLabelColon => '요약:';

  @override
  String get editorDescriptionLabelColon => '설명:';

  @override
  String get editorStaleDialogTitle => '영어 원문이 변경되었습니다';

  @override
  String get editorStaleExplanation =>
      '현재 번역은 오래된 영어 원문을 기반으로 합니다. 마지막 번역 이후 모듈 관리자가 Drupal.org에서 영어 텍스트를 변경했으므로, 기존 번역 내용이 더 이상 정확하거나 완전하지 않을 수 있습니다.';

  @override
  String get editorStaleTip =>
      '팁: \"영어 원문 사용\"을 클릭하면 현재 영어 원문을 편집기에 바로 불러올 수 있습니다. 이후 이를 새 번역의 시작점으로 활용할 수 있습니다. 영어 원문은 왼쪽 패널에서도 확인할 수 있습니다.';

  @override
  String get editorEnglishSourceShort => '영어 원문';

  @override
  String get editorPreviousTranslation => '이전 번역';

  @override
  String get editorWhatChangedTitle => '무엇이 변경되었나요?';

  @override
  String get editorShowDiff => '차이점 표시';

  @override
  String get editorUseEnglish => '영어 원문 사용';

  @override
  String get editorStaleBannerText => '영어 원문이 변경되었습니다 — 번역이 오래되었습니다';

  @override
  String get editorDetailsAndApply => '세부 정보 및 적용';

  @override
  String editorTranslationSectionHeader(String langName) {
    return '$langName 번역';
  }

  @override
  String get editorTranslatingEllipsis => '번역 중...';

  @override
  String get editorShowEditor => '편집기 표시';

  @override
  String get editorModuleTitleLabel => '모듈 제목 (영어)';

  @override
  String get editorSummaryFieldLabel => '요약';

  @override
  String get editorBodyFieldLabel => '본문';

  @override
  String get editorHtmlCleaned => 'HTML 정리됨';

  @override
  String get editorLivePreviewHeader => '실시간 미리보기';

  @override
  String get editorTidyHtmlTooltip => 'HTML 정리 (DeepL 잔여물 제거)';

  @override
  String get editorVisualMode => '비주얼';

  @override
  String get editorSourceCodeMode => '소스 (HTML)';

  @override
  String get commonCancel => '취소';

  @override
  String get costDialogTitle => '비용 예상 (AI)';

  @override
  String get costDialogIntro =>
      '선택한 모듈은 Google Gemini AI로 번역됩니다. 이 작업에 대한 예상 비용 내역은 다음과 같습니다:';

  @override
  String get costRowModel => '모델';

  @override
  String get costRowInputTokens => '입력 토큰';

  @override
  String get costRowOutputTokens => '출력 토큰 (추정치)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars자)';
  }

  @override
  String get costRowPriceInput => '입력 100만 개당 가격';

  @override
  String get costRowPriceOutput => '출력 100만 개당 가격';

  @override
  String get costRowTotalEstimate => '예상 총 비용';

  @override
  String get costDialogFootnote =>
      '* 참고: 이는 현재 Google 종량제 가격 모델을 기반으로 한 추정치입니다. 실제 사용량은 다소 다를 수 있습니다.';

  @override
  String get costDialogStartTranslation => '번역 시작';

  @override
  String get htmlToolbarInsertLink => '링크 삽입';

  @override
  String get htmlToolbarLinkTooltip => '링크 삽입 (a)';

  @override
  String get htmlToolbarInsert => '삽입';

  @override
  String get htmlToolbarHeading2 => '제목 2';

  @override
  String get htmlToolbarHeading3 => '제목 3';

  @override
  String get htmlToolbarBold => '굵게 (strong)';

  @override
  String get htmlToolbarItalic => '기울임꼴 (em)';

  @override
  String get htmlToolbarBulletList => '글머리 기호 목록 (ul)';

  @override
  String get htmlToolbarNumberedList => '번호 매기기 목록 (ol)';

  @override
  String get htmlToolbarQuote => '인용문 (blockquote)';

  @override
  String get screenshotAltsHeader => '스크린샷 대체 텍스트';

  @override
  String get screenshotAltsIntro => '각 스크린샷에 대상 언어로 설명적인 대체 텍스트를 입력하세요.';

  @override
  String screenshotLabel(int number) {
    return '스크린샷 $number';
  }

  @override
  String get screenshotPreviewUnavailable => '미리보기를 사용할 수 없습니다';

  @override
  String get screenshotAltHint => '대상 언어로 대체 텍스트를 입력하세요…';

  @override
  String get dashUnignoreAllConfirmTitle => '모든 모듈의 무시를 해제하시겠습니까?';

  @override
  String get dashUnignoreAllConfirmBody =>
      '무시된 모든 모듈이 활성 목록으로 되돌려지며 다시 번역할 수 있게 됩니다.';

  @override
  String get dashUnignoreAllConfirmAction => '전체 무시 해제';

  @override
  String get dashUnignoreAllSuccess => '무시된 모든 모듈의 무시가 해제되었습니다.';

  @override
  String get dashUnignoreAllError => '모듈의 무시를 해제하지 못했습니다.';

  @override
  String get dashUnignoreAllButton => '모든 모듈 무시 해제';

  @override
  String dashSyncStartError(String error) {
    return '동기화를 시작하지 못했습니다: $error';
  }

  @override
  String get dashQuickUpdateStarted => '빠른 업데이트(7일)가 시작되었습니다 ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return '빠른 업데이트 오류: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return '동기화 성공: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Drupal.org에서 모듈을 찾을 수 없습니다.';

  @override
  String get dashAiBulkTranslation => 'AI 대량 번역';

  @override
  String get dashHeaderTitle => '프로젝트 설명';

  @override
  String get dashHeaderSubtitle =>
      'Drupal 모듈 설명을 대상 언어로 번역하세요. 생태계를 더 쉽게 접근할 수 있도록 도와주세요.';

  @override
  String get dashHeaderSubtitleShort => 'Drupal 모듈 설명을 번역하세요.';

  @override
  String get dashLastLabel => '최근: ';

  @override
  String get dashContinue => '계속';

  @override
  String get dashContinueShort => '계속';

  @override
  String get dashUnignoreAllButtonLong => '모든 모듈 무시 해제';

  @override
  String get dashQuickUpdateTooltip => '빠른 업데이트 (최근 7일)';

  @override
  String get dashFullSyncTooltip => 'Drupal.org로부터 전체 데이터베이스 동기화';

  @override
  String get dashManualLoadTooltip => 'Drupal.org에서 모듈 하나를 수동으로 불러오기';

  @override
  String get dashQuickShort => '빠른';

  @override
  String get dashModuleShort => '모듈';

  @override
  String get dashFoundLabel => '찾음: ';

  @override
  String get dashModulesSuffix => '개 모듈';

  @override
  String dashPerPage(int count) {
    return '페이지당 $count개';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count개 / 페이지';
  }

  @override
  String get dashFirstPage => '첫 페이지';

  @override
  String get dashPrevPage => '이전 페이지';

  @override
  String get dashNextPage => '다음 페이지';

  @override
  String get dashLastPage => '마지막 페이지';

  @override
  String dashPageOf(int page, int total) {
    return '$total 중 $page 페이지';
  }

  @override
  String get dashMachineNameHint => 'machine_name (예: pathauto)';

  @override
  String get dashAddButton => '추가';

  @override
  String get dashAddModuleManually => '모듈 수동 추가';

  @override
  String get dashAddModuleSubtitle => 'machine name으로 Drupal.org에서 직접 불러오기.';

  @override
  String get dashAddModuleShort => '모듈 추가';

  @override
  String get dashNoProjectsFound => '프로젝트를 찾을 수 없습니다.';

  @override
  String get dashFilterAll => '모든 프로젝트';

  @override
  String get dashFilterMissing => '번역 누락';

  @override
  String get dashFilterReview => '검토 대기열';

  @override
  String get dashFilterTranslated => '번역된 프로젝트';

  @override
  String get dashFilterReleased => '게시된 프로젝트';

  @override
  String get dashBulkDialogIntro =>
      'Google Gemini를 사용하여 선택한 필터의 여러 모듈을 자동으로 번역합니다.';

  @override
  String get dashActiveFilter => '활성 필터';

  @override
  String get dashModuleCount => '모듈 수';

  @override
  String dashModulesCountItem(int count) {
    return '$count개 모듈';
  }

  @override
  String get dashPrioritizeD12Title => 'Drupal 12 모듈 우선 처리';

  @override
  String get dashPrioritizeD12Subtitle => 'Drupal 12를 지원하지 않는 모듈을 먼저 번역합니다';

  @override
  String get dashTotalModules => '전체 모듈';

  @override
  String get dashInputTokensEst => '입력 토큰 (추정치)';

  @override
  String get dashOutputTokensEst => '출력 토큰 (추정치)';

  @override
  String get dashBulkFootnote => '* 시간 초과를 방지하기 위해 번역은 리소스 효율적인 배치로 실행됩니다.';

  @override
  String get dashStartBulkTranslation => '대량 번역 시작';

  @override
  String dashStaleLoadError(String error) {
    return '오래된 모듈을 불러오는 중 오류: $error';
  }

  @override
  String get dashNoStaleModules => '오래된 모듈이 없습니다 — 모두 최신 상태입니다! ✨';

  @override
  String get dashRetranslateOutdatedTitle => '오래된 모듈 재번역';

  @override
  String get dashRetranslateOutdatedIntro =>
      '마지막 번역 이후 영어 원문이 변경된 모든 번역이 Google Gemini를 사용하여 자동으로 재번역됩니다. 각 모듈을 수동으로 열 필요가 없습니다.';

  @override
  String get dashOutdatedModules => '오래된 모듈';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* 번역은 기존 텍스트를 대체하고 is_reviewed를 재설정합니다. 4개 모듈씩 배치로 실행됩니다.';

  @override
  String dashRetranslateAllCount(int count) {
    return '$count개 모듈 전체 재번역';
  }

  @override
  String get dashRetranslatingOutdatedTitle => '오래된 모듈을 재번역하는 중…';

  @override
  String get dashFetchingProjects => '서버에서 프로젝트를 가져오는 중…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$total개 중 $processed개 모듈 처리됨';
  }

  @override
  String get dashNoTranslatableProjects => '이 필터에 해당하는 번역 가능한 프로젝트가 없습니다.';

  @override
  String get dashStartingTranslation => '번역을 시작하는 중…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return '$total개 중 모듈 $start–$end 번역 중 …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$total개 중 $end개 모듈 완료.';
  }

  @override
  String get dashTranslationCompleted => '번역이 성공적으로 완료되었습니다! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '모듈 $count개의 대량 번역에 성공했습니다! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return '대량 번역 오류: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return '모듈 $count개가 모두 성공적으로 재번역되었습니다! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '오래된 모듈 $count개가 성공적으로 재번역되었습니다! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return '재번역 중 오류: $error';
  }

  @override
  String get filterAllShort => '전체';

  @override
  String get filterMissing => '누락';

  @override
  String get filterTranslated => '번역됨';

  @override
  String get filterReviewQueue => '검토 대기열';

  @override
  String get filterReleased => '게시됨';

  @override
  String get filterOutdated => '오래됨';

  @override
  String get filterPriority => '우선순위';

  @override
  String get filterIgnored => '무시됨';

  @override
  String get commonEdit => '편집';

  @override
  String get commonReset => '재설정';

  @override
  String get commonRefresh => '새로고침';

  @override
  String commonErrorPrefix(String error) {
    return '오류: $error';
  }

  @override
  String get reviewResetAllConfirmTitle => '게시된 모든 번역을 재설정하시겠습니까?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return '$langcode에 대해 게시됨으로 표시된 모든 번역이 검토 상태로 재설정됩니다. 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count개 번역이 검토 상태로 재설정되었습니다.';
  }

  @override
  String get reviewPipelineTitle => '검토 파이프라인';

  @override
  String get reviewPipelineSubtitle => 'AI 번역을 위한 사람 품질 보증 파이프라인';

  @override
  String get reviewSearchHint => '프로젝트 검색...';

  @override
  String get reviewResetPublished => '게시됨 재설정';

  @override
  String reviewResultsCount(int count, int total) {
    return '결과: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return '대기 중: $count';
  }

  @override
  String get reviewNoProjectsPending => '검토 대기 중인 프로젝트가 없습니다.';

  @override
  String get reviewAllVerifiedOrNone =>
      '모든 번역이 이미 검증되었거나 이 언어 컨텍스트에 존재하지 않습니다.';

  @override
  String get reviewNoSummary => '요약이 없습니다.';

  @override
  String get reviewStartAudit => '감사 시작';

  @override
  String get reviewHtmlSourceShort => 'HTML 소스';

  @override
  String get reviewCopySource => '원문 복사';

  @override
  String get reviewModuleDetails => '모듈 세부 정보';

  @override
  String get reviewOriginalTitle => '원본 제목';

  @override
  String get reviewDrupalOrgProject => 'Drupal.org 프로젝트';

  @override
  String get reviewSuggestions => '제안';

  @override
  String get reviewNoSuggestions => '사용 가능한 제안이 없습니다.';

  @override
  String get reviewApply => '적용';

  @override
  String get reviewNoChanges => '변경 사항 없음';

  @override
  String get reviewOriginalBeforeCorrection => '원본 (수정 전)';

  @override
  String get reviewCorrectedCurrentVersion => '수정됨 (현재 버전)';

  @override
  String get reviewBaseOriginal => '기준 (원본)';

  @override
  String get reviewYourCorrection => '회원님의 수정';

  @override
  String get reviewChangesVisual => '변경 사항 검토 (비주얼)';

  @override
  String get commonSkip => '건너뛰기';

  @override
  String get commonIgnore => '무시';

  @override
  String get reviewEmptyProjectTitle => '빈 프로젝트';

  @override
  String get reviewEmptyProjectBody =>
      '이 프로젝트는 비어 있으며(제목, 요약 또는 본문 없음) 승인할 수 없습니다. 건너뛰어 주세요.';

  @override
  String get reviewApprovedSuccess => '번역이 승인되었습니다! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ \"$machine\" 승인에 실패했습니다 — 다시 시도해 주세요.';
  }

  @override
  String get reviewUnignoredSuccess => '무시가 해제되었습니다. 모듈이 다시 활성화되었습니다!';

  @override
  String get reviewActionFailed => '작업에 실패했습니다.';

  @override
  String get reviewIgnoreModuleTitle => '모듈을 무시하시겠습니까?';

  @override
  String get reviewIgnoreModuleBody =>
      '이 모듈은 모든 목록에서 영구적으로 숨겨집니다. 더 이상 이 모듈에 발목 잡히지 않습니다.';

  @override
  String get reviewModulePermanentlyIgnored => '모듈이 영구적으로 무시되었습니다.';

  @override
  String get reviewIgnoreFailed => '모듈을 무시하지 못했습니다.';

  @override
  String get reviewSuggestionSaved => '제안 초안이 저장되었습니다! 💾';

  @override
  String get reviewSaveSuggestionFailed => '제안 초안을 저장하지 못했습니다.';

  @override
  String get reviewSuggestionDeleted => '제안이 삭제되었습니다.';

  @override
  String get reviewDeleteFailed => '삭제하지 못했습니다.';

  @override
  String get reviewSuggestionApplied => '제안이 적용되었습니다.';

  @override
  String get reviewPreparingData => '검토 데이터를 준비하는 중...';

  @override
  String get reviewDirectEdit => '직접 편집';

  @override
  String get reviewLivePreview => '실시간 미리보기';

  @override
  String get reviewCompareWith => '비교 대상:';

  @override
  String get reviewProductionVersion => '운영 버전';

  @override
  String get reviewEditorialReview => '편집 검토';

  @override
  String get reviewOpenQueue => '검토 대기열 열기';

  @override
  String get reviewCopyPromptShort => '프롬프트 복사';

  @override
  String get reviewUnignoreShort => '무시 해제';

  @override
  String get reviewApproveButton => '승인';

  @override
  String get reviewHideDetails => '세부 정보 숨기기';

  @override
  String get reviewDetailsAndEnglishSource => '세부 정보 및 영어 원문';

  @override
  String reviewPendingCountShort(int count) {
    return '$count개 대기 중';
  }

  @override
  String reviewReviewingModule(String name) {
    return '$name 검토 중';
  }

  @override
  String get reviewCompareTranslationTooltip => '번역을 영어 원문과 비교';

  @override
  String get reviewTranslationLabel => '번역';

  @override
  String get reviewComparisonTitle => '비교';

  @override
  String get reviewCopyPromptLongTooltip => '원문 텍스트 + 번역 프롬프트를 클립보드에 복사';

  @override
  String get reviewUnignoreCaps => '무시 해제';

  @override
  String get reviewIgnoreCaps => '무시';

  @override
  String get reviewSkipShortcut => '건너뛰기 (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => '편집 검토';

  @override
  String get reviewUnignoreTablet => '무시 해제';

  @override
  String get reviewApproveForProduction => '운영 환경에 승인 (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => '직접 다듬기';

  @override
  String get reviewTitleField => '제목';

  @override
  String get reviewSummaryField => '요약';

  @override
  String get reviewBodyField => '본문 콘텐츠';

  @override
  String get reviewSaveShortcut => '저장 (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => '실시간 미리보기 (렌더링 중)';

  @override
  String get reviewVoiceFemale => '여성';

  @override
  String get reviewVoiceMale => '남성';

  @override
  String get reviewStopListening => '중지';

  @override
  String get reviewListen => '듣기';

  @override
  String get reviewAutopTooltip => '단락 자동 서식 지정 (줄바꿈 → <p>)';

  @override
  String get reviewSourceCodeShort => '소스';

  @override
  String get reviewNoParagraphChange => '텍스트에 이미 <p> 태그가 있습니다 — 변경 사항 없음';

  @override
  String get reviewParagraphsFormatted => '단락이 서식 지정되었습니다 ¶';

  @override
  String get commonRetry => '다시 시도';

  @override
  String categoriesLoadError(String error) {
    return '카테고리를 불러오지 못했습니다: $error';
  }

  @override
  String get categoriesSaveSuccess => '카테고리가 성공적으로 저장되었습니다.';

  @override
  String get categoriesSaveFailed => '번역을 저장하지 못했습니다.';

  @override
  String get categoriesFileEmpty => '파일이 비어 있습니다.';

  @override
  String get categoriesInvalidJson => '잘못된 JSON 형식입니다.';

  @override
  String get categoriesNoValidUuids => '파일에서 유효한 UUID 항목을 찾을 수 없습니다.';

  @override
  String categoriesImportSuccess(int count) {
    return '파일에서 카테고리 $count개를 가져왔습니다.';
  }

  @override
  String get categoriesTitle => '카테고리';

  @override
  String categoriesTranslatingFor(String lang) {
    return '번역 대상: $lang';
  }

  @override
  String get categoriesImportJson => 'JSON 가져오기';

  @override
  String get categoriesSaving => '저장 중...';

  @override
  String get categoriesSaveAll => '모두 저장';

  @override
  String get categoriesLoading => '카테고리를 불러오는 중...';

  @override
  String categoriesTranslationColumn(String code) {
    return '번역 ($code)';
  }

  @override
  String get categoriesNoneFound => '카테고리를 찾을 수 없습니다.';

  @override
  String categoriesTranslateHint(String name) {
    return '\"$name\" 번역...';
  }

  @override
  String get loginPhotoBy => '사진 제공: ';

  @override
  String get loginPhotoOn => ' — ';

  @override
  String get loginPleaseSignIn => '로그인해 주세요';

  @override
  String get loginUsername => '사용자 이름';

  @override
  String get loginPassword => '비밀번호';

  @override
  String get loginRememberMe => '로그인 상태 유지';

  @override
  String get loginSignIn => '로그인';

  @override
  String get loginNoAccount => '아직 계정이 없으신가요? ';

  @override
  String get loginRegisterNow => '지금 가입하기';

  @override
  String get commonBack => '뒤로';

  @override
  String get commonNext => '다음';

  @override
  String get registerFillRequired => '필수 항목을 모두 입력해 주세요.';

  @override
  String get registerPasswordMismatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get registerPasswordTooShort => '비밀번호는 최소 8자 이상이어야 합니다.';

  @override
  String get registerSelectLanguage => '언어를 하나 이상 선택해 주세요.';

  @override
  String get registerFailed => '가입에 실패했습니다.';

  @override
  String get registerHeaderTitle => '회원가입';

  @override
  String get registerStepAccount => '계정';

  @override
  String get registerStepRole => '역할';

  @override
  String get registerStepLanguages => '언어';

  @override
  String get registerStepApiKeys => 'API 키';

  @override
  String get registerYourAccount => '회원님의 계정';

  @override
  String get registerAvatarOptional => '아바타 (선택 사항)';

  @override
  String get registerUsernameRequired => '사용자 이름 *';

  @override
  String get registerEmailRequired => '이메일 주소 *';

  @override
  String get registerPasswordRequired => '비밀번호 *';

  @override
  String get registerPasswordRepeat => '비밀번호 확인 *';

  @override
  String get registerYourRole => '회원님의 역할';

  @override
  String get registerRoleExplanation =>
      '번역가는 텍스트를 번역할 수 있지만 검토 대기열에는 접근할 수 없습니다. 검토자는 번역된 콘텐츠를 확인하고 승인합니다.';

  @override
  String get registerRoleTranslator => '번역가';

  @override
  String get registerRoleTranslatorDesc => '번역을 작성하고 편집합니다.';

  @override
  String get registerRoleReviewer => '검토자';

  @override
  String get registerRoleReviewerDesc => '번역을 검토하고 승인합니다.';

  @override
  String get registerTargetLanguages => '대상 언어';

  @override
  String get registerLanguagesExplanation => '작업하고자 하는 모든 언어를 선택하세요.';

  @override
  String get registerNoLanguagesAvailable => '사용 가능한 언어가 없습니다.';

  @override
  String get registerApiKeysTitle => 'API 키';

  @override
  String get registerApiKeysExplanation =>
      '본인의 API 키를 입력하세요. 각 사용자는 오직 자신의 키만 사용합니다. 나중에 프로필에서 추가할 수도 있습니다.';

  @override
  String get registerKeysEncryptedNote => '키는 암호화되어 저장되며 다른 사용자와 공유되지 않습니다.';

  @override
  String get registerOptionalSuffix => ' (선택 사항)';

  @override
  String get registerSuccessTitle => '가입이 완료되었습니다!';

  @override
  String get registerSuccessBody =>
      '계정이 생성되었으며 관리자의 승인을 기다리고 있습니다. 접근 권한이 활성화되면 알림을 받게 됩니다.';

  @override
  String get registerGoToLogin => '로그인으로 이동';

  @override
  String get registerSubmit => '가입하기';

  @override
  String registerPhotoCredit(String name) {
    return '사진 제공: $name (Unsplash)';
  }

  @override
  String get profileUpdateSuccess => '프로필이 성공적으로 업데이트되었습니다!';

  @override
  String get profileUpdateFailed => '업데이트에 실패했습니다.';

  @override
  String profileSaveError(String error) {
    return '저장 중 오류가 발생했습니다: $error';
  }

  @override
  String get profilePasswordMismatch => '비밀번호가 일치하지 않습니다!';

  @override
  String get profilePasswordChangeSuccess => '비밀번호가 성공적으로 변경되었습니다!';

  @override
  String get profilePasswordChangeError =>
      '비밀번호 변경 중 오류가 발생했습니다: 현재 비밀번호가 올바르지 않습니다.';

  @override
  String get profileAvatarUploadSuccess => '아바타가 성공적으로 업로드되었습니다!';

  @override
  String get profileAvatarUploadError => '아바타 업로드 중 오류가 발생했습니다.';

  @override
  String get profileTitle => '프로필 및 설정';

  @override
  String get profileSubtitle =>
      '사용자 프로필, 번역 API(Gemini 및 DeepL), 계정 보안을 관리하세요.';

  @override
  String get profileRoleUser => '사용자';

  @override
  String get profileNoEmail => '제공된 이메일 주소가 없습니다';

  @override
  String get profileTabDetails => '프로필 세부 정보';

  @override
  String get profileTabGemini => 'AI 번역 (Gemini)';

  @override
  String get profileTabDeepl => 'DeepL 번역';

  @override
  String get profileTabPassword => '비밀번호 변경';

  @override
  String get profileSectionInfo => '프로필 정보';

  @override
  String get profileFieldName => '이름';

  @override
  String get profileFieldNameHint => '전체 이름';

  @override
  String get profileFieldEmail => '이메일 주소';

  @override
  String get profileFieldEmailHint => '이메일 주소';

  @override
  String get profileSectionGemini => 'GEMINI 코파일럿 설정';

  @override
  String get profileFieldGeminiKey => 'Google Gemini API 키';

  @override
  String get profileFieldGeminiKeyHint => 'gemini-3.1-flash API 키를 입력하세요';

  @override
  String get profileFieldAiPrompt => '사용자 지정 AI 프롬프트';

  @override
  String get profileFieldAiPromptHint =>
      '선택 사항: Gemini의 시스템 프롬프트를 사용자 지정하세요...';

  @override
  String get profileSectionDeepl => 'DEEPL 번역 설정';

  @override
  String get profileDeeplDescription =>
      'DeepL은 HTML 태그를 보존하면서 고품질 기계 번역을 제공합니다. 무료 계정(월 500,000자)에는 \":fx\" 접미사가 붙은 키가 발급됩니다.';

  @override
  String get profileFieldDeeplKey => 'DeepL API 키';

  @override
  String get profileFieldDeeplKeyHint =>
      '예: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      '무료 키는 \":fx\"로 끝나며 api-free.deepl.com을 사용합니다. Pro 키는 api.deepl.com을 사용합니다. 구분은 자동으로 이루어집니다.';

  @override
  String get profileSectionSecurity => '계정 보안';

  @override
  String get profileFieldCurrentPassword => '현재 비밀번호';

  @override
  String get profileFieldCurrentPasswordHint => '현재 비밀번호를 입력하세요';

  @override
  String get profileFieldNewPassword => '새 비밀번호';

  @override
  String get profileFieldNewPasswordHint => '최소 6자 이상';

  @override
  String get profileFieldConfirmPassword => '새 비밀번호 확인';

  @override
  String get profileFieldConfirmPasswordHint => '비밀번호를 다시 입력하세요';

  @override
  String get profileChangePasswordButton => '비밀번호 변경';

  @override
  String get commonDelete => '삭제';

  @override
  String get settingsRegistrationUpdated => '가입 설정이 업데이트되었습니다';

  @override
  String get settingsUpdateFailed => '업데이트에 실패했습니다.';

  @override
  String get settingsUserApproved => '사용자가 승인되었습니다!';

  @override
  String get settingsAccountDeactivated => '계정이 비활성화되었습니다.';

  @override
  String get settingsUserDeleted => '사용자가 삭제되었습니다.';

  @override
  String get settingsActionFailed => '작업에 실패했습니다.';

  @override
  String get settingsDeleteAccountTitle => '계정을 삭제하시겠습니까?';

  @override
  String get settingsDeactivateAccountTitle => '계정을 비활성화하시겠습니까?';

  @override
  String settingsDeleteAccountBody(String username) {
    return '\"$username\" 계정이 영구적으로 삭제됩니다. 계속하시겠습니까?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return '\"$username\" 계정이 잠깁니다. 사용자는 더 이상 로그인할 수 없지만 계정은 유지됩니다.';
  }

  @override
  String get settingsDeactivate => '비활성화';

  @override
  String settingsSyncSuccess(String count) {
    return '$count개 번역이 동기화되었습니다!';
  }

  @override
  String settingsSyncError(String error) {
    return '동기화 오류: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '우선순위 모듈 $count개가 동기화되었습니다!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return '우선순위 목록 동기화 오류: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return '백업 성공: 파일 $count개가 처리되었습니다.';
  }

  @override
  String get settingsUploadFailed => '업로드에 실패했습니다.';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsSystemConfig => '시스템 구성';

  @override
  String get settingsRegistration => '가입';

  @override
  String get settingsRegistrationHint => '전역 가입 양식의 표시 여부를 전환합니다.';

  @override
  String get settingsPendingUsers => '대기 중인 사용자';

  @override
  String get settingsNoNewRequests => '새로운 요청이 없습니다.';

  @override
  String get settingsWantsReviewer => '검토자 희망';

  @override
  String get settingsAssignRole => '역할 지정';

  @override
  String get settingsRoleTranslator => '번역가';

  @override
  String get settingsRoleReviewer => '검토자';

  @override
  String get settingsApprove => '승인';

  @override
  String get settingsReject => '거부';

  @override
  String get settingsActiveUsers => '활성 사용자';

  @override
  String get settingsNoActiveUsers => '활성 사용자가 없습니다.';

  @override
  String get settingsDeactivateAccountTooltip => '비활성화';

  @override
  String get settingsDeleteAccountAction => '계정 삭제';

  @override
  String get settingsAppearance => '화면';

  @override
  String get settingsThemePearl => '밝게 (펄)';

  @override
  String get settingsThemeDark => '어둡게';

  @override
  String get settingsThemeGlassy => '글래시';

  @override
  String get settingsThemeNature => '네이처';

  @override
  String get settingsThemeLiquid => '리퀴드';

  @override
  String get settingsThemeStage => '스테이지';

  @override
  String get settingsTypography => '타이포그래피';

  @override
  String get settingsFontHint => '인터페이스 글꼴을 변경합니다.';

  @override
  String get settingsFontClean => '클린';

  @override
  String get settingsFontFuturistic => '퓨처리스틱';

  @override
  String get settingsFontTech => '테크';

  @override
  String get settingsWorkflowFun => '작업 흐름 및 재미';

  @override
  String get settingsConfettiTitle => '성공 축하 효과 (색종이 조각)';

  @override
  String get settingsConfettiHint => '저장에 성공하면 작은 애니메이션을 표시합니다.';

  @override
  String get settingsLargeUiTitle => '가독성 향상 (큰 글꼴)';

  @override
  String get settingsLargeUiHint => '가독성을 위해 글꼴과 배지 크기를 키웁니다.';

  @override
  String get settingsAutoPTitle => '단락 자동 서식 지정 (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      '검토 화면에서 모듈이 로드될 때 일반 텍스트를 자동으로 <p> 단락으로 감쌉니다. ¶ 버튼을 수동으로 클릭하는 것과 동일합니다.';

  @override
  String get settingsDatabaseSync => '데이터베이스 동기화';

  @override
  String get settingsDatabaseSyncTooltip => 'DB 항목을 JSON 번역 파일과 동기화합니다.';

  @override
  String get settingsDatabaseSyncHint => '내부 데이터베이스 항목을 서버의 번역 JSON과 동기화합니다.';

  @override
  String get settingsSyncing => '동기화 중...';

  @override
  String get settingsSyncNow => '지금 동기화';

  @override
  String get settingsSyncD11List => 'D11 목록 동기화';

  @override
  String get settingsUploadBackup => '백업 업로드 (.zip)';

  @override
  String get settingsSelectZipFile => 'ZIP 파일 선택';

  @override
  String get settingsUploading => '업로드 중...';

  @override
  String get settingsErrorDiagnostics => '오류 진단 및 시스템 로그';

  @override
  String get settingsLogsCopied => '로그가 클립보드에 복사되었습니다! 📋';

  @override
  String get settingsCopyLogs => '로그 복사';

  @override
  String get settingsLogsRotated => '로그가 보관 및 순환 처리되었습니다! 📁';

  @override
  String get settingsRotate => '순환';

  @override
  String get settingsClear => '지우기';

  @override
  String get settingsLogLimit => '로그 제한: ';

  @override
  String get settingsNoLogs => '기록된 로그가 없습니다';

  @override
  String get layoutMenu => '메뉴';

  @override
  String get layoutNavAnalytics => '분석';

  @override
  String get layoutNavReviewQueue => '검토 대기열';

  @override
  String get layoutNavGlossary => '용어집';

  @override
  String get layoutNavCategories => '카테고리';

  @override
  String get layoutNavHelp => '도움말';

  @override
  String get layoutNavSettings => '설정';

  @override
  String get layoutPhotoBy => '사진 제공: ';

  @override
  String get layoutPhotoOn => ' — ';

  @override
  String get layoutEditProfile => '프로필 편집';

  @override
  String get layoutLogout => '로그아웃';

  @override
  String get layoutThemeLabel => '테마';

  @override
  String get layoutThemePearl => '밝게';

  @override
  String get layoutThemeDark => '어둡게';

  @override
  String get layoutThemeGlassy => '글래시';

  @override
  String get layoutThemeNature => '네이처';

  @override
  String get layoutThemeLiquid => '리퀴드';

  @override
  String get layoutThemeStage => '스테이지';

  @override
  String get layoutTargetLanguage => '대상 언어';

  @override
  String get layoutDeeplUsage => 'DEEPL 사용량';

  @override
  String get layoutUnavailable => '사용 불가';

  @override
  String get layoutUnlimited => '무제한';

  @override
  String get layoutUsed => '사용됨';

  @override
  String get layoutTranslate => '번역';

  @override
  String get analyticsSubtitle => '호환성, 번역 잔여 작업량, 주간 추세.';

  @override
  String get analyticsBacklog => '번역 잔여 작업량';

  @override
  String get analyticsMissing => '누락';

  @override
  String get analyticsStale => '오래됨';

  @override
  String get analyticsInReview => '검토 중';

  @override
  String get analyticsReleased => '게시됨';

  @override
  String get analyticsTranslated => '번역됨';

  @override
  String get analyticsTotalModules => '전체 모듈';

  @override
  String get analyticsCompatByVersion => 'Drupal 버전별 호환성';

  @override
  String analyticsLanguageLegend(String lang) {
    return '언어: $lang · 게시됨 / 검토 중 / 누락';
  }

  @override
  String get analyticsLoadingCounts => '개수를 불러오는 중 …';

  @override
  String get analyticsWindow => '기간:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks주';
  }

  @override
  String get analyticsNewDescriptionsPerWeek => '주간 신규 프로젝트 설명';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return '주간 오래됨으로 표시된 항목 ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count개 모듈';
  }

  @override
  String get analyticsReviewShort => '검토';

  @override
  String get analyticsNoDataInWindow => '이 기간에 대한 데이터가 없습니다.';

  @override
  String get analyticsAndMore => '… 및 더 보기';

  @override
  String glossaryLoadError(String error) {
    return '불러오기 오류: $error';
  }

  @override
  String get glossaryNewTerm => '새 용어 만들기';

  @override
  String get glossaryEditTerm => '용어 편집';

  @override
  String get glossaryFieldSourceWord => '원본 단어 (텍스트에 나타나는 기본형)';

  @override
  String get glossaryFieldSourceWordHint => '예: node';

  @override
  String get glossaryWordForms => '추가 단어 형태 (복수형, 소유격, 여격 등)';

  @override
  String get glossaryWordFormsHint => '예: content — Enter 키를 눌러 추가';

  @override
  String get glossaryAddForm => '형태 추가';

  @override
  String get glossaryFieldPreferredWord => '선호 번역';

  @override
  String get glossaryFieldPreferredWordHint => '예: content';

  @override
  String get glossaryFieldExplanation => '설명 (툴팁에 표시됨)';

  @override
  String get glossaryFieldExplanationHint => '이 단어를 다르게 번역해야 하는 이유는 무엇인가요?';

  @override
  String get glossaryCreate => '만들기';

  @override
  String get glossaryRequiredFields => '원본 단어와 선호 번역은 필수입니다.';

  @override
  String get glossaryCreated => '용어가 생성되었습니다 ✓';

  @override
  String get glossaryUpdated => '용어가 업데이트되었습니다 ✓';

  @override
  String glossaryError(String error) {
    return '오류: $error';
  }

  @override
  String get glossaryDeleteTitle => '용어를 삭제하시겠습니까?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\"이(가) 용어집에서 영구적으로 삭제됩니다.';
  }

  @override
  String get glossaryDeleted => '용어가 삭제되었습니다.';

  @override
  String get glossaryTitle => '번역 용어집';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return '언어: $lang · $count개 항목';
  }

  @override
  String get glossaryNewShort => '신규';

  @override
  String get glossaryCreateTerm => '용어 만들기';

  @override
  String get glossaryInfoBanner =>
      '이 용어집의 단어는 검토 편집기에서 강조 표시됩니다. 마우스를 올리면 다른 번역이 더 적합한 이유를 설명하는 툴팁이 표시됩니다.';

  @override
  String get glossaryNoEntries => '아직 항목이 없습니다.';

  @override
  String get glossaryNoEntriesEditorHint => '첫 항목을 만들려면 \"용어 만들기\"를 클릭하세요.';

  @override
  String get glossaryNoEntriesForLanguage => '이 언어에 대한 용어집 항목이 아직 없습니다.';

  @override
  String get diffNoChanges => '콘텐츠 차이가 감지되지 않았습니다.';

  @override
  String get diffRemoved => '삭제됨';

  @override
  String get diffAdded => '추가됨';

  @override
  String syncBarQuickSync(String count) {
    return '빠른 동기화: 변경된 모듈 $count개 …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return '전체 동기화: $current / $total개 모듈';
  }

  @override
  String syncBarFullSync(String count) {
    return '전체 동기화: 모듈 $count개 …';
  }
}
