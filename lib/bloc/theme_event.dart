part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  ThemeChanged({
    required this.themeMode,
  });

  final ThemeMode themeMode;
}

class LocaleChanged extends ThemeEvent {
  LocaleChanged({
    required this.locale,
  });

  final Locale locale;
}
