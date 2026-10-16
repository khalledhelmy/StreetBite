import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:street_bite/core/routing/app_routes.dart';

import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:street_bite/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:street_bite/features/auth/presentation/widgets/login_body_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          GoRouter.of(context).pushReplacementNamed(AppRoutes.mainScreen);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failure.message)));
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(12),
                    AuthHeaderWidget(title: 'auth.title'.tr(context: context)),
                    HeightSpace(32),
                    LoginBodyWidget(isLoading: isLoading),
                    HeightSpace(370),
                    Center(
                      child: AuthFooterWidget(
                        onTap: () {
                          GoRouter.of(
                            context,
                          ).pushReplacementNamed(AppRoutes.signUpScreen);
                        },
                        firstText: 'auth.no_account'.tr(context: context),
                        secondText: 'auth.sign_up'.tr(context: context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
