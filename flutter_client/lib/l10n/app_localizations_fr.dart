// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PB Translation Hub';

  @override
  String get editorLoadingProject => 'Chargement des détails du projet...';

  @override
  String editorLoadError(String error) {
    return 'Échec du chargement des données du projet : $error';
  }

  @override
  String get editorGeminiSuccess => 'Traduction avec Gemini réussie ! ✨';

  @override
  String get editorUnknownError => 'Erreur inconnue';

  @override
  String editorGeminiFailed(String detail) {
    return 'Échec de la traduction Gemini : $detail';
  }

  @override
  String get editorGeminiKeyMissing =>
      'Veuillez ajouter votre clé Google AI dans votre profil utilisateur (pas dans les paramètres d\'administration).';

  @override
  String get editorGeminiError =>
      'Erreur lors de la traduction Gemini. Veuillez vérifier votre clé Google AI dans votre profil.';

  @override
  String get editorDeeplSuccess => 'Traduction avec DeepL réussie ! 🔵';

  @override
  String editorDeeplFailed(String detail) {
    return 'Échec de la traduction DeepL : $detail';
  }

  @override
  String get editorDeeplGenericError =>
      'Erreur lors de la traduction DeepL. Vérifiez que votre clé API DeepL est bien définie dans votre profil.';

  @override
  String get editorDeeplInvalidKey =>
      'Clé API DeepL invalide. Veuillez la vérifier dans votre profil.';

  @override
  String get editorDeeplQuotaExceeded =>
      'Quota DeepL épuisé. Veuillez vérifier votre forfait.';

  @override
  String get editorReviewReset => 'Traduction remise à l\'état de révision.';

  @override
  String editorResetError(String error) {
    return 'Échec de la réinitialisation : $error';
  }

  @override
  String get editorUnignoreSuccess =>
      'Le module a été remis dans la liste active.';

  @override
  String get editorUnignoreError => 'Échec de la restauration du module.';

  @override
  String get editorSaveSuccess =>
      'Traduction enregistrée — retour à la file de révision.';

  @override
  String editorSaveError(String error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get editorNoMoreProjects => 'Plus aucun projet ouvert dans la liste.';

  @override
  String get editorChangesDiscarded =>
      'Modifications annulées, chargement du projet suivant...';

  @override
  String get editorEnglishSourceApplied =>
      'Original anglais appliqué — veuillez le traduire maintenant.';

  @override
  String editorCannotOpenUrl(String url) {
    return 'Impossible d\'ouvrir l\'URL : $url';
  }

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get editorCloseEnglishSource => 'Fermer la source anglaise';

  @override
  String get editorShowEnglishSource => 'Afficher la source anglaise';

  @override
  String get editorUnignoreShortTooltip => 'Restaurer le module';

  @override
  String get editorBackToReviewTooltip => 'Remettre en révision';

  @override
  String get editorAndNext => 'et Suivant';

  @override
  String get editorBackToDashboard => 'Retour au tableau de bord';

  @override
  String editorTranslatingInto(String langName, String langCode) {
    return 'Traduction vers $langName ($langCode)';
  }

  @override
  String editorRemainingCount(int count) {
    return '$count restants';
  }

  @override
  String get editorUnignoreLongTooltip =>
      'Remettre le module dans la liste active';

  @override
  String get editorUnignoreLabel => 'Restaurer';

  @override
  String get editorUnpublishTooltip =>
      'Révoquer la publication et remettre en révision';

  @override
  String get editorBackToReview => 'Retour à la révision';

  @override
  String get editorSaveAndNext => 'Enregistrer et suivant';

  @override
  String get editorEnglishSourceHeader => 'SOURCE ANGLAISE';

  @override
  String get editorStaleTooltip =>
      'Afficher l\'explication et appliquer le texte anglais';

  @override
  String get editorStaleDetailsLabel => 'Obsolète — Détails';

  @override
  String get editorCopyPromptTooltip =>
      'Copier la source et le prompt de traduction';

  @override
  String get editorPromptCopied => 'Prompt copié dans le presse-papiers 📋';

  @override
  String get editorShowPreview => 'Afficher l\'aperçu';

  @override
  String get editorShowHtmlSource => 'Afficher le code source HTML';

  @override
  String editorSourceDumpTemplate(String summary, String body) {
    return 'RÉSUMÉ :\n$summary\n\nCONTENU :\n$body';
  }

  @override
  String get editorSummaryLabelColon => 'Résumé :';

  @override
  String get editorDescriptionLabelColon => 'Description :';

  @override
  String get editorStaleDialogTitle => 'La source anglaise a changé';

  @override
  String get editorStaleExplanation =>
      'La traduction existante est basée sur un texte original anglais obsolète. Depuis la dernière traduction, le mainteneur du module a modifié le texte anglais sur Drupal.org — le contenu de la traduction existante peut donc ne plus être exact ou complet.';

  @override
  String get editorStaleTip =>
      'Astuce : cliquez sur « Utiliser l\'original anglais » pour charger la source anglaise actuelle directement dans l\'éditeur. Vous pouvez ensuite l\'utiliser comme point de départ pour une nouvelle traduction. L\'original anglais est également visible dans le panneau de gauche.';

  @override
  String get editorEnglishSourceShort => 'Source anglaise';

  @override
  String get editorPreviousTranslation => 'Traduction précédente';

  @override
  String get editorWhatChangedTitle => 'Qu\'est-ce qui a changé ?';

  @override
  String get editorShowDiff => 'Afficher les différences';

  @override
  String get editorUseEnglish => 'Utiliser l\'original anglais';

  @override
  String get editorStaleBannerText =>
      'La source anglaise a changé — la traduction est obsolète';

  @override
  String get editorDetailsAndApply => 'Détails et application';

  @override
  String editorTranslationSectionHeader(String langName) {
    return 'TRADUCTION $langName';
  }

  @override
  String get editorTranslatingEllipsis => 'Traduction en cours...';

  @override
  String get editorShowEditor => 'Afficher l\'éditeur';

  @override
  String get editorModuleTitleLabel => 'Titre du module (anglais)';

  @override
  String get editorSummaryFieldLabel => 'Résumé';

  @override
  String get editorBodyFieldLabel => 'Contenu';

  @override
  String get editorHtmlCleaned => 'HTML nettoyé';

  @override
  String get editorLivePreviewHeader => 'APERÇU EN DIRECT';

  @override
  String get editorTidyHtmlTooltip =>
      'Nettoyer le HTML (supprimer les artefacts DeepL)';

  @override
  String get editorVisualMode => 'VISUEL';

  @override
  String get editorSourceCodeMode => 'SOURCE (HTML)';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get costDialogTitle => 'Estimation des coûts (IA)';

  @override
  String get costDialogIntro =>
      'Le module sélectionné sera traduit avec Google Gemini AI. Voici le détail estimé des coûts pour cette opération :';

  @override
  String get costRowModel => 'Modèle';

  @override
  String get costRowInputTokens => 'Jetons en entrée';

  @override
  String get costRowOutputTokens => 'Jetons en sortie (estimation)';

  @override
  String costTokenChars(int tokens, int chars) {
    return '$tokens (~$chars caractères)';
  }

  @override
  String get costRowPriceInput => 'Prix pour 1M en entrée';

  @override
  String get costRowPriceOutput => 'Prix pour 1M en sortie';

  @override
  String get costRowTotalEstimate => 'Coût total estimé';

  @override
  String get costDialogFootnote =>
      '* Remarque : ceci est une estimation basée sur le modèle de tarification à l\'usage actuel de Google. L\'utilisation réelle peut légèrement varier.';

  @override
  String get costDialogStartTranslation => 'Démarrer la traduction';

  @override
  String get htmlToolbarInsertLink => 'Insérer un lien';

  @override
  String get htmlToolbarLinkTooltip => 'Insérer un lien (a)';

  @override
  String get htmlToolbarInsert => 'Insérer';

  @override
  String get htmlToolbarHeading2 => 'Titre 2';

  @override
  String get htmlToolbarHeading3 => 'Titre 3';

  @override
  String get htmlToolbarBold => 'Gras (strong)';

  @override
  String get htmlToolbarItalic => 'Italique (em)';

  @override
  String get htmlToolbarBulletList => 'Liste à puces (ul)';

  @override
  String get htmlToolbarNumberedList => 'Liste numérotée (ol)';

  @override
  String get htmlToolbarQuote => 'Citation (blockquote)';

  @override
  String get screenshotAltsHeader => 'TEXTE ALTERNATIF DES CAPTURES D\'ÉCRAN';

  @override
  String get screenshotAltsIntro =>
      'Saisissez un texte alternatif descriptif dans la langue cible pour chaque capture d\'écran.';

  @override
  String screenshotLabel(int number) {
    return 'Capture d\'écran $number';
  }

  @override
  String get screenshotPreviewUnavailable => 'Aperçu indisponible';

  @override
  String get screenshotAltHint =>
      'Saisissez le texte alternatif dans la langue cible…';

  @override
  String get dashUnignoreAllConfirmTitle =>
      'Restaurer tous les modules ignorés ?';

  @override
  String get dashUnignoreAllConfirmBody =>
      'Tous les modules ignorés seront remis dans la liste active et redeviendront disponibles pour la traduction.';

  @override
  String get dashUnignoreAllConfirmAction => 'Tout restaurer';

  @override
  String get dashUnignoreAllSuccess =>
      'Tous les modules ignorés ont été restaurés.';

  @override
  String get dashUnignoreAllError => 'Échec de la restauration des modules.';

  @override
  String get dashUnignoreAllButton => 'Restaurer tous les modules ignorés';

  @override
  String dashSyncStartError(String error) {
    return 'Échec du démarrage de la synchronisation : $error';
  }

  @override
  String get dashQuickUpdateStarted =>
      'Mise à jour rapide (7 jours) démarrée ⚡';

  @override
  String dashQuickUpdateError(String error) {
    return 'Erreur de mise à jour rapide : $error';
  }

  @override
  String dashManualSyncSuccess(String name) {
    return 'Synchronisation réussie : $name';
  }

  @override
  String get dashManualSyncNotFound => 'Module introuvable sur Drupal.org.';

  @override
  String get dashAiBulkTranslation => 'Traduction groupée par IA';

  @override
  String get dashHeaderTitle => 'Descriptions de projets';

  @override
  String get dashHeaderSubtitle =>
      'Traduisez les descriptions de modules Drupal dans la langue cible. Aidez à rendre l\'écosystème plus accessible.';

  @override
  String get dashHeaderSubtitleShort =>
      'Traduisez les descriptions de modules Drupal.';

  @override
  String get dashLastLabel => 'Dernier : ';

  @override
  String get dashContinue => 'Continuer';

  @override
  String get dashContinueShort => 'Continuer';

  @override
  String get dashUnignoreAllButtonLong => 'Restaurer tous les modules ignorés';

  @override
  String get dashQuickUpdateTooltip => 'Mise à jour rapide (7 derniers jours)';

  @override
  String get dashFullSyncTooltip =>
      'Synchronisation complète de la base de données depuis Drupal.org';

  @override
  String get dashManualLoadTooltip =>
      'Charger manuellement un seul module depuis Drupal.org';

  @override
  String get dashQuickShort => 'Rapide';

  @override
  String get dashModuleShort => 'Module';

  @override
  String get dashFoundLabel => 'Trouvés : ';

  @override
  String get dashModulesSuffix => ' modules';

  @override
  String dashPerPage(int count) {
    return '$count par page';
  }

  @override
  String dashPerPageShort(int count) {
    return '$count / page';
  }

  @override
  String get dashFirstPage => 'Première page';

  @override
  String get dashPrevPage => 'Page précédente';

  @override
  String get dashNextPage => 'Page suivante';

  @override
  String get dashLastPage => 'Dernière page';

  @override
  String dashPageOf(int page, int total) {
    return 'Page $page sur $total';
  }

  @override
  String get dashMachineNameHint => 'machine_name (ex. pathauto)';

  @override
  String get dashAddButton => 'Ajouter';

  @override
  String get dashAddModuleManually => 'Ajouter un module manuellement';

  @override
  String get dashAddModuleSubtitle =>
      'Charger directement depuis Drupal.org par machine_name.';

  @override
  String get dashAddModuleShort => 'Ajouter un module';

  @override
  String get dashNoProjectsFound => 'Aucun projet trouvé.';

  @override
  String get dashFilterAll => 'Tous les projets';

  @override
  String get dashFilterMissing => 'Traductions manquantes';

  @override
  String get dashFilterReview => 'File de révision';

  @override
  String get dashFilterTranslated => 'Projets traduits';

  @override
  String get dashFilterReleased => 'Projets publiés';

  @override
  String get dashBulkDialogIntro =>
      'Traduisez automatiquement plusieurs modules du filtre sélectionné à l\'aide de Google Gemini.';

  @override
  String get dashActiveFilter => 'Filtre actif';

  @override
  String get dashModuleCount => 'Nombre de modules';

  @override
  String dashModulesCountItem(int count) {
    return '$count modules';
  }

  @override
  String get dashPrioritizeD12Title => 'Prioriser les modules Drupal 12';

  @override
  String get dashPrioritizeD12Subtitle =>
      'Traduit d\'abord les modules sans support Drupal 12';

  @override
  String get dashTotalModules => 'Total des modules';

  @override
  String get dashInputTokensEst => 'Jetons en entrée (est.)';

  @override
  String get dashOutputTokensEst => 'Jetons en sortie (est.)';

  @override
  String get dashBulkFootnote =>
      '* La traduction est exécutée par lots économes en ressources afin d\'éviter les délais d\'attente.';

  @override
  String get dashStartBulkTranslation => 'Démarrer la traduction groupée';

  @override
  String dashStaleLoadError(String error) {
    return 'Erreur lors du chargement des modules obsolètes : $error';
  }

  @override
  String get dashNoStaleModules =>
      'Aucun module obsolète trouvé — tout est à jour ! ✨';

  @override
  String get dashRetranslateOutdatedTitle => 'Retraduire les modules obsolètes';

  @override
  String get dashRetranslateOutdatedIntro =>
      'Toutes les traductions dont la source anglaise a changé depuis la dernière traduction seront automatiquement retraduites avec Google Gemini. Pas besoin d\'ouvrir chaque module manuellement.';

  @override
  String get dashOutdatedModules => 'Modules obsolètes';

  @override
  String get dashRetranslateOutdatedFootnote =>
      '* La traduction remplace le texte existant et réinitialise is_reviewed. Exécutée par lots de 4 modules.';

  @override
  String dashRetranslateAllCount(int count) {
    return 'Retraduire les $count modules';
  }

  @override
  String get dashRetranslatingOutdatedTitle =>
      'Retraduction des modules obsolètes…';

  @override
  String get dashFetchingProjects =>
      'Récupération des projets depuis le serveur…';

  @override
  String dashModulesProcessed(int processed, int total) {
    return '$processed sur $total modules traités';
  }

  @override
  String get dashNoTranslatableProjects =>
      'Aucun projet traduisible trouvé pour ce filtre.';

  @override
  String get dashStartingTranslation => 'Démarrage de la traduction…';

  @override
  String dashTranslatingModuleRange(int start, int end, int total) {
    return 'Traduction du module $start à $end sur $total …';
  }

  @override
  String dashModulesCompleted(int end, int total) {
    return '$end sur $total modules terminés.';
  }

  @override
  String get dashTranslationCompleted => 'Traduction terminée avec succès ! ✨';

  @override
  String dashBulkTranslationSuccess(int count) {
    return 'Traduction groupée de $count modules réussie ! ✨';
  }

  @override
  String dashBulkTranslationError(String error) {
    return 'Erreur de traduction groupée : $error';
  }

  @override
  String dashAllModulesRetranslated(int count) {
    return 'Les $count modules ont été retraduits avec succès ! ✨';
  }

  @override
  String dashOutdatedRetranslatedSuccess(int count) {
    return '$count modules obsolètes retraduits avec succès ! ✨';
  }

  @override
  String dashStaleTranslationError(String error) {
    return 'Erreur lors de la retraduction : $error';
  }

  @override
  String get filterAllShort => 'Tous';

  @override
  String get filterMissing => 'Manquantes';

  @override
  String get filterTranslated => 'Traduites';

  @override
  String get filterReviewQueue => 'File de révision';

  @override
  String get filterReleased => 'Publiées';

  @override
  String get filterOutdated => 'Obsolètes';

  @override
  String get filterPriority => 'Priorité';

  @override
  String get filterIgnored => 'Ignorées';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonReset => 'Réinitialiser';

  @override
  String get commonRefresh => 'Actualiser';

  @override
  String commonErrorPrefix(String error) {
    return 'Erreur : $error';
  }

  @override
  String get reviewResetAllConfirmTitle =>
      'Réinitialiser toutes les traductions publiées ?';

  @override
  String reviewResetAllConfirmBody(String langcode) {
    return 'Toutes les traductions marquées comme publiées pour $langcode seront remises à l\'état de révision. Cette action est irréversible.';
  }

  @override
  String reviewResetAllSuccess(int count) {
    return '$count traductions remises à l\'état de révision.';
  }

  @override
  String get reviewPipelineTitle => 'Pipeline de révision';

  @override
  String get reviewPipelineSubtitle =>
      'Pipeline d\'assurance qualité humaine pour les traductions IA';

  @override
  String get reviewSearchHint => 'Rechercher des projets...';

  @override
  String get reviewResetPublished => 'Réinitialiser les publiées';

  @override
  String reviewResultsCount(int count, int total) {
    return 'Résultats : $count / $total';
  }

  @override
  String reviewPendingCount(int count) {
    return 'En attente : $count';
  }

  @override
  String get reviewNoProjectsPending => 'Aucun projet en attente de révision.';

  @override
  String get reviewAllVerifiedOrNone =>
      'Toutes les traductions ont déjà été vérifiées ou aucune n\'existe dans ce contexte linguistique.';

  @override
  String get reviewNoSummary => 'Aucun résumé.';

  @override
  String get reviewStartAudit => 'COMMENCER LA VÉRIFICATION';

  @override
  String get reviewHtmlSourceShort => 'Source HTML';

  @override
  String get reviewCopySource => 'Copier la source';

  @override
  String get reviewModuleDetails => 'Détails du module';

  @override
  String get reviewOriginalTitle => 'Titre original';

  @override
  String get reviewDrupalOrgProject => 'Projet Drupal.org';

  @override
  String get reviewSuggestions => 'Suggestions';

  @override
  String get reviewNoSuggestions => 'Aucune suggestion disponible.';

  @override
  String get reviewApply => 'Appliquer';

  @override
  String get reviewNoChanges => 'Aucun changement';

  @override
  String get reviewOriginalBeforeCorrection => 'Original (avant correction)';

  @override
  String get reviewCorrectedCurrentVersion => 'Corrigé (version actuelle)';

  @override
  String get reviewBaseOriginal => 'Base (Original)';

  @override
  String get reviewYourCorrection => 'Votre correction';

  @override
  String get reviewChangesVisual => 'Révisez vos modifications (visuel)';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonIgnore => 'Ignorer';

  @override
  String get reviewEmptyProjectTitle => 'Projet vide';

  @override
  String get reviewEmptyProjectBody =>
      'Ce projet est vide (aucun titre, résumé ou contenu) et ne peut pas être approuvé. Veuillez le passer.';

  @override
  String get reviewApprovedSuccess => 'Traduction approuvée ! 🎉';

  @override
  String reviewApprovalFailed(String machine) {
    return '⚠️ L\'approbation de « $machine » a échoué — veuillez réessayer.';
  }

  @override
  String get reviewUnignoredSuccess =>
      'Restauré. Le module est à nouveau actif !';

  @override
  String get reviewActionFailed => 'Échec de l\'action.';

  @override
  String get reviewIgnoreModuleTitle => 'Ignorer le module ?';

  @override
  String get reviewIgnoreModuleBody =>
      'Ce module sera masqué définitivement de toutes les listes. Vous n\'y serez plus bloqué.';

  @override
  String get reviewModulePermanentlyIgnored => 'Module définitivement ignoré.';

  @override
  String get reviewIgnoreFailed => 'Échec de l\'ignorance du module.';

  @override
  String get reviewSuggestionSaved => 'Brouillon de suggestion enregistré ! 💾';

  @override
  String get reviewSaveSuggestionFailed =>
      'Échec de l\'enregistrement du brouillon de suggestion.';

  @override
  String get reviewSuggestionDeleted => 'Suggestion supprimée.';

  @override
  String get reviewDeleteFailed => 'Échec de la suppression.';

  @override
  String get reviewSuggestionApplied => 'Suggestion appliquée.';

  @override
  String get reviewPreparingData => 'Préparation des données de révision...';

  @override
  String get reviewDirectEdit => 'Édition directe';

  @override
  String get reviewLivePreview => 'Aperçu en direct';

  @override
  String get reviewCompareWith => 'Comparer avec :';

  @override
  String get reviewProductionVersion => 'Version de production';

  @override
  String get reviewEditorialReview => 'Révision éditoriale';

  @override
  String get reviewOpenQueue => 'Ouvrir la file de révision';

  @override
  String get reviewCopyPromptShort => 'Copier le prompt';

  @override
  String get reviewUnignoreShort => 'Restaurer';

  @override
  String get reviewApproveButton => 'APPROUVER';

  @override
  String get reviewHideDetails => 'Masquer les détails';

  @override
  String get reviewDetailsAndEnglishSource => 'Détails et source anglaise';

  @override
  String reviewPendingCountShort(int count) {
    return '$count en attente';
  }

  @override
  String reviewReviewingModule(String name) {
    return 'Révision de $name';
  }

  @override
  String get reviewCompareTranslationTooltip =>
      'Comparer la traduction avec la source anglaise';

  @override
  String get reviewTranslationLabel => 'Traduction';

  @override
  String get reviewComparisonTitle => 'Comparaison';

  @override
  String get reviewCopyPromptLongTooltip =>
      'Copier le texte source et le prompt de traduction dans le presse-papiers';

  @override
  String get reviewUnignoreCaps => 'RESTAURER';

  @override
  String get reviewIgnoreCaps => 'IGNORER';

  @override
  String get reviewSkipShortcut => 'PASSER (Ctrl+→)';

  @override
  String get reviewEditorialReviewShort => 'Révision éditoriale';

  @override
  String get reviewUnignoreTablet => 'RESTAURER';

  @override
  String get reviewApproveForProduction =>
      'APPROUVER POUR LA PRODUCTION (Ctrl+Entrée)';

  @override
  String get reviewDirectRefinement => 'Amélioration directe';

  @override
  String get reviewTitleField => 'Titre';

  @override
  String get reviewSummaryField => 'Résumé';

  @override
  String get reviewBodyField => 'Contenu';

  @override
  String get reviewSaveShortcut => 'ENREGISTRER (Ctrl+Alt+S)';

  @override
  String get reviewLivePreviewRendering => 'Aperçu en direct (rendu)';

  @override
  String get reviewVoiceFemale => 'Féminine';

  @override
  String get reviewVoiceMale => 'Masculine';

  @override
  String get reviewStopListening => 'Arrêter';

  @override
  String get reviewListen => 'Écouter';

  @override
  String get reviewAutopTooltip =>
      'Formater automatiquement les paragraphes (sauts de ligne → <p>)';

  @override
  String get reviewSourceCodeShort => 'SOURCE';

  @override
  String get reviewNoParagraphChange =>
      'Le texte contient déjà des balises <p> — aucun changement';

  @override
  String get reviewParagraphsFormatted => 'Paragraphes formatés ¶';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String categoriesLoadError(String error) {
    return 'Échec du chargement des catégories : $error';
  }

  @override
  String get categoriesSaveSuccess => 'Catégories enregistrées avec succès.';

  @override
  String get categoriesSaveFailed =>
      'Échec de l\'enregistrement des traductions.';

  @override
  String get categoriesFileEmpty => 'Le fichier est vide.';

  @override
  String get categoriesInvalidJson => 'Format JSON invalide.';

  @override
  String get categoriesNoValidUuids =>
      'Aucune entrée UUID valide trouvée dans le fichier.';

  @override
  String categoriesImportSuccess(int count) {
    return '$count catégories importées depuis le fichier.';
  }

  @override
  String get categoriesTitle => 'Catégories';

  @override
  String categoriesTranslatingFor(String lang) {
    return 'Traduction pour : $lang';
  }

  @override
  String get categoriesImportJson => 'Importer un JSON';

  @override
  String get categoriesSaving => 'Enregistrement...';

  @override
  String get categoriesSaveAll => 'Tout enregistrer';

  @override
  String get categoriesLoading => 'Chargement des catégories...';

  @override
  String categoriesTranslationColumn(String code) {
    return 'Traduction ($code)';
  }

  @override
  String get categoriesNoneFound => 'Aucune catégorie trouvée.';

  @override
  String categoriesTranslateHint(String name) {
    return 'Traduire « $name »...';
  }

  @override
  String get loginPhotoBy => 'Photo par ';

  @override
  String get loginPhotoOn => ' sur ';

  @override
  String get loginPleaseSignIn => 'Veuillez vous connecter';

  @override
  String get loginUsername => 'Nom d\'utilisateur';

  @override
  String get loginPassword => 'Mot de passe';

  @override
  String get loginRememberMe => 'Se souvenir de moi';

  @override
  String get loginSignIn => 'SE CONNECTER';

  @override
  String get loginNoAccount => 'Pas encore de compte ? ';

  @override
  String get loginRegisterNow => 'S\'inscrire maintenant';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonNext => 'Suivant';

  @override
  String get registerFillRequired =>
      'Veuillez remplir tous les champs obligatoires.';

  @override
  String get registerPasswordMismatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get registerPasswordTooShort =>
      'Le mot de passe doit comporter au moins 8 caractères.';

  @override
  String get registerSelectLanguage =>
      'Veuillez sélectionner au moins une langue.';

  @override
  String get registerFailed => 'Échec de l\'inscription.';

  @override
  String get registerHeaderTitle => 'INSCRIPTION';

  @override
  String get registerStepAccount => 'Compte';

  @override
  String get registerStepRole => 'Rôle';

  @override
  String get registerStepLanguages => 'Langues';

  @override
  String get registerStepApiKeys => 'Clés API';

  @override
  String get registerYourAccount => 'Votre compte';

  @override
  String get registerAvatarOptional => 'Avatar (optionnel)';

  @override
  String get registerUsernameRequired => 'Nom d\'utilisateur *';

  @override
  String get registerEmailRequired => 'Adresse e-mail *';

  @override
  String get registerPasswordRequired => 'Mot de passe *';

  @override
  String get registerPasswordRepeat => 'Répéter le mot de passe *';

  @override
  String get registerYourRole => 'Votre rôle';

  @override
  String get registerRoleExplanation =>
      'Les traducteurs peuvent traduire des textes mais n\'ont pas accès à la file de révision. Les réviseurs vérifient et approuvent le contenu traduit.';

  @override
  String get registerRoleTranslator => 'Traducteur';

  @override
  String get registerRoleTranslatorDesc => 'Créer et modifier des traductions.';

  @override
  String get registerRoleReviewer => 'Réviseur';

  @override
  String get registerRoleReviewerDesc =>
      'Réviser et approuver les traductions.';

  @override
  String get registerTargetLanguages => 'Langues cibles';

  @override
  String get registerLanguagesExplanation =>
      'Choisissez toutes les langues sur lesquelles vous souhaitez travailler.';

  @override
  String get registerNoLanguagesAvailable => 'Aucune langue disponible.';

  @override
  String get registerApiKeysTitle => 'Clés API';

  @override
  String get registerApiKeysExplanation =>
      'Saisissez vos propres clés API. Chaque utilisateur utilise exclusivement ses propres clés. Vous pouvez aussi les ajouter plus tard dans votre profil.';

  @override
  String get registerKeysEncryptedNote =>
      'Les clés sont stockées chiffrées et ne sont jamais partagées avec d\'autres utilisateurs.';

  @override
  String get registerOptionalSuffix => ' (optionnel)';

  @override
  String get registerSuccessTitle => 'Inscription réussie !';

  @override
  String get registerSuccessBody =>
      'Votre compte a été créé et attend l\'approbation d\'un administrateur. Vous serez averti dès que votre accès sera activé.';

  @override
  String get registerGoToLogin => 'Aller à la connexion';

  @override
  String get registerSubmit => 'S\'inscrire';

  @override
  String registerPhotoCredit(String name) {
    return 'Photo par $name sur Unsplash';
  }

  @override
  String get profileUpdateSuccess => 'Profil mis à jour avec succès !';

  @override
  String get profileUpdateFailed => 'Échec de la mise à jour.';

  @override
  String profileSaveError(String error) {
    return 'Erreur lors de l\'enregistrement : $error';
  }

  @override
  String get profilePasswordMismatch =>
      'Les mots de passe ne correspondent pas !';

  @override
  String get profilePasswordChangeSuccess =>
      'Mot de passe modifié avec succès !';

  @override
  String get profilePasswordChangeError =>
      'Erreur lors du changement de mot de passe : mot de passe actuel incorrect.';

  @override
  String get profileAvatarUploadSuccess => 'Avatar téléversé avec succès !';

  @override
  String get profileAvatarUploadError =>
      'Erreur lors du téléversement de l\'avatar.';

  @override
  String get profileTitle => 'Profil et paramètres';

  @override
  String get profileSubtitle =>
      'Gérez votre profil utilisateur, vos API de traduction (Gemini et DeepL) et la sécurité de votre compte.';

  @override
  String get profileRoleUser => 'Utilisateur';

  @override
  String get profileNoEmail => 'Aucune adresse e-mail indiquée';

  @override
  String get profileTabDetails => 'Détails du profil';

  @override
  String get profileTabGemini => 'Traduction IA (Gemini)';

  @override
  String get profileTabDeepl => 'Traduction DeepL';

  @override
  String get profileTabPassword => 'Changer le mot de passe';

  @override
  String get profileSectionInfo => 'INFORMATIONS DU PROFIL';

  @override
  String get profileFieldName => 'Nom';

  @override
  String get profileFieldNameHint => 'Votre nom complet';

  @override
  String get profileFieldEmail => 'Adresse e-mail';

  @override
  String get profileFieldEmailHint => 'Votre adresse e-mail';

  @override
  String get profileSectionGemini => 'PARAMÈTRES GEMINI CO-PILOT';

  @override
  String get profileFieldGeminiKey => 'Clé API Google Gemini';

  @override
  String get profileFieldGeminiKeyHint =>
      'Saisissez votre clé API gemini-3.1-flash';

  @override
  String get profileFieldAiPrompt => 'Prompt IA personnalisé';

  @override
  String get profileFieldAiPromptHint =>
      'Optionnel : personnalisez le prompt système pour Gemini...';

  @override
  String get profileSectionDeepl => 'PARAMÈTRES DE TRADUCTION DEEPL';

  @override
  String get profileDeeplDescription =>
      'DeepL propose une traduction automatique de haute qualité avec préservation des balises HTML. Les comptes gratuits (500 000 caractères/mois) reçoivent une clé se terminant par « :fx ».';

  @override
  String get profileFieldDeeplKey => 'Clé API DeepL';

  @override
  String get profileFieldDeeplKeyHint =>
      'ex. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx';

  @override
  String get profileDeeplInfo =>
      'Les clés gratuites se terminent par « :fx » et utilisent api-free.deepl.com. Les clés Pro utilisent api.deepl.com. La distinction est faite automatiquement.';

  @override
  String get profileSectionSecurity => 'SÉCURITÉ DU COMPTE';

  @override
  String get profileFieldCurrentPassword => 'Mot de passe actuel';

  @override
  String get profileFieldCurrentPasswordHint =>
      'Saisissez votre mot de passe actuel';

  @override
  String get profileFieldNewPassword => 'Nouveau mot de passe';

  @override
  String get profileFieldNewPasswordHint => 'Au moins 6 caractères';

  @override
  String get profileFieldConfirmPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get profileFieldConfirmPasswordHint => 'Répétez le mot de passe';

  @override
  String get profileChangePasswordButton => 'Changer le mot de passe';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get settingsRegistrationUpdated =>
      'Paramètre d\'inscription mis à jour';

  @override
  String get settingsUpdateFailed => 'Échec de la mise à jour.';

  @override
  String get settingsUserApproved => 'Utilisateur approuvé !';

  @override
  String get settingsAccountDeactivated => 'Compte désactivé.';

  @override
  String get settingsUserDeleted => 'Utilisateur supprimé.';

  @override
  String get settingsActionFailed => 'Échec de l\'action.';

  @override
  String get settingsDeleteAccountTitle => 'Supprimer le compte ?';

  @override
  String get settingsDeactivateAccountTitle => 'Désactiver le compte ?';

  @override
  String settingsDeleteAccountBody(String username) {
    return 'Le compte « $username » sera supprimé définitivement. Continuer ?';
  }

  @override
  String settingsDeactivateAccountBody(String username) {
    return 'Le compte « $username » sera verrouillé. L\'utilisateur ne pourra plus se connecter, mais le compte est conservé.';
  }

  @override
  String get settingsDeactivate => 'Désactiver';

  @override
  String settingsSyncSuccess(String count) {
    return '$count traductions synchronisées !';
  }

  @override
  String settingsSyncError(String error) {
    return 'Erreur de synchronisation : $error';
  }

  @override
  String settingsPrioritySyncSuccess(String count) {
    return '$count modules prioritaires synchronisés !';
  }

  @override
  String settingsPrioritySyncError(String error) {
    return 'Erreur lors de la synchronisation de la liste prioritaire : $error';
  }

  @override
  String settingsBackupSuccess(String count) {
    return 'Sauvegarde réussie : $count fichiers traités.';
  }

  @override
  String get settingsUploadFailed => 'Échec du téléversement.';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsSystemConfig => 'CONFIGURATION SYSTÈME';

  @override
  String get settingsRegistration => 'Inscription';

  @override
  String get settingsRegistrationHint =>
      'Activer ou désactiver globalement le formulaire d\'inscription.';

  @override
  String get settingsPendingUsers => 'Utilisateurs en attente';

  @override
  String get settingsNoNewRequests => 'Aucune nouvelle demande.';

  @override
  String get settingsWantsReviewer => 'Souhaite devenir réviseur';

  @override
  String get settingsAssignRole => 'Attribuer un rôle';

  @override
  String get settingsRoleTranslator => 'Traducteur';

  @override
  String get settingsRoleReviewer => 'Réviseur';

  @override
  String get settingsApprove => 'Approuver';

  @override
  String get settingsReject => 'Rejeter';

  @override
  String get settingsActiveUsers => 'Utilisateurs actifs';

  @override
  String get settingsNoActiveUsers => 'Aucun utilisateur actif.';

  @override
  String get settingsDeactivateAccountTooltip => 'Désactiver';

  @override
  String get settingsDeleteAccountAction => 'Supprimer le compte';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsThemePearl => 'CLAIR (PERLE)';

  @override
  String get settingsThemeDark => 'SOMBRE';

  @override
  String get settingsThemeGlassy => 'VITRÉ';

  @override
  String get settingsThemeNature => 'NATURE';

  @override
  String get settingsThemeLiquid => 'LIQUIDE';

  @override
  String get settingsThemeStage => 'SCÈNE';

  @override
  String get settingsTypography => 'Typographie';

  @override
  String get settingsFontHint => 'Modifier la police de l\'interface.';

  @override
  String get settingsFontClean => 'Épuré';

  @override
  String get settingsFontFuturistic => 'Futuriste';

  @override
  String get settingsFontTech => 'Tech';

  @override
  String get settingsWorkflowFun => 'Flux de travail et convivialité';

  @override
  String get settingsConfettiTitle => 'Célébration de réussite (confettis)';

  @override
  String get settingsConfettiHint =>
      'Affiche une petite animation lors d\'un enregistrement réussi.';

  @override
  String get settingsLargeUiTitle => 'Lisibilité améliorée (grande police)';

  @override
  String get settingsLargeUiHint =>
      'Augmente la taille des polices et des badges pour une meilleure lisibilité.';

  @override
  String get settingsAutoPTitle =>
      'Formatage automatique des paragraphes (¶ Auto-P)';

  @override
  String get settingsAutoPHint =>
      'Enveloppe automatiquement le texte brut dans des paragraphes <p> lorsqu\'un module est chargé dans l\'écran de révision. Équivalent à cliquer manuellement sur le bouton ¶.';

  @override
  String get settingsDatabaseSync => 'Synchronisation de la base de données';

  @override
  String get settingsDatabaseSyncTooltip =>
      'Synchronise les entrées de la base de données avec les fichiers JSON de traduction.';

  @override
  String get settingsDatabaseSyncHint =>
      'Synchronise les entrées internes de la base de données avec les JSON de traduction sur le serveur.';

  @override
  String get settingsSyncing => 'Synchronisation en cours...';

  @override
  String get settingsSyncNow => 'Synchroniser maintenant';

  @override
  String get settingsSyncD11List => 'Synchroniser la liste D11';

  @override
  String get settingsUploadBackup => 'Charger une sauvegarde (.zip)';

  @override
  String get settingsSelectZipFile => 'Sélectionner un fichier ZIP';

  @override
  String get settingsUploading => 'Téléversement en cours...';

  @override
  String get settingsErrorDiagnostics =>
      'Diagnostic des erreurs et journaux système';

  @override
  String get settingsLogsCopied =>
      'Journaux copiés dans le presse-papiers ! 📋';

  @override
  String get settingsCopyLogs => 'Copier les journaux';

  @override
  String get settingsLogsRotated => 'Journaux archivés et faits tourner ! 📁';

  @override
  String get settingsRotate => 'Faire tourner';

  @override
  String get settingsClear => 'Effacer';

  @override
  String get settingsLogLimit => 'Limite des journaux : ';

  @override
  String get settingsNoLogs => 'Aucun journal enregistré';

  @override
  String get layoutMenu => 'Menu';

  @override
  String get layoutNavAnalytics => 'Statistiques';

  @override
  String get layoutNavReviewQueue => 'File de révision';

  @override
  String get layoutNavGlossary => 'Glossaire';

  @override
  String get layoutNavCategories => 'Catégories';

  @override
  String get layoutNavHelp => 'Aide';

  @override
  String get layoutNavSettings => 'Paramètres';

  @override
  String get layoutPhotoBy => 'Photo par ';

  @override
  String get layoutPhotoOn => ' sur ';

  @override
  String get layoutEditProfile => 'Modifier le profil';

  @override
  String get layoutLogout => 'Déconnexion';

  @override
  String get layoutThemeLabel => 'THÈME';

  @override
  String get layoutThemePearl => 'Clair';

  @override
  String get layoutThemeDark => 'Sombre';

  @override
  String get layoutThemeGlassy => 'Vitré';

  @override
  String get layoutThemeNature => 'Nature';

  @override
  String get layoutThemeLiquid => 'Liquide';

  @override
  String get layoutThemeStage => 'Scène';

  @override
  String get layoutTargetLanguage => 'LANGUE CIBLE';

  @override
  String get layoutDeeplUsage => 'UTILISATION DEEPL';

  @override
  String get layoutUnavailable => 'Indisponible';

  @override
  String get layoutUnlimited => 'illimité';

  @override
  String get layoutUsed => 'utilisé';

  @override
  String get layoutTranslate => 'Traduire';

  @override
  String get analyticsSubtitle =>
      'Compatibilité, arriéré de traduction et tendances hebdomadaires.';

  @override
  String get analyticsBacklog => 'Arriéré de traduction';

  @override
  String get analyticsMissing => 'Manquantes';

  @override
  String get analyticsStale => 'Obsolètes';

  @override
  String get analyticsInReview => 'En révision';

  @override
  String get analyticsReleased => 'Publiées';

  @override
  String get analyticsTranslated => 'Traduites';

  @override
  String get analyticsTotalModules => 'Total des modules';

  @override
  String get analyticsCompatByVersion => 'Compatibilité par version de Drupal';

  @override
  String analyticsLanguageLegend(String lang) {
    return 'Langue : $lang · publiées / en révision / manquantes';
  }

  @override
  String get analyticsLoadingCounts => 'Chargement des compteurs …';

  @override
  String get analyticsWindow => 'Période :';

  @override
  String analyticsWeeks(String weeks) {
    return '$weeks semaines';
  }

  @override
  String get analyticsNewDescriptionsPerWeek =>
      'Nouvelles descriptions de projets par semaine';

  @override
  String analyticsMarkedOutdatedPerWeek(String lang) {
    return 'Marquées obsolètes par semaine ($lang)';
  }

  @override
  String analyticsModuleCount(String count) {
    return '$count modules';
  }

  @override
  String get analyticsReviewShort => 'Révision';

  @override
  String get analyticsNoDataInWindow => 'Aucune donnée dans cette période.';

  @override
  String get analyticsAndMore => '… et plus';

  @override
  String glossaryLoadError(String error) {
    return 'Erreur de chargement : $error';
  }

  @override
  String get glossaryNewTerm => 'Créer un nouveau terme';

  @override
  String get glossaryEditTerm => 'Modifier le terme';

  @override
  String get glossaryFieldSourceWord =>
      'Mot source (forme de base, tel qu\'il apparaît dans le texte)';

  @override
  String get glossaryFieldSourceWordHint => 'ex. nœud';

  @override
  String get glossaryWordForms =>
      'Autres formes du mot (pluriel, génitif, datif …)';

  @override
  String get glossaryWordFormsHint =>
      'ex. contenu — appuyez sur Entrée pour ajouter';

  @override
  String get glossaryAddForm => 'Ajouter une forme';

  @override
  String get glossaryFieldPreferredWord => 'Traduction préférée';

  @override
  String get glossaryFieldPreferredWordHint => 'ex. contenu';

  @override
  String get glossaryFieldExplanation =>
      'Explication (affichée dans l\'infobulle)';

  @override
  String get glossaryFieldExplanationHint =>
      'Pourquoi ce mot devrait-il être traduit différemment ?';

  @override
  String get glossaryCreate => 'Créer';

  @override
  String get glossaryRequiredFields =>
      'Le mot source et la traduction préférée sont obligatoires.';

  @override
  String get glossaryCreated => 'Terme créé ✓';

  @override
  String get glossaryUpdated => 'Terme mis à jour ✓';

  @override
  String glossaryError(String error) {
    return 'Erreur : $error';
  }

  @override
  String get glossaryDeleteTitle => 'Supprimer le terme ?';

  @override
  String glossaryDeleteBody(String word) {
    return '« $word » sera définitivement retiré du glossaire.';
  }

  @override
  String get glossaryDeleted => 'Terme supprimé.';

  @override
  String get glossaryTitle => 'Glossaire de traduction';

  @override
  String glossaryLanguageCount(String lang, String count) {
    return 'Langue : $lang · $count entrées';
  }

  @override
  String get glossaryNewShort => 'Nouveau';

  @override
  String get glossaryCreateTerm => 'Créer un terme';

  @override
  String get glossaryInfoBanner =>
      'Les mots de ce glossaire sont mis en évidence dans l\'éditeur de révision. Une infobulle explique au survol pourquoi une autre traduction convient mieux.';

  @override
  String get glossaryNoEntries => 'Aucune entrée pour le moment.';

  @override
  String get glossaryNoEntriesEditorHint =>
      'Cliquez sur « Créer un terme » pour créer la première entrée.';

  @override
  String get glossaryNoEntriesForLanguage =>
      'Aucune entrée de glossaire pour cette langue pour le moment.';

  @override
  String get diffNoChanges => 'Aucune différence de contenu détectée.';

  @override
  String get diffRemoved => 'Supprimé';

  @override
  String get diffAdded => 'Ajouté';

  @override
  String syncBarQuickSync(String count) {
    return 'Synchronisation rapide : $count modules modifiés …';
  }

  @override
  String syncBarFullSyncProgress(String current, String total) {
    return 'Synchronisation complète : $current / $total modules';
  }

  @override
  String syncBarFullSync(String count) {
    return 'Synchronisation complète : $count modules …';
  }
}
