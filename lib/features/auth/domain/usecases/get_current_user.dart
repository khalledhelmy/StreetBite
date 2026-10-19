import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository _repo;
  const GetCurrentUser(this._repo);

  Future<Either<Failure, UserEntity?>> call() {
    return _repo.getCurrentUser();
  }
}
