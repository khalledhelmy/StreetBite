import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/utils/validators.dart';
import 'package:street_bite/core/widgets/custom_text_field.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';

class LoginBodyWidget extends StatefulWidget {
  final bool isLoading;
  const LoginBodyWidget({super.key, required this.isLoading});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'auth.email'.tr(context: context),
            controller: _emailController,
            validator: (value) => Validators.email(value, context),
          ),
          HeightSpace(20),
          CustomTextField(
            hintText: 'auth.password'.tr(context: context),
            controller: _passwordController,
            validator: (value) => Validators.password(value, context),
            isPassword: !_isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: widget.isLoading
                  ? null
                  : () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
          HeightSpace(30),
          widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: _login,
                  child: Text('auth.login'.tr(context: context)),
                ),
        ],
      ),
    );
  }
}
