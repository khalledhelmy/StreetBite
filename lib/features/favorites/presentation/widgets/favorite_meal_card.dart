import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class FavoriteMealCard extends StatelessWidget {
  final MealEntity meal;

  const FavoriteMealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(
          AppRoutes.mealDetailsScreen,
          extra: (
            meal: meal,
            heroTag: 'favorite-meal-${meal.id}',
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: meal.thumbnail.trim().isEmpty
                    ? const Center(child: Icon(Icons.restaurant))
                    : Hero(
                        tag: 'favorite-meal-${meal.id}',
                        child: CachedNetworkImage(
                          imageUrl: meal.thumbnail,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.restaurant)),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.w, 8.h, 4.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),

                        Text(
                          meal.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<FavoritesCubit>().removeFavorite(meal.id),
                    icon: Icon(Icons.favorite, color: theme.colorScheme.error),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
