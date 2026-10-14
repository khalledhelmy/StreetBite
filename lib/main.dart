import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/routing/router_generation_config.dart';
import 'package:street_bite/core/theme/app_theme.dart';
import 'package:street_bite/core/theme/cubit/theme_cubit.dart';
import 'package:street_bite/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const StreetBite());
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
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                title: 'StreetBite',
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
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
