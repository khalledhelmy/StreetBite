import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class Validators {
  const Validators._();

  static String? email(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.email_required'.tr(context: context);
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'validators.email_invalid'.tr(context: context);
    }

    return null;
  }

  static String? password(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'validators.password_required'.tr(context: context);
    }
    if (value.length < 8) {
      return 'validators.password_min_length'.tr(context: context);
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).+$').hasMatch(value)) {
      return 'validators.password_complexity'.tr(context: context);
    }
    return null;
  }

  static String? fullName(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.name_required'.tr(context: context);
    }

    final fullName = value.trim();

    if (fullName.length < 3) {
      return 'validators.name_min_length'.tr(context: context);
    }

    if (!RegExp(r'^[A-Z]').hasMatch(fullName)) {
      return 'validators.name_capital_letter'.tr(context: context);
    }

    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return 'validators.confirm_password_required'.tr(context: context);
    }
    if (value != password) {
      return 'validators.password_mismatch'.tr(context: context);
    }
    return null;
  }

  static String? post(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.post_required'.tr(context: context);
    }

    return null;
  }
}
