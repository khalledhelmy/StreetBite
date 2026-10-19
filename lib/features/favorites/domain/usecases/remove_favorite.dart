import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavorite {
  final FavoritesRepository _repository;
  const RemoveFavorite(this._repository);

  Future<Either<Failure, void>> call(String mealId) {
    return _repository.removeFavorite(mealId);
  }
}
