import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/core/widgets/change_theme_widget.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:street_bite/features/favorites/presentation/widgets/favorite_meal_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.read<FavoritesCubit>().state is FavoritesInitial) {
        context.read<FavoritesCubit>().loadFavorites();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites.title'.tr(context: context)),
        actions: [const ChangeThemeWidget()],
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading || state is FavoritesInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesEmpty) {
            return Center(
              child: Text(
                'favorites.empty'.tr(context: context),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state is FavoritesError) {
            final failure = state.failure;
            final failureMessage = failure is ServerFailure
                ? failure.serverMessage ??
                      failure.messageKey.tr(context: context)
                : failure.messageKey.tr(context: context);
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(failureMessage, textAlign: TextAlign.center),
                    HeightSpace(12),
                    TextButton(
                      onPressed: context.read<FavoritesCubit>().loadFavorites,
                      child: Text('favorites.retry'.tr(context: context)),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is FavoritesLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: state.favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                final meal = state.favorites[index];
                return FavoriteMealCard(meal: meal);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
