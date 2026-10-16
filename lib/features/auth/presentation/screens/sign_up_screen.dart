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
import 'package:street_bite/features/auth/presentation/widgets/sign_up_body_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        final isLoading = state is AuthLoading;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(12),
                    AuthHeaderWidget(
                      title: 'auth.sign_up_title'.tr(context: context),
                    ),
                    HeightSpace(32),
                    SignUpBodyWidget(isLoading: isLoading),
                    HeightSpace(220),
                    Center(
                      child: AuthFooterWidget(
                        onTap: () {
                          GoRouter.of(
                            context,
                          ).pushReplacementNamed(AppRoutes.loginScreen);
                        },
                        firstText: 'auth.have_account'.tr(context: context),
                        secondText: 'auth.login'.tr(context: context),
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
