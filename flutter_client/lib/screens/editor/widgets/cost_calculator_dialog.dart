import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
                const Expanded(
                  child: Text(
                    'Kosten-Vorkalkulation (AI)',
                    style: TextStyle(
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
              'Das ausgewählte Modul wird mit Google Gemini AI übersetzt. Hier ist die geschätzte Kostenaufstellung für diesen Vorgang:',
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
                  _buildCostRow('Modell', 'Gemini 3.1 Flash-Lite'),
                  Divider(color: attrs.borderMain, height: 24),
                  _buildCostRow('Eingabe-Tokens', '$estInputTokens (~$summaryLength Zeichen)'),
                  _buildCostRow('Ausgabe-Tokens (Schätzung)', '$estOutputTokens (~${(summaryLength + bodyLength) * 1.1 ~/ 1} Zeichen)'),
                  Divider(color: attrs.borderMain, height: 24),
                  _buildCostRow('Preis pro 1M Input', '\$0.25', isValueColorMuted: true),
                  _buildCostRow('Preis pro 1M Output', '\$1.50', isValueColorMuted: true),
                  Divider(color: attrs.borderMain, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Geschätzte Gesamtkosten',
                        style: TextStyle(
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
              '* Hinweis: Dies ist eine Schätzung basierend auf dem aktuellen Google Pay-as-you-go Preismodell. Der tatsächliche Verbrauch kann minimal variieren.',
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
                  child: const Text('Abbrechen', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  child: const Text('Übersetzung starten', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
