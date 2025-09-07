import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/localization_provider.dart';
import '../services/calculation_service.dart';
import '../services/translations.dart';
import '../utils/number_formatter.dart';

class BaseAmountCard extends StatefulWidget {
  final double amount;
  final ValueChanged<double> onAmountChanged;

  const BaseAmountCard({
    super.key,
    required this.amount,
    required this.onAmountChanged,
  });

  @override
  State<BaseAmountCard> createState() => _BaseAmountCardState();
}

class _BaseAmountCardState extends State<BaseAmountCard> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: NumberFormatter.formatForInput(widget.amount),
    );
  }

  @override
  void didUpdateWidget(BaseAmountCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      _controller.text = NumberFormatter.formatForInput(widget.amount);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    final localizationProvider = context.read<LocalizationProvider>();
    setState(() {
      if (value.isEmpty) {
        _errorText = Translations.get(
          'amountRequired',
          localizationProvider.currentLanguage,
        );
        return;
      }

      if (!CalculationService.validateAmount(value)) {
        _errorText = Translations.get(
          'validPositiveAmount',
          localizationProvider.currentLanguage,
        );
        return;
      }

      _errorText = null;
      final amount = double.parse(value);
      widget.onAmountChanged(amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      Translations.get(
                        'baseAmount',
                        localizationProvider.currentLanguage,
                      ),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: InputDecoration(
                    labelText: Translations.get(
                      'baseAmountLabel',
                      localizationProvider.currentLanguage,
                    ),
                    prefixIcon: const Icon(Icons.attach_money),
                    border: const OutlineInputBorder(),
                    errorText: _errorText,
                    suffixText: 'USD',
                  ),
                  onChanged: _onTextChanged,
                ),
                const SizedBox(height: 8),
                Text(
                  Translations.get(
                    'enterAmount',
                    localizationProvider.currentLanguage,
                  ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
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
