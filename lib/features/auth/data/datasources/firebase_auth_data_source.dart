import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite/core/errors/error_handler.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/auth/data/models/user_model.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  const FirebaseAuthDataSource(this._firebaseAuth);

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return const Left(UnexpectedFailure('auth_errors.failed'));
      }

      return Right(UserModel.fromFirebaseUser(user));
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  Future<Either<Failure, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        return const Left(UnexpectedFailure('auth_errors.failed'));
      }
      await user.updateDisplayName(name);
      await user.reload();
      return Right(UserModel.fromFirebaseUser(user));
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  Future<Either<Failure, Unit>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(unit);
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return Right(user == null ? null : UserModel.fromFirebaseUser(user));
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }
}
