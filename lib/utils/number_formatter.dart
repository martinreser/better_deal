class NumberFormatter {
  /// Formats a double to string, removing unnecessary decimal places
  /// Examples: 1.0 -> "1", 1.5 -> "1.5", 1.25 -> "1.25"
  static String formatForInput(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    }
    return value.toString();
  }
  
  /// Parse string to double safely
  static double? parseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }
}