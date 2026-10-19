import 'package:go_router/go_router.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/features/auth/presentation/screens/login_screen.dart';
import 'package:street_bite/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/main_layout_screen/presentation/screens/main_screen.dart';
import 'package:street_bite/features/meal_details/presentation/screens/meal_details_screen.dart';
import 'package:street_bite/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:street_bite/features/splash/presentation/screens/splash_screen.dart';

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
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpScreen,
        name: AppRoutes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.mainScreen,
        name: AppRoutes.mainScreen,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: AppRoutes.mealDetailsScreen,
        path: AppRoutes.mealDetailsScreen,
        builder: (context, state) {
          final args = state.extra as ({MealEntity meal, String heroTag});

          return MealDetailsScreen(meal: args.meal, heroTag: args.heroTag);
        },
      ),
    ],
  );
}
