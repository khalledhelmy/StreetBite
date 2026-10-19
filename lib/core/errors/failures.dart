import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String messageKey;
  const Failure(this.messageKey);

  String get message => messageKey.tr();

  @override
  List<Object?> get props => [messageKey];
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? serverMessage;

  const ServerFailure({
    String key = 'errors.server',
    this.statusCode,
    this.serverMessage,
  }) : super(key);

  @override
  String get message => serverMessage ?? messageKey.tr();

  @override
  List<Object?> get props => [messageKey, statusCode, serverMessage];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.key = 'errors.network']);
}

class AuthFailure extends Failure {
  final String code;
  const AuthFailure(super.key, {this.code = 'unknown'});

  @override
  List<Object?> get props => [messageKey, code];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('errors.unauthorized');
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.key = 'errors.unexpected']);
}
