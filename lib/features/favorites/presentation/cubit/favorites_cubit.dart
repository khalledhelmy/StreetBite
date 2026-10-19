import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/favorites/domain/usecases/add_favorite.dart';
import 'package:street_bite/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:street_bite/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase _getFavorites;
  final AddFavorite _addFavorite;
  final RemoveFavorite _removeFavorite;

  FavoritesCubit({
    required GetFavoritesUseCase getFavorites,
    required AddFavorite addFavorite,
    required RemoveFavorite removeFavorite,
  }) : _getFavorites = getFavorites,
       _addFavorite = addFavorite,
       _removeFavorite = removeFavorite,
       super(const FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());
    await _emitFavoritesResult(await _getFavorites());
  }

  Future<void> addFavorite(MealEntity meal) async {
    emit(const FavoritesLoading());
    final result = await _addFavorite(meal);
    if (isClosed) return;

    await result.fold(
      (failure) async => emit(FavoritesError(failure)),
      (_) async => _loadFavorites(),
    );
  }

  Future<void> removeFavorite(String mealId) async {
    emit(const FavoritesLoading());
    final result = await _removeFavorite(mealId);
    if (isClosed) return;

    await result.fold(
      (failure) async => emit(FavoritesError(failure)),
      (_) async => _loadFavorites(),
    );
  }

  Future<void> _loadFavorites() async {
    final result = await _getFavorites();
    await _emitFavoritesResult(result);
  }

  Future<void> _emitFavoritesResult(
    Either<Failure, List<MealEntity>> result,
  ) async {
    if (isClosed) return;

    result.fold(
      (failure) => emit(FavoritesError(failure)),
      (favorites) => emit(
        favorites.isEmpty ? const FavoritesEmpty() : FavoritesLoaded(favorites),
      ),
    );
  }
}
