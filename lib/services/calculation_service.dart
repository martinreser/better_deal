import '../models/models.dart';
import '../providers/localization_provider.dart';
import 'translations.dart';

class CalculationService {
  static ScenarioResult calculateScenario(Scenario scenario, [AppLanguage? language]) {
    if (!scenario.isValid) {
      return ScenarioResult(
        scenario: scenario,
        finalAmount: Amount(value: 0, currency: scenario.baseAmount.currency),
        steps: [],
        isValid: false,
      );
    }

    return _calculateMultiCommissionScenario(scenario, language ?? AppLanguage.english);
  }

  static ScenarioResult _calculateMultiCommissionScenario(Scenario scenario, AppLanguage language) {
    final steps = <CalculationStep>[];
    double currentAmount = scenario.baseAmount.value;

    // Apply commissions first
    for (int i = 0; i < scenario.commissions.length; i++) {
      final commission = scenario.commissions[i];
      final commissionAmount = commission.calculateCommissionAmount(
        currentAmount,
      );
      final afterCommission = commission.applyCommission(currentAmount);

      steps.add(
        CalculationStep(
          description: commission.description.isEmpty
              ? 'Commission ${i + 1} (${commission.displayValue})'
              : '${commission.description} (${commission.displayValue})',
          inputAmount: currentAmount,
          outputAmount: afterCommission,
          commissionPercentage: commission.type == CommissionType.percentage
              ? commission.value
              : null,
          commissionAmount: commissionAmount,
        ),
      );

      currentAmount = afterCommission;
    }

    // Apply reimbursements after commissions
    for (int i = 0; i < scenario.reimbursements.length; i++) {
      final reimbursement = scenario.reimbursements[i];
      final reimbursementAmount = reimbursement.calculateReimbursementAmount(
        currentAmount,
      );
      final afterReimbursement = reimbursement.applyReimbursement(
        currentAmount,
      );

      steps.add(
        CalculationStep(
          description: reimbursement.description.isEmpty
              ? 'Reimbursement ${i + 1} (+${reimbursement.displayValue})'
              : '${reimbursement.description} (+${reimbursement.displayValue})',
          inputAmount: currentAmount,
          outputAmount: afterReimbursement,
          commissionPercentage: null,
          commissionAmount:
              -reimbursementAmount, // Negative because it's a reimbursement
        ),
      );

      currentAmount = afterReimbursement;
    }

    final finalValue = currentAmount * scenario.exchangeRate;
    steps.add(
      CalculationStep(
        description: '${Translations.get('finalConversion', language)} (rate: ${scenario.exchangeRate})',
        inputAmount: currentAmount,
        outputAmount: finalValue,
      ),
    );

    return ScenarioResult(
      scenario: scenario,
      finalAmount: Amount(
        value: finalValue,
        currency: scenario.baseAmount.currency,
      ),
      steps: steps,
      isValid: true,
    );
  }

  static ComparisonResult compareScenarios(
    Scenario scenarioA,
    Scenario scenarioB,
    [AppLanguage? language]
  ) {
    final resultA = calculateScenario(scenarioA, language);
    final resultB = calculateScenario(scenarioB, language);

    return ComparisonResult(scenarioA: resultA, scenarioB: resultB);
  }

  static bool validateAmount(String value) {
    if (value.isEmpty) return false;
    final parsed = double.tryParse(value);
    return parsed != null && parsed > 0;
  }

  static bool validatePercentage(String value) {
    if (value.isEmpty) return false;
    final parsed = double.tryParse(value);
    return parsed != null && parsed >= 0 && parsed <= 100;
  }

  static bool validateFixedAmount(String value) {
    if (value.isEmpty) return false;
    final parsed = double.tryParse(value);
    return parsed != null && parsed >= 0;
  }

  static bool validateCommission(String value, CommissionType type) {
    if (type == CommissionType.percentage) {
      return validatePercentage(value);
    } else {
      return validateFixedAmount(value);
    }
  }

  static bool validateReimbursement(String value, ReimbursementType type) {
    if (type == ReimbursementType.percentage) {
      return validatePercentage(value);
    } else {
      return validateFixedAmount(value);
    }
  }

  static bool validateExchangeRate(String value) {
    if (value.isEmpty) return false;
    final parsed = double.tryParse(value);
    return parsed != null && parsed > 0;
  }
}
