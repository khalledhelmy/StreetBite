import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/change_theme_widget.dart';
import 'package:street_bite/core/widgets/language_switcher.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  const AuthHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ChangeThemeWidget(), LanguageSwitcher()],
        ),
        HeightSpace(20),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 32.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
