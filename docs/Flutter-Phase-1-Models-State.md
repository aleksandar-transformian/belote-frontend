# Flutter Phase 1: State Management & Core Models

## 🎯 Objectives
- Define all domain models (User, Game, Card, etc.)
- Implement JSON serialization with freezed
- Create BLoC pattern structure
- Set up repository interfaces
- Build base API client with dio
- Implement error handling

## ⏱️ Estimated Time: 6-8 hours

## 📋 Prerequisites
- Phase 0 completed
- Code generation tools configured
- Dependencies installed

---

## 🎴 Step 1: Card Models

Create `lib/features/game/domain/entities/card.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';
part 'card.g.dart';

enum Suit {
  @JsonValue('CLUBS')
  clubs,
  @JsonValue('DIAMONDS')
  diamonds,
  @JsonValue('HEARTS')
  hearts,
  @JsonValue('SPADES')
  spades,
}

enum Rank {
  @JsonValue('7')
  seven,
  @JsonValue('8')
  eight,
  @JsonValue('9')
  nine,
  @JsonValue('10')
  ten,
  @JsonValue('J')
  jack,
  @JsonValue('Q')
  queen,
  @JsonValue('K')
  king,
  @JsonValue('A')
  ace,
}

@freezed
class CardEntity with _$CardEntity {
  const factory CardEntity({
    required Suit suit,
    required Rank rank,
  }) = _CardEntity;

  factory CardEntity.fromJson(Map<String, dynamic> json) =>
      _$CardEntityFromJson(json);
}

extension CardEntityX on CardEntity {
  String get displayName => '${_rankName(rank)}${_suitSymbol(suit)}';
  
  int getTrumpValue() {
    switch (rank) {
      case Rank.jack:
        return 20;
      case Rank.nine:
        return 14;
      case Rank.ace:
        return 11;
      case Rank.ten:
        return 10;
      case Rank.king:
        return 4;
      case Rank.queen:
        return 3;
      default:
        return 0;
    }
  }
  
  int getNonTrumpValue() {
    switch (rank) {
      case Rank.ace:
        return 11;
      case Rank.ten:
        return 10;
      case Rank.king:
        return 4;
      case Rank.queen:
        return 3;
      case Rank.jack:
        return 2;
      default:
        return 0;
    }
  }
  
  int getValue(bool isTrump) => isTrump ? getTrumpValue() : getNonTrumpValue();
  
  String _suitSymbol(Suit suit) {
    switch (suit) {
      case Suit.clubs:
        return '♣';
      case Suit.diamonds:
        return '♦';
      case Suit.hearts:
        return '♥';
      case Suit.spades:
        return '♠';
    }
  }
  
  String _rankName(Rank rank) {
    switch (rank) {
      case Rank.seven:
        return '7';
      case Rank.eight:
        return '8';
      case Rank.nine:
        return '9';
      case Rank.ten:
        return '10';
      case Rank.jack:
        return 'J';
      case Rank.queen:
        return 'Q';
      case Rank.king:
        return 'K';
      case Rank.ace:
        return 'A';
    }
  }
}
```

---

## 👤 Step 2: User Models

Create `lib/features/auth/domain/entities/user.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String username,
    required String email,
    required int eloRating,
    required int totalGames,
    required int wins,
    required int losses,
    required DateTime createdAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

extension UserEntityX on UserEntity {
  double get winRate => totalGames > 0 ? wins / totalGames : 0.0;
  String get winRatePercentage => '${(winRate * 100).toStringAsFixed(1)}%';
}
```

Create `lib/features/auth/data/models/auth_response.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required UserEntity user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
```

---

## 🎮 Step 3: Game Models

Create `lib/features/game/domain/entities/game.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

enum GameStatus {
  @JsonValue('WAITING')
  waiting,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
}

enum GamePhase {
  @JsonValue('DEALING')
  dealing,
  @JsonValue('BIDDING')
  bidding,
  @JsonValue('DECLARING')
  declaring,
  @JsonValue('PLAYING')
  playing,
  @JsonValue('SCORING')
  scoring,
  @JsonValue('FINISHED')
  finished,
}

enum ContractType {
  @JsonValue('CLUBS')
  clubs,
  @JsonValue('DIAMONDS')
  diamonds,
  @JsonValue('HEARTS')
  hearts,
  @JsonValue('SPADES')
  spades,
  @JsonValue('NO_TRUMPS')
  noTrumps,
  @JsonValue('ALL_TRUMPS')
  allTrumps,
}

enum BidType {
  @JsonValue('PASS')
  pass,
  @JsonValue('CONTRACT')
  contract,
  @JsonValue('DOUBLE')
  double,
  @JsonValue('REDOUBLE')
  redouble,
}

@freezed
class GameEntity with _$GameEntity {
  const factory GameEntity({
    required String id,
    required List<String> team1PlayerIds,
    required List<String> team2PlayerIds,
    required GameStatus status,
    required GamePhase phase,
    required int currentDealerIndex,
    required int currentPlayerIndex,
    required int team1MatchPoints,
    required int team2MatchPoints,
    required DateTime createdAt,
    DateTime? finishedAt,
  }) = _GameEntity;

  factory GameEntity.fromJson(Map<String, dynamic> json) =>
      _$GameEntityFromJson(json);
}

@freezed
class Bid with _$Bid {
  const factory Bid({
    required String playerId,
    required BidType type,
    ContractType? contract,
    required DateTime timestamp,
  }) = _Bid;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
}

@freezed
class Declaration with _$Declaration {
  const factory Declaration({
    required String type,
    required List<String> cards,
    required int points,
    required String playerId,
  }) = _Declaration;

  factory Declaration.fromJson(Map<String, dynamic> json) =>
      _$DeclarationFromJson(json);
}

@freezed
class Trick with _$Trick {
  const factory Trick({
    required List<PlayedCard> cards,
    required String winnerId,
    required int points,
  }) = _Trick;

  factory Trick.fromJson(Map<String, dynamic> json) => _$TrickFromJson(json);
}

@freezed
class PlayedCard with _$PlayedCard {
  const factory PlayedCard({
    required String playerId,
    required Map<String, dynamic> card,
  }) = _PlayedCard;

  factory PlayedCard.fromJson(Map<String, dynamic> json) =>
      _$PlayedCardFromJson(json);
}
```

