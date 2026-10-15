import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:street_bite/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _dataSource.login(email: email, password: password);
    return result.map<UserEntity>((user) => user);
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _dataSource.signUp(
      name: name,
      email: email,
      password: password,
    );
    return result.map<UserEntity>((user) => user);
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    final result = await _dataSource.getCurrentUser();
    return result.map<UserEntity?>((user) => user);
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return _dataSource.logout();
  }
}
