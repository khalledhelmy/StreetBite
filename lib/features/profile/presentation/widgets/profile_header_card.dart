import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageProvider,
    required this.onChoosePhoto,
  });

  final String name;
  final String email;
  final ImageProvider? imageProvider;
  final VoidCallback onChoosePhoto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 48.r,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  backgroundImage: imageProvider,
                  child: imageProvider == null
                      ? Icon(
                          Icons.person,
                          size: 48.sp,
                          color: theme.colorScheme.primary,
                        )
                      : null,
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: Material(
                    color: theme.colorScheme.primary,
                    shape: const CircleBorder(),
                    child: IconButton(
                      tooltip: 'profile.change_photo'.tr(),
                      onPressed: onChoosePhoto,
                      icon: Icon(
                        Icons.photo_camera_outlined,
                        color: theme.colorScheme.onPrimary,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            HeightSpace(16),
            Text(name, style: theme.textTheme.titleLarge),
            HeightSpace(4),
            Text(
              email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            HeightSpace(8),
            Text(
              'profile.photo_local_note'.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
