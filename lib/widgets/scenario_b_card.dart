import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/comparison_provider.dart';
import '../providers/localization_provider.dart';
import '../services/calculation_service.dart';
import '../services/translations.dart';
import '../utils/number_formatter.dart';
import 'reimbursement_input_widget.dart';
import 'scenario_a_card.dart';

class ScenarioBCard extends StatefulWidget {
  final List<Commission> commissions;
  final List<Reimbursement> reimbursements;
  final double exchangeRate;
  final VoidCallback onAddCommission;
  final ValueChanged<int> onRemoveCommission;
  final Function(int, double) onUpdateCommissionValue;
  final Function(int, CommissionType) onUpdateCommissionType;
  final Function(int, String) onUpdateCommissionDescription;
  final VoidCallback onAddReimbursement;
  final ValueChanged<int> onRemoveReimbursement;
  final Function(int, double) onUpdateReimbursementValue;
  final Function(int, ReimbursementType) onUpdateReimbursementType;
  final Function(int, String) onUpdateReimbursementDescription;
  final ValueChanged<double> onExchangeRateChanged;

  const ScenarioBCard({
    super.key,
    required this.commissions,
    required this.reimbursements,
    required this.exchangeRate,
    required this.onAddCommission,
    required this.onRemoveCommission,
    required this.onUpdateCommissionValue,
    required this.onUpdateCommissionType,
    required this.onUpdateCommissionDescription,
    required this.onAddReimbursement,
    required this.onRemoveReimbursement,
    required this.onUpdateReimbursementValue,
    required this.onUpdateReimbursementType,
    required this.onUpdateReimbursementDescription,
    required this.onExchangeRateChanged,
  });

  @override
  State<ScenarioBCard> createState() => _ScenarioBCardState();
}

class _ScenarioBCardState extends State<ScenarioBCard> {
  late TextEditingController _exchangeRateController;
  String? _exchangeRateError;

  @override
  void initState() {
    super.initState();
    _exchangeRateController = TextEditingController(
      text: NumberFormatter.formatForInput(widget.exchangeRate),
    );
  }

  @override
  void didUpdateWidget(ScenarioBCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exchangeRate != widget.exchangeRate) {
      _exchangeRateController.text = NumberFormatter.formatForInput(
        widget.exchangeRate,
      );
    }
  }

  @override
  void dispose() {
    _exchangeRateController.dispose();
    super.dispose();
  }

  void _onExchangeRateChanged(String value) {
    final localizationProvider = context.read<LocalizationProvider>();
    setState(() {
      if (value.isEmpty) {
        _exchangeRateError = Translations.get(
          'exchangeRateRequired',
          localizationProvider.currentLanguage,
        );
        return;
      }

      if (!CalculationService.validateExchangeRate(value)) {
        _exchangeRateError = Translations.get(
          'validPositiveExchangeRate',
          localizationProvider.currentLanguage,
        );
        return;
      }

      _exchangeRateError = null;
      final rate = double.parse(value);
      widget.onExchangeRateChanged(rate);
    });
  }

  void _showEditNameDialog(
    BuildContext context,
    ComparisonProvider provider,
    LocalizationProvider localizationProvider,
    bool isScenarioA,
  ) {
    final currentName = isScenarioA
        ? provider.scenarioAName
        : provider.scenarioBName;
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            Translations.get(
              'editScenarioName',
              localizationProvider.currentLanguage,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: Translations.get(
                  'scenarioNameLabel',
                  localizationProvider.currentLanguage,
                ),
                hintText: Translations.get(
                  'enterScenarioName',
                  localizationProvider.currentLanguage,
                ),
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
              maxLength: 30,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                Translations.get(
                  'cancel',
                  localizationProvider.currentLanguage,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (isScenarioA) {
                  provider.updateScenarioAName(controller.text);
                } else {
                  provider.updateScenarioBName(controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                Translations.get('save', localizationProvider.currentLanguage),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );

    return Consumer2<ComparisonProvider, LocalizationProvider>(
      builder: (context, provider, localizationProvider, child) {
        final result = CalculationService.calculateScenario(provider.scenarioB);

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
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.layers,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.scenarioBName,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () => _showEditNameDialog(
                              context,
                              provider,
                              localizationProvider,
                              false,
                            ),
                            tooltip: Translations.get(
                              'editScenarioName',
                              localizationProvider.currentLanguage,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  Translations.get(
                    'commissions',
                    localizationProvider.currentLanguage,
                  ),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...widget.commissions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final commission = entry.value;
                  return CommissionInputWidget(
                    key: ValueKey('scenarioB_commission_$index'),
                    commission: commission,
                    index: index,
                    onValueChanged: (value) =>
                        widget.onUpdateCommissionValue(index, value),
                    onTypeChanged: (type) =>
                        widget.onUpdateCommissionType(index, type),
                    onDescriptionChanged: (description) => widget
                        .onUpdateCommissionDescription(index, description),
                    onRemove: () => widget.onRemoveCommission(index),
                  );
                }),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: widget.onAddCommission,
                    icon: const Icon(Icons.add),
                    label: Text(
                      Translations.get(
                        'addCommission',
                        localizationProvider.currentLanguage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Translations.get(
                    'reimbursements',
                    localizationProvider.currentLanguage,
                  ),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 8),
                ...widget.reimbursements.asMap().entries.map((entry) {
                  final index = entry.key;
                  final reimbursement = entry.value;
                  return ReimbursementInputWidget(
                    key: ValueKey('scenarioB_reimbursement_$index'),
                    reimbursement: reimbursement,
                    index: index,
                    onValueChanged: (value) =>
                        widget.onUpdateReimbursementValue(index, value),
                    onTypeChanged: (type) =>
                        widget.onUpdateReimbursementType(index, type),
                    onDescriptionChanged: (description) => widget
                        .onUpdateReimbursementDescription(index, description),
                    onRemove: () => widget.onRemoveReimbursement(index),
                  );
                }),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: widget.onAddReimbursement,
                    icon: const Icon(Icons.add),
                    label: Text(
                      Translations.get(
                        'addReimbursement',
                        localizationProvider.currentLanguage,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.tertiary,
                      side: BorderSide(color: theme.colorScheme.tertiary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _exchangeRateController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: InputDecoration(
                    labelText: Translations.get(
                      'finalExchangeRate',
                      localizationProvider.currentLanguage,
                    ),
                    prefixIcon: const Icon(Icons.currency_exchange),
                    border: const OutlineInputBorder(),
                    errorText: _exchangeRateError,
                    helperText: Translations.get(
                      'appliedAfterCommissions',
                      localizationProvider.currentLanguage,
                    ),
                  ),
                  onChanged: _onExchangeRateChanged,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translations.get(
                          'calculationSteps',
                          localizationProvider.currentLanguage,
                        ),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (result.isValid) ...[
                        ...result.steps.map(
                          (step) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    step.description,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                                Text(
                                  '${currencyFormat.format(step.inputAmount)} → ${currencyFormat.format(step.outputAmount)}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translations.get(
                                'finalAmount',
                                localizationProvider.currentLanguage,
                              ),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(result.finalAmount.value),
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Text(
                          Translations.get(
                            'invalidInputs',
                            localizationProvider.currentLanguage,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
