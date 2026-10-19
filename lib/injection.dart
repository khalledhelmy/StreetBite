import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite/core/networking/dio_helper.dart';
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
import 'package:street_bite/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:street_bite/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:street_bite/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite/features/favorites/domain/usecases/add_favorite.dart';
import 'package:street_bite/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:street_bite/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:street_bite/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:street_bite/features/home/data/datasources/meal_remote_data_source.dart';
import 'package:street_bite/features/home/data/repositories/meal_repository_impl.dart';
import 'package:street_bite/features/home/domain/repositories/meal_repository.dart';
import 'package:street_bite/features/home/domain/usecases/get_meals_use_case.dart';
import 'package:street_bite/features/home/domain/usecases/search_meals_use_case.dart';
import 'package:street_bite/features/home/presentation/cubit/meals_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();

  // Core
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<SharedPrefHelper>(
    () => SharedPrefHelper(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<DioHelper>(() => DioHelper());

  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data Sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(FirebaseAuth.instance),
  );
  sl.registerLazySingleton<MealRemoteDataSource>(
    () => MealRemoteDataSource(sl<DioHelper>(), sl<SharedPrefHelper>()),
  );
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSource(sl<FirebaseFirestore>(), sl<FirebaseAuth>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<FirebaseAuthDataSource>()),
  );
  sl.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(sl<MealRemoteDataSource>()),
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoriteRepositoryImpl(sl<FavoriteRemoteDataSource>()),
  );

  // Usecases
  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton<SignUp>(() => SignUp(sl<AuthRepository>()));
  sl.registerLazySingleton<Logout>(() => Logout(sl<AuthRepository>()));
  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetMealsUseCase>(
    () => GetMealsUseCase(sl<MealRepository>()),
  );
  sl.registerLazySingleton<SearchMealsUseCase>(
    () => SearchMealsUseCase(sl<MealRepository>()),
  );
  sl.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<AddFavorite>(
    () => AddFavorite(sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<RemoveFavorite>(
    () => RemoveFavorite(sl<FavoritesRepository>()),
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
  sl.registerFactory<MealsCubit>(
    () => MealsCubit(
      getMeals: sl<GetMealsUseCase>(),
      searchMeals: sl<SearchMealsUseCase>(),
    ),
  );
  sl.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(
      getFavorites: sl<GetFavoritesUseCase>(),
      addFavorite: sl<AddFavorite>(),
      removeFavorite: sl<RemoveFavorite>(),
    ),
  );
}
