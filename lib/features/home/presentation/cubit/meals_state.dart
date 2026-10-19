part of 'meals_cubit.dart';

abstract class MealsState extends Equatable {
  const MealsState();

  @override
  List<Object?> get props => [];
}

class MealsInitial extends MealsState {
  const MealsInitial();
}

class MealsLoading extends MealsState {
  const MealsLoading();
}

class MealsLoaded extends MealsState {
  final List<MealEntity> meals;

  MealsLoaded(List<MealEntity> meals) : meals = List.unmodifiable(meals);

  @override
  List<Object?> get props => [meals];
}

class MealsEmpty extends MealsState {
  const MealsEmpty();
}

class MealsError extends MealsState {
  final Failure failure;
  const MealsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
