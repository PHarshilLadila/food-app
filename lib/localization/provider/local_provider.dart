import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider with ChangeNotifier {
  Locale _appLocale = const Locale("en");

  Locale get appLocal => _appLocale;

  LocalProvider() {
    fetchLocale();
  }

  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return;
    }

    _appLocale = Locale(prefs.getString('language_code')!);
    notifyListeners();
  }

  Future<void> changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("es")) {
      _appLocale = const Locale("es");
      await prefs.setString('language_code', 'es');
      await prefs.setString('countryCode', 'ES');
    } else if (type == const Locale("he")) {
      _appLocale = const Locale("he");
      await prefs.setString('language_code', 'he');
      await prefs.setString('countryCode', 'IL');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
