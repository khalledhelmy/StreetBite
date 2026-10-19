import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/change_theme_widget.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/features/home/presentation/widgets/home_search_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const HomeHeaderWidget({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        children: [
          HeightSpace(45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final name = state is AuthAuthenticated
                        ? state.user.name.trim()
                        : '';
                    final greeting = name.isEmpty
                        ? 'home.greeting_guest'.tr()
                        : 'home.greeting'.tr(namedArgs: {'name': name});

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'home.prompt'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const ChangeThemeWidget(),
            ],
          ),
          HeightSpace(12),
          HomeSearchWidget(onSearchChanged: onSearchChanged),
        ],
      ),
    );
  }
}
