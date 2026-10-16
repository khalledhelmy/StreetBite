import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return InkWell(
      onTap: () {
        context.setLocale(isArabic ? const Locale('en') : const Locale('ar'));
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            isArabic ? 'EN' : 'ع',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
