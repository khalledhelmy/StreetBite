import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite/core/storage/shared_pref_keys.dart';

class SharedPrefHelper {
  final SharedPreferences _prefs;

  const SharedPrefHelper(this._prefs);

  String? getThemeMode() => _prefs.getString(SharedPrefKeys.themeMode);

  Future<void> updateThemeMode(String mode) =>
      _prefs.setString(SharedPrefKeys.themeMode, mode);

  bool get isOnboardingCompleted =>
      _prefs.getBool(SharedPrefKeys.isOnboardingCompleted) ?? false;

  Future<void> setOnboardingCompleted() async =>
      await _prefs.setBool(SharedPrefKeys.isOnboardingCompleted, true);
}
