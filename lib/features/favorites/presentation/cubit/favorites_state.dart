part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<MealEntity> favorites;

  FavoritesLoaded(List<MealEntity> favorites)
    : favorites = List.unmodifiable(favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoritesEmpty extends FavoritesState {
  const FavoritesEmpty();
}

class FavoritesError extends FavoritesState {
  final Failure failure;

  const FavoritesError(this.failure);

  @override
  List<Object?> get props => [failure];
}

