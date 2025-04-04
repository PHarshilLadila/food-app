import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationUtils extends ChangeNotifier {
  // * Singleton class.
  LocalizationUtils._();

  static final instance = LocalizationUtils._();

  final storageBox = Hive.box('kHiveBox');

  late Locale _locale;

  Locale get locale => _locale;

  /// Sets the app's locale initially. (Default is system's locale)
  void initialize() {
    final String? localLanguageCode = storageBox.get('language_code');
    if (localLanguageCode != null) {
      _locale = Locale(localLanguageCode).localeWithCountryCode;
      return;
    }
    _locale = Locale(Platform.localeName);
  }

  /// Changes the app's locale and also stores the locale in the Hive.
  void changeLocale({required Locale locale, required bool systemDefault}) {
    if (systemDefault) {
      storageBox.delete('language_code');

      const supportedLocales = AppLocalizations.supportedLocales;
      final localeWithCountryCode = locale.localeWithCountryCode;

      if (supportedLocales.contains(localeWithCountryCode)) {
        _locale = localeWithCountryCode;
      } else if (supportedLocales
          .contains(Locale(localeWithCountryCode.languageCode))) {
        _locale = Locale(localeWithCountryCode.languageCode);
      } else {
        _locale = const Locale('en');
      }
    } else {
      _locale = locale;
      storageBox.put('language_code', locale.toString());
    }
    notifyListeners();
  }

  /// Callback that is invoked when the app's locale is changed.
  Locale? localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (storageBox.get('language_code') != null) return null;
    if (locale != null && locale.countryCode != null) {
      if (supportedLocales.contains(locale)) {
        return _locale = locale;
      } else if (supportedLocales.contains(Locale(locale.languageCode))) {
        return _locale = Locale(locale.languageCode);
      }
      return _locale = const Locale('en');
    }
    return _locale;
  }
}

extension LocaleExtension on Locale {
  Locale get localeWithCountryCode {
    if (countryCode == null || countryCode!.isEmpty) {
      return this;
    }
    return Locale(languageCode, countryCode);
  }
}
