import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/models.dart';
import '../providers/localization_provider.dart';
import '../services/translations.dart';

class ComparisonResultCard extends StatelessWidget {
  final ComparisonResult comparisonResult;

  const ComparisonResultCard({super.key, required this.comparisonResult});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizationProvider = context.watch<LocalizationProvider>();
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );

    if (!comparisonResult.isValid) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 8),
              Text(
                'Invalid Inputs',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Please check your inputs and try again.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final betterScenario = comparisonResult.betterScenario;
    final isScenarioABetter = comparisonResult.scenarioAIsBetter;
    final difference = comparisonResult.difference;
    final differencePercentage = comparisonResult.differencePercentage;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.compare_arrows,
                    color: theme.colorScheme.onTertiaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    Translations.get(
                      'comparisonResult',
                      localizationProvider.currentLanguage,
                    ),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isScenarioABetter
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                    : theme.colorScheme.secondaryContainer.withValues(
                        alpha: 0.3,
                      ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isScenarioABetter
                      ? theme.colorScheme.primary
                      : theme.colorScheme.secondary,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 32,
                    color: isScenarioABetter
                        ? theme.colorScheme.primary
                        : theme.colorScheme.secondary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${isScenarioABetter ? comparisonResult.scenarioA.scenario.name : comparisonResult.scenarioB.scenario.name} Wins!',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isScenarioABetter
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currencyFormat.format(betterScenario.finalAmount.value),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _ScenarioResultWidget(
                    title: comparisonResult.scenarioA.scenario.name,
                    amount: comparisonResult.scenarioA.finalAmount.value,
                    isWinner: isScenarioABetter,
                    color: theme.colorScheme.primary,
                    currencyFormat: currencyFormat,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ScenarioResultWidget(
                    title: comparisonResult.scenarioB.scenario.name,
                    amount: comparisonResult.scenarioB.finalAmount.value,
                    isWinner: !isScenarioABetter,
                    color: theme.colorScheme.secondary,
                    currencyFormat: currencyFormat,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Translations.get('difference', localizationProvider.currentLanguage)}:',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        currencyFormat.format(difference),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Translations.get('percentageDifference', localizationProvider.currentLanguage)}:',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${differencePercentage.toStringAsFixed(2)}%',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${isScenarioABetter ? comparisonResult.scenarioA.scenario.name : comparisonResult.scenarioB.scenario.name} ${localizationProvider.currentLanguage == AppLanguage.spanish ? 'te da' : 'gives you'} ${currencyFormat.format(difference)} ${localizationProvider.currentLanguage == AppLanguage.spanish ? 'más' : 'more'} (${differencePercentage.toStringAsFixed(2)}% ${localizationProvider.currentLanguage == AppLanguage.spanish ? 'mejor' : 'better'}).',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    _shareResult(context, comparisonResult, currencyFormat),
                icon: const Icon(Icons.share),
                label: Text(
                  Translations.get(
                    'shareResult',
                    context.watch<LocalizationProvider>().currentLanguage,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareResult(
    BuildContext context,
    ComparisonResult result,
    NumberFormat currencyFormat,
  ) {
    final localizationProvider = context.read<LocalizationProvider>();
    final language = localizationProvider.currentLanguage;
    final isSpanish = language == AppLanguage.spanish;

    final betterScenario = result.betterScenario;
    final isScenarioABetter = result.scenarioAIsBetter;
    final difference = result.difference;
    final differencePercentage = result.differencePercentage;

    final winnerName = isScenarioABetter
        ? result.scenarioA.scenario.name
        : result.scenarioB.scenario.name;
    final winnerAmount = currencyFormat.format(
      betterScenario.finalAmount.value,
    );

    final scenarioAAmount = currencyFormat.format(
      result.scenarioA.finalAmount.value,
    );
    final scenarioBAmount = currencyFormat.format(
      result.scenarioB.finalAmount.value,
    );

    final formattedDifference = currencyFormat.format(difference);
    final formattedPercentage = differencePercentage.toStringAsFixed(2);
    final baseAmount = currencyFormat.format(
      result.scenarioA.scenario.baseAmount.value,
    );

    String shareText;
    if (isSpanish) {
      // Build detailed breakdown for Spanish
      final scenarioADetails = _buildScenarioDetails(result.scenarioA, true);
      final scenarioBDetails = _buildScenarioDetails(result.scenarioB, true);

      shareText =
          '''
📊 *_Better Deal_* Result

- Monto inicial: $baseAmount

🏆 Ganador: $winnerName
💰 Cantidad Final: $winnerAmount

📋 Desglose Detallado:

🅰️ ${result.scenarioA.scenario.name}:
$scenarioADetails
💵 Total: $scenarioAAmount

🅱️ ${result.scenarioB.scenario.name}:
$scenarioBDetails
💵 Total: $scenarioBAmount

💡 Diferencia: $formattedDifference ($formattedPercentage% mejor)

$winnerName te da $formattedDifference más ($formattedPercentage% mejor).

#betterdeal
''';
    } else {
      // Build detailed breakdown for English
      final scenarioADetails = _buildScenarioDetails(result.scenarioA, false);
      final scenarioBDetails = _buildScenarioDetails(result.scenarioB, false);

      shareText =
          '''
📊 *_Better Deal_* Result

- Base amount: $baseAmount

🏆 Winner: $winnerName
💰 Final Amount: $winnerAmount

📋 Detailed Breakdown:

🅰️ ${result.scenarioA.scenario.name}:
$scenarioADetails
💵 Total: $scenarioAAmount

🅱️ ${result.scenarioB.scenario.name}:
$scenarioBDetails
💵 Total: $scenarioBAmount

💡 Difference: $formattedDifference ($formattedPercentage% better)

$winnerName gives you $formattedDifference more ($formattedPercentage% better).

#betterdeal
''';
    }

    Share.share(shareText.trim());
  }

  String _buildScenarioDetails(ScenarioResult scenarioResult, bool isSpanish) {
    final scenario = scenarioResult.scenario;
    final details = StringBuffer();

    // Add commissions
    if (scenario.commissions.isNotEmpty) {
      details.writeln(isSpanish ? '📉 Comisiones:' : '📉 Commissions:');
      for (var commission in scenario.commissions) {
        final description = commission.description.isEmpty
            ? (isSpanish ? 'Comisión' : 'Commission')
            : commission.description;
        details.writeln('  • $description: ${commission.displayValue}');
      }
    }

    // Add reimbursements
    if (scenario.reimbursements.isNotEmpty) {
      details.writeln(isSpanish ? '📈 Reembolsos:' : '📈 Reimbursements:');
      for (var reimbursement in scenario.reimbursements) {
        final description = reimbursement.description.isEmpty
            ? (isSpanish ? 'Reembolso' : 'Reimbursement')
            : reimbursement.description;
        details.writeln('  • $description: ${reimbursement.displayValue}');
      }
    }

    // Add exchange rate
    final exchangeRateText = isSpanish ? 'Tasa de cambio' : 'Exchange rate';
    details.writeln('💱 $exchangeRateText: ${scenario.exchangeRate}');

    return details.toString().trim();
  }
}

class _ScenarioResultWidget extends StatelessWidget {
  final String title;
  final double amount;
  final bool isWinner;
  final Color color;
  final NumberFormat currencyFormat;

  const _ScenarioResultWidget({
    required this.title,
    required this.amount,
    required this.isWinner,
    required this.color,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWinner
            ? color.withValues(alpha: 0.1)
            : theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isWinner
              ? color
              : theme.colorScheme.outline.withValues(alpha: 0.2),
          width: isWinner ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isWinner) ...[
                Icon(Icons.check_circle, size: 16, color: color),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isWinner ? color : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormat.format(amount),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isWinner ? color : null,
            ),
          ),
        ],
      ),
    );
  }
}
