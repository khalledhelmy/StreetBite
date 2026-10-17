import 'package:dio/dio.dart';
import 'package:street_bite/core/networking/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  late final Dio dio;

  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json'},
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        requestBody: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Response<dynamic>> getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) {
    return dio.get(endPoint, queryParameters: query);
  }
}
