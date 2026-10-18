import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/features/home/presentation/cubit/meals_cubit.dart';
import 'package:street_bite/features/home/presentation/widgets/home_content_widget.dart';
import 'package:street_bite/features/home/presentation/widgets/home_header_widget.dart';
import 'package:street_bite/features/home/presentation/widgets/home_shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MealsCubit>().loadMeals();
      }
    });
  }

  void _searchMeals(String query) {
    _searchQuery = query;
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        context.read<MealsCubit>().searchMeals(query);
      }
    });
  }

  void _retrySearch() {
    _searchDebounce?.cancel();
    context.read<MealsCubit>().searchMeals(_searchQuery);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeaderWidget(onSearchChanged: _searchMeals),

          Expanded(
            child: BlocBuilder<MealsCubit, MealsState>(
              builder: (context, state) {
                if (state is MealsLoading || state is MealsInitial) {
                  return const HomeShimmerWidget();
                }

                if (state is MealsLoaded) {
                  return HomeContentWidget(meals: state.meals);
                }

                if (state is MealsEmpty) {
                  return Center(child: Text('home.no_meals'.tr()));
                }

                if (state is MealsError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.failure.message,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: _retrySearch,
                            child: Text('home.retry'.tr()),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
