import 'amount.dart';
import 'scenario.dart';

class CalculationStep {
  final String description;
  final double inputAmount;
  final double outputAmount;
  final double? commissionPercentage;
  final double? commissionAmount;

  const CalculationStep({
    required this.description,
    required this.inputAmount,
    required this.outputAmount,
    this.commissionPercentage,
    this.commissionAmount,
  });

  @override
  String toString() =>
      'Step: $description - $inputAmount -> $outputAmount';
}

class ScenarioResult {
  final Scenario scenario;
  final Amount finalAmount;
  final List<CalculationStep> steps;
  final bool isValid;

  const ScenarioResult({
    required this.scenario,
    required this.finalAmount,
    required this.steps,
    this.isValid = true,
  });

  @override
  String toString() =>
      'ScenarioResult(final: ${finalAmount.value}, steps: ${steps.length})';
}

class ComparisonResult {
  final ScenarioResult scenarioA;
  final ScenarioResult scenarioB;

  const ComparisonResult({
    required this.scenarioA,
    required this.scenarioB,
  });

  ScenarioResult get betterScenario {
    return scenarioA.finalAmount.value >= scenarioB.finalAmount.value
        ? scenarioA
        : scenarioB;
  }

  ScenarioResult get worseScenario {
    return scenarioA.finalAmount.value < scenarioB.finalAmount.value
        ? scenarioA
        : scenarioB;
  }

  double get difference {
    return (scenarioA.finalAmount.value - scenarioB.finalAmount.value).abs();
  }

  double get differencePercentage {
    final worse = worseScenario.finalAmount.value;
    if (worse == 0) return 0;
    return (difference / worse) * 100;
  }

  bool get scenarioAIsBetter =>
      scenarioA.finalAmount.value >= scenarioB.finalAmount.value;

  bool get isValid => scenarioA.isValid && scenarioB.isValid;

  @override
  String toString() =>
      'ComparisonResult(A: ${scenarioA.finalAmount.value}, B: ${scenarioB.finalAmount.value}, diff: $difference)';
}