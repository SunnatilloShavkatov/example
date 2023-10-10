import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeMode: ThemeMode.system,
            locale: const Locale('en'),
          ),
        ) {
    on<ThemeChanged>(onThemeChanged);
    on<LocaleChanged>(onLocaleChanged);
  }

  void onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void onLocaleChanged(
    LocaleChanged event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(locale: event.locale));
  }
}
