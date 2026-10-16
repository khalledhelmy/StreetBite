import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';
import 'package:street_bite/core/theme/cubit/theme_cubit.dart';
import 'package:street_bite/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:street_bite/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:street_bite/features/auth/domain/repositories/auth_repository.dart';
import 'package:street_bite/features/auth/domain/usecases/get_current_user.dart';
import 'package:street_bite/features/auth/domain/usecases/login.dart';
import 'package:street_bite/features/auth/domain/usecases/logout.dart';
import 'package:street_bite/features/auth/domain/usecases/sign_up.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();

  // Core
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<SharedPrefHelper>(
    () => SharedPrefHelper(sl<SharedPreferences>()),
  );

  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data Sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(FirebaseAuth.instance),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<FirebaseAuthDataSource>()),
  );

  // Usecases
  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton<SignUp>(() => SignUp(sl<AuthRepository>()));
  sl.registerLazySingleton<Logout>(() => Logout(sl<AuthRepository>()));
  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(sl<AuthRepository>()),
  );

  // Cubits
  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(sl<SharedPrefHelper>()),
  );
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      login: sl<Login>(),
      signUp: sl<SignUp>(),
      logout: sl<Logout>(),
      getCurrentUser: sl<GetCurrentUser>(),
    ),
  );
}
