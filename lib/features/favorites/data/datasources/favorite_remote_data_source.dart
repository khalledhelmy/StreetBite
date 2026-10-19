import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite/core/errors/error_handler.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/core/services/firestore_service.dart';
import 'package:street_bite/features/home/data/models/meal_model.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class FavoriteRemoteDataSource {
  final FirestoreService _firestore;
  final FirebaseAuth _firebaseAuth;

  const FavoriteRemoteDataSource(this._firestore, this._firebaseAuth);

  Future<Either<Failure, List<MealModel>>> getFavorites() async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      return const Left(UnauthorizedFailure());
    }

    try {
      final snapshot = await _favoritesCollection(userId).get();
      final favorites = snapshot.docs.map((document) {
        final data = document.data();
        data['idMeal'] ??= document.id;
        return MealModel.fromJson(data);
      }).toList();
      return Right(favorites);
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  Future<Either<Failure, Unit>> addFavorite(MealEntity meal) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      return const Left(UnauthorizedFailure());
    }
    if (meal.id.isEmpty) {
      return const Left(UnexpectedFailure());
    }

    try {
      await _favoritesCollection(
        userId,
      ).doc(meal.id).set(MealModel.fromEntity(meal).toJson());
      return const Right(unit);
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  Future<Either<Failure, Unit>> removeFavorite(String mealId) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      return const Left(UnauthorizedFailure());
    }
    if (mealId.isEmpty) {
      return const Left(UnexpectedFailure());
    }

    try {
      await _favoritesCollection(userId).doc(mealId).delete();
      return const Right(unit);
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  CollectionReference<Map<String, dynamic>> _favoritesCollection(
    String userId,
  ) => _firestore.userCollection(userId, 'favorites');
}
