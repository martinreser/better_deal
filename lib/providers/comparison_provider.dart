import 'package:flutter/foundation.dart';

import '../models/models.dart';
import '../services/calculation_service.dart';

class ComparisonProvider with ChangeNotifier {
  double _baseAmount = 1000.0;
  String _scenarioAName = 'Scenario A';
  String _scenarioBName = 'Scenario B';
  List<Commission> _scenarioACommissions = [
    const Commission(
      value: 1.0,
      type: CommissionType.percentage,
      description: 'Commission 1',
    ),
  ];
  List<Reimbursement> _scenarioAReimbursements = [];
  double _scenarioAExchangeRate = 1.0;
  List<Commission> _scenarioBCommissions = [
    const Commission(
      value: 1.0,
      type: CommissionType.percentage,
      description: 'Commission 1',
    ),
  ];
  List<Reimbursement> _scenarioBReimbursements = [];
  double _scenarioBExchangeRate = 1.0;

  double get baseAmount => _baseAmount;
  String get scenarioAName => _scenarioAName;
  String get scenarioBName => _scenarioBName;
  List<Commission> get scenarioACommissions =>
      List.unmodifiable(_scenarioACommissions);
  List<Reimbursement> get scenarioAReimbursements =>
      List.unmodifiable(_scenarioAReimbursements);
  double get scenarioAExchangeRate => _scenarioAExchangeRate;
  List<Commission> get scenarioBCommissions =>
      List.unmodifiable(_scenarioBCommissions);
  List<Reimbursement> get scenarioBReimbursements =>
      List.unmodifiable(_scenarioBReimbursements);
  double get scenarioBExchangeRate => _scenarioBExchangeRate;

  Scenario get scenarioA => Scenario(
    baseAmount: Amount(value: _baseAmount),
    exchangeRate: _scenarioAExchangeRate,
    commissions: _scenarioACommissions,
    reimbursements: _scenarioAReimbursements,
    name: _scenarioAName,
  );

  Scenario get scenarioB => Scenario(
    baseAmount: Amount(value: _baseAmount),
    exchangeRate: _scenarioBExchangeRate,
    commissions: _scenarioBCommissions,
    reimbursements: _scenarioBReimbursements,
    name: _scenarioBName,
  );

  ComparisonResult get comparisonResult {
    return CalculationService.compareScenarios(scenarioA, scenarioB);
  }

  void updateBaseAmount(double amount) {
    if (_baseAmount != amount) {
      _baseAmount = amount;
      notifyListeners();
    }
  }

  void updateScenarioAName(String name) {
    if (_scenarioAName != name.trim()) {
      _scenarioAName = name.trim().isEmpty ? 'Scenario A' : name.trim();
      notifyListeners();
    }
  }

  void updateScenarioBName(String name) {
    if (_scenarioBName != name.trim()) {
      _scenarioBName = name.trim().isEmpty ? 'Scenario B' : name.trim();
      notifyListeners();
    }
  }

  void updateScenarioAExchangeRate(double rate) {
    if (_scenarioAExchangeRate != rate) {
      _scenarioAExchangeRate = rate;
      notifyListeners();
    }
  }

  void updateScenarioBExchangeRate(double rate) {
    if (_scenarioBExchangeRate != rate) {
      _scenarioBExchangeRate = rate;
      notifyListeners();
    }
  }

  // Scenario A Commission Management
  void addScenarioACommission() {
    _scenarioACommissions.add(
      Commission(
        value: 1.0,
        type: CommissionType.percentage,
        description: 'Commission ${_scenarioACommissions.length + 1}',
      ),
    );
    notifyListeners();
  }

  void removeScenarioACommission(int index) {
    if (index >= 0 && index < _scenarioACommissions.length) {
      _scenarioACommissions.removeAt(index);
      notifyListeners();
    }
  }

  void updateScenarioACommission(int index, Commission commission) {
    if (index >= 0 && index < _scenarioACommissions.length) {
      _scenarioACommissions[index] = commission;
      notifyListeners();
    }
  }

  void updateScenarioACommissionValue(int index, double value) {
    if (index >= 0 && index < _scenarioACommissions.length) {
      final current = _scenarioACommissions[index];
      _scenarioACommissions[index] = current.copyWith(value: value);
      notifyListeners();
    }
  }

  void updateScenarioACommissionType(int index, CommissionType type) {
    if (index >= 0 && index < _scenarioACommissions.length) {
      final current = _scenarioACommissions[index];
      _scenarioACommissions[index] = current.copyWith(type: type);
      notifyListeners();
    }
  }

  void updateScenarioACommissionDescription(int index, String description) {
    if (index >= 0 && index < _scenarioACommissions.length) {
      final current = _scenarioACommissions[index];
      _scenarioACommissions[index] = current.copyWith(description: description);
      notifyListeners();
    }
  }

  // Scenario A Reimbursement Management
  void addScenarioAReimbursement() {
    _scenarioAReimbursements.add(
      Reimbursement(
        value: 1.0,
        type: ReimbursementType.percentage,
        description: 'Reimbursement ${_scenarioAReimbursements.length + 1}',
      ),
    );
    notifyListeners();
  }

  void removeScenarioAReimbursement(int index) {
    if (index >= 0 && index < _scenarioAReimbursements.length) {
      _scenarioAReimbursements.removeAt(index);
      notifyListeners();
    }
  }

