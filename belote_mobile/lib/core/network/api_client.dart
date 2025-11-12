import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  ApiClient(this._dio, this._secureStorage) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.read(key: AppConstants.accessTokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Try to refresh token
            final refreshed = await _refreshToken();
            if (refreshed) {
              // Retry the request
              return handler.resolve(await _retry(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        '${AppConstants.apiPrefix}$path',
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.apiPrefix}$path',
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        '${AppConstants.apiPrefix}$path',
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        '${AppConstants.apiPrefix}$path',
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _secureStorage.read(
        key: AppConstants.refreshTokenKey,
      );
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '${AppConstants.apiPrefix}/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        await _secureStorage.write(
          key: AppConstants.accessTokenKey,
          value: data['accessToken'],
        );
        await _secureStorage.write(
          key: AppConstants.refreshTokenKey,
          value: data['refreshToken'],
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const AuthenticationException('Unauthorized');
        } else if (statusCode! >= 500) {
          return const ServerException('Server error');
        }
        return ServerException(
          error.response?.data['error'] ?? 'Unknown error',
        );
      case DioExceptionType.cancel:
        return const ServerException('Request cancelled');
      default:
        return const NetworkException('No internet connection');
    }
  }
}
