import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';
import 'package:street_bite/core/theme/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<SharedPrefHelper>(
    () => SharedPrefHelper(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(sl<SharedPrefHelper>()),
  );
}
