import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPrefHelper _prefs;
  ThemeCubit(this._prefs) : super(ThemeMode.system);

  void loadTheme() {
    final saved = _prefs.getThemeMode();

    switch (saved) {
      case 'light':
        emit(ThemeMode.light);
      case 'dark':
        emit(ThemeMode.dark);
      default:
        emit(ThemeMode.system);
    }
  }

  Future<void> updateTheme(ThemeMode mode) async {
    await _prefs.updateThemeMode(mode.name);
    emit(mode);
  }
}
