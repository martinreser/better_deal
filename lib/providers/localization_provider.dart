import 'package:flutter/foundation.dart';

enum AppLanguage { english, spanish }

class LocalizationProvider with ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.english;

  AppLanguage get currentLanguage => _currentLanguage;
  String get languageCode => _currentLanguage == AppLanguage.english ? 'en' : 'es';

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == AppLanguage.english 
        ? AppLanguage.spanish 
        : AppLanguage.english;
    notifyListeners();
  }

  void setLanguage(AppLanguage language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
    }
  }
}