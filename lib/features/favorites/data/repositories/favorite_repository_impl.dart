import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:street_bite/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class FavoriteRepositoryImpl implements FavoritesRepository {
  final FavoriteRemoteDataSource _remoteDataSource;
  const FavoriteRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> addFavorite(MealEntity meal) {
    return _remoteDataSource.addFavorite(meal);
  }

  @override
  Future<Either<Failure, List<MealEntity>>> getFavorites() async {
    final result = await _remoteDataSource.getFavorites();

    return result.fold((failure) => Left(failure), (meals) => Right(meals));
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String mealId) {
    return _remoteDataSource.removeFavorite(mealId);
  }
}
