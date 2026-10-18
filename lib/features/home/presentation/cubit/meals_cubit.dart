import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/home/domain/usecases/get_meals_use_case.dart';
import 'package:street_bite/features/home/domain/usecases/search_meals_use_case.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final GetMealsUseCase _getMeals;
  final SearchMealsUseCase _searchMeals;

  MealsCubit({
    required GetMealsUseCase getMeals,
    required SearchMealsUseCase searchMeals,
  }) : _getMeals = getMeals,
       _searchMeals = searchMeals,
       super(const MealsInitial());

  Future<void> loadMeals() async {
    emit(const MealsLoading());

    final result = await _getMeals();
    if (isClosed) return;

    result.fold(
      (failure) => emit(MealsError(failure)),
      (meals) => emit(meals.isEmpty ? const MealsEmpty() : MealsLoaded(meals)),
    );
  }

  Future<void> searchMeals(String query) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) {
      await loadMeals();
      return;
    }

    emit(const MealsLoading());

    final result = await _searchMeals(query: normalizedQuery);
    if (isClosed) return;

    result.fold(
      (failure) => emit(MealsError(failure)),
      (meals) => emit(meals.isEmpty ? const MealsEmpty() : MealsLoaded(meals)),
    );
  }
}
