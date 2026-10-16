import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite/core/errors/dio_error_mapper.dart';
import 'package:street_bite/core/errors/exceptions.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/core/errors/firebase_error_mapper.dart';

Failure handleError(Object error, [StackTrace? stack]) {
  if (error is FirebaseAuthException) return mapFirebaseAuthError(error);
  if (error is DioException) return mapDioError(error);

  if (error is ServerException) {
    return ServerFailure(
      statusCode: error.statusCode,
      serverMessage: error.message,
    );
  }
  if (error is CacheException) {
    return const UnexpectedFailure('errors.cache');
  }

  return const UnexpectedFailure();
}
