import 'package:flutter/material.dart';
import 'package:street_bite/core/theme/app_colors.dart';

class AuthFooterWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function() onTap;
  const AuthFooterWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.textSecondary),
          children: [
            TextSpan(
              text: secondText,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
