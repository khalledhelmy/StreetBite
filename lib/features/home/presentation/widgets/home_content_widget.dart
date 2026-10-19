import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/home/presentation/widgets/hot_meals_section.dart';
import 'package:street_bite/features/home/presentation/widgets/meal_card_widget.dart';

class HomeContentWidget extends StatelessWidget {
  final List<MealEntity> meals;

  const HomeContentWidget({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HotMealsSection(meals: meals.take(5).toList()),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          sliver: SliverToBoxAdapter(
            child: Text(
              'home.all_meals'.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.72,
            ),
            itemCount: meals.length,
            itemBuilder: (context, index) => MealCardWidget(meal: meals[index]),
          ),
        ),
      ],
    );
  }
}
