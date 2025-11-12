import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../models/auth_response.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._apiClient, this._secureStorage);

  @override
  Future<Either<Failure, AuthResponse>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data['data']);

      // Store tokens
      await _secureStorage.write(
        key: AppConstants.accessTokenKey,
        value: authResponse.accessToken,
      );
      await _secureStorage.write(
        key: AppConstants.refreshTokenKey,
        value: authResponse.refreshToken,
      );
      await _secureStorage.write(
        key: AppConstants.userIdKey,
        value: authResponse.user.id,
      );

      return Right(authResponse);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data['data']);

      // Store tokens
      await _secureStorage.write(
        key: AppConstants.accessTokenKey,
        value: authResponse.accessToken,
      );
      await _secureStorage.write(
        key: AppConstants.refreshTokenKey,
        value: authResponse.refreshToken,
      );
      await _secureStorage.write(
        key: AppConstants.userIdKey,
        value: authResponse.user.id,
      );

      return Right(authResponse);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _secureStorage.delete(key: AppConstants.accessTokenKey);
      await _secureStorage.delete(key: AppConstants.refreshTokenKey);
      await _secureStorage.delete(key: AppConstants.userIdKey);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to logout'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final response = await _apiClient.get('/users/profile');
      final user = UserEntity.fromJson(response.data['data']);
      return Right(user);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to load profile'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await _secureStorage.read(key: AppConstants.accessTokenKey);
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return const Right(false);
    }
  }
}
