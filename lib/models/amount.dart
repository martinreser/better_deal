class Amount {
  final double value;
  final String currency;

  const Amount({
    required this.value,
    this.currency = 'USD',
  });

  Amount copyWith({
    double? value,
    String? currency,
  }) {
    return Amount(
      value: value ?? this.value,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Amount &&
        other.value == value &&
        other.currency == currency;
  }

  @override
  int get hashCode => Object.hash(value, currency);

  @override
  String toString() => 'Amount(value: $value, currency: $currency)';
}