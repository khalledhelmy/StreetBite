import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/theme/app_colors.dart';

class HomeSearchWidget extends StatelessWidget {
  final void Function(String) onSearchChanged;
  const HomeSearchWidget({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: 'home.search_hint'.tr(),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.fieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: AppColors.fieldBackground),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: AppColors.fieldBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
