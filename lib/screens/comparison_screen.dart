import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comparison_provider.dart';
import '../providers/localization_provider.dart';
import '../services/translations.dart';
import '../widgets/widgets.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              Translations.get(
                'Better Deal',
                localizationProvider.currentLanguage,
              ),
            ),
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/betterdeal_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Text(
                  localizationProvider.currentLanguage == AppLanguage.english
                      ? '🇺🇸'
                      : '🇪🇸',
                  style: const TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  localizationProvider.toggleLanguage();
                },
                tooltip: Translations.get(
                  'languageTooltip',
                  localizationProvider.currentLanguage,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<ComparisonProvider>().resetToDefaults();
                },
                tooltip: Translations.get(
                  'resetTooltip',
                  localizationProvider.currentLanguage,
                ),
              ),
            ],
          ),
          body: Consumer<ComparisonProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseAmountCard(
                      amount: provider.baseAmount,
                      onAmountChanged: provider.updateBaseAmount,
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen = constraints.maxWidth > 800;

                        if (isWideScreen) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ScenarioACard(
                                  commissions: provider.scenarioACommissions,
                                  reimbursements: provider.scenarioAReimbursements,
                                  exchangeRate: provider.scenarioAExchangeRate,
                                  onAddCommission:
                                      provider.addScenarioACommission,
                                  onRemoveCommission:
                                      provider.removeScenarioACommission,
                                  onUpdateCommissionValue:
                                      provider.updateScenarioACommissionValue,
                                  onUpdateCommissionType:
                                      provider.updateScenarioACommissionType,
                                  onUpdateCommissionDescription: provider
                                      .updateScenarioACommissionDescription,
                                  onAddReimbursement:
                                      provider.addScenarioAReimbursement,
                                  onRemoveReimbursement:
                                      provider.removeScenarioAReimbursement,
                                  onUpdateReimbursementValue:
                                      provider.updateScenarioAReimbursementValue,
                                  onUpdateReimbursementType:
                                      provider.updateScenarioAReimbursementType,
                                  onUpdateReimbursementDescription: provider
                                      .updateScenarioAReimbursementDescription,
                                  onExchangeRateChanged:
                                      provider.updateScenarioAExchangeRate,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ScenarioBCard(
                                  commissions: provider.scenarioBCommissions,
                                  reimbursements: provider.scenarioBReimbursements,
                                  exchangeRate: provider.scenarioBExchangeRate,
                                  onAddCommission: provider.addCommission,
                                  onRemoveCommission: provider.removeCommission,
                                  onUpdateCommissionValue:
                                      provider.updateCommissionPercentage,
                                  onUpdateCommissionType:
                                      provider.updateCommissionType,
                                  onUpdateCommissionDescription:
                                      provider.updateCommissionDescription,
                                  onAddReimbursement:
                                      provider.addScenarioBReimbursement,
                                  onRemoveReimbursement:
                                      provider.removeScenarioBReimbursement,
                                  onUpdateReimbursementValue:
                                      provider.updateScenarioBReimbursementValue,
                                  onUpdateReimbursementType:
                                      provider.updateScenarioBReimbursementType,
                                  onUpdateReimbursementDescription: provider
                                      .updateScenarioBReimbursementDescription,
                                  onExchangeRateChanged:
                                      provider.updateScenarioBExchangeRate,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              ScenarioACard(
                                commissions: provider.scenarioACommissions,
                                reimbursements: provider.scenarioAReimbursements,
                                exchangeRate: provider.scenarioAExchangeRate,
                                onAddCommission:
                                    provider.addScenarioACommission,
                                onRemoveCommission:
                                    provider.removeScenarioACommission,
                                onUpdateCommissionValue:
                                    provider.updateScenarioACommissionValue,
                                onUpdateCommissionType:
                                    provider.updateScenarioACommissionType,
                                onUpdateCommissionDescription: provider
                                    .updateScenarioACommissionDescription,
                                onAddReimbursement:
                                    provider.addScenarioAReimbursement,
                                onRemoveReimbursement:
                                    provider.removeScenarioAReimbursement,
                                onUpdateReimbursementValue:
                                    provider.updateScenarioAReimbursementValue,
                                onUpdateReimbursementType:
                                    provider.updateScenarioAReimbursementType,
                                onUpdateReimbursementDescription: provider
                                    .updateScenarioAReimbursementDescription,
                                onExchangeRateChanged:
                                    provider.updateScenarioAExchangeRate,
                              ),
                              const SizedBox(height: 16),
                              ScenarioBCard(
                                commissions: provider.scenarioBCommissions,
                                reimbursements: provider.scenarioBReimbursements,
                                exchangeRate: provider.scenarioBExchangeRate,
                                onAddCommission: provider.addCommission,
                                onRemoveCommission: provider.removeCommission,
                                onUpdateCommissionValue:
                                    provider.updateCommissionPercentage,
                                onUpdateCommissionType:
                                    provider.updateCommissionType,
                                onUpdateCommissionDescription:
                                    provider.updateCommissionDescription,
                                onAddReimbursement:
                                    provider.addScenarioBReimbursement,
                                onRemoveReimbursement:
                                    provider.removeScenarioBReimbursement,
                                onUpdateReimbursementValue:
                                    provider.updateScenarioBReimbursementValue,
                                onUpdateReimbursementType:
                                    provider.updateScenarioBReimbursementType,
                                onUpdateReimbursementDescription: provider
                                    .updateScenarioBReimbursementDescription,
                                onExchangeRateChanged:
                                    provider.updateScenarioBExchangeRate,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    ComparisonResultCard(
                      comparisonResult: provider.comparisonResult,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
