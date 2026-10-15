import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';
import 'package:street_bite/core/theme/app_colors.dart';
import 'package:street_bite/injection.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await sl<SharedPrefHelper>().setOnboardingCompleted();
        if (!context.mounted) return;
        GoRouter.of(context).pushReplacementNamed(AppRoutes.loginScreen);
      },
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),

        child: Icon(
          Icons.arrow_forward,
          size: 26.sp,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
