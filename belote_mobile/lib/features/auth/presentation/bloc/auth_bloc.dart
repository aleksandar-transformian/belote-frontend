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