---

## 🔌 Step 4: API Client

Create `lib/core/network/api_client.dart`:

```dart
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
```

---

## 📦 Step 5: Repository Pattern

Create `lib/features/auth/domain/repositories/auth_repository.dart`:

```dart
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
```

Add dartz to pubspec.yaml:
```yaml
dependencies:
  dartz: ^0.10.1
```

---

## 🎯 Step 6: BLoC Base Structure

Create `lib/core/presentation/bloc/base_bloc.dart`:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class InitialState extends BaseState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BaseState {
  @override
  List<Object> get props => [];
}

class LoadedState<T> extends BaseState {
  final T data;
  
  const LoadedState(this.data);
  
  @override
  List<Object> get props => [data as Object];
}

class ErrorState extends BaseState {
  final String message;
  
  const ErrorState(this.message);
  
  @override
  List<Object> get props => [message];
}
```

---

## 🔐 Step 7: Auth BLoC Structure

Create `lib/features/auth/presentation/bloc/auth_event.dart`:

```dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const RegisterRequested({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
```

Create `lib/features/auth/presentation/bloc/auth_state.dart`:

```dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
```

Create `lib/features/auth/presentation/bloc/auth_bloc.dart`:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _authRepository.isAuthenticated();
    
    result.fold(
      (failure) => emit(Unauthenticated()),
      (isAuthenticated) async {
        if (isAuthenticated) {
          final profileResult = await _authRepository.getProfile();
          profileResult.fold(
            (failure) => emit(Unauthenticated()),
            (user) => emit(Authenticated(user)),
          );
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _authRepository.login(
      email: event.email,
      password: event.password,
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authResponse) => emit(Authenticated(authResponse.user)),
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _authRepository.register(
      username: event.username,
      email: event.email,
      password: event.password,
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authResponse) => emit(Authenticated(authResponse.user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(Unauthenticated());
  }
}
```

---

## 🧪 Step 8: Unit Tests

Create `test/features/auth/domain/entities/user_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/features/auth/domain/entities/user.dart';

void main() {
  group('UserEntity', () {
    test('should calculate win rate correctly', () {
      final user = UserEntity(
        id: '1',
        username: 'testuser',
        email: 'test@example.com',
        eloRating: 1000,
        totalGames: 10,
        wins: 7,
        losses: 3,
        createdAt: DateTime.now(),
      );

      expect(user.winRate, 0.7);
      expect(user.winRatePercentage, '70.0%');
    });

    test('should handle zero games', () {
      final user = UserEntity(
        id: '1',
        username: 'newuser',
        email: 'new@example.com',
        eloRating: 1000,
        totalGames: 0,
        wins: 0,
        losses: 0,
        createdAt: DateTime.now(),
      );

      expect(user.winRate, 0.0);
    });
  });
}
```

Create `test/features/auth/presentation/bloc/auth_bloc_test.dart`:

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:belote_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:belote_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:belote_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:belote_mobile/features/auth/presentation/bloc/auth_state.dart';

@GenerateMocks([AuthRepository])
import 'auth_bloc_test.mocks.dart';

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state should be AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] when login fails',
      build: () {
        when(mockAuthRepository.login(
          email: any,
          password: any,
        )).thenAnswer(
          (_) async => const Left(AuthenticationFailure('Invalid credentials')),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const LoginRequested(email: 'test@test.com', password: 'wrong'),
      ),
      expect: () => [
        AuthLoading(),
        const AuthError('Invalid credentials'),
      ],
    );
  });
}
```

---

## 🔧 Step 9: Code Generation

Run code generation for all models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `.freezed.dart` files (immutable classes)
- `.g.dart` files (JSON serialization)
- Dependency injection code

---

## ✅ Acceptance Criteria

- [ ] All domain models created with freezed
- [ ] JSON serialization works correctly
- [ ] API client can make authenticated requests
- [ ] BLoC structure is consistent across features
- [ ] Repository interfaces defined
- [ ] Error handling covers all cases
- [ ] Code generation succeeds
- [ ] Unit tests pass
- [ ] No compilation errors

---

## 🔄 Next Phase

Proceed to **Flutter Phase 2: Authentication & User Management** to implement the full authentication flow with UI.

---

## 📚 Resources

- [Freezed Package](https://pub.dev/packages/freezed)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Dio HTTP Client](https://pub.dev/packages/dio)
