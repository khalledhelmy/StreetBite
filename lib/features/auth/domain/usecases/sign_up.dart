import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository _repo;
  const SignUp(this._repo);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repo.signUp(name: name, email: email, password: password);
  }
}
