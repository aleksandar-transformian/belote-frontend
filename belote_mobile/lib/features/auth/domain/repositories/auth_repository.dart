import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../../data/models/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> register({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity>> getProfile();

  Future<Either<Failure, bool>> isAuthenticated();
}
