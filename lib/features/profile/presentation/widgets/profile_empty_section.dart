import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEmptySection extends StatelessWidget {
  const ProfileEmptySection({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Center(child: Text(message, textAlign: TextAlign.center)),
    ),
  );
}
