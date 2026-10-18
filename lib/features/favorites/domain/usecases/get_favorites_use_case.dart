import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class GetFavoritesUseCase {
  final FavoritesRepository _repository;
  const GetFavoritesUseCase(this._repository);

  Future<Either<Failure, List<MealEntity>>> call() {
    return _repository.getFavorites();
  }
}
