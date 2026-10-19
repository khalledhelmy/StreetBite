import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class AddFavorite {
  final FavoritesRepository _repository;
  const AddFavorite(this._repository);

  Future<Either<Failure, void>> call(MealEntity meal) {
    return _repository.addFavorite(meal);
  }
}
