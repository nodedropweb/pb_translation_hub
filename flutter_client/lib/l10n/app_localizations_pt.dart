// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Carregando detalhes do projeto...';

  @override
  String editorLoadError(String error) {
    return 'Falha ao carregar os dados do projeto: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Tradução com o Gemini realizada com sucesso! ✨';

  @override
  String get editorUnknownError => 'Erro desconhecido';

  @override
  String editorGeminiFailed(String detail) {
    return 'Falha na tradução com o Gemini: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Adicione sua chave do Google AI no seu perfil de usuário (não nas configurações de administrador).';

  @override
  String get editorGeminiError =>
      'Erro durante a tradução com o Gemini. Verifique sua chave do Google AI no seu perfil.';

  @override
  String get editorDeeplSuccess =>
      'Tradução com o DeepL realizada com sucesso! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Falha na tradução com o DeepL: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Erro durante a tradução com o DeepL. Verifique se sua chave de API do DeepL está definida no seu perfil.';

  @override
  String get editorDeeplInvalidKey =>
      'Chave de API do DeepL inválida. Verifique-a no seu perfil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Cota do DeepL esgotada. Verifique seu plano.';

  @override
  String get editorReviewReset =>
      'Tradução redefinida para o status de revisão.';

  @override
  String editorResetError(String error) {
    return 'Falha ao redefinir: $error';
  }

  @override
  String get editorUnignoreSuccess => 'O módulo foi devolvido à lista ativa.';

  @override
  String get editorUnignoreError => 'Falha ao restaurar o módulo.';

  @override
  String get editorSaveSuccess =>
      'Tradução salva — de volta à fila de revisão.';

  @override
  String editorSaveError(String error) {
    return 'Falha ao salvar: $error';
  }

  @override
  String get editorNoMoreProjects => 'Não há mais projetos abertos na lista.';

  @override
  String get editorChangesDiscarded =>
      'Alterações descartadas, carregando o próximo projeto...';

  @override
  String get editorEnglishSourceApplied =>
      'Original em inglês aplicado — traduza-o agora.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Não foi possível abrir a URL: $url';
  }

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get editorCloseEnglishSource => 'Fechar fonte em inglês';

  @override
  String get editorShowEnglishSource => 'Mostrar fonte em inglês';

  @override
  String get editorUnignoreShortTooltip => 'Restaurar módulo';

  @override
  String get editorBackToReviewTooltip => 'Retornar para revisão';

  @override
  String get editorAndNext => 'e Próximo';

  @override
  String get editorBackToDashboard => 'Voltar ao painel';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Traduzindo para $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count restantes';
  }

  @override
  String get editorUnignoreLongTooltip => 'Devolver módulo à lista ativa';

  @override
  String get editorUnignoreLabel => 'Restaurar';

  @override
  String get editorUnpublishTooltip =>
      'Revogar publicação e retornar para revisão';

  @override
  String get editorBackToReview => 'Voltar para revisão';

  @override
  String get editorSaveAndNext => 'Salvar e próximo';

  @override
  String get editorEnglishSourceHeader => 'FONTE EM INGLÊS';

  @override
  String get editorStaleTooltip =>
      'Mostrar explicação e aplicar o texto em inglês';

  @override
  String get editorStaleDetailsLabel => 'Desatualizado — Detalhes';

  @override
  String get editorCopyPromptTooltip => 'Copiar fonte + prompt de tradução';

  @override
  String get editorPromptCopied =>
      'Prompt copiado para a área de transferência 📋';

  @override
  String get editorShowPreview => 'Mostrar pré-visualização';

  @override
  String get editorShowHtmlSource => 'Mostrar código-fonte HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RESUMO:\n$summary\n\nCORPO:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Resumo:';

  @override
  String get editorDescriptionLabelColon => 'Descrição:';

  @override
  String get editorStaleDialogTitle => 'A fonte em inglês foi alterada';

  @override
  String get editorStaleExplanation =>
      'A tradução existente é baseada em um texto original em inglês desatualizado. Desde a última tradução, o mantenedor do módulo alterou o texto em inglês no Drupal.org — o conteúdo da tradução existente pode, portanto, não ser mais preciso ou completo.';

  @override
  String get editorStaleTip =>
      'Dica: clique em \"Usar original em inglês\" para carregar a fonte em inglês atual diretamente no editor. Você pode então usá-la como ponto de partida para uma nova tradução. O original em inglês também é exibido no painel à esquerda.';

  @override
  String get editorEnglishSourceShort => 'Fonte em inglês';

  @override
  String get editorPreviousTranslation => 'Tradução anterior';

  @override
  String get editorWhatChangedTitle => 'O que mudou?';

  @override
  String get editorShowDiff => 'Mostrar diferenças';

  @override
  String get editorUseEnglish => 'Usar original em inglês';

  @override
  String get editorStaleBannerText =>
      'A fonte em inglês foi alterada — a tradução está desatualizada';

  @override
  String get editorDetailsAndApply => 'Detalhes e aplicação';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUÇÃO PARA $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Traduzindo...';

  @override
  String get editorShowEditor => 'Mostrar editor';

  @override
  String get editorModuleTitleLabel => 'Título do módulo (inglês)';

  @override
  String get editorSummaryFieldLabel => 'Resumo';

  @override
  String get editorBodyFieldLabel => 'Corpo';

  @override
  String get editorHtmlCleaned => 'HTML limpo';

  @override
  String get editorLivePreviewHeader => 'PRÉ-VISUALIZAÇÃO AO VIVO';

  @override
  String get editorTidyHtmlTooltip =>
      'Limpar HTML (remover artefatos do DeepL)';

  @override
  String get editorVisualMode => 'VISUAL';

  @override
  String get editorSourceCodeMode => 'FONTE (HTML)';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get costDialogTitle => 'Estimativa de custo (IA)';

  @override
  String get costDialogIntro =>
      'O módulo selecionado será traduzido com a IA Google Gemini. Aqui está a estimativa detalhada de custo para esta operação:';

  @override
  String get costRowModel => 'Modelo';

  @override
  String get costRowInputTokens => 'Tokens de entrada';

  @override
  String get costRowOutputTokens => 'Tokens de saída (estimativa)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caracteres)';
  }

  @override
  String get costRowPriceInput => 'Preço por 1M de entrada';

  @override
  String get costRowPriceOutput => 'Preço por 1M de saída';

  @override
  String get costRowTotalEstimate => 'Custo total estimado';

  @override
  String get costDialogFootnote =>
      '* Observação: esta é uma estimativa baseada no modelo de preços pay-as-you-go atual do Google. O uso real pode variar ligeiramente.';

  @override
  String get costDialogStartTranslation => 'Iniciar tradução';

  @override
  String get htmlToolbarInsertLink => 'Inserir link';

  @override
  String get htmlToolbarLinkTooltip => 'Inserir link (a)';

  @override
  String get htmlToolbarInsert => 'Inserir';

  @override
  String get htmlToolbarHeading2 => 'Título 2';

  @override
  String get htmlToolbarHeading3 => 'Título 3';

  @override
  String get htmlToolbarBold => 'Negrito (strong)';

  @override
  String get htmlToolbarItalic => 'Itálico (em)';

  @override
  String get htmlToolbarBulletList => 'Lista com marcadores (ul)';

  @override
  String get htmlToolbarNumberedList => 'Lista numerada (ol)';

  @override
  String get htmlToolbarQuote => 'Citação (blockquote)';

  @override
  String get screenshotAltsHeader => 'TEXTO ALTERNATIVO DAS CAPTURAS DE TELA';

  @override
  String get screenshotAltsIntro =>
      'Insira um texto alternativo descritivo no idioma de destino para cada captura de tela.';

  @override
  String screenshotLabel(int number) {
    return 'Captura de tela $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Pré-visualização indisponível';

  @override
  String get screenshotAltHint =>
      'Insira o texto alternativo no idioma de destino…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Restaurar todos os módulos ignorados?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Todos os módulos ignorados serão devolvidos à lista ativa e ficarão disponíveis para tradução novamente.';

  @override
  String get dashUnignoreAllConfirmAction => 'Restaurar todos';

  @override
  String get dashUnignoreAllSuccess =>
      'Todos os módulos ignorados foram restaurados.';

  @override
  String get dashUnignoreAllError => 'Falha ao restaurar os módulos.';

  @override
  String get dashUnignoreAllButton => 'Restaurar todos os módulos ignorados';

  @override
  String dashSyncStartError(String error) {
    return 'Falha ao iniciar a sincronização: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Atualização rápida (7 dias) iniciada ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Erro na atualização rápida: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sincronizado com sucesso: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Módulo não encontrado no Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Tradução em massa por IA';

  @override
  String get dashHeaderTitle => 'Descrições de projetos';

  @override
  String get dashHeaderSubtitle =>
      'Traduza descrições de módulos do Drupal para o idioma de destino. Ajude a tornar o ecossistema mais acessível.';

  @override
  String get dashHeaderSubtitleShort =>
      'Traduza descrições de módulos do Drupal.';

  @override
  String get dashLastLabel => 'Última: ';

  @override
  String get dashContinue => 'Continuar';

  @override
  String get dashContinueShort => 'Continuar';

  @override
  String get dashUnignoreAllButtonLong =>
      'Restaurar todos os módulos ignorados';

  @override
  String get dashQuickUpdateTooltip => 'Atualização rápida (últimos 7 dias)';

  @override
  String get dashFullSyncTooltip =>
      'Sincronização completa do banco de dados a partir do Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Carregar manualmente um único módulo do Drupal.org';

  @override
  String get dashQuickShort => 'Rápida';

  @override
  String get dashModuleShort => 'Módulo';

  @override
  String get dashFoundLabel => 'Encontrados: ';

  @override
  String get dashModulesSuffix => ' módulos';

  @override
  String dashPerPage(int count) {
    return '$count por página';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / página';
  }

  @override
  String get dashFirstPage => 'Primeira página';

  @override
  String get dashPrevPage => 'Página anterior';

  @override
  String get dashNextPage => 'Próxima página';

  @override
  String get dashLastPage => 'Última página';

  @override
  String dashPageOf(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (ex.: pathauto)';

  @override
  String get dashAddButton => 'Adicionar';

  @override
  String get dashAddModuleManually => 'Adicionar módulo manualmente';

  @override
  String get dashAddModuleSubtitle =>
      'Carregar diretamente do Drupal.org pelo machine name.';

  @override
  String get dashAddModuleShort => 'Adicionar módulo';

  @override
  String get dashNoProjectsFound => 'Nenhum projeto encontrado.';

  @override
  String get dashFilterAll => 'Todos os projetos';

  @override
  String get dashFilterMissing => 'Traduções ausentes';

  @override
  String get dashFilterReview => 'Fila de revisão';

  @override
  String get dashFilterTranslated => 'Projetos traduzidos';

  @override
  String get dashFilterReleased => 'Projetos publicados';

  @override
  String get dashBulkDialogIntro =>
      'Traduza automaticamente vários módulos do filtro selecionado usando o Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtro ativo';

  @override
  String get dashModuleCount => 'Número de módulos';

  @override
  String dashModulesCountItem(int count) {
    return '$count módulos';
  }

  @override
  String get dashPrioritizeD12Title => 'Priorizar módulos do Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Traduz primeiro os módulos sem suporte ao Drupal 12';

  @override
  String get dashTotalModules => 'Total de módulos';

  @override
  String get dashInputTokensEst => 'Tokens de entrada (est.)';

  @override
  String get dashOutputTokensEst => 'Tokens de saída (est.)';

  @override
  String get dashBulkFootnote =>
      '* A tradução é executada em lotes eficientes em termos de recursos para evitar tempos limite.';

  @override
  String get dashStartBulkTranslation => 'Iniciar tradução em massa';

  @override
  String dashStaleLoadError(String error) {
    return 'Erro ao carregar módulos desatualizados: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Nenhum módulo desatualizado encontrado — tudo está em dia! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Retraduzir módulos desatualizados';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Todas as traduções cuja fonte em inglês mudou desde a última tradução serão retraduzidas automaticamente usando o Google Gemini. Não é necessário abrir cada módulo manualmente.';

  @override
  String get dashOutdatedModules => 'Módulos desatualizados';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* A tradução substitui o texto existente e redefine is_reviewed. Executada em lotes de 4 módulos.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Retraduzir todos os $count módulos';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Retraduzindo módulos desatualizados…';

  @override
  String get dashFetchingProjects => 'Buscando projetos no servidor…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed de $total módulos processados';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Nenhum projeto traduzível encontrado para este filtro.';

  @override
  String get dashStartingTranslation => 'Iniciando tradução…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Traduzindo módulo $start–$end de $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end de $total módulos concluídos.';
  }

  @override
  String get dashTranslationCompleted => 'Tradução concluída com sucesso! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Tradução em massa de $count módulos realizada com sucesso! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Erro na tradução em massa: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Todos os $count módulos foram retraduzidos com sucesso! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count módulos desatualizados retraduzidos com sucesso! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Erro durante a retradução: $error';
  }

  @override
  String get filterAllShort => 'Todos';

  @override
  String get filterMissing => 'Ausentes';

  @override
  String get filterTranslated => 'Traduzidos';

  @override
  String get filterReviewQueue => 'Fila de revisão';

  @override
  String get filterReleased => 'Publicados';

  @override
  String get filterOutdated => 'Desatualizados';

  @override
  String get filterPriority => 'Prioridade';

  @override
  String get filterIgnored => 'Ignorados';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonReset => 'Redefinir';

  @override
  String get commonRefresh => 'Atualizar';

  @override
  String commonErrorPrefix(String error) {
    return 'Erro: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Redefinir todas as traduções publicadas?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Todas as traduções marcadas como publicadas para $langcode serão redefinidas para o estado de revisão. Isso não pode ser desfeito.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traduções redefinidas para o estado de revisão.';
  }

  @override
  String get reviewPipelineTitle => 'Pipeline de revisão';

  @override
  String get reviewPipelineSubtitle =>
      'Pipeline de garantia de qualidade humana para traduções por IA';

  @override
  String get reviewSearchHint => 'Buscar projetos...';

  @override
  String get reviewResetPublished => 'Redefinir publicadas';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultados: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Pendentes: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Nenhum projeto pendente de revisão.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Todas as traduções já foram verificadas ou nenhuma existe neste contexto de idioma.';

  @override
  String get reviewNoSummary => 'Sem resumo.';

  @override
  String get reviewStartAudit => 'INICIAR AUDITORIA';

  @override
  String get reviewHtmlSourceShort => 'Fonte HTML';

  @override
  String get reviewCopySource => 'Copiar fonte';

  @override
  String get reviewModuleDetails => 'Detalhes do módulo';

  @override
  String get reviewOriginalTitle => 'Título original';

  @override
  String get reviewDrupalOrgProject => 'Projeto no Drupal.org';

  @override
  String get reviewSuggestions => 'Sugestões';

  @override
  String get reviewNoSuggestions => 'Nenhuma sugestão disponível.';

  @override
  String get reviewApply => 'Aplicar';

  @override
  String get reviewNoChanges => 'Sem alterações';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (antes da correção)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corrigido (versão atual)';

  @override
  String get reviewBaseOriginal => 'Base (Original)';

  @override
  String get reviewYourCorrection => 'Sua correção';

  @override
  String get reviewChangesVisual => 'Revise suas alterações (visual)';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonIgnore => 'Ignorar';

  @override
  String get reviewEmptyProjectTitle => 'Projeto vazio';

  @override
  String get reviewEmptyProjectBody =>
      'Este projeto está vazio (sem título, resumo ou corpo) e não pode ser aprovado. Pule-o.';

  @override
  String get reviewApprovedSuccess => 'Tradução aprovada! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ A aprovação de \"$machine\" falhou — tente novamente.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Restaurado. O módulo está ativo novamente!';

  @override
  String get reviewActionFailed => 'Ação falhou.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorar módulo?';

  @override
  String get reviewIgnoreModuleBody =>
      'Este módulo será ocultado permanentemente de todas as listas. Você não vai mais travar nele.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Módulo ignorado permanentemente.';

  @override
  String get reviewIgnoreFailed => 'Falha ao ignorar o módulo.';

  @override
  String get reviewSuggestionSaved => 'Rascunho da sugestão salvo! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Falha ao salvar o rascunho da sugestão.';

  @override
  String get reviewSuggestionDeleted => 'Sugestão excluída.';

  @override
  String get reviewDeleteFailed => 'Falha ao excluir.';

  @override
  String get reviewSuggestionApplied => 'Sugestão aplicada.';

  @override
  String get reviewPreparingData => 'Preparando dados de revisão...';

  @override
  String get reviewDirectEdit => 'Edição direta';

  @override
  String get reviewLivePreview => 'Pré-visualização ao vivo';

  @override
  String get reviewCompareWith => 'Comparar com:';

  @override
  String get reviewProductionVersion => 'Versão de produção';

  @override
  String get reviewEditorialReview => 'Revisão editorial';

  @override
  String get reviewOpenQueue => 'Abrir fila de revisão';

  @override
  String get reviewCopyPromptShort => 'Copiar prompt';

  @override
  String get reviewUnignoreShort => 'Restaurar';

  @override
  String get reviewApproveButton => 'APROVAR';

  @override
  String get reviewHideDetails => 'Ocultar detalhes';

  @override
  String get reviewDetailsAndEnglishSource => 'Detalhes e fonte em inglês';

  @override
  String reviewPendingCountShort(int count) {
    return '$count pendentes';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Revisando $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Comparar tradução com a fonte em inglês';

  @override
  String get reviewTranslationLabel => 'Tradução';

  @override
  String get reviewComparisonTitle => 'Comparação';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copiar texto de origem + prompt de tradução para a área de transferência';

  @override
  String get reviewUnignoreCaps => 'RESTAURAR';

  @override
  String get reviewIgnoreCaps => 'IGNORAR';

  @override
  String get reviewSkipShortcut => 'PULAR (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Revisão editorial';

  @override
  String get reviewUnignoreTablet => 'RESTAURAR';

  @override
  String get reviewApproveForProduction => 'APROVAR PARA PRODUÇÃO (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Refinamento direto';

  @override
  String get reviewTitleField => 'Título';

  @override
  String get reviewSummaryField => 'Resumo';

  @override
  String get reviewBodyField => 'Conteúdo do corpo';

  @override
  String get reviewSaveShortcut => 'SALVAR (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Pré-visualização ao vivo (renderizando)';

  @override
  String get reviewVoiceFemale => 'Feminina';

  @override
  String get reviewVoiceMale => 'Masculina';

  @override
  String get reviewStopListening => 'Parar';

  @override
  String get reviewListen => 'Ouvir';

  @override
  String get reviewAutopTooltip =>
      'Formatar parágrafos automaticamente (quebras de linha → <p>)';

  @override
  String get reviewSourceCodeShort => 'FONTE';

  @override
  String get reviewNoParagraphChange =>
      'O texto já contém tags <p> — nenhuma alteração';

  @override
  String get reviewParagraphsFormatted => 'Parágrafos formatados ¶';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String categoriesLoadError(String error) {
    return 'Falha ao carregar categorias: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categorias salvas com sucesso.';

  @override
  String get categoriesSaveFailed => 'Falha ao salvar traduções.';

  @override
  String get categoriesFileEmpty => 'O arquivo está vazio.';

  @override
  String get categoriesInvalidJson => 'Formato JSON inválido.';

  @override
  String get categoriesNoValidUuids =>
      'Nenhuma entrada de UUID válida encontrada no arquivo.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categorias importadas do arquivo.';
  }

  @override
  String get categoriesTitle => 'Categorias';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Traduzindo para: $lang';
  }

  @override
  String get categoriesImportJson => 'Importar JSON';

  @override
  String get categoriesSaving => 'Salvando...';

  @override
  String get categoriesSaveAll => 'Salvar tudo';

  @override
  String get categoriesLoading => 'Carregando categorias...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Tradução ($code)';
  }

  @override
  String get categoriesNoneFound => 'Nenhuma categoria encontrada.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Traduzir \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto de ';

  @override
  String get loginPhotoOn => ' no ';

  @override
  String get loginPleaseSignIn => 'Faça login';

  @override
  String get loginUsername => 'Nome de usuário';

  @override
  String get loginPassword => 'Senha';

  @override
  String get loginRememberMe => 'Lembrar de mim';

  @override
  String get loginSignIn => 'ENTRAR';

  @override
  String get loginNoAccount => 'Ainda não tem uma conta? ';

  @override
  String get loginRegisterNow => 'Cadastre-se agora';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonNext => 'Próximo';

  @override
  String get registerFillRequired => 'Preencha todos os campos obrigatórios.';

  @override
  String get registerPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get registerPasswordTooShort =>
      'A senha deve ter pelo menos 8 caracteres.';

  @override
  String get registerSelectLanguage => 'Selecione pelo menos um idioma.';

  @override
  String get registerFailed => 'Falha no cadastro.';

  @override
  String get registerHeaderTitle => 'CADASTRO';

  @override
  String get registerStepAccount => 'Conta';

  @override
  String get registerStepRole => 'Função';

  @override
  String get registerStepLanguages => 'Idiomas';

  @override
  String get registerStepApiKeys => 'Chaves de API';

  @override
  String get registerYourAccount => 'Sua conta';

  @override
  String get registerAvatarOptional => 'Avatar (opcional)';

  @override
  String get registerUsernameRequired => 'Nome de usuário *';

  @override
  String get registerEmailRequired => 'Endereço de e-mail *';

  @override
  String get registerPasswordRequired => 'Senha *';

  @override
  String get registerPasswordRepeat => 'Repita a senha *';

  @override
  String get registerYourRole => 'Sua função';

  @override
  String get registerRoleExplanation =>
      'Tradutores podem traduzir textos, mas não têm acesso à fila de revisão. Revisores verificam e aprovam o conteúdo traduzido.';

  @override
  String get registerRoleTranslator => 'Tradutor';

  @override
  String get registerRoleTranslatorDesc => 'Criar e editar traduções.';

  @override
  String get registerRoleReviewer => 'Revisor';

  @override
  String get registerRoleReviewerDesc => 'Revisar e aprovar traduções.';

  @override
  String get registerTargetLanguages => 'Idiomas de destino';

  @override
  String get registerLanguagesExplanation =>
      'Escolha todos os idiomas nos quais deseja trabalhar.';

  @override
  String get registerNoLanguagesAvailable => 'Nenhum idioma disponível.';

  @override
  String get registerApiKeysTitle => 'Chaves de API';

  @override
  String get registerApiKeysExplanation =>
      'Informe suas próprias chaves de API. Cada usuário usa exclusivamente suas próprias chaves. Você também pode adicioná-las depois no seu perfil.';

  @override
  String get registerKeysEncryptedNote =>
      'As chaves são armazenadas de forma criptografada e nunca são compartilhadas com outros usuários.';

  @override
  String get registerOptionalSuffix => ' (opcional)';

  @override
  String get registerSuccessTitle => 'Cadastro realizado com sucesso!';

  @override
  String get registerSuccessBody =>
      'Sua conta foi criada e está aguardando aprovação de um administrador. Você será notificado assim que seu acesso for ativado.';

  @override
  String get registerGoToLogin => 'Ir para o login';

  @override
  String get registerSubmit => 'Cadastrar';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto de $name no Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Perfil atualizado com sucesso!';

  @override
  String get profileUpdateFailed => 'Falha na atualização.';

  @override
  String profileSaveError(String error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get profilePasswordMismatch => 'As senhas não coincidem!';

  @override
  String get profilePasswordChangeSuccess => 'Senha alterada com sucesso!';

  @override
  String get profilePasswordChangeError =>
      'Erro ao alterar a senha: senha atual incorreta.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar enviado com sucesso!';

  @override
  String get profileAvatarUploadError => 'Erro ao enviar o avatar.';

  @override
  String get profileTitle => 'Perfil e configurações';

  @override
  String get profileSubtitle =>
      'Gerencie seu perfil de usuário, suas APIs de tradução (Gemini e DeepL) e a segurança da sua conta.';

  @override
  String get profileRoleUser => 'Usuário';

  @override
  String get profileNoEmail => 'Nenhum endereço de e-mail informado';

  @override
  String get profileTabDetails => 'Detalhes do perfil';

  @override
  String get profileTabGemini => 'Tradução por IA (Gemini)';

  @override
  String get profileTabDeepl => 'Tradução DeepL';

  @override
  String get profileTabPassword => 'Alterar senha';

  @override
  String get profileSectionInfo => 'INFORMAÇÕES DO PERFIL';

  @override
  String get profileFieldName => 'Nome';

  @override
  String get profileFieldNameHint => 'Seu nome completo';

  @override
  String get profileFieldEmail => 'Endereço de e-mail';

  @override
  String get profileFieldEmailHint => 'Seu endereço de e-mail';

  @override
  String get profileSectionGemini => 'CONFIGURAÇÕES DO GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Chave de API do Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Insira sua chave de API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Prompt de IA personalizado';

  @override
  String get profileFieldAiPromptHint =>
      'Opcional: personalize o prompt do sistema para o Gemini...';

  @override
  String get profileSectionDeepl => 'CONFIGURAÇÕES DE TRADUÇÃO DO DEEPL';

  @override
  String get profileDeeplDescription =>
      'O DeepL oferece tradução automática de alta qualidade com preservação de tags HTML. Contas gratuitas (500.000 caracteres/mês) recebem uma chave com o sufixo \":fx\".';

  @override
  String get profileFieldDeeplKey => 'Chave de API do DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'ex.: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Chaves gratuitas terminam em \":fx\" e usam api-free.deepl.com. Chaves Pro usam api.deepl.com. A distinção é feita automaticamente.';

  @override
  String get profileSectionSecurity => 'SEGURANÇA DA CONTA';

  @override
  String get profileFieldCurrentPassword => 'Senha atual';

  @override
  String get profileFieldCurrentPasswordHint => 'Insira sua senha atual';

  @override
  String get profileFieldNewPassword => 'Nova senha';

  @override
  String get profileFieldNewPasswordHint => 'Pelo menos 6 caracteres';

  @override
  String get profileFieldConfirmPassword => 'Confirmar nova senha';

  @override
  String get profileFieldConfirmPasswordHint => 'Repita a senha';

  @override
  String get profileChangePasswordButton => 'Alterar senha';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get settingsRegistrationUpdated =>
      'Configuração de cadastro atualizada';

  @override
  String get settingsUpdateFailed => 'Falha na atualização.';

  @override
  String get settingsUserApproved => 'Usuário aprovado!';

  @override
  String get settingsAccountDeactivated => 'Conta desativada.';

  @override
  String get settingsUserDeleted => 'Usuário excluído.';

  @override
  String get settingsActionFailed => 'Ação falhou.';

  @override
  String get settingsDeleteAccountTitle => 'Excluir conta?';

  @override
  String get settingsDeactivateAccountTitle => 'Desativar conta?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'A conta \"$username\" será excluída permanentemente. Continuar?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'A conta \"$username\" será bloqueada. O usuário não poderá mais fazer login, mas a conta será mantida.';
  }

  @override
  String get settingsDeactivate => 'Desativar';

  @override
  String settingsSyncSuccess(String count) {
    return '$count traduções sincronizadas!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Erro de sincronização: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count módulos prioritários sincronizados!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Erro ao sincronizar a lista de prioridade: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup realizado com sucesso: $count arquivos processados.';
  }

  @override
  String get settingsUploadFailed => 'Falha no envio.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsSystemConfig => 'CONFIGURAÇÃO DO SISTEMA';

  @override
  String get settingsRegistration => 'Cadastro';

  @override
  String get settingsRegistrationHint =>
      'Ativar ou desativar globalmente a visibilidade do formulário de cadastro.';

  @override
  String get settingsPendingUsers => 'Usuários pendentes';

  @override
  String get settingsNoNewRequests => 'Nenhuma nova solicitação.';

  @override
  String get settingsWantsReviewer => 'Deseja ser revisor';

  @override
  String get settingsAssignRole => 'Atribuir função';

  @override
  String get settingsRoleTranslator => 'Tradutor';

  @override
  String get settingsRoleReviewer => 'Revisor';

  @override
  String get settingsApprove => 'Aprovar';

  @override
  String get settingsReject => 'Rejeitar';

  @override
  String get settingsActiveUsers => 'Usuários ativos';

  @override
  String get settingsNoActiveUsers => 'Nenhum usuário ativo.';

  @override
  String get settingsDeactivateAccountTooltip => 'Desativar';

  @override
  String get settingsDeleteAccountAction => 'Excluir conta';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsThemePearl => 'CLARO (PÉROLA)';

  @override
  String get settingsThemeDark => 'ESCURO';

  @override
  String get settingsThemeGlassy => 'VIDRO';

  @override
  String get settingsThemeNature => 'NATUREZA';

  @override
  String get settingsThemeLiquid => 'LÍQUIDO';

  @override
  String get settingsThemeStage => 'PALCO';

  @override
  String get settingsTypography => 'Tipografia';

  @override
  String get settingsFontHint => 'Alterar a família tipográfica da interface.';

  @override
  String get settingsFontClean => 'Limpa';

  @override
  String get settingsFontFuturistic => 'Futurista';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Fluxo de trabalho e diversão';

  @override
  String get settingsConfettiTitle => 'Celebração de sucesso (confetes)';

  @override
  String get settingsConfettiHint =>
      'Exibe uma pequena animação ao salvar com sucesso.';

  @override
  String get settingsLargeUiTitle => 'Legibilidade aprimorada (fonte grande)';

  @override
  String get settingsLargeUiHint =>
      'Aumenta o tamanho de fontes e selos para melhor legibilidade.';

  @override
  String get settingsAutoPTitle =>
      'Formatação automática de parágrafos (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Envolve automaticamente o texto simples em parágrafos <p> quando um módulo é carregado na tela de revisão. Equivale a clicar manualmente no botão ¶.';

  @override
  String get settingsDatabaseSync => 'Sincronização do banco de dados';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sincroniza as entradas do banco de dados com os arquivos JSON de tradução.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sincroniza as entradas internas do banco de dados com os JSONs de tradução no servidor.';

  @override
  String get settingsSyncing => 'Sincronizando...';

  @override
  String get settingsSyncNow => 'Sincronizar agora';

  @override
  String get settingsSyncD11List => 'Sincronizar lista D11';

  @override
  String get settingsUploadBackup => 'Enviar backup (.zip)';

  @override
  String get settingsSelectZipFile => 'Selecionar arquivo ZIP';

  @override
  String get settingsUploading => 'Enviando...';

  @override
  String get settingsErrorDiagnostics =>
      'Diagnóstico de erros e logs do sistema';

  @override
  String get settingsLogsCopied =>
      'Logs copiados para a área de transferência! 📋';

  @override
  String get settingsCopyLogs => 'Copiar logs';

  @override
  String get settingsLogsRotated => 'Logs arquivados e rotacionados! 📁';

  @override
  String get settingsRotate => 'Rotacionar';

  @override
  String get settingsClear => 'Limpar';

  @override
  String get settingsLogLimit => 'Limite de logs: ';

  @override
  String get settingsNoLogs => 'Nenhum log registrado';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Análises';

  @override
  String get layoutNavReviewQueue => 'Fila de revisão';

  @override
  String get layoutNavGlossary => 'Glossário';

  @override
  String get layoutNavCategories => 'Categorias';

  @override
  String get layoutNavHelp => 'Ajuda';

  @override
  String get layoutNavSettings => 'Configurações';

  @override
  String get layoutPhotoBy => 'Foto de ';

  @override
  String get layoutPhotoOn => ' no ';

  @override
  String get layoutEditProfile => 'Editar perfil';

  @override
  String get layoutLogout => 'Sair';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Claro';

  @override
  String get layoutThemeDark => 'Escuro';

  @override
  String get layoutThemeGlassy => 'Vidro';

  @override
  String get layoutThemeNature => 'Natureza';

  @override
  String get layoutThemeLiquid => 'Líquido';

  @override
  String get layoutThemeStage => 'Palco';

  @override
  String get layoutTargetLanguage => 'IDIOMA DE DESTINO';

  @override
  String get layoutDeeplUsage => 'USO DO DEEPL';

  @override
  String get layoutUnavailable => 'Indisponível';

  @override
  String get layoutUnlimited => 'ilimitado';

  @override
  String get layoutUsed => 'usado';

  @override
  String get layoutTranslate => 'Traduzir';

  @override
  String get analyticsSubtitle =>
      'Compatibilidade, backlog de tradução e tendências semanais.';

  @override
  String get analyticsBacklog => 'Backlog de tradução';

  @override
  String get analyticsMissing => 'Ausentes';

  @override
  String get analyticsStale => 'Desatualizadas';

  @override
  String get analyticsInReview => 'Em revisão';

  @override
  String get analyticsReleased => 'Publicadas';

  @override
  String get analyticsTranslated => 'Traduzidas';

  @override
  String get analyticsTotalModules => 'Total de módulos';

  @override
  String get analyticsCompatByVersion => 'Compatibilidade por versão do Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Idioma: $lang · publicadas / em revisão / ausentes';
  }

  @override
  String get analyticsLoadingCounts => 'Carregando contagens …';

  @override
  String get analyticsWindow => 'Período:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks semanas';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Novas descrições de projetos por semana';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marcadas como desatualizadas por semana ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count módulos';
  }

  @override
  String get analyticsReviewShort => 'Revisão';

  @override
  String get analyticsNoDataInWindow => 'Nenhum dado neste período.';

  @override
  String get analyticsAndMore => '… e mais';

  @override
  String glossaryLoadError(String error) {
    return 'Erro ao carregar: $error';
  }

  @override
  String get glossaryNewTerm => 'Criar novo termo';

  @override
  String get glossaryEditTerm => 'Editar termo';

  @override
  String get glossaryFieldSourceWord =>
      'Palavra de origem (forma base, como aparece no texto)';

  @override
  String get glossaryFieldSourceWordHint => 'ex.: node (nó)';

  @override
  String get glossaryWordForms =>
      'Outras formas da palavra (plural, genitivo, dativo …)';

  @override
  String get glossaryWordFormsHint =>
      'ex.: content (conteúdo) — pressione Enter para adicionar';

  @override
  String get glossaryAddForm => 'Adicionar forma';

  @override
  String get glossaryFieldPreferredWord => 'Tradução preferida';

  @override
  String get glossaryFieldPreferredWordHint => 'ex.: conteúdo';

  @override
  String get glossaryFieldExplanation =>
      'Explicação (exibida na dica de contexto)';

  @override
  String get glossaryFieldExplanationHint =>
      'Por que essa palavra deveria ser traduzida de forma diferente?';

  @override
  String get glossaryCreate => 'Criar';

  @override
  String get glossaryRequiredFields =>
      'A palavra de origem e a tradução preferida são obrigatórias.';

  @override
  String get glossaryCreated => 'Termo criado ✓';

  @override
  String get glossaryUpdated => 'Termo atualizado ✓';

  @override
  String glossaryError(String error) {
    return 'Erro: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Excluir termo?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" será removido permanentemente do glossário.';
  }

  @override
  String get glossaryDeleted => 'Termo excluído.';

  @override
  String get glossaryTitle => 'Glossário de tradução';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Idioma: $lang · $count entradas';
  }

  @override
  String get glossaryNewShort => 'Novo';

  @override
  String get glossaryCreateTerm => 'Criar termo';

  @override
  String get glossaryInfoBanner =>
      'As palavras deste glossário são destacadas no editor de revisão. Uma dica de contexto explica ao passar o mouse por que outra tradução é mais adequada.';

  @override
  String get glossaryNoEntries => 'Ainda não há entradas.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Clique em \"Criar termo\" para criar a primeira entrada.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Ainda não há entradas de glossário para este idioma.';

  @override
  String get diffNoChanges => 'Nenhuma diferença de conteúdo detectada.';

  @override
  String get diffRemoved => 'Removido';

  @override
  String get diffAdded => 'Adicionado';

  @override
  String syncBarQuickSync(String count) {
    return 'Sincronização rápida: $count módulos alterados …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sincronização completa: $current / $total módulos';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sincronização completa: $count módulos …';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Carregando detalhes do projeto...';

  @override
  String editorLoadError(String error) {
    return 'Falha ao carregar os dados do projeto: $error';
  }

  @override
  String get editorGeminiSuccess =>
      'Tradução com o Gemini realizada com sucesso! ✨';

  @override
  String get editorUnknownError => 'Erro desconhecido';

  @override
  String editorGeminiFailed(String detail) {
    return 'Falha na tradução com o Gemini: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Adicione sua chave do Google AI no seu perfil de usuário (não nas configurações de administrador).';

  @override
  String get editorGeminiError =>
      'Erro durante a tradução com o Gemini. Verifique sua chave do Google AI no seu perfil.';

  @override
  String get editorDeeplSuccess =>
      'Tradução com o DeepL realizada com sucesso! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Falha na tradução com o DeepL: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Erro durante a tradução com o DeepL. Verifique se sua chave de API do DeepL está definida no seu perfil.';

  @override
  String get editorDeeplInvalidKey =>
      'Chave de API do DeepL inválida. Verifique-a no seu perfil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Cota do DeepL esgotada. Verifique seu plano.';

  @override
  String get editorReviewReset =>
      'Tradução redefinida para o status de revisão.';

  @override
  String editorResetError(String error) {
    return 'Falha ao redefinir: $error';
  }

  @override
  String get editorUnignoreSuccess => 'O módulo foi devolvido à lista ativa.';

  @override
  String get editorUnignoreError => 'Falha ao restaurar o módulo.';

  @override
  String get editorSaveSuccess =>
      'Tradução salva — de volta à fila de revisão.';

  @override
  String editorSaveError(String error) {
    return 'Falha ao salvar: $error';
  }

  @override
  String get editorNoMoreProjects => 'Não há mais projetos abertos na lista.';

  @override
  String get editorChangesDiscarded =>
      'Alterações descartadas, carregando o próximo projeto...';

  @override
  String get editorEnglishSourceApplied =>
      'Original em inglês aplicado — traduza-o agora.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Não foi possível abrir a URL: $url';
  }

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get editorCloseEnglishSource => 'Fechar fonte em inglês';

  @override
  String get editorShowEnglishSource => 'Mostrar fonte em inglês';

  @override
  String get editorUnignoreShortTooltip => 'Restaurar módulo';

  @override
  String get editorBackToReviewTooltip => 'Retornar para revisão';

  @override
  String get editorAndNext => 'e Próximo';

  @override
  String get editorBackToDashboard => 'Voltar ao painel';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Traduzindo para $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count restantes';
  }

  @override
  String get editorUnignoreLongTooltip => 'Devolver módulo à lista ativa';

  @override
  String get editorUnignoreLabel => 'Restaurar';

  @override
  String get editorUnpublishTooltip =>
      'Revogar publicação e retornar para revisão';

  @override
  String get editorBackToReview => 'Voltar para revisão';

  @override
  String get editorSaveAndNext => 'Salvar e próximo';

  @override
  String get editorEnglishSourceHeader => 'FONTE EM INGLÊS';

  @override
  String get editorStaleTooltip =>
      'Mostrar explicação e aplicar o texto em inglês';

  @override
  String get editorStaleDetailsLabel => 'Desatualizado — Detalhes';

  @override
  String get editorCopyPromptTooltip => 'Copiar fonte + prompt de tradução';

  @override
  String get editorPromptCopied =>
      'Prompt copiado para a área de transferência 📋';

  @override
  String get editorShowPreview => 'Mostrar pré-visualização';

  @override
  String get editorShowHtmlSource => 'Mostrar código-fonte HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RESUMO:\n$summary\n\nCORPO:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Resumo:';

  @override
  String get editorDescriptionLabelColon => 'Descrição:';

  @override
  String get editorStaleDialogTitle => 'A fonte em inglês foi alterada';

  @override
  String get editorStaleExplanation =>
      'A tradução existente é baseada em um texto original em inglês desatualizado. Desde a última tradução, o mantenedor do módulo alterou o texto em inglês no Drupal.org — o conteúdo da tradução existente pode, portanto, não ser mais preciso ou completo.';

  @override
  String get editorStaleTip =>
      'Dica: clique em \"Usar original em inglês\" para carregar a fonte em inglês atual diretamente no editor. Você pode então usá-la como ponto de partida para uma nova tradução. O original em inglês também é exibido no painel à esquerda.';

  @override
  String get editorEnglishSourceShort => 'Fonte em inglês';

  @override
  String get editorPreviousTranslation => 'Tradução anterior';

  @override
  String get editorWhatChangedTitle => 'O que mudou?';

  @override
  String get editorShowDiff => 'Mostrar diferenças';

  @override
  String get editorUseEnglish => 'Usar original em inglês';

  @override
  String get editorStaleBannerText =>
      'A fonte em inglês foi alterada — a tradução está desatualizada';

  @override
  String get editorDetailsAndApply => 'Detalhes e aplicação';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUÇÃO PARA $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Traduzindo...';

  @override
  String get editorShowEditor => 'Mostrar editor';

  @override
  String get editorModuleTitleLabel => 'Título do módulo (inglês)';

  @override
  String get editorSummaryFieldLabel => 'Resumo';

  @override
  String get editorBodyFieldLabel => 'Corpo';

  @override
  String get editorHtmlCleaned => 'HTML limpo';

  @override
  String get editorLivePreviewHeader => 'PRÉ-VISUALIZAÇÃO AO VIVO';

  @override
  String get editorTidyHtmlTooltip =>
      'Limpar HTML (remover artefatos do DeepL)';

  @override
  String get editorVisualMode => 'VISUAL';

  @override
  String get editorSourceCodeMode => 'FONTE (HTML)';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get costDialogTitle => 'Estimativa de custo (IA)';

  @override
  String get costDialogIntro =>
      'O módulo selecionado será traduzido com a IA Google Gemini. Aqui está a estimativa detalhada de custo para esta operação:';

  @override
  String get costRowModel => 'Modelo';

  @override
  String get costRowInputTokens => 'Tokens de entrada';

  @override
  String get costRowOutputTokens => 'Tokens de saída (estimativa)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caracteres)';
  }

  @override
  String get costRowPriceInput => 'Preço por 1M de entrada';

  @override
  String get costRowPriceOutput => 'Preço por 1M de saída';

  @override
  String get costRowTotalEstimate => 'Custo total estimado';

  @override
  String get costDialogFootnote =>
      '* Observação: esta é uma estimativa baseada no modelo de preços pay-as-you-go atual do Google. O uso real pode variar ligeiramente.';

  @override
  String get costDialogStartTranslation => 'Iniciar tradução';

  @override
  String get htmlToolbarInsertLink => 'Inserir link';

  @override
  String get htmlToolbarLinkTooltip => 'Inserir link (a)';

  @override
  String get htmlToolbarInsert => 'Inserir';

  @override
  String get htmlToolbarHeading2 => 'Título 2';

  @override
  String get htmlToolbarHeading3 => 'Título 3';

  @override
  String get htmlToolbarBold => 'Negrito (strong)';

  @override
  String get htmlToolbarItalic => 'Itálico (em)';

  @override
  String get htmlToolbarBulletList => 'Lista com marcadores (ul)';

  @override
  String get htmlToolbarNumberedList => 'Lista numerada (ol)';

  @override
  String get htmlToolbarQuote => 'Citação (blockquote)';

  @override
  String get screenshotAltsHeader => 'TEXTO ALTERNATIVO DAS CAPTURAS DE TELA';

  @override
  String get screenshotAltsIntro =>
      'Insira um texto alternativo descritivo no idioma de destino para cada captura de tela.';

  @override
  String screenshotLabel(int number) {
    return 'Captura de tela $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Pré-visualização indisponível';

  @override
  String get screenshotAltHint =>
      'Insira o texto alternativo no idioma de destino…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Restaurar todos os módulos ignorados?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Todos os módulos ignorados serão devolvidos à lista ativa e ficarão disponíveis para tradução novamente.';

  @override
  String get dashUnignoreAllConfirmAction => 'Restaurar todos';

  @override
  String get dashUnignoreAllSuccess =>
      'Todos os módulos ignorados foram restaurados.';

  @override
  String get dashUnignoreAllError => 'Falha ao restaurar os módulos.';

  @override
  String get dashUnignoreAllButton => 'Restaurar todos os módulos ignorados';

  @override
  String dashSyncStartError(String error) {
    return 'Falha ao iniciar a sincronização: $error';
  }

  @override
  String get dashQuickUpdateStarted => 'Atualização rápida (7 dias) iniciada ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Erro na atualização rápida: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sincronizado com sucesso: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Módulo não encontrado no Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Tradução em massa por IA';

  @override
  String get dashHeaderTitle => 'Descrições de projetos';

  @override
  String get dashHeaderSubtitle =>
      'Traduza descrições de módulos do Drupal para o idioma de destino. Ajude a tornar o ecossistema mais acessível.';

  @override
  String get dashHeaderSubtitleShort =>
      'Traduza descrições de módulos do Drupal.';

  @override
  String get dashLastLabel => 'Última: ';

  @override
  String get dashContinue => 'Continuar';

  @override
  String get dashContinueShort => 'Continuar';

  @override
  String get dashUnignoreAllButtonLong =>
      'Restaurar todos os módulos ignorados';

  @override
  String get dashQuickUpdateTooltip => 'Atualização rápida (últimos 7 dias)';

  @override
  String get dashFullSyncTooltip =>
      'Sincronização completa do banco de dados a partir do Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Carregar manualmente um único módulo do Drupal.org';

  @override
  String get dashQuickShort => 'Rápida';

  @override
  String get dashModuleShort => 'Módulo';

  @override
  String get dashFoundLabel => 'Encontrados: ';

  @override
  String get dashModulesSuffix => ' módulos';

  @override
  String dashPerPage(int count) {
    return '$count por página';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / página';
  }

  @override
  String get dashFirstPage => 'Primeira página';

  @override
  String get dashPrevPage => 'Página anterior';

  @override
  String get dashNextPage => 'Próxima página';

  @override
  String get dashLastPage => 'Última página';

  @override
  String dashPageOf(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (ex.: pathauto)';

  @override
  String get dashAddButton => 'Adicionar';

  @override
  String get dashAddModuleManually => 'Adicionar módulo manualmente';

  @override
  String get dashAddModuleSubtitle =>
      'Carregar diretamente do Drupal.org pelo machine name.';

  @override
  String get dashAddModuleShort => 'Adicionar módulo';

  @override
  String get dashNoProjectsFound => 'Nenhum projeto encontrado.';

  @override
  String get dashFilterAll => 'Todos os projetos';

  @override
  String get dashFilterMissing => 'Traduções ausentes';

  @override
  String get dashFilterReview => 'Fila de revisão';

  @override
  String get dashFilterTranslated => 'Projetos traduzidos';

  @override
  String get dashFilterReleased => 'Projetos publicados';

  @override
  String get dashBulkDialogIntro =>
      'Traduza automaticamente vários módulos do filtro selecionado usando o Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtro ativo';

  @override
  String get dashModuleCount => 'Número de módulos';

  @override
  String dashModulesCountItem(int count) {
    return '$count módulos';
  }

  @override
  String get dashPrioritizeD12Title => 'Priorizar módulos do Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Traduz primeiro os módulos sem suporte ao Drupal 12';

  @override
  String get dashTotalModules => 'Total de módulos';

  @override
  String get dashInputTokensEst => 'Tokens de entrada (est.)';

  @override
  String get dashOutputTokensEst => 'Tokens de saída (est.)';

  @override
  String get dashBulkFootnote =>
      '* A tradução é executada em lotes eficientes em termos de recursos para evitar tempos limite.';

  @override
  String get dashStartBulkTranslation => 'Iniciar tradução em massa';

  @override
  String dashStaleLoadError(String error) {
    return 'Erro ao carregar módulos desatualizados: $error';
  }

  @override
  String get dashNoStaleModules =>
      'Nenhum módulo desatualizado encontrado — tudo está em dia! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Retraduzir módulos desatualizados';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Todas as traduções cuja fonte em inglês mudou desde a última tradução serão retraduzidas automaticamente usando o Google Gemini. Não é necessário abrir cada módulo manualmente.';

  @override
  String get dashOutdatedModules => 'Módulos desatualizados';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* A tradução substitui o texto existente e redefine is_reviewed. Executada em lotes de 4 módulos.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Retraduzir todos os $count módulos';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Retraduzindo módulos desatualizados…';

  @override
  String get dashFetchingProjects => 'Buscando projetos no servidor…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed de $total módulos processados';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Nenhum projeto traduzível encontrado para este filtro.';

  @override
  String get dashStartingTranslation => 'Iniciando tradução…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Traduzindo módulo $start–$end de $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end de $total módulos concluídos.';
  }

  @override
  String get dashTranslationCompleted => 'Tradução concluída com sucesso! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Tradução em massa de $count módulos realizada com sucesso! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Erro na tradução em massa: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Todos os $count módulos foram retraduzidos com sucesso! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count módulos desatualizados retraduzidos com sucesso! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Erro durante a retradução: $error';
  }

  @override
  String get filterAllShort => 'Todos';

  @override
  String get filterMissing => 'Ausentes';

  @override
  String get filterTranslated => 'Traduzidos';

  @override
  String get filterReviewQueue => 'Fila de revisão';

  @override
  String get filterReleased => 'Publicados';

  @override
  String get filterOutdated => 'Desatualizados';

  @override
  String get filterPriority => 'Prioridade';

  @override
  String get filterIgnored => 'Ignorados';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonReset => 'Redefinir';

  @override
  String get commonRefresh => 'Atualizar';

  @override
  String commonErrorPrefix(String error) {
    return 'Erro: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Redefinir todas as traduções publicadas?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Todas as traduções marcadas como publicadas para $langcode serão redefinidas para o estado de revisão. Isso não pode ser desfeito.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traduções redefinidas para o estado de revisão.';
  }

  @override
  String get reviewPipelineTitle => 'Pipeline de revisão';

  @override
  String get reviewPipelineSubtitle =>
      'Pipeline de garantia de qualidade humana para traduções por IA';

  @override
  String get reviewSearchHint => 'Buscar projetos...';

  @override
  String get reviewResetPublished => 'Redefinir publicadas';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultados: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Pendentes: $count';
  }

  @override
  String get reviewNoProjectsPending => 'Nenhum projeto pendente de revisão.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Todas as traduções já foram verificadas ou nenhuma existe neste contexto de idioma.';

  @override
  String get reviewNoSummary => 'Sem resumo.';

  @override
  String get reviewStartAudit => 'INICIAR AUDITORIA';

  @override
  String get reviewHtmlSourceShort => 'Fonte HTML';

  @override
  String get reviewCopySource => 'Copiar fonte';

  @override
  String get reviewModuleDetails => 'Detalhes do módulo';

  @override
  String get reviewOriginalTitle => 'Título original';

  @override
  String get reviewDrupalOrgProject => 'Projeto no Drupal.org';

  @override
  String get reviewSuggestions => 'Sugestões';

  @override
  String get reviewNoSuggestions => 'Nenhuma sugestão disponível.';

  @override
  String get reviewApply => 'Aplicar';

  @override
  String get reviewNoChanges => 'Sem alterações';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (antes da correção)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corrigido (versão atual)';

  @override
  String get reviewBaseOriginal => 'Base (Original)';

  @override
  String get reviewYourCorrection => 'Sua correção';

  @override
  String get reviewChangesVisual => 'Revise suas alterações (visual)';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonIgnore => 'Ignorar';

  @override
  String get reviewEmptyProjectTitle => 'Projeto vazio';

  @override
  String get reviewEmptyProjectBody =>
      'Este projeto está vazio (sem título, resumo ou corpo) e não pode ser aprovado. Pule-o.';

  @override
  String get reviewApprovedSuccess => 'Tradução aprovada! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ A aprovação de \"$machine\" falhou — tente novamente.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Restaurado. O módulo está ativo novamente!';

  @override
  String get reviewActionFailed => 'Ação falhou.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorar módulo?';

  @override
  String get reviewIgnoreModuleBody =>
      'Este módulo será ocultado permanentemente de todas as listas. Você não vai mais travar nele.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Módulo ignorado permanentemente.';

  @override
  String get reviewIgnoreFailed => 'Falha ao ignorar o módulo.';

  @override
  String get reviewSuggestionSaved => 'Rascunho da sugestão salvo! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Falha ao salvar o rascunho da sugestão.';

  @override
  String get reviewSuggestionDeleted => 'Sugestão excluída.';

  @override
  String get reviewDeleteFailed => 'Falha ao excluir.';

  @override
  String get reviewSuggestionApplied => 'Sugestão aplicada.';

  @override
  String get reviewPreparingData => 'Preparando dados de revisão...';

  @override
  String get reviewDirectEdit => 'Edição direta';

  @override
  String get reviewLivePreview => 'Pré-visualização ao vivo';

  @override
  String get reviewCompareWith => 'Comparar com:';

  @override
  String get reviewProductionVersion => 'Versão de produção';

  @override
  String get reviewEditorialReview => 'Revisão editorial';

  @override
  String get reviewOpenQueue => 'Abrir fila de revisão';

  @override
  String get reviewCopyPromptShort => 'Copiar prompt';

  @override
  String get reviewUnignoreShort => 'Restaurar';

  @override
  String get reviewApproveButton => 'APROVAR';

  @override
  String get reviewHideDetails => 'Ocultar detalhes';

  @override
  String get reviewDetailsAndEnglishSource => 'Detalhes e fonte em inglês';

  @override
  String reviewPendingCountShort(int count) {
    return '$count pendentes';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Revisando $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Comparar tradução com a fonte em inglês';

  @override
  String get reviewTranslationLabel => 'Tradução';

  @override
  String get reviewComparisonTitle => 'Comparação';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copiar texto de origem + prompt de tradução para a área de transferência';

  @override
  String get reviewUnignoreCaps => 'RESTAURAR';

  @override
  String get reviewIgnoreCaps => 'IGNORAR';

  @override
  String get reviewSkipShortcut => 'PULAR (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Revisão editorial';

  @override
  String get reviewUnignoreTablet => 'RESTAURAR';

  @override
  String get reviewApproveForProduction => 'APROVAR PARA PRODUÇÃO (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Refinamento direto';

  @override
  String get reviewTitleField => 'Título';

  @override
  String get reviewSummaryField => 'Resumo';

  @override
  String get reviewBodyField => 'Conteúdo do corpo';

  @override
  String get reviewSaveShortcut => 'SALVAR (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Pré-visualização ao vivo (renderizando)';

  @override
  String get reviewVoiceFemale => 'Feminina';

  @override
  String get reviewVoiceMale => 'Masculina';

  @override
  String get reviewStopListening => 'Parar';

  @override
  String get reviewListen => 'Ouvir';

  @override
  String get reviewAutopTooltip =>
      'Formatar parágrafos automaticamente (quebras de linha → <p>)';

  @override
  String get reviewSourceCodeShort => 'FONTE';

  @override
  String get reviewNoParagraphChange =>
      'O texto já contém tags <p> — nenhuma alteração';

  @override
  String get reviewParagraphsFormatted => 'Parágrafos formatados ¶';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String categoriesLoadError(String error) {
    return 'Falha ao carregar categorias: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categorias salvas com sucesso.';

  @override
  String get categoriesSaveFailed => 'Falha ao salvar traduções.';

  @override
  String get categoriesFileEmpty => 'O arquivo está vazio.';

  @override
  String get categoriesInvalidJson => 'Formato JSON inválido.';

  @override
  String get categoriesNoValidUuids =>
      'Nenhuma entrada de UUID válida encontrada no arquivo.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categorias importadas do arquivo.';
  }

  @override
  String get categoriesTitle => 'Categorias';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Traduzindo para: $lang';
  }

  @override
  String get categoriesImportJson => 'Importar JSON';

  @override
  String get categoriesSaving => 'Salvando...';

  @override
  String get categoriesSaveAll => 'Salvar tudo';

  @override
  String get categoriesLoading => 'Carregando categorias...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Tradução ($code)';
  }

  @override
  String get categoriesNoneFound => 'Nenhuma categoria encontrada.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Traduzir \"$name\"...';
  }

  @override
  String get loginPhotoBy => 'Foto de ';

  @override
  String get loginPhotoOn => ' no ';

  @override
  String get loginPleaseSignIn => 'Faça login';

  @override
  String get loginUsername => 'Nome de usuário';

  @override
  String get loginPassword => 'Senha';

  @override
  String get loginRememberMe => 'Lembrar de mim';

  @override
  String get loginSignIn => 'ENTRAR';

  @override
  String get loginNoAccount => 'Ainda não tem uma conta? ';

  @override
  String get loginRegisterNow => 'Cadastre-se agora';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonNext => 'Próximo';

  @override
  String get registerFillRequired => 'Preencha todos os campos obrigatórios.';

  @override
  String get registerPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get registerPasswordTooShort =>
      'A senha deve ter pelo menos 8 caracteres.';

  @override
  String get registerSelectLanguage => 'Selecione pelo menos um idioma.';

  @override
  String get registerFailed => 'Falha no cadastro.';

  @override
  String get registerHeaderTitle => 'CADASTRO';

  @override
  String get registerStepAccount => 'Conta';

  @override
  String get registerStepRole => 'Função';

  @override
  String get registerStepLanguages => 'Idiomas';

  @override
  String get registerStepApiKeys => 'Chaves de API';

  @override
  String get registerYourAccount => 'Sua conta';

  @override
  String get registerAvatarOptional => 'Avatar (opcional)';

  @override
  String get registerUsernameRequired => 'Nome de usuário *';

  @override
  String get registerEmailRequired => 'Endereço de e-mail *';

  @override
  String get registerPasswordRequired => 'Senha *';

  @override
  String get registerPasswordRepeat => 'Repita a senha *';

  @override
  String get registerYourRole => 'Sua função';

  @override
  String get registerRoleExplanation =>
      'Tradutores podem traduzir textos, mas não têm acesso à fila de revisão. Revisores verificam e aprovam o conteúdo traduzido.';

  @override
  String get registerRoleTranslator => 'Tradutor';

  @override
  String get registerRoleTranslatorDesc => 'Criar e editar traduções.';

  @override
  String get registerRoleReviewer => 'Revisor';

  @override
  String get registerRoleReviewerDesc => 'Revisar e aprovar traduções.';

  @override
  String get registerTargetLanguages => 'Idiomas de destino';

  @override
  String get registerLanguagesExplanation =>
      'Escolha todos os idiomas nos quais deseja trabalhar.';

  @override
  String get registerNoLanguagesAvailable => 'Nenhum idioma disponível.';

  @override
  String get registerApiKeysTitle => 'Chaves de API';

  @override
  String get registerApiKeysExplanation =>
      'Informe suas próprias chaves de API. Cada usuário usa exclusivamente suas próprias chaves. Você também pode adicioná-las depois no seu perfil.';

  @override
  String get registerKeysEncryptedNote =>
      'As chaves são armazenadas de forma criptografada e nunca são compartilhadas com outros usuários.';

  @override
  String get registerOptionalSuffix => ' (opcional)';

  @override
  String get registerSuccessTitle => 'Cadastro realizado com sucesso!';

  @override
  String get registerSuccessBody =>
      'Sua conta foi criada e está aguardando aprovação de um administrador. Você será notificado assim que seu acesso for ativado.';

  @override
  String get registerGoToLogin => 'Ir para o login';

  @override
  String get registerSubmit => 'Cadastrar';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto de $name no Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Perfil atualizado com sucesso!';

  @override
  String get profileUpdateFailed => 'Falha na atualização.';

  @override
  String profileSaveError(String error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get profilePasswordMismatch => 'As senhas não coincidem!';

  @override
  String get profilePasswordChangeSuccess => 'Senha alterada com sucesso!';

  @override
  String get profilePasswordChangeError =>
      'Erro ao alterar a senha: senha atual incorreta.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar enviado com sucesso!';

  @override
  String get profileAvatarUploadError => 'Erro ao enviar o avatar.';

  @override
  String get profileTitle => 'Perfil e configurações';

  @override
  String get profileSubtitle =>
      'Gerencie seu perfil de usuário, suas APIs de tradução (Gemini e DeepL) e a segurança da sua conta.';

  @override
  String get profileRoleUser => 'Usuário';

  @override
  String get profileNoEmail => 'Nenhum endereço de e-mail informado';

  @override
  String get profileTabDetails => 'Detalhes do perfil';

  @override
  String get profileTabGemini => 'Tradução por IA (Gemini)';

  @override
  String get profileTabDeepl => 'Tradução DeepL';

  @override
  String get profileTabPassword => 'Alterar senha';

  @override
  String get profileSectionInfo => 'INFORMAÇÕES DO PERFIL';

  @override
  String get profileFieldName => 'Nome';

  @override
  String get profileFieldNameHint => 'Seu nome completo';

  @override
  String get profileFieldEmail => 'Endereço de e-mail';

  @override
  String get profileFieldEmailHint => 'Seu endereço de e-mail';

  @override
  String get profileSectionGemini => 'CONFIGURAÇÕES DO GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Chave de API do Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Insira sua chave de API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Prompt de IA personalizado';

  @override
  String get profileFieldAiPromptHint =>
      'Opcional: personalize o prompt do sistema para o Gemini...';

  @override
  String get profileSectionDeepl => 'CONFIGURAÇÕES DE TRADUÇÃO DO DEEPL';

  @override
  String get profileDeeplDescription =>
      'O DeepL oferece tradução automática de alta qualidade com preservação de tags HTML. Contas gratuitas (500.000 caracteres/mês) recebem uma chave com o sufixo \":fx\".';

  @override
  String get profileFieldDeeplKey => 'Chave de API do DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'ex.: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Chaves gratuitas terminam em \":fx\" e usam api-free.deepl.com. Chaves Pro usam api.deepl.com. A distinção é feita automaticamente.';

  @override
  String get profileSectionSecurity => 'SEGURANÇA DA CONTA';

  @override
  String get profileFieldCurrentPassword => 'Senha atual';

  @override
  String get profileFieldCurrentPasswordHint => 'Insira sua senha atual';

  @override
  String get profileFieldNewPassword => 'Nova senha';

  @override
  String get profileFieldNewPasswordHint => 'Pelo menos 6 caracteres';

  @override
  String get profileFieldConfirmPassword => 'Confirmar nova senha';

  @override
  String get profileFieldConfirmPasswordHint => 'Repita a senha';

  @override
  String get profileChangePasswordButton => 'Alterar senha';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get settingsRegistrationUpdated =>
      'Configuração de cadastro atualizada';

  @override
  String get settingsUpdateFailed => 'Falha na atualização.';

  @override
  String get settingsUserApproved => 'Usuário aprovado!';

  @override
  String get settingsAccountDeactivated => 'Conta desativada.';

  @override
  String get settingsUserDeleted => 'Usuário excluído.';

  @override
  String get settingsActionFailed => 'Ação falhou.';

  @override
  String get settingsDeleteAccountTitle => 'Excluir conta?';

  @override
  String get settingsDeactivateAccountTitle => 'Desativar conta?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'A conta \"$username\" será excluída permanentemente. Continuar?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'A conta \"$username\" será bloqueada. O usuário não poderá mais fazer login, mas a conta será mantida.';
  }

  @override
  String get settingsDeactivate => 'Desativar';

  @override
  String settingsSyncSuccess(String count) {
    return '$count traduções sincronizadas!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Erro de sincronização: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count módulos prioritários sincronizados!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Erro ao sincronizar a lista de prioridade: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Backup realizado com sucesso: $count arquivos processados.';
  }

  @override
  String get settingsUploadFailed => 'Falha no envio.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsSystemConfig => 'CONFIGURAÇÃO DO SISTEMA';

  @override
  String get settingsRegistration => 'Cadastro';

  @override
  String get settingsRegistrationHint =>
      'Ativar ou desativar globalmente a visibilidade do formulário de cadastro.';

  @override
  String get settingsPendingUsers => 'Usuários pendentes';

  @override
  String get settingsNoNewRequests => 'Nenhuma nova solicitação.';

  @override
  String get settingsWantsReviewer => 'Deseja ser revisor';

  @override
  String get settingsAssignRole => 'Atribuir função';

  @override
  String get settingsRoleTranslator => 'Tradutor';

  @override
  String get settingsRoleReviewer => 'Revisor';

  @override
  String get settingsApprove => 'Aprovar';

  @override
  String get settingsReject => 'Rejeitar';

  @override
  String get settingsActiveUsers => 'Usuários ativos';

  @override
  String get settingsNoActiveUsers => 'Nenhum usuário ativo.';

  @override
  String get settingsDeactivateAccountTooltip => 'Desativar';

  @override
  String get settingsDeleteAccountAction => 'Excluir conta';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsThemePearl => 'CLARO (PÉROLA)';

  @override
  String get settingsThemeDark => 'ESCURO';

  @override
  String get settingsThemeGlassy => 'VIDRO';

  @override
  String get settingsThemeNature => 'NATUREZA';

  @override
  String get settingsThemeLiquid => 'LÍQUIDO';

  @override
  String get settingsThemeStage => 'PALCO';

  @override
  String get settingsTypography => 'Tipografia';

  @override
  String get settingsFontHint => 'Alterar a família tipográfica da interface.';

  @override
  String get settingsFontClean => 'Limpa';

  @override
  String get settingsFontFuturistic => 'Futurista';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Fluxo de trabalho e diversão';

  @override
  String get settingsConfettiTitle => 'Celebração de sucesso (confetes)';

  @override
  String get settingsConfettiHint =>
      'Exibe uma pequena animação ao salvar com sucesso.';

  @override
  String get settingsLargeUiTitle => 'Legibilidade aprimorada (fonte grande)';

  @override
  String get settingsLargeUiHint =>
      'Aumenta o tamanho de fontes e selos para melhor legibilidade.';

  @override
  String get settingsAutoPTitle =>
      'Formatação automática de parágrafos (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Envolve automaticamente o texto simples em parágrafos <p> quando um módulo é carregado na tela de revisão. Equivale a clicar manualmente no botão ¶.';

  @override
  String get settingsDatabaseSync => 'Sincronização do banco de dados';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sincroniza as entradas do banco de dados com os arquivos JSON de tradução.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sincroniza as entradas internas do banco de dados com os JSONs de tradução no servidor.';

  @override
  String get settingsSyncing => 'Sincronizando...';

  @override
  String get settingsSyncNow => 'Sincronizar agora';

  @override
  String get settingsSyncD11List => 'Sincronizar lista D11';

  @override
  String get settingsUploadBackup => 'Enviar backup (.zip)';

  @override
  String get settingsSelectZipFile => 'Selecionar arquivo ZIP';

  @override
  String get settingsUploading => 'Enviando...';

  @override
  String get settingsErrorDiagnostics =>
      'Diagnóstico de erros e logs do sistema';

  @override
  String get settingsLogsCopied =>
      'Logs copiados para a área de transferência! 📋';

  @override
  String get settingsCopyLogs => 'Copiar logs';

  @override
  String get settingsLogsRotated => 'Logs arquivados e rotacionados! 📁';

  @override
  String get settingsRotate => 'Rotacionar';

  @override
  String get settingsClear => 'Limpar';

  @override
  String get settingsLogLimit => 'Limite de logs: ';

  @override
  String get settingsNoLogs => 'Nenhum log registrado';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Análises';

  @override
  String get layoutNavReviewQueue => 'Fila de revisão';

  @override
  String get layoutNavGlossary => 'Glossário';

  @override
  String get layoutNavCategories => 'Categorias';

  @override
  String get layoutNavHelp => 'Ajuda';

  @override
  String get layoutNavSettings => 'Configurações';

  @override
  String get layoutPhotoBy => 'Foto de ';

  @override
  String get layoutPhotoOn => ' no ';

  @override
  String get layoutEditProfile => 'Editar perfil';

  @override
  String get layoutLogout => 'Sair';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Claro';

  @override
  String get layoutThemeDark => 'Escuro';

  @override
  String get layoutThemeGlassy => 'Vidro';

  @override
  String get layoutThemeNature => 'Natureza';

  @override
  String get layoutThemeLiquid => 'Líquido';

  @override
  String get layoutThemeStage => 'Palco';

  @override
  String get layoutTargetLanguage => 'IDIOMA DE DESTINO';

  @override
  String get layoutDeeplUsage => 'USO DO DEEPL';

  @override
  String get layoutUnavailable => 'Indisponível';

  @override
  String get layoutUnlimited => 'ilimitado';

  @override
  String get layoutUsed => 'usado';

  @override
  String get layoutTranslate => 'Traduzir';

  @override
  String get analyticsSubtitle =>
      'Compatibilidade, backlog de tradução e tendências semanais.';

  @override
  String get analyticsBacklog => 'Backlog de tradução';

  @override
  String get analyticsMissing => 'Ausentes';

  @override
  String get analyticsStale => 'Desatualizadas';

  @override
  String get analyticsInReview => 'Em revisão';

  @override
  String get analyticsReleased => 'Publicadas';

  @override
  String get analyticsTranslated => 'Traduzidas';

  @override
  String get analyticsTotalModules => 'Total de módulos';

  @override
  String get analyticsCompatByVersion => 'Compatibilidade por versão do Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Idioma: $lang · publicadas / em revisão / ausentes';
  }

  @override
  String get analyticsLoadingCounts => 'Carregando contagens …';

  @override
  String get analyticsWindow => 'Período:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks semanas';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Novas descrições de projetos por semana';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marcadas como desatualizadas por semana ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count módulos';
  }

  @override
  String get analyticsReviewShort => 'Revisão';

  @override
  String get analyticsNoDataInWindow => 'Nenhum dado neste período.';

  @override
  String get analyticsAndMore => '… e mais';

  @override
  String glossaryLoadError(String error) {
    return 'Erro ao carregar: $error';
  }

  @override
  String get glossaryNewTerm => 'Criar novo termo';

  @override
  String get glossaryEditTerm => 'Editar termo';

  @override
  String get glossaryFieldSourceWord =>
      'Palavra de origem (forma base, como aparece no texto)';

  @override
  String get glossaryFieldSourceWordHint => 'ex.: node (nó)';

  @override
  String get glossaryWordForms =>
      'Outras formas da palavra (plural, genitivo, dativo …)';

  @override
  String get glossaryWordFormsHint =>
      'ex.: content (conteúdo) — pressione Enter para adicionar';

  @override
  String get glossaryAddForm => 'Adicionar forma';

  @override
  String get glossaryFieldPreferredWord => 'Tradução preferida';

  @override
  String get glossaryFieldPreferredWordHint => 'ex.: conteúdo';

  @override
  String get glossaryFieldExplanation =>
      'Explicação (exibida na dica de contexto)';

  @override
  String get glossaryFieldExplanationHint =>
      'Por que essa palavra deveria ser traduzida de forma diferente?';

  @override
  String get glossaryCreate => 'Criar';

  @override
  String get glossaryRequiredFields =>
      'A palavra de origem e a tradução preferida são obrigatórias.';

  @override
  String get glossaryCreated => 'Termo criado ✓';

  @override
  String get glossaryUpdated => 'Termo atualizado ✓';

  @override
  String glossaryError(String error) {
    return 'Erro: $error';
  }

  @override
  String get glossaryDeleteTitle => 'Excluir termo?';

  @override
  String glossaryDeleteBody(String word) {
    return '\"$word\" será removido permanentemente do glossário.';
  }

  @override
  String get glossaryDeleted => 'Termo excluído.';

  @override
  String get glossaryTitle => 'Glossário de tradução';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Idioma: $lang · $count entradas';
  }

  @override
  String get glossaryNewShort => 'Novo';

  @override
  String get glossaryCreateTerm => 'Criar termo';

  @override
  String get glossaryInfoBanner =>
      'As palavras deste glossário são destacadas no editor de revisão. Uma dica de contexto explica ao passar o mouse por que outra tradução é mais adequada.';

  @override
  String get glossaryNoEntries => 'Ainda não há entradas.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Clique em \"Criar termo\" para criar a primeira entrada.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Ainda não há entradas de glossário para este idioma.';

  @override
  String get diffNoChanges => 'Nenhuma diferença de conteúdo detectada.';

  @override
  String get diffRemoved => 'Removido';

  @override
  String get diffAdded => 'Adicionado';

  @override
  String syncBarQuickSync(String count) {
    return 'Sincronização rápida: $count módulos alterados …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sincronização completa: $current / $total módulos';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sincronização completa: $count módulos …';
  }
}
