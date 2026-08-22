import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../l10n/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_container.dart';

class CostCalculatorDialog extends StatelessWidget {
  final ThemeAttributes attrs;
  final String englishSummary;
  final String englishBody;

  const CostCalculatorDialog({
    super.key,
    required this.attrs,
    required this.englishSummary,
    required this.englishBody,
  });

  Widget _buildCostRow(String label, String value, {bool isValueColorMuted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: attrs.textMuted, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              color: isValueColorMuted ? attrs.textMuted : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final summaryLength = englishSummary.length;
    final bodyLength = englishBody.length;

    // Calculations based on Gemini 3.1 Flash-Lite (Standard tier)
    // Pricing: $0.25 / 1M input tokens, $1.50 / 1M output tokens
    final estInputTokens = ((700 + summaryLength + bodyLength) / 4).ceil();
    final estOutputTokens = ((summaryLength + bodyLength) * 1.1 / 4).ceil();

    final estInputCost = estInputTokens * 0.00000025;
    final estOutputCost = estOutputTokens * 0.00000150;
    final estTotalCost = estInputCost + estOutputCost;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GlassContainer(
        borderRadius: 24,
        backgroundColor: attrs.bgCard.withOpacity(0.85),
        padding: const EdgeInsets.all(32.0),
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: attrs.brand600.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    LucideIcons.sparkles,
                    color: attrs.brand600,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.costDialogTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.costDialogIntro,
              style: TextStyle(
                color: attrs.textMuted,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: attrs.bgInput.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: attrs.borderMain),
              ),
              child: Column(
                children: [
                  _buildCostRow(AppLocalizations.of(context)!.costRowModel, 'Gemini 3.1 Flash-Lite'),
                  Divider(color: attrs.borderMain, height: 24),
                  _buildCostRow(AppLocalizations.of(context)!.costRowInputTokens,
                      AppLocalizations.of(context)!.costTokenChars(estInputTokens, summaryLength)),
                  _buildCostRow(AppLocalizations.of(context)!.costRowOutputTokens,
                      AppLocalizations.of(context)!.costTokenChars(estOutputTokens, (summaryLength + bodyLength) * 1.1 ~/ 1)),
                  Divider(color: attrs.borderMain, height: 24),
                  _buildCostRow(AppLocalizations.of(context)!.costRowPriceInput, '\$0.25', isValueColorMuted: true),
                  _buildCostRow(AppLocalizations.of(context)!.costRowPriceOutput, '\$1.50', isValueColorMuted: true),
                  Divider(color: attrs.borderMain, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.costRowTotalEstimate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$${estTotalCost.toStringAsFixed(6)} USD',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: attrs.brand600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.costDialogFootnote,
              style: TextStyle(
                fontSize: 11,
                color: attrs.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    foregroundColor: attrs.textMuted,
                  ),
                  child: Text(AppLocalizations.of(context)!.commonCancel, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: attrs.brand600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.costDialogStartTranslation, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
