import 'package:dio/dio.dart';
import 'package:street_bite/core/errors/failures.dart';

Failure mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure('errors.timeout');
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      final data = e.response?.data;
      final serverMsg = data is Map ? data['message']?.toString() : null;
      switch (code) {
        case 401:
          return const UnauthorizedFailure();
        case 400:
          return ServerFailure(
            key: 'errors.bad_request',
            statusCode: code,
            serverMessage: serverMsg,
          );
        case 403:
          return ServerFailure(key: 'errors.forbidden', statusCode: code);
        case 404:
          return ServerFailure(key: 'errors.not_found', statusCode: code);
        default:
          return ServerFailure(statusCode: code, serverMessage: serverMsg);
      }
    case DioExceptionType.cancel:
      return const UnexpectedFailure('errors.cancelled');
    default:
      return const UnexpectedFailure();
  }
}
