import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';
import 'package:street_bite/core/theme/app_colors.dart';
import 'package:street_bite/injection.dart';

class CustomSkipButton extends StatelessWidget {
  const CustomSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(100.w, 45.h),

        side: BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(24.r),
        ),
      ),
      onPressed: () async {
        await sl<SharedPrefHelper>().setOnboardingCompleted();
        if (!context.mounted) return;
        GoRouter.of(context).pushReplacementNamed(AppRoutes.loginScreen);
      },
      child: Text('skip'.tr()),
    );
  }
}
