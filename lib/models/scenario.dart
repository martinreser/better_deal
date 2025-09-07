import 'amount.dart';
import 'commission.dart';
import 'reimbursement.dart';

class Scenario {
  final Amount baseAmount;
  final double exchangeRate;
  final List<Commission> commissions;
  final List<Reimbursement> reimbursements;
  final String name;

  const Scenario({
    required this.baseAmount,
    required this.exchangeRate,
    this.commissions = const [],
    this.reimbursements = const [],
    this.name = '',
  });

  Scenario copyWith({
    Amount? baseAmount,
    double? exchangeRate,
    List<Commission>? commissions,
    List<Reimbursement>? reimbursements,
    String? name,
  }) {
    return Scenario(
      baseAmount: baseAmount ?? this.baseAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      commissions: commissions ?? this.commissions,
      reimbursements: reimbursements ?? this.reimbursements,
      name: name ?? this.name,
    );
  }

  bool get isValid {
    return baseAmount.value > 0 &&
        exchangeRate > 0 &&
        commissions.every((c) => c.isValid) &&
        reimbursements.every((r) => r.isValid);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Scenario &&
        other.baseAmount == baseAmount &&
        other.exchangeRate == exchangeRate &&
        other.commissions.length == commissions.length &&
        other.reimbursements.length == reimbursements.length &&
        other.name == name;
  }

  @override
  int get hashCode => Object.hash(
      baseAmount, exchangeRate, commissions.length, reimbursements.length, name);

  @override
  String toString() =>
      'Scenario(baseAmount: $baseAmount, exchangeRate: $exchangeRate, commissions: ${commissions.length}, reimbursements: ${reimbursements.length}, name: $name)';
}