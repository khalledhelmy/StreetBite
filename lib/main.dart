import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/routing/router_generation_config.dart';
import 'package:street_bite/core/theme/app_theme.dart';
import 'package:street_bite/core/theme/cubit/theme_cubit.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:street_bite/features/home/presentation/cubit/meals_cubit.dart';
import 'package:street_bite/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const StreetBite(),
    ),
  );
}

class StreetBite extends StatelessWidget {
  const StreetBite({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<ThemeCubit>()..loadTheme()),
            BlocProvider(
              create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            ),
            BlocProvider(create: (context) => sl<FavoritesCubit>()),
            BlocProvider(create: (context) => sl<MealsCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                title: 'StreetBite',
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                routerConfig: RouterGenerationConfig.goRouter,
              );
            },
          ),
        );
      },
    );
  }
}
