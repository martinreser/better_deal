import '../providers/localization_provider.dart';

class Translations {
  static const Map<String, Map<AppLanguage, String>> _translations = {
    // App Bar
    'resetTooltip': {
      AppLanguage.english: 'Reset to defaults',
      AppLanguage.spanish: 'Restablecer valores',
    },
    'languageTooltip': {
      AppLanguage.english: 'Switch language',
      AppLanguage.spanish: 'Cambiar idioma',
    },

    // Base Amount Card
    'baseAmount': {
      AppLanguage.english: 'Base Amount',
      AppLanguage.spanish: 'Monto inicial',
    },
    'baseAmountLabel': {
      AppLanguage.english: 'Enter the base amount',
      AppLanguage.spanish: 'Ingresa el monto inicial',
    },
    'enterAmount': {
      AppLanguage.english: 'Enter the base amount to compare',
      AppLanguage.spanish: 'Ingrese el monto inicial para comparar',
    },

    // Scenario Cards
    'scenarioA': {
      AppLanguage.english: 'Scenario A',
      AppLanguage.spanish: 'Escenario A',
    },
    'scenarioB': {
      AppLanguage.english: 'Scenario B',
      AppLanguage.spanish: 'Escenario B',
    },
    'multiCommissionProcess': {
      AppLanguage.english: 'Multi-Commission Process',
      AppLanguage.spanish: 'Proceso Multi-Comisión',
    },
    'commissions': {
      AppLanguage.english: 'Commissions',
      AppLanguage.spanish: 'Comisiones',
    },
    'addCommission': {
      AppLanguage.english: 'Add Commission',
      AppLanguage.spanish: 'Agregar Comisión',
    },
    'reimbursements': {
      AppLanguage.english: 'Reimbursements',
      AppLanguage.spanish: 'Reembolsos',
    },
    'addReimbursement': {
      AppLanguage.english: 'Add Reimbursement',
      AppLanguage.spanish: 'Agregar Reembolso',
    },
    'finalExchangeRate': {
      AppLanguage.english: 'Final Exchange Rate',
      AppLanguage.spanish: 'Tasa de Cambio Final',
    },
    'finalConversion': {
      AppLanguage.english: 'Final conversion',
      AppLanguage.spanish: 'Conversión final',
    },
    'appliedAfterCommissions': {
      AppLanguage.english:
          'Applied after all commissions and/or reimbursements',
      AppLanguage.spanish:
          'Aplicado después de todas las comisiones y/o reintegros',
    },
    'calculationSteps': {
      AppLanguage.english: 'Calculation Steps',
      AppLanguage.spanish: 'Pasos de Cálculo',
    },
    'finalAmount': {
      AppLanguage.english: 'Final Amount:',
      AppLanguage.spanish: 'Cantidad Final:',
    },
    'invalidInputs': {
      AppLanguage.english: 'Invalid inputs',
      AppLanguage.spanish: 'Entradas inválidas',
    },

    // Commission Input Widget
    'description': {
      AppLanguage.english: 'Description',
      AppLanguage.spanish: 'Descripción',
    },
    'percentage': {
      AppLanguage.english: 'Percentage',
      AppLanguage.spanish: 'Porcentaje',
    },
    'amount': {AppLanguage.english: 'Amount', AppLanguage.spanish: 'Cantidad'},
    'removeCommission': {
      AppLanguage.english: 'Remove commission',
      AppLanguage.spanish: 'Eliminar comisión',
    },
    'removeReimbursement': {
      AppLanguage.english: 'Remove reimbursement',
      AppLanguage.spanish: 'Eliminar reembolso',
    },

    // Comparison Result Card
    'comparisonResult': {
      AppLanguage.english: 'Comparison Result',
      AppLanguage.spanish: 'Resultado de Comparación',
    },
    'scenarioAIsBetter': {
      AppLanguage.english: 'Scenario A is better',
      AppLanguage.spanish: 'El Escenario A es mejor',
    },
    'scenarioBIsBetter': {
      AppLanguage.english: 'Scenario B is better',
      AppLanguage.spanish: 'El Escenario B es mejor',
    },
    'bothScenariosEqual': {
      AppLanguage.english: 'Both scenarios are equal',
      AppLanguage.spanish: 'Ambos escenarios son iguales',
    },
    'difference': {
      AppLanguage.english: 'Difference',
      AppLanguage.spanish: 'Diferencia',
    },
    'percentageDifference': {
      AppLanguage.english: 'Percentage Difference',
      AppLanguage.spanish: 'Diferencia Porcentual',
    },
    'betterBy': {
      AppLanguage.english: 'Better by',
      AppLanguage.spanish: 'Mejor por',
    },
    'export': {AppLanguage.english: 'Export', AppLanguage.spanish: 'Exportar'},

    // Validation Messages
    'amountRequired': {
      AppLanguage.english: 'Amount is required',
      AppLanguage.spanish: 'La cantidad es requerida',
    },
    'validPositiveAmount': {
      AppLanguage.english: 'Please enter a valid positive amount',
      AppLanguage.spanish: 'Por favor ingrese una cantidad positiva válida',
    },
    'exchangeRateRequired': {
      AppLanguage.english: 'Exchange rate is required',
      AppLanguage.spanish: 'La tasa de cambio es requerida',
    },
    'validPositiveExchangeRate': {
      AppLanguage.english: 'Please enter a valid positive exchange rate',
      AppLanguage.spanish:
          'Por favor ingrese una tasa de cambio positiva válida',
    },
    'percentageRequired': {
      AppLanguage.english: 'Percentage is required',
      AppLanguage.spanish: 'El porcentaje es requerido',
    },
    'amountIsRequired': {
      AppLanguage.english: 'Amount is required',
      AppLanguage.spanish: 'La cantidad es requerida',
    },
    'validPercentage': {
      AppLanguage.english: 'Please enter a percentage between 0 and 100',
      AppLanguage.spanish: 'Por favor ingrese un porcentaje entre 0 y 100',
    },
    'validPositiveAmountError': {
      AppLanguage.english: 'Please enter a positive amount',
      AppLanguage.spanish: 'Por favor ingrese una cantidad positiva',
    },

    // Default Commission Names
    'commission': {
      AppLanguage.english: 'Commission',
      AppLanguage.spanish: 'Comisión',
    },
    'reimbursement': {
      AppLanguage.english: 'Reimbursement',
      AppLanguage.spanish: 'Reembolso',
    },

    // Scenario Name Editing
    'editScenarioName': {
      AppLanguage.english: 'Edit scenario name',
      AppLanguage.spanish: 'Editar nombre del escenario',
    },
    'scenarioNameLabel': {
      AppLanguage.english: 'Scenario Name',
      AppLanguage.spanish: 'Nombre del Escenario',
    },
    'enterScenarioName': {
      AppLanguage.english: 'Enter scenario name',
      AppLanguage.spanish: 'Ingrese nombre del escenario',
    },
    'cancel': {AppLanguage.english: 'Cancel', AppLanguage.spanish: 'Cancelar'},
    'save': {AppLanguage.english: 'Save', AppLanguage.spanish: 'Guardar'},
    'share': {AppLanguage.english: 'Share', AppLanguage.spanish: 'Compartir'},
    'shareResult': {
      AppLanguage.english: 'Share Result',
      AppLanguage.spanish: 'Compartir Resultado',
    },
  };

  static String get(String key, AppLanguage language) {
    final translations = _translations[key];
    if (translations == null) {
      return key; // Return key if translation not found
    }
    return translations[language] ?? key;
  }
}
