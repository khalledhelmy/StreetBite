import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/custom_back_button.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.heroTag,
  });

  final MealEntity meal;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text('home.add_to_cart'.tr()),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  meal.thumbnail.trim().isEmpty
                      ? Container(
                          color: theme.colorScheme.primaryContainer,
                          child: Center(
                            child: Icon(Icons.restaurant, size: 40.sp),
                          ),
                        )
                      : Hero(
                          tag: heroTag,
                          child: CachedNetworkImage(
                            imageUrl: meal.thumbnail,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.restaurant)),
                          ),
                        ),
                  Positioned(top: 40.h, left: 16.w, child: CustomBackButton()),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 12.h,
                horizontal: 24.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        color: theme.colorScheme.primary,
                      ),
                      WidthSpace(8),
                      Expanded(
                        child: Text(
                          meal.category,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: theme.colorScheme.primary,
                      ),
                      WidthSpace(4),
                      Expanded(
                        child: Text(
                          meal.area,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(24),
                  Text(
                    'Instructions',
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(meal.instructions, style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
