import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocaleLocalizations {
  LocaleLocalizations(this.locale);

  final Locale locale;

  static LocaleLocalizations of(BuildContext context) {
    return Localizations.of<LocaleLocalizations>(context, LocaleLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Hello World',
    },
    'uz': {
      'title': 'Salom',
      'title1': 'Salom 1',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String tr(String value) {
    return _localizedValues[locale.languageCode]?[value] ?? '* $value';
  }
}
// #enddocregion Demo

// #docregion Delegate
class LocaleLocalizationsDelegate
    extends LocalizationsDelegate<LocaleLocalizations> {
  const LocaleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocaleLocalizations.languages().contains(locale.languageCode);

  @override
  Future<LocaleLocalizations> load(Locale locale) {
    return SynchronousFuture<LocaleLocalizations>(LocaleLocalizations(locale));
  }

  @override
  bool shouldReload(LocaleLocalizationsDelegate old) => false;
}
