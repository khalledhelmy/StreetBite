import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/utils/validators.dart';
import 'package:street_bite/core/widgets/custom_text_field.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';

class SignUpBodyWidget extends StatefulWidget {
  final bool isLoading;
  const SignUpBodyWidget({super.key, required this.isLoading});

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthCubit>().signUp(
      name: _nameController.text.trim(),
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
            hintText: 'auth.name'.tr(context: context),
            controller: _nameController,
            validator: (value) => Validators.fullName(value, context),
            keyboardType: TextInputType.name,
          ),
          HeightSpace(20),
          CustomTextField(
            hintText: 'auth.email'.tr(context: context),
            controller: _emailController,
            validator: (value) => Validators.email(value, context),
            keyboardType: TextInputType.emailAddress,
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
          HeightSpace(20),
          CustomTextField(
            hintText: 'auth.confirm_password'.tr(context: context),
            controller: _confirmPasswordController,
            validator: (value) => Validators.confirmPassword(
              value,
              _passwordController.text,
              context,
            ),
            isPassword: !_isConfirmPasswordVisible,
            suffixIcon: IconButton(
              onPressed: widget.isLoading
                  ? null
                  : () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
          HeightSpace(30),
          widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: _signUp,
                  child: Text('auth.sign_up'.tr(context: context)),
                ),
        ],
      ),
    );
  }
}
