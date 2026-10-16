import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/theme/app_colors.dart';
import 'package:street_bite/core/theme/cubit/theme_cubit.dart';
import 'package:street_bite/core/theme/extensions/theme_extensions.dart';

class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.isDarkMode
            ? Icons.light_mode_rounded
            : Icons.dark_mode_outlined,

        color: context.isDarkMode ? AppColors.rating : null,
      ),

      onPressed: () {
        if (context.isDarkMode) {
          context.read<ThemeCubit>().updateTheme(ThemeMode.light);
        } else {
          context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
        }
      },
    );
  }
}
