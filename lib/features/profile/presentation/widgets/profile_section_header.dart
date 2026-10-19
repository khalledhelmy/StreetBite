import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSectionHeader extends StatelessWidget {
  const ProfileSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(start: 4.w),
    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
  );
}
