import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/splash/presentation/screens/splash_screen.dart';

class RouterGenerationConfig {
  const RouterGenerationConfig._();

  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        name: AppRoutes.onBoardingScreen,
        builder: (context, state) =>
            const Scaffold(backgroundColor: Colors.blue),
      ),
    ],
  );
}
