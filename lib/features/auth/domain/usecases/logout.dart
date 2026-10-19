import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/auth/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository _repo;
  const Logout(this._repo);

  Future<Either<Failure, Unit>> call() {
    return _repo.logout();
  }
}
