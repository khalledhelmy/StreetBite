import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/theme/extensions/theme_extensions.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class MealCardWidget extends StatelessWidget {
  final MealEntity meal;

  const MealCardWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.r,
            spreadRadius: 8.r,
            offset: const Offset(0, 4),
            color: context.isDarkMode
                ? Theme.of(context).colorScheme.onPrimary.withAlpha(10)
                : Theme.of(context).colorScheme.shadow.withAlpha(10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: meal.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => ColoredBox(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => ColoredBox(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        child: const Center(child: Icon(Icons.restaurant)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5.w,
                    top: 5.h,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(180),
                        ),
                        child: Icon(
                          Icons.favorite_outline,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    HeightSpace(2),
                    Text(
                      meal.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            'home.added_to_cart'.tr(
                              namedArgs: {'name': meal.name},
                            ),
                          ),
                        ),
                      );
                  },
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(fixedSize: Size(160.w, 40.h)),
              onPressed: () {},
              child: Text('home.view_details'.tr()),
            ),
          ),
          HeightSpace(8),
        ],
      ),
    );
  }
}
