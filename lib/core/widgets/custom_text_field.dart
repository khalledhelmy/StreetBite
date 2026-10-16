import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final bool? withLargeSpace;
  final int? maxLength;
  final int? maxLines;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    this.width,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textAlign,
    this.maxLength,
    this.withLargeSpace,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        controller: controller,
        validator: validator,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        style: withLargeSpace == null
            ? Theme.of(context).textTheme.bodyMedium
            : Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(letterSpacing: 6.w),
        obscureText: isPassword ?? false,

        decoration: InputDecoration(
          counterText: '',
          suffixIcon: suffixIcon,
          hintText: hintText ?? '',
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
