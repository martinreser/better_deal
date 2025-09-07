import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/localization_provider.dart';
import '../services/calculation_service.dart';
import '../services/translations.dart';
import '../utils/number_formatter.dart';

class ReimbursementInputWidget extends StatefulWidget {
  final Reimbursement reimbursement;
  final int index;
  final ValueChanged<double> onValueChanged;
  final ValueChanged<ReimbursementType> onTypeChanged;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onRemove;

  const ReimbursementInputWidget({
    super.key,
    required this.reimbursement,
    required this.index,
    required this.onValueChanged,
    required this.onTypeChanged,
    required this.onDescriptionChanged,
    required this.onRemove,
  });

  @override
  State<ReimbursementInputWidget> createState() =>
      _ReimbursementInputWidgetState();
}

class _ReimbursementInputWidgetState extends State<ReimbursementInputWidget> {
  late TextEditingController _valueController;
  late TextEditingController _descriptionController;
  String? _valueError;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(
      text: NumberFormatter.formatForInput(widget.reimbursement.value),
    );
    _descriptionController = TextEditingController(
      text: widget.reimbursement.description,
    );
  }

  @override
  void didUpdateWidget(ReimbursementInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reimbursement != widget.reimbursement) {
      _valueController.text = NumberFormatter.formatForInput(
        widget.reimbursement.value,
      );
      _descriptionController.text = widget.reimbursement.description;
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onValueChanged(String value) {
    final localizationProvider = context.read<LocalizationProvider>();
    setState(() {
      if (value.isEmpty) {
        _valueError = widget.reimbursement.type == ReimbursementType.percentage
            ? Translations.get(
                'percentageRequired',
                localizationProvider.currentLanguage,
              )
            : Translations.get(
                'amountIsRequired',
                localizationProvider.currentLanguage,
              );
        return;
      }

      if (!CalculationService.validateReimbursement(
        value,
        widget.reimbursement.type,
      )) {
        _valueError = widget.reimbursement.type == ReimbursementType.percentage
            ? Translations.get(
                'validPercentage',
                localizationProvider.currentLanguage,
              )
            : Translations.get(
                'validPositiveAmountError',
                localizationProvider.currentLanguage,
              );
        return;
      }

      _valueError = null;
      final reimbursementValue = double.parse(value);
      widget.onValueChanged(reimbursementValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        final theme = Theme.of(context);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: theme.colorScheme.tertiary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: Translations.get(
                            'description',
                            localizationProvider.currentLanguage,
                          ),
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: widget.onDescriptionChanged,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _valueController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: InputDecoration(
                          labelText:
                              widget.reimbursement.type ==
                                  ReimbursementType.percentage
                              ? Translations.get(
                                  'percentage',
                                  localizationProvider.currentLanguage,
                                )
                              : Translations.get(
                                  'amount',
                                  localizationProvider.currentLanguage,
                                ),
                          border: const OutlineInputBorder(),
                          isDense: true,
                          suffixText:
                              widget.reimbursement.type ==
                                  ReimbursementType.percentage
                              ? '%'
                              : '\$',
                          errorText: _valueError,
                          prefixStyle: TextStyle(
                            color: theme.colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: _onValueChanged,
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<ReimbursementType>(
                      value: widget.reimbursement.type,
                      items: const [
                        DropdownMenuItem(
                          value: ReimbursementType.percentage,
                          child: Text('%'),
                        ),
                        DropdownMenuItem(
                          value: ReimbursementType.fixed,
                          child: Text('\$'),
                        ),
                      ],
                      onChanged: (type) {
                        if (type != null) {
                          widget.onTypeChanged(type);
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: widget.onRemove,
                      icon: const Icon(Icons.remove_circle_outline),
                      tooltip: Translations.get(
                        'removeReimbursement',
                        localizationProvider.currentLanguage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
