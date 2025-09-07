import 'package:flutter_test/flutter_test.dart';
import 'package:better_deal/models/models.dart';
import 'package:better_deal/services/calculation_service.dart';

void main() {
  group('CalculationService', () {
    test('calculateMultiCommissionScenario with percentage commissions should work correctly', () {
      final scenario = Scenario(
        baseAmount: const Amount(value: 1000),
        exchangeRate: 350,
        commissions: [
          const Commission(value: 1.0, type: CommissionType.percentage, description: 'Fee 1'),
          const Commission(value: 2.0, type: CommissionType.percentage, description: 'Fee 2'),
        ],
      );

      final result = CalculationService.calculateScenario(scenario);

      expect(result.isValid, true);
      // After 1% commission: 1000 - 10 = 990
      // After 2% commission: 990 - 19.8 = 970.2
      // Final: 970.2 * 350 = 339570
      expect(result.finalAmount.value, closeTo(339570, 0.1));
      expect(result.steps.length, 3); // 2 commissions + 1 conversion
    });

    test('calculateMultiCommissionScenario with fixed commissions should work correctly', () {
      final scenario = Scenario(
        baseAmount: const Amount(value: 1000),
        exchangeRate: 350,
        commissions: [
          const Commission(value: 5.0, type: CommissionType.fixed, description: 'Fixed Fee 1'),
          const Commission(value: 10.0, type: CommissionType.fixed, description: 'Fixed Fee 2'),
        ],
      );

      final result = CalculationService.calculateScenario(scenario);

      expect(result.isValid, true);
      // After $5 commission: 1000 - 5 = 995
      // After $10 commission: 995 - 10 = 985
      // Final: 985 * 350 = 344750
      expect(result.finalAmount.value, 344750);
      expect(result.steps.length, 3); // 2 commissions + 1 conversion
    });

    test('compareScenarios should identify better option', () {
      final scenarioA = Scenario(
        baseAmount: const Amount(value: 1000),
        exchangeRate: 350,
        commissions: [
          const Commission(value: 1.0, type: CommissionType.percentage, description: 'Low fee'),
        ],
      );

      final scenarioB = Scenario(
        baseAmount: const Amount(value: 1000),
        exchangeRate: 350,
        commissions: [
          const Commission(value: 5.0, type: CommissionType.percentage, description: 'High fee'),
        ],
      );

      final comparison = CalculationService.compareScenarios(scenarioA, scenarioB);

      expect(comparison.isValid, true);
      expect(comparison.scenarioAIsBetter, true);
      expect(comparison.difference, greaterThan(0));
    });

    test('validation methods should work correctly', () {
      expect(CalculationService.validateAmount('1000'), true);
      expect(CalculationService.validateAmount('0'), false);
      expect(CalculationService.validateAmount('-1'), false);
      expect(CalculationService.validateAmount('abc'), false);

      expect(CalculationService.validatePercentage('5.5'), true);
      expect(CalculationService.validatePercentage('0'), true);
      expect(CalculationService.validatePercentage('100'), true);
      expect(CalculationService.validatePercentage('101'), false);
      expect(CalculationService.validatePercentage('-1'), false);

      expect(CalculationService.validateExchangeRate('350'), true);
      expect(CalculationService.validateExchangeRate('0'), false);
      expect(CalculationService.validateExchangeRate('-1'), false);
    });

    test('invalid scenario should return invalid result', () {
      final scenario = Scenario(
        baseAmount: const Amount(value: -1000), // Invalid negative amount
        exchangeRate: 350,
        commissions: [],
      );

      final result = CalculationService.calculateScenario(scenario);

      expect(result.isValid, false);
      expect(result.finalAmount.value, 0);
    });
  });

  group('Commission', () {
    test('should calculate percentage commission correctly', () {
      const commission = Commission(value: 5.0, type: CommissionType.percentage);
      
      expect(commission.calculateCommissionAmount(1000), 50);
      expect(commission.applyCommission(1000), 950);
    });

    test('should calculate fixed commission correctly', () {
      const commission = Commission(value: 25.0, type: CommissionType.fixed);
      
      expect(commission.calculateCommissionAmount(1000), 25);
      expect(commission.applyCommission(1000), 975);
    });

    test('should validate commission values', () {
      const validPercentageCommission = Commission(value: 5.0, type: CommissionType.percentage);
      const invalidPercentageCommission = Commission(value: 150.0, type: CommissionType.percentage);
      const validFixedCommission = Commission(value: 25.0, type: CommissionType.fixed);
      const invalidFixedCommission = Commission(value: -5.0, type: CommissionType.fixed);
      
      expect(validPercentageCommission.isValid, true);
      expect(invalidPercentageCommission.isValid, false);
      expect(validFixedCommission.isValid, true);
      expect(invalidFixedCommission.isValid, false);
    });
  });
}