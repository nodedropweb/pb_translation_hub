// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Cargando detalles del proyecto...';

  @override
  String editorLoadError(String error) {
    return 'Error al cargar los datos del proyecto: $error';
  }

  @override
  String get editorGeminiSuccess =>
      '¡Traducción con Gemini completada con éxito! ✨';

  @override
  String get editorUnknownError => 'Error desconocido';

  @override
  String editorGeminiFailed(String detail) {
    return 'Fallo en la traducción con Gemini: $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Añade tu clave de Google AI en tu perfil de usuario (no en la configuración de administración).';

  @override
  String get editorGeminiError =>
      'Error durante la traducción con Gemini. Comprueba tu clave de Google AI en tu perfil.';

  @override
  String get editorDeeplSuccess =>
      '¡Traducción con DeepL completada con éxito! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Fallo en la traducción con DeepL: $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Error durante la traducción con DeepL. Asegúrate de que tu clave de API de DeepL esté configurada en tu perfil.';

  @override
  String get editorDeeplInvalidKey =>
      'Clave de API de DeepL no válida. Compruébala en tu perfil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Se ha agotado la cuota de DeepL. Comprueba tu plan.';

  @override
  String get editorReviewReset =>
      'Traducción restablecida al estado de revisión.';

  @override
  String editorResetError(String error) {
    return 'Error al restablecer: $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'El módulo se ha devuelto a la lista activa.';

  @override
  String get editorUnignoreError => 'Error al restaurar el módulo.';

  @override
  String get editorSaveSuccess =>
      'Traducción guardada — de vuelta a la cola de revisión.';

  @override
  String editorSaveError(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get editorNoMoreProjects =>
      'No hay más proyectos abiertos en la lista.';

  @override
  String get editorChangesDiscarded =>
      'Cambios descartados, cargando el siguiente proyecto...';

  @override
  String get editorEnglishSourceApplied =>
      'Original en inglés aplicado — tradúcelo ahora.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'No se pudo abrir la URL: $url';
  }

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get editorCloseEnglishSource => 'Cerrar fuente en inglés';

  @override
  String get editorShowEnglishSource => 'Mostrar fuente en inglés';

  @override
  String get editorUnignoreShortTooltip => 'Restaurar módulo';

  @override
  String get editorBackToReviewTooltip => 'Volver a estado de revisión';

  @override
  String get editorAndNext => 'y Siguiente';

  @override
  String get editorBackToDashboard => 'Volver al panel';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Traduciendo a $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count restantes';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Devolver el módulo a la lista activa';

  @override
  String get editorUnignoreLabel => 'Restaurar';

  @override
  String get editorUnpublishTooltip =>
      'Revocar publicación y volver a estado de revisión';

  @override
  String get editorBackToReview => 'Volver a revisión';

  @override
  String get editorSaveAndNext => 'Guardar y siguiente';

  @override
  String get editorEnglishSourceHeader => 'FUENTE EN INGLÉS';

  @override
  String get editorStaleTooltip =>
      'Mostrar explicación y aplicar el texto en inglés';

  @override
  String get editorStaleDetailsLabel => 'Obsoleto — Detalles';

  @override
  String get editorCopyPromptTooltip => 'Copiar fuente + prompt de traducción';

  @override
  String get editorPromptCopied => 'Prompt copiado al portapapeles 📋';

  @override
  String get editorShowPreview => 'Mostrar vista previa';

  @override
  String get editorShowHtmlSource => 'Mostrar código fuente HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RESUMEN:\n$summary\n\nCONTENIDO:\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Resumen:';

  @override
  String get editorDescriptionLabelColon => 'Descripción:';

  @override
  String get editorStaleDialogTitle => 'La fuente en inglés ha cambiado';

  @override
  String get editorStaleExplanation =>
      'La traducción existente se basa en un texto original en inglés desactualizado. Desde la última traducción, el mantenedor del módulo ha cambiado el texto en inglés en Drupal.org — por lo tanto, el contenido de la traducción existente puede que ya no sea preciso ni esté completo.';

  @override
  String get editorStaleTip =>
      'Consejo: haz clic en «Usar original en inglés» para cargar la fuente en inglés actual directamente en el editor. Luego puedes usarla como punto de partida para una nueva traducción. El original en inglés también es visible en el panel izquierdo.';

  @override
  String get editorEnglishSourceShort => 'Fuente en inglés';

  @override
  String get editorPreviousTranslation => 'Traducción anterior';

  @override
  String get editorWhatChangedTitle => '¿Qué ha cambiado?';

  @override
  String get editorShowDiff => 'Mostrar diferencias';

  @override
  String get editorUseEnglish => 'Usar original en inglés';

  @override
  String get editorStaleBannerText =>
      'La fuente en inglés ha cambiado — la traducción está desactualizada';

  @override
  String get editorDetailsAndApply => 'Detalles y aplicación';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUCCIÓN AL $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Traduciendo...';

  @override
  String get editorShowEditor => 'Mostrar editor';

  @override
  String get editorModuleTitleLabel => 'Título del módulo (inglés)';

  @override
  String get editorSummaryFieldLabel => 'Resumen';

  @override
  String get editorBodyFieldLabel => 'Contenido';

  @override
  String get editorHtmlCleaned => 'HTML limpiado';

  @override
  String get editorLivePreviewHeader => 'VISTA PREVIA EN VIVO';

  @override
  String get editorTidyHtmlTooltip =>
      'Limpiar HTML (eliminar artefactos de DeepL)';

  @override
  String get editorVisualMode => 'VISUAL';

  @override
  String get editorSourceCodeMode => 'FUENTE (HTML)';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get costDialogTitle => 'Estimación de costes (IA)';

  @override
  String get costDialogIntro =>
      'El módulo seleccionado se traducirá con Google Gemini AI. Aquí tienes el desglose estimado del coste de esta operación:';

  @override
  String get costRowModel => 'Modelo';

  @override
  String get costRowInputTokens => 'Tokens de entrada';

  @override
  String get costRowOutputTokens => 'Tokens de salida (estimación)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caracteres)';
  }

  @override
  String get costRowPriceInput => 'Precio por 1M de entrada';

  @override
  String get costRowPriceOutput => 'Precio por 1M de salida';

  @override
  String get costRowTotalEstimate => 'Coste total estimado';

  @override
  String get costDialogFootnote =>
      '* Nota: esto es una estimación basada en el modelo de precios de pago por uso actual de Google. El uso real puede variar ligeramente.';

  @override
  String get costDialogStartTranslation => 'Iniciar traducción';

  @override
  String get htmlToolbarInsertLink => 'Insertar enlace';

  @override
  String get htmlToolbarLinkTooltip => 'Insertar enlace (a)';

  @override
  String get htmlToolbarInsert => 'Insertar';

  @override
  String get htmlToolbarHeading2 => 'Encabezado 2';

  @override
  String get htmlToolbarHeading3 => 'Encabezado 3';

  @override
  String get htmlToolbarBold => 'Negrita (strong)';

  @override
  String get htmlToolbarItalic => 'Cursiva (em)';

  @override
  String get htmlToolbarBulletList => 'Lista con viñetas (ul)';

  @override
  String get htmlToolbarNumberedList => 'Lista numerada (ol)';

  @override
  String get htmlToolbarQuote => 'Cita (blockquote)';

  @override
  String get screenshotAltsHeader =>
      'TEXTO ALTERNATIVO DE LAS CAPTURAS DE PANTALLA';

  @override
  String get screenshotAltsIntro =>
      'Introduce un texto alternativo descriptivo en el idioma de destino para cada captura de pantalla.';

  @override
  String screenshotLabel(int number) {
    return 'Captura de pantalla $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Vista previa no disponible';

  @override
  String get screenshotAltHint =>
      'Introduce el texto alternativo en el idioma de destino…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      '¿Restaurar todos los módulos ignorados?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Todos los módulos ignorados se devolverán a la lista activa y volverán a estar disponibles para su traducción.';

  @override
  String get dashUnignoreAllConfirmAction => 'Restaurar todos';

  @override
  String get dashUnignoreAllSuccess =>
      'Se han restaurado todos los módulos ignorados.';

  @override
  String get dashUnignoreAllError => 'Error al restaurar los módulos.';

  @override
  String get dashUnignoreAllButton => 'Restaurar todos los módulos ignorados';

  @override
  String dashSyncStartError(String error) {
    return 'Error al iniciar la sincronización: $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'Actualización rápida (7 días) iniciada ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Error de actualización rápida: $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Sincronizado correctamente: $name';
  }

  @override
  String get dashManualSyncNotFound => 'Módulo no encontrado en Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Traducción masiva con IA';

  @override
  String get dashHeaderTitle => 'Descripciones de proyectos';

  @override
  String get dashHeaderSubtitle =>
      'Traduce descripciones de módulos de Drupal al idioma de destino. Ayuda a que el ecosistema sea más accesible.';

  @override
  String get dashHeaderSubtitleShort =>
      'Traduce descripciones de módulos de Drupal.';

  @override
  String get dashLastLabel => 'Último: ';

  @override
  String get dashContinue => 'Continuar';

  @override
  String get dashContinueShort => 'Continuar';

  @override
  String get dashUnignoreAllButtonLong =>
      'Restaurar todos los módulos ignorados';

  @override
  String get dashQuickUpdateTooltip => 'Actualización rápida (últimos 7 días)';

  @override
  String get dashFullSyncTooltip =>
      'Sincronización completa de la base de datos desde Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Cargar manualmente un único módulo desde Drupal.org';

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
    return '$count / pág.';
  }

  @override
  String get dashFirstPage => 'Primera página';

  @override
  String get dashPrevPage => 'Página anterior';

  @override
  String get dashNextPage => 'Página siguiente';

  @override
  String get dashLastPage => 'Última página';

  @override
  String dashPageOf(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (p. ej., pathauto)';

  @override
  String get dashAddButton => 'Añadir';

  @override
  String get dashAddModuleManually => 'Añadir módulo manualmente';

  @override
  String get dashAddModuleSubtitle =>
      'Cargar directamente desde Drupal.org por machine name.';

  @override
  String get dashAddModuleShort => 'Añadir módulo';

  @override
  String get dashNoProjectsFound => 'No se encontraron proyectos.';

  @override
  String get dashFilterAll => 'Todos los proyectos';

  @override
  String get dashFilterMissing => 'Traducciones faltantes';

  @override
  String get dashFilterReview => 'Cola de revisión';

  @override
  String get dashFilterTranslated => 'Proyectos traducidos';

  @override
  String get dashFilterReleased => 'Proyectos publicados';

  @override
  String get dashBulkDialogIntro =>
      'Traduce automáticamente varios módulos del filtro seleccionado usando Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtro activo';

  @override
  String get dashModuleCount => 'Número de módulos';

  @override
  String dashModulesCountItem(int count) {
    return '$count módulos';
  }

  @override
  String get dashPrioritizeD12Title => 'Priorizar módulos de Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Traduce primero los módulos sin compatibilidad con Drupal 12';

  @override
  String get dashTotalModules => 'Total de módulos';

  @override
  String get dashInputTokensEst => 'Tokens de entrada (est.)';

  @override
  String get dashOutputTokensEst => 'Tokens de salida (est.)';

  @override
  String get dashBulkFootnote =>
      '* La traducción se ejecuta en lotes eficientes en recursos para evitar tiempos de espera agotados.';

  @override
  String get dashStartBulkTranslation => 'Iniciar traducción masiva';

  @override
  String dashStaleLoadError(String error) {
    return 'Error al cargar módulos desactualizados: $error';
  }

  @override
  String get dashNoStaleModules =>
      'No se encontraron módulos desactualizados — ¡todo está al día! ✨';

  @override
  String get dashRetranslateOutdatedTitle =>
      'Retraducir módulos desactualizados';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Todas las traducciones cuya fuente en inglés haya cambiado desde la última traducción se retraducirán automáticamente con Google Gemini. No es necesario abrir cada módulo manualmente.';

  @override
  String get dashOutdatedModules => 'Módulos desactualizados';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* La traducción reemplaza el texto existente y restablece is_reviewed. Se ejecuta en lotes de 4 módulos.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Retraducir los $count módulos';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Retraduciendo módulos desactualizados…';

  @override
  String get dashFetchingProjects => 'Obteniendo proyectos del servidor…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed de $total módulos procesados';
  }

  @override
  String get dashNoTranslatableProjects =>
      'No se encontraron proyectos traducibles para este filtro.';

  @override
  String get dashStartingTranslation => 'Iniciando traducción…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Traduciendo el módulo $start–$end de $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end de $total módulos completados.';
  }

  @override
  String get dashTranslationCompleted => '¡Traducción completada con éxito! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return '¡Traducción masiva de $count módulos realizada con éxito! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Error de traducción masiva: $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return '¡Los $count módulos se han retraducido correctamente! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '¡$count módulos desactualizados retraducidos correctamente! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Error durante la retraducción: $error';
  }

  @override
  String get filterAllShort => 'Todos';

  @override
  String get filterMissing => 'Faltantes';

  @override
  String get filterTranslated => 'Traducidos';

  @override
  String get filterReviewQueue => 'Cola de revisión';

  @override
  String get filterReleased => 'Publicados';

  @override
  String get filterOutdated => 'Desactualizados';

  @override
  String get filterPriority => 'Prioridad';

  @override
  String get filterIgnored => 'Ignorados';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonReset => 'Restablecer';

  @override
  String get commonRefresh => 'Actualizar';

  @override
  String commonErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      '¿Restablecer todas las traducciones publicadas?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Todas las traducciones marcadas como publicadas para $langcode se restablecerán al estado de revisión. Esto no se puede deshacer.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traducciones restablecidas al estado de revisión.';
  }

  @override
  String get reviewPipelineTitle => 'Flujo de revisión';

  @override
  String get reviewPipelineSubtitle =>
      'Proceso de control de calidad humano para traducciones de IA';

  @override
  String get reviewSearchHint => 'Buscar proyectos...';

  @override
  String get reviewResetPublished => 'Restablecer publicadas';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Resultados: $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'Pendientes: $count';
  }

  @override
  String get reviewNoProjectsPending =>
      'No hay proyectos pendientes de revisión.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Todas las traducciones ya han sido verificadas, o ninguna existe en este contexto de idioma.';

  @override
  String get reviewNoSummary => 'Sin resumen.';

  @override
  String get reviewStartAudit => 'INICIAR AUDITORÍA';

  @override
  String get reviewHtmlSourceShort => 'Fuente HTML';

  @override
  String get reviewCopySource => 'Copiar fuente';

  @override
  String get reviewModuleDetails => 'Detalles del módulo';

  @override
  String get reviewOriginalTitle => 'Título original';

  @override
  String get reviewDrupalOrgProject => 'Proyecto de Drupal.org';

  @override
  String get reviewSuggestions => 'Sugerencias';

  @override
  String get reviewNoSuggestions => 'No hay sugerencias disponibles.';

  @override
  String get reviewApply => 'Aplicar';

  @override
  String get reviewNoChanges => 'Sin cambios';

  @override
  String get reviewOriginalBeforeCorrection =>
      'Original (antes de la corrección)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corregido (versión actual)';

  @override
  String get reviewBaseOriginal => 'Base (Original)';

  @override
  String get reviewYourCorrection => 'Tu corrección';

  @override
  String get reviewChangesVisual => 'Revisa tus cambios (visual)';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonIgnore => 'Ignorar';

  @override
  String get reviewEmptyProjectTitle => 'Proyecto vacío';

  @override
  String get reviewEmptyProjectBody =>
      'Este proyecto está vacío (sin título, resumen ni contenido) y no se puede aprobar. Por favor, omítelo.';

  @override
  String get reviewApprovedSuccess => '¡Traducción aprobada! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ La aprobación de «$machine» ha fallado — inténtalo de nuevo.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Restaurado. ¡El módulo está activo de nuevo!';

  @override
  String get reviewActionFailed => 'La acción ha fallado.';

  @override
  String get reviewIgnoreModuleTitle => '¿Ignorar módulo?';

  @override
  String get reviewIgnoreModuleBody =>
      'Este módulo se ocultará de forma permanente en todas las listas. Ya no te quedarás atascado en él.';

  @override
  String get reviewModulePermanentlyIgnored =>
      'Módulo ignorado permanentemente.';

  @override
  String get reviewIgnoreFailed => 'Error al ignorar el módulo.';

  @override
  String get reviewSuggestionSaved => '¡Borrador de sugerencia guardado! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Error al guardar el borrador de sugerencia.';

  @override
  String get reviewSuggestionDeleted => 'Sugerencia eliminada.';

  @override
  String get reviewDeleteFailed => 'Error al eliminar.';

  @override
  String get reviewSuggestionApplied => 'Sugerencia aplicada.';

  @override
  String get reviewPreparingData => 'Preparando datos de revisión...';

  @override
  String get reviewDirectEdit => 'Edición directa';

  @override
  String get reviewLivePreview => 'Vista previa en vivo';

  @override
  String get reviewCompareWith => 'Comparar con:';

  @override
  String get reviewProductionVersion => 'Versión de producción';

  @override
  String get reviewEditorialReview => 'Revisión editorial';

  @override
  String get reviewOpenQueue => 'Abrir cola de revisión';

  @override
  String get reviewCopyPromptShort => 'Copiar prompt';

  @override
  String get reviewUnignoreShort => 'Restaurar';

  @override
  String get reviewApproveButton => 'APROBAR';

  @override
  String get reviewHideDetails => 'Ocultar detalles';

  @override
  String get reviewDetailsAndEnglishSource => 'Detalles y fuente en inglés';

  @override
  String reviewPendingCountShort(int count) {
    return '$count pendientes';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Revisando $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Comparar traducción con la fuente en inglés';

  @override
  String get reviewTranslationLabel => 'Traducción';

  @override
  String get reviewComparisonTitle => 'Comparación';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copiar texto de origen + prompt de traducción al portapapeles';

  @override
  String get reviewUnignoreCaps => 'RESTAURAR';

  @override
  String get reviewIgnoreCaps => 'IGNORAR';

  @override
  String get reviewSkipShortcut => 'OMITIR (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Revisión editorial';

  @override
  String get reviewUnignoreTablet => 'RESTAURAR';

  @override
  String get reviewApproveForProduction =>
      'APROBAR PARA PRODUCCIÓN (Ctrl+Enter)';

  @override
  String get reviewDirectRefinement => 'Refinamiento directo';

  @override
  String get reviewTitleField => 'Título';

  @override
  String get reviewSummaryField => 'Resumen';

  @override
  String get reviewBodyField => 'Contenido';

  @override
  String get reviewSaveShortcut => 'GUARDAR (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering =>
      'Vista previa en vivo (renderizando)';

  @override
  String get reviewVoiceFemale => 'Femenina';

  @override
  String get reviewVoiceMale => 'Masculina';

  @override
  String get reviewStopListening => 'Detener';

  @override
  String get reviewListen => 'Escuchar';

  @override
  String get reviewAutopTooltip =>
      'Formatear párrafos automáticamente (saltos de línea → <p>)';

  @override
  String get reviewSourceCodeShort => 'FUENTE';

  @override
  String get reviewNoParagraphChange =>
      'El texto ya contiene etiquetas <p> — sin cambios';

  @override
  String get reviewParagraphsFormatted => 'Párrafos formateados ¶';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String categoriesLoadError(String error) {
    return 'Error al cargar categorías: $error';
  }

  @override
  String get categoriesSaveSuccess => 'Categorías guardadas correctamente.';

  @override
  String get categoriesSaveFailed => 'Error al guardar las traducciones.';

  @override
  String get categoriesFileEmpty => 'El archivo está vacío.';

  @override
  String get categoriesInvalidJson => 'Formato JSON no válido.';

  @override
  String get categoriesNoValidUuids =>
      'No se encontraron entradas UUID válidas en el archivo.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count categorías importadas del archivo.';
  }

  @override
  String get categoriesTitle => 'Categorías';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Traduciendo para: $lang';
  }

  @override
  String get categoriesImportJson => 'Importar JSON';

  @override
  String get categoriesSaving => 'Guardando...';

  @override
  String get categoriesSaveAll => 'Guardar todo';

  @override
  String get categoriesLoading => 'Cargando categorías...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Traducción ($code)';
  }

  @override
  String get categoriesNoneFound => 'No se encontraron categorías.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Traducir «$name»...';
  }

  @override
  String get loginPhotoBy => 'Foto de ';

  @override
  String get loginPhotoOn => ' en ';

  @override
  String get loginPleaseSignIn => 'Inicia sesión';

  @override
  String get loginUsername => 'Nombre de usuario';

  @override
  String get loginPassword => 'Contraseña';

  @override
  String get loginRememberMe => 'Recordarme';

  @override
  String get loginSignIn => 'INICIAR SESIÓN';

  @override
  String get loginNoAccount => '¿Aún no tienes cuenta? ';

  @override
  String get loginRegisterNow => 'Regístrate ahora';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get registerFillRequired => 'Rellena todos los campos obligatorios.';

  @override
  String get registerPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get registerPasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get registerSelectLanguage => 'Selecciona al menos un idioma.';

  @override
  String get registerFailed => 'Error en el registro.';

  @override
  String get registerHeaderTitle => 'REGISTRO';

  @override
  String get registerStepAccount => 'Cuenta';

  @override
  String get registerStepRole => 'Rol';

  @override
  String get registerStepLanguages => 'Idiomas';

  @override
  String get registerStepApiKeys => 'Claves de API';

  @override
  String get registerYourAccount => 'Tu cuenta';

  @override
  String get registerAvatarOptional => 'Avatar (opcional)';

  @override
  String get registerUsernameRequired => 'Nombre de usuario *';

  @override
  String get registerEmailRequired => 'Dirección de correo electrónico *';

  @override
  String get registerPasswordRequired => 'Contraseña *';

  @override
  String get registerPasswordRepeat => 'Repite la contraseña *';

  @override
  String get registerYourRole => 'Tu rol';

  @override
  String get registerRoleExplanation =>
      'Los traductores pueden traducir textos, pero no tienen acceso a la cola de revisión. Los revisores comprueban y aprueban el contenido traducido.';

  @override
  String get registerRoleTranslator => 'Traductor';

  @override
  String get registerRoleTranslatorDesc => 'Crear y editar traducciones.';

  @override
  String get registerRoleReviewer => 'Revisor';

  @override
  String get registerRoleReviewerDesc => 'Revisar y aprobar traducciones.';

  @override
  String get registerTargetLanguages => 'Idiomas de destino';

  @override
  String get registerLanguagesExplanation =>
      'Elige todos los idiomas en los que quieras trabajar.';

  @override
  String get registerNoLanguagesAvailable => 'No hay idiomas disponibles.';

  @override
  String get registerApiKeysTitle => 'Claves de API';

  @override
  String get registerApiKeysExplanation =>
      'Introduce tus propias claves de API. Cada usuario utiliza exclusivamente sus propias claves. También puedes añadirlas más tarde en tu perfil.';

  @override
  String get registerKeysEncryptedNote =>
      'Las claves se almacenan cifradas y nunca se comparten con otros usuarios.';

  @override
  String get registerOptionalSuffix => ' (opcional)';

  @override
  String get registerSuccessTitle => '¡Registro completado con éxito!';

  @override
  String get registerSuccessBody =>
      'Tu cuenta ha sido creada y está pendiente de aprobación por parte de un administrador. Se te notificará en cuanto se active tu acceso.';

  @override
  String get registerGoToLogin => 'Ir a iniciar sesión';

  @override
  String get registerSubmit => 'Registrarse';

  @override
  String registerPhotoCredit(String name) {
    return 'Foto de $name en Unsplash';
  }

  @override
  String get profileUpdateSuccess => '¡Perfil actualizado con éxito!';

  @override
  String get profileUpdateFailed => 'Error al actualizar.';

  @override
  String profileSaveError(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get profilePasswordMismatch => '¡Las contraseñas no coinciden!';

  @override
  String get profilePasswordChangeSuccess => '¡Contraseña cambiada con éxito!';

  @override
  String get profilePasswordChangeError =>
      'Error al cambiar la contraseña: la contraseña actual es incorrecta.';

  @override
  String get profileAvatarUploadSuccess => '¡Avatar subido con éxito!';

  @override
  String get profileAvatarUploadError => 'Error al subir el avatar.';

  @override
  String get profileTitle => 'Perfil y configuración';

  @override
  String get profileSubtitle =>
      'Gestiona tu perfil de usuario, tus API de traducción (Gemini y DeepL) y la seguridad de tu cuenta.';

  @override
  String get profileRoleUser => 'Usuario';

  @override
  String get profileNoEmail =>
      'No se ha proporcionado dirección de correo electrónico';

  @override
  String get profileTabDetails => 'Detalles del perfil';

  @override
  String get profileTabGemini => 'Traducción por IA (Gemini)';

  @override
  String get profileTabDeepl => 'Traducción DeepL';

  @override
  String get profileTabPassword => 'Cambiar contraseña';

  @override
  String get profileSectionInfo => 'INFORMACIÓN DEL PERFIL';

  @override
  String get profileFieldName => 'Nombre';

  @override
  String get profileFieldNameHint => 'Tu nombre completo';

  @override
  String get profileFieldEmail => 'Dirección de correo electrónico';

  @override
  String get profileFieldEmailHint => 'Tu dirección de correo electrónico';

  @override
  String get profileSectionGemini => 'AJUSTES DE GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Clave de API de Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Introduce tu clave de API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Prompt de IA personalizado';

  @override
  String get profileFieldAiPromptHint =>
      'Opcional: personaliza el prompt del sistema para Gemini...';

  @override
  String get profileSectionDeepl => 'AJUSTES DE TRADUCCIÓN DE DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL ofrece traducción automática de alta calidad conservando las etiquetas HTML. Las cuentas gratuitas (500.000 caracteres/mes) reciben una clave con el sufijo «:fx».';

  @override
  String get profileFieldDeeplKey => 'Clave de API de DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'p. ej., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Las claves gratuitas terminan en «:fx» y usan api-free.deepl.com. Las claves Pro usan api.deepl.com. La distinción se hace automáticamente.';

  @override
  String get profileSectionSecurity => 'SEGURIDAD DE LA CUENTA';

  @override
  String get profileFieldCurrentPassword => 'Contraseña actual';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Introduce tu contraseña actual';

  @override
  String get profileFieldNewPassword => 'Nueva contraseña';

  @override
  String get profileFieldNewPasswordHint => 'Al menos 6 caracteres';

  @override
  String get profileFieldConfirmPassword => 'Confirmar nueva contraseña';

  @override
  String get profileFieldConfirmPasswordHint => 'Repite la contraseña';

  @override
  String get profileChangePasswordButton => 'Cambiar contraseña';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get settingsRegistrationUpdated =>
      'Configuración de registro actualizada';

  @override
  String get settingsUpdateFailed => 'Error al actualizar.';

  @override
  String get settingsUserApproved => '¡Usuario aprobado!';

  @override
  String get settingsAccountDeactivated => 'Cuenta desactivada.';

  @override
  String get settingsUserDeleted => 'Usuario eliminado.';

  @override
  String get settingsActionFailed => 'La acción ha fallado.';

  @override
  String get settingsDeleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String get settingsDeactivateAccountTitle => '¿Desactivar cuenta?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'La cuenta «$username» se eliminará de forma permanente. ¿Continuar?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'La cuenta «$username» se bloqueará. El usuario ya no podrá iniciar sesión, pero la cuenta se conservará.';
  }

  @override
  String get settingsDeactivate => 'Desactivar';

  @override
  String settingsSyncSuccess(String count) {
    return '¡$count traducciones sincronizadas!';
  }

  @override
  String settingsSyncError(String error) {
    return 'Error de sincronización: $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '¡$count módulos prioritarios sincronizados!';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Error al sincronizar la lista de prioridad: $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Copia de seguridad correcta: $count archivos procesados.';
  }

  @override
  String get settingsUploadFailed => 'Error al subir.';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsSystemConfig => 'CONFIGURACIÓN DEL SISTEMA';

  @override
  String get settingsRegistration => 'Registro';

  @override
  String get settingsRegistrationHint =>
      'Activa o desactiva globalmente la visibilidad del formulario de registro.';

  @override
  String get settingsPendingUsers => 'Usuarios pendientes';

  @override
  String get settingsNoNewRequests => 'No hay nuevas solicitudes.';

  @override
  String get settingsWantsReviewer => 'Quiere ser revisor';

  @override
  String get settingsAssignRole => 'Asignar rol';

  @override
  String get settingsRoleTranslator => 'Traductor';

  @override
  String get settingsRoleReviewer => 'Revisor';

  @override
  String get settingsApprove => 'Aprobar';

  @override
  String get settingsReject => 'Rechazar';

  @override
  String get settingsActiveUsers => 'Usuarios activos';

  @override
  String get settingsNoActiveUsers => 'No hay usuarios activos.';

  @override
  String get settingsDeactivateAccountTooltip => 'Desactivar';

  @override
  String get settingsDeleteAccountAction => 'Eliminar cuenta';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsThemePearl => 'CLARO (PERLA)';

  @override
  String get settingsThemeDark => 'OSCURO';

  @override
  String get settingsThemeGlassy => 'CRISTAL';

  @override
  String get settingsThemeNature => 'NATURALEZA';

  @override
  String get settingsThemeLiquid => 'LÍQUIDO';

  @override
  String get settingsThemeStage => 'ESCENARIO';

  @override
  String get settingsTypography => 'Tipografía';

  @override
  String get settingsFontHint =>
      'Modificar la familia tipográfica de la interfaz.';

  @override
  String get settingsFontClean => 'Limpia';

  @override
  String get settingsFontFuturistic => 'Futurista';

  @override
  String get settingsFontTech => 'Tecnológica';

  @override
  String get settingsWorkflowFun => 'Flujo de trabajo y diversión';

  @override
  String get settingsConfettiTitle => 'Celebración de éxito (confeti)';

  @override
  String get settingsConfettiHint =>
      'Muestra una pequeña animación al guardar con éxito.';

  @override
  String get settingsLargeUiTitle => 'Legibilidad mejorada (fuente grande)';

  @override
  String get settingsLargeUiHint =>
      'Aumenta el tamaño de las fuentes y las insignias para mejorar la legibilidad.';

  @override
  String get settingsAutoPTitle => 'Formateo automático de párrafos (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Envuelve automáticamente el texto plano en párrafos <p> cuando se carga un módulo en la pantalla de revisión. Equivale a hacer clic manualmente en el botón ¶.';

  @override
  String get settingsDatabaseSync => 'Sincronización de la base de datos';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Sincroniza las entradas de la base de datos con los archivos JSON de traducción.';

  @override
  String get settingsDatabaseSyncHint =>
      'Sincroniza las entradas internas de la base de datos con los JSON de traducción en el servidor.';

  @override
  String get settingsSyncing => 'Sincronizando...';

  @override
  String get settingsSyncNow => 'Sincronizar ahora';

  @override
  String get settingsSyncD11List => 'Sincronizar lista D11';

  @override
  String get settingsUploadBackup => 'Subir copia de seguridad (.zip)';

  @override
  String get settingsSelectZipFile => 'Seleccionar archivo ZIP';

  @override
  String get settingsUploading => 'Subiendo...';

  @override
  String get settingsErrorDiagnostics =>
      'Diagnóstico de errores y registros del sistema';

  @override
  String get settingsLogsCopied => '¡Registros copiados al portapapeles! 📋';

  @override
  String get settingsCopyLogs => 'Copiar registros';

  @override
  String get settingsLogsRotated => '¡Registros archivados y rotados! 📁';

  @override
  String get settingsRotate => 'Rotar';

  @override
  String get settingsClear => 'Borrar';

  @override
  String get settingsLogLimit => 'Límite de registros: ';

  @override
  String get settingsNoLogs => 'No hay registros guardados';

  @override
  String get layoutMenu => 'Menú';

  @override
  String get layoutNavAnalytics => 'Estadísticas';

  @override
  String get layoutNavReviewQueue => 'Cola de revisión';

  @override
  String get layoutNavGlossary => 'Glosario';

  @override
  String get layoutNavCategories => 'Categorías';

  @override
  String get layoutNavHelp => 'Ayuda';

  @override
  String get layoutNavSettings => 'Configuración';

  @override
  String get layoutPhotoBy => 'Foto de ';

  @override
  String get layoutPhotoOn => ' en ';

  @override
  String get layoutEditProfile => 'Editar perfil';

  @override
  String get layoutLogout => 'Cerrar sesión';

  @override
  String get layoutThemeLabel => 'TEMA';

  @override
  String get layoutThemePearl => 'Claro';

  @override
  String get layoutThemeDark => 'Oscuro';

  @override
  String get layoutThemeGlassy => 'Cristal';

  @override
  String get layoutThemeNature => 'Naturaleza';

  @override
  String get layoutThemeLiquid => 'Líquido';

  @override
  String get layoutThemeStage => 'Escenario';

  @override
  String get layoutTargetLanguage => 'IDIOMA DE DESTINO';

  @override
  String get layoutDeeplUsage => 'USO DE DEEPL';

  @override
  String get layoutUnavailable => 'No disponible';

  @override
  String get layoutUnlimited => 'ilimitado';

  @override
  String get layoutUsed => 'usado';

  @override
  String get layoutTranslate => 'Traducir';

  @override
  String get analyticsSubtitle =>
      'Compatibilidad, trabajo de traducción pendiente y tendencias semanales.';

  @override
  String get analyticsBacklog => 'Trabajo de traducción pendiente';

  @override
  String get analyticsMissing => 'Faltantes';

  @override
  String get analyticsStale => 'Desactualizadas';

  @override
  String get analyticsInReview => 'En revisión';

  @override
  String get analyticsReleased => 'Publicadas';

  @override
  String get analyticsTranslated => 'Traducidas';

  @override
  String get analyticsTotalModules => 'Total de módulos';

  @override
  String get analyticsCompatByVersion => 'Compatibilidad por versión de Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Idioma: $lang · publicadas / en revisión / faltantes';
  }

  @override
  String get analyticsLoadingCounts => 'Cargando recuentos …';

  @override
  String get analyticsWindow => 'Período:';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks semanas';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nuevas descripciones de proyectos por semana';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marcadas como desactualizadas por semana ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count módulos';
  }

  @override
  String get analyticsReviewShort => 'Revisión';

  @override
  String get analyticsNoDataInWindow => 'No hay datos en este período.';

  @override
  String get analyticsAndMore => '… y más';

  @override
  String glossaryLoadError(String error) {
    return 'Error al cargar: $error';
  }

  @override
  String get glossaryNewTerm => 'Crear nuevo término';

  @override
  String get glossaryEditTerm => 'Editar término';

  @override
  String get glossaryFieldSourceWord =>
      'Palabra de origen (forma base, tal como aparece en el texto)';

  @override
  String get glossaryFieldSourceWordHint => 'p. ej., node';

  @override
  String get glossaryWordForms =>
      'Otras formas de la palabra (plural, genitivo, dativo, etc.)';

  @override
  String get glossaryWordFormsHint =>
      'p. ej., content — pulsa Intro para añadir';

  @override
  String get glossaryAddForm => 'Añadir forma';

  @override
  String get glossaryFieldPreferredWord => 'Traducción preferida';

  @override
  String get glossaryFieldPreferredWordHint => 'p. ej., contenido';

  @override
  String get glossaryFieldExplanation =>
      'Explicación (se muestra en la información sobre herramientas)';

  @override
  String get glossaryFieldExplanationHint =>
      '¿Por qué debería traducirse esta palabra de forma diferente?';

  @override
  String get glossaryCreate => 'Crear';

  @override
  String get glossaryRequiredFields =>
      'La palabra de origen y la traducción preferida son obligatorias.';

  @override
  String get glossaryCreated => 'Término creado ✓';

  @override
  String get glossaryUpdated => 'Término actualizado ✓';

  @override
  String glossaryError(String error) {
    return 'Error: $error';
  }

  @override
  String get glossaryDeleteTitle => '¿Eliminar término?';

  @override
  String glossaryDeleteBody(String word) {
    return '«$word» se eliminará permanentemente del glosario.';
  }

  @override
  String get glossaryDeleted => 'Término eliminado.';

  @override
  String get glossaryTitle => 'Glosario de traducción';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Idioma: $lang · $count entradas';
  }

  @override
  String get glossaryNewShort => 'Nuevo';

  @override
  String get glossaryCreateTerm => 'Crear término';

  @override
  String get glossaryInfoBanner =>
      'Las palabras de este glosario se resaltan en el editor de revisión. Una información sobre herramientas explica al pasar el cursor por qué una traducción diferente es más adecuada.';

  @override
  String get glossaryNoEntries => 'Aún no hay entradas.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Haz clic en «Crear término» para crear la primera entrada.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Aún no hay entradas de glosario para este idioma.';

  @override
  String get diffNoChanges => 'No se detectaron diferencias de contenido.';

  @override
  String get diffRemoved => 'Eliminado';

  @override
  String get diffAdded => 'Añadido';

  @override
  String syncBarQuickSync(String count) {
    return 'Sincronización rápida: $count módulos modificados …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Sincronización completa: $current / $total módulos';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Sincronización completa: $count módulos …';
  }
}
