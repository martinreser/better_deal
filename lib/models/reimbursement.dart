enum ReimbursementType { percentage, fixed }

class Reimbursement {
  final double value;
  final ReimbursementType type;
  final String description;

  const Reimbursement({
    required this.value,
    required this.type,
    this.description = '',
  });

  Reimbursement copyWith({
    double? value,
    ReimbursementType? type,
    String? description,
  }) {
    return Reimbursement(
      value: value ?? this.value,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  bool get isValid {
    if (type == ReimbursementType.percentage) {
      return value >= 0 && value <= 100;
    } else {
      return value >= 0;
    }
  }

  double calculateReimbursementAmount(double baseAmount) {
    if (type == ReimbursementType.percentage) {
      return baseAmount * (value / 100);
    } else {
      return value;
    }
  }

  double applyReimbursement(double baseAmount) {
    return baseAmount + calculateReimbursementAmount(baseAmount);
  }

  String get displayValue {
    if (type == ReimbursementType.percentage) {
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2)}%';
    } else {
      return '\$${value.toStringAsFixed(2)}';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Reimbursement &&
        other.value == value &&
        other.type == type &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hash(value, type, description);

  @override
  String toString() => 'Reimbursement(value: $value, type: $type, description: $description)';
}