  void updateScenarioAReimbursement(int index, Reimbursement reimbursement) {
    if (index >= 0 && index < _scenarioAReimbursements.length) {
      _scenarioAReimbursements[index] = reimbursement;
      notifyListeners();
    }
  }

  void updateScenarioAReimbursementValue(int index, double value) {
    if (index >= 0 && index < _scenarioAReimbursements.length) {
      final current = _scenarioAReimbursements[index];
      _scenarioAReimbursements[index] = current.copyWith(value: value);
      notifyListeners();
    }
  }

  void updateScenarioAReimbursementType(int index, ReimbursementType type) {
    if (index >= 0 && index < _scenarioAReimbursements.length) {
      final current = _scenarioAReimbursements[index];
      _scenarioAReimbursements[index] = current.copyWith(type: type);
      notifyListeners();
    }
  }

  void updateScenarioAReimbursementDescription(int index, String description) {
    if (index >= 0 && index < _scenarioAReimbursements.length) {
      final current = _scenarioAReimbursements[index];
      _scenarioAReimbursements[index] = current.copyWith(description: description);
      notifyListeners();
    }
  }

  // Scenario B Commission Management
  void addCommission() {
    _scenarioBCommissions.add(
      Commission(
        value: 1.0,
        type: CommissionType.percentage,
        description: 'Commission ${_scenarioBCommissions.length + 1}',
      ),
    );
    notifyListeners();
  }

  void removeCommission(int index) {
    if (index >= 0 && index < _scenarioBCommissions.length) {
      _scenarioBCommissions.removeAt(index);
      notifyListeners();
    }
  }

  void updateCommission(int index, Commission commission) {
    if (index >= 0 && index < _scenarioBCommissions.length) {
      _scenarioBCommissions[index] = commission;
      notifyListeners();
    }
  }

  void updateCommissionPercentage(int index, double value) {
    if (index >= 0 && index < _scenarioBCommissions.length) {
      final current = _scenarioBCommissions[index];
      _scenarioBCommissions[index] = current.copyWith(value: value);
      notifyListeners();
    }
  }

  void updateCommissionType(int index, CommissionType type) {
    if (index >= 0 && index < _scenarioBCommissions.length) {
      final current = _scenarioBCommissions[index];
      _scenarioBCommissions[index] = current.copyWith(type: type);
      notifyListeners();
    }
  }

  void updateCommissionDescription(int index, String description) {
    if (index >= 0 && index < _scenarioBCommissions.length) {
      final current = _scenarioBCommissions[index];
      _scenarioBCommissions[index] = current.copyWith(description: description);
      notifyListeners();
    }
  }

  // Scenario B Reimbursement Management
  void addScenarioBReimbursement() {
    _scenarioBReimbursements.add(
      Reimbursement(
        value: 1.0,
        type: ReimbursementType.percentage,
        description: 'Reimbursement ${_scenarioBReimbursements.length + 1}',
      ),
    );
    notifyListeners();
  }

  void removeScenarioBReimbursement(int index) {
    if (index >= 0 && index < _scenarioBReimbursements.length) {
      _scenarioBReimbursements.removeAt(index);
      notifyListeners();
    }
  }

  void updateScenarioBReimbursement(int index, Reimbursement reimbursement) {
    if (index >= 0 && index < _scenarioBReimbursements.length) {
      _scenarioBReimbursements[index] = reimbursement;
      notifyListeners();
    }
  }

  void updateScenarioBReimbursementValue(int index, double value) {
    if (index >= 0 && index < _scenarioBReimbursements.length) {
      final current = _scenarioBReimbursements[index];
      _scenarioBReimbursements[index] = current.copyWith(value: value);
      notifyListeners();
    }
  }

  void updateScenarioBReimbursementType(int index, ReimbursementType type) {
    if (index >= 0 && index < _scenarioBReimbursements.length) {
      final current = _scenarioBReimbursements[index];
      _scenarioBReimbursements[index] = current.copyWith(type: type);
      notifyListeners();
    }
  }

  void updateScenarioBReimbursementDescription(int index, String description) {
    if (index >= 0 && index < _scenarioBReimbursements.length) {
      final current = _scenarioBReimbursements[index];
      _scenarioBReimbursements[index] = current.copyWith(description: description);
      notifyListeners();
    }
  }

  void resetToDefaults() {
    _baseAmount = 1000.0;
    _scenarioAName = 'Scenario A';
    _scenarioBName = 'Scenario B';
    _scenarioACommissions = [
      const Commission(
        value: 1.0,
        type: CommissionType.percentage,
        description: 'Commission 1',
      ),
    ];
    _scenarioAReimbursements = [];
    _scenarioAExchangeRate = 1.0;
    _scenarioBCommissions = [
      const Commission(
        value: 1.0,
        type: CommissionType.percentage,
        description: 'Commission 1',
      ),
    ];
    _scenarioBReimbursements = [];
    _scenarioBExchangeRate = 1.0;
    notifyListeners();
  }

  bool validateInputs() {
    return _baseAmount > 0 &&
        _scenarioAExchangeRate > 0 &&
        _scenarioBExchangeRate > 0 &&
        _scenarioACommissions.every((c) => c.isValid) &&
        _scenarioBCommissions.every((c) => c.isValid) &&
        _scenarioAReimbursements.every((r) => r.isValid) &&
        _scenarioBReimbursements.every((r) => r.isValid);
  }
}
