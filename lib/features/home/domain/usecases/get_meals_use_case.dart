import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/home/domain/repositories/meal_repository.dart';

class GetMealsUseCase {
  final MealRepository _repository;

  const GetMealsUseCase(this._repository);

  Future<Either<Failure, List<MealEntity>>> call() {
    return _repository.getMeals();
  }
}
