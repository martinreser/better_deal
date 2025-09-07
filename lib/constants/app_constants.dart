class AppConstants {
  // App Information
  static const String appName = 'Better Deal';
  static const String appTagline = 'Commission Calculator';
  static const String appVersion = '1.0.0';
  
  // Default Values
  static const double defaultBaseAmount = 1000.0;
  static const double defaultExchangeRate = 1.0;
  static const double defaultCommissionPercentage = 1.0;
  
  // Validation Limits
  static const double maxAmount = 1000000000; // 1 billion
  static const double minAmount = 0.01;
  static const double maxPercentage = 100.0;
  static const double minPercentage = 0.0;
  static const double maxExchangeRate = 1000000; // 1 million
  static const double minExchangeRate = 0.0001;
  
  // Storage Limits
  static const int maxSavedScenarios = 50;
  static const int maxRecentScenarios = 10;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double cardBorderRadius = 8.0;
  static const double buttonBorderRadius = 8.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  
  // Colors (for custom theming if needed)
  static const int primaryColorValue = 0xFF2196F3;
  static const int secondaryColorValue = 0xFF03DAC6;
  static const int errorColorValue = 0xFFB00020;
  static const int warningColorValue = 0xFFFF9800;
  static const int successColorValue = 0xFF4CAF50;
  
  // Commission Descriptions
  static const List<String> commonCommissionDescriptions = [
    'Platform Fee',
    'Processing Fee',
    'Service Charge',
    'Transaction Fee',
    'Handling Fee',
    'Exchange Fee',
    'Conversion Fee',
    'Administrative Fee',
  ];
  
  // Export Formats
  static const List<String> exportFormats = [
    'Text',
    'JSON',
    'CSV',
    'Sharing Format',
  ];
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String validationErrorMessage = 'Please check your inputs and try again.';
  static const String storageErrorMessage = 'Failed to save data. Please try again.';
  
  // Success Messages
  static const String scenarioSavedMessage = 'Scenario saved successfully';
  static const String scenarioLoadedMessage = 'Scenario loaded successfully';
  static const String dataExportedMessage = 'Data exported successfully';
  static const String settingsUpdatedMessage = 'Settings updated successfully';
}

class AppStrings {
  // Screen Titles
  static const String homeTitle = 'Commission Calculator';
  static const String settingsTitle = 'Settings';
  static const String aboutTitle = 'About';
  
  // Button Labels
  static const String saveButton = 'Save';
  static const String loadButton = 'Load';
  static const String cancelButton = 'Cancel';
  static const String deleteButton = 'Delete';
  static const String exportButton = 'Export';
  static const String resetButton = 'Reset';
  static const String addButton = 'Add';
  static const String removeButton = 'Remove';
  
  // Field Labels
  static const String baseAmountLabel = 'Base Amount';
  static const String exchangeRateLabel = 'Exchange Rate';
  static const String commissionLabel = 'Commission';
  static const String percentageLabel = 'Percentage';
  static const String descriptionLabel = 'Description';
  static const String scenarioNameLabel = 'Scenario Name';
  
  // Hints and Helpers
  static const String baseAmountHint = 'Enter the initial amount';
  static const String exchangeRateHint = '1 USD = X ARS';
  static const String commissionHint = 'Enter percentage (0-100)';
  static const String scenarioNameHint = 'Enter a name for this scenario';
  
  // Tooltips
  static const String resetTooltip = 'Reset to default values';
  static const String saveTooltip = 'Save current scenario';
  static const String loadTooltip = 'Load saved scenario';
  static const String exportTooltip = 'Export comparison result';
  static const String themeTooltip = 'Toggle dark/light theme';
  static const String deleteTooltip = 'Delete this scenario';
  
  // Status Messages
  static const String calculatingMessage = 'Calculating...';
  static const String loadingMessage = 'Loading...';
  static const String savingMessage = 'Saving...';
  static const String noDataMessage = 'No data available';
  static const String invalidInputMessage = 'Invalid input';
  
  // Comparison Results
  static const String scenarioAWins = 'Scenario A gives better value!';
  static const String scenarioBWins = 'Scenario B gives better value!';
  static const String equalResults = 'Both scenarios give equal results';
  
  // Feature Descriptions
  static const String scenarioADescription = 'Direct conversion with simple exchange rate';
  static const String scenarioBDescription = 'Multi-step process with commissions before final conversion';
  static const String comparisonDescription = 'Compare different commission structures to find the best deal';
}