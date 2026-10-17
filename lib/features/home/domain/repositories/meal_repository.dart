import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

abstract class MealRepository {
  Future<Either<Failure, List<MealEntity>>> getMeals();

  Future<Either<Failure, List<MealEntity>>> searchMeals(String query);
}
