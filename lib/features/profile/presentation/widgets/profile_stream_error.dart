import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileStreamError extends StatelessWidget {
  const ProfileStreamError({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      title: Text('profile.load_error'.tr()),
      trailing: IconButton(
        tooltip: 'profile.retry'.tr(),
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
      ),
    ),
  );
}
