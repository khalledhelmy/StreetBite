import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/home/data/datasources/meal_remote_data_source.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/home/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource _remoteDataSource;

  const MealRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<MealEntity>>> getMeals() async {
    final result = await _remoteDataSource.getMeals();
    return result.map<List<MealEntity>>((meals) => meals);
  }

  @override
  Future<Either<Failure, List<MealEntity>>> searchMeals(String query) async {
    final result = await _remoteDataSource.searchMeals(query);
    return result.map<List<MealEntity>>((meals) => meals);
  }
}
