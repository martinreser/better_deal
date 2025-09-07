enum CommissionType { percentage, fixed }

class Commission {
  final double value;
  final CommissionType type;
  final String description;

  const Commission({
    required this.value,
    required this.type,
    this.description = '',
  });

  Commission copyWith({
    double? value,
    CommissionType? type,
    String? description,
  }) {
    return Commission(
      value: value ?? this.value,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  bool get isValid {
    if (type == CommissionType.percentage) {
      return value >= 0 && value <= 100;
    } else {
      return value >= 0;
    }
  }

  double calculateCommissionAmount(double baseAmount) {
    if (type == CommissionType.percentage) {
      return baseAmount * (value / 100);
    } else {
      return value;
    }
  }

  double applyCommission(double baseAmount) {
    return baseAmount - calculateCommissionAmount(baseAmount);
  }

  String get displayValue {
    if (type == CommissionType.percentage) {
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2)}%';
    } else {
      return '\$${value.toStringAsFixed(2)}';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Commission &&
        other.value == value &&
        other.type == type &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hash(value, type, description);

  @override
  String toString() => 'Commission(value: $value, type: $type, description: $description)';
}