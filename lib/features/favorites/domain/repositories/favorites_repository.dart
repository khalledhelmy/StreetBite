import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<MealEntity>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(MealEntity meal);
  Future<Either<Failure, void>> removeFavorite(String mealId);
}
