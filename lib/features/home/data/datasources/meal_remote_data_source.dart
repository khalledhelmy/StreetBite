import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/error_handler.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/core/networking/api_endpoints.dart';
import 'package:street_bite/core/networking/dio_helper.dart';
import 'package:street_bite/core/storage/shared_pref_helper.dart';
import 'package:street_bite/core/storage/shared_pref_keys.dart';
import 'package:street_bite/features/home/data/models/meal_model.dart';

class MealRemoteDataSource {
  final DioHelper _dioHelper;
  final SharedPrefHelper _prefs;

  const MealRemoteDataSource(this._dioHelper, this._prefs);

  Future<Either<Failure, List<MealModel>>> getMeals() {
    return _fetchMeals('');
  }

  Future<Either<Failure, List<MealModel>>> searchMeals(String query) {
    return _fetchMeals(query);
  }

  Future<Either<Failure, List<MealModel>>> _fetchMeals(String query) async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.searchMeals,
        query: {'s': query},
      );
      final data = response.data;

      if (data is! Map) {
        throw const FormatException('Expected a meal response object.');
      }

      final meals = data['meals'];
      if (meals == null) {
        final emptyMeals = <MealModel>[];
        await _cacheMeals(query, emptyMeals);
        return Right(emptyMeals);
      }
      if (meals is! List) {
        throw const FormatException('Expected meals to be a list.');
      }

      final mealModels = _parseMeals(meals);
      await _cacheMeals(query, mealModels);
      return Right(mealModels);
    } catch (error, stackTrace) {
      try {
        final cachedMeals = _readCachedMeals(query);
        if (cachedMeals != null) {
          return Right(cachedMeals);
        }
      } catch (cacheError, cacheStackTrace) {
        return Left(handleError(cacheError, cacheStackTrace));
      }
      return Left(handleError(error, stackTrace));
    }
  }

  List<MealModel> _parseMeals(List<dynamic> meals) {
    return meals.map((meal) {
      if (meal is! Map) {
        throw const FormatException('Expected each meal to be an object.');
      }
      return MealModel.fromJson(Map<String, dynamic>.from(meal));
    }).toList();
  }

  Future<void> _cacheMeals(String query, List<MealModel> meals) async {
    final cacheKey = _cacheKey(query);
    final didCache = await _prefs.setString(
      cacheKey,
      jsonEncode(meals.map((meal) => meal.toJson()).toList()),
    );
    if (!didCache) {
      throw StateError('Failed to cache meals.');
    }
  }

  List<MealModel>? _readCachedMeals(String query) {
    final cachedJson = _prefs.getString(_cacheKey(query));
    if (cachedJson == null) {
      return null;
    }

    final decoded = jsonDecode(cachedJson);
    if (decoded is! List) {
      throw const FormatException('Expected cached meals to be a list.');
    }
    return _parseMeals(decoded);
  }

  String _cacheKey(String query) =>
      '${SharedPrefKeys.mealsCachePrefix}${query.trim().toLowerCase()}';
}
