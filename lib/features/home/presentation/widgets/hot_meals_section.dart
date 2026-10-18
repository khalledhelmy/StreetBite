import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotMealsSection extends StatelessWidget {
  final List<MealEntity> meals;

  const HotMealsSection({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 12.w, top: 12.h, bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.hot_offers'.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w, top: 12.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      width: 300.w,
                      height: 170.h,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: meal.thumbnail,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => ColoredBox(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => ColoredBox(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: const Center(
                                child: Icon(Icons.restaurant),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              color: Colors.black54,
                              child: Text(
                                meal.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
