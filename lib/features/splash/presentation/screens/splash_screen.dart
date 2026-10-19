import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:street_bite/core/constants/app_assets.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';
import 'package:street_bite/injection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await _animationController.forward();
    if (!mounted) return;

    final isOnboardingCompleted = sl<SharedPrefHelper>().isOnboardingCompleted;
    if (isOnboardingCompleted) {
      GoRouter.of(context).pushReplacementNamed(AppRoutes.loginScreen);
    } else {
      GoRouter.of(context).pushReplacementNamed(AppRoutes.onBoardingScreen);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.splashBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          ScaleTransition(
            scale: _animation,
            child: Center(
              child: Image.asset(AppAssets.logo, width: 150.w, height: 200.h),
            ),
          ),
        ],
      ),
    );
  }
}
