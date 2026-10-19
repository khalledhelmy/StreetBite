import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite/features/auth/domain/usecases/get_current_user.dart';
import 'package:street_bite/features/auth/domain/usecases/login.dart';
import 'package:street_bite/features/auth/domain/usecases/logout.dart';
import 'package:street_bite/features/auth/domain/usecases/sign_up.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login _login;
  final SignUp _signUp;
  final Logout _logout;
  final GetCurrentUser _getCurrentUser;
  AuthCubit({
    required Login login,
    required SignUp signUp,
    required Logout logout,
    required GetCurrentUser getCurrentUser,
  }) : _login = login,
       _signUp = signUp,
       _logout = logout,
       _getCurrentUser = getCurrentUser,
       super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    final res = await _getCurrentUser();

    res.fold(
      (failure) {
        AuthError(failure);
      },
      (user) {
        if (user == null) {
          emit(AuthUnauthenticated());
        } else {
          emit(AuthAuthenticated(user));
        }
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    final res = await _login(email: email, password: password);
    res.fold(
      (failure) {
        emit(AuthError(failure));
      },
      (user) {
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final res = await _signUp(name: name, email: email, password: password);
    res.fold(
      (failure) {
        emit(AuthError(failure));
      },
      (user) {
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> logout() async {
    final res = await _logout();

    res.fold(
      (failure) {
        emit(AuthError(failure));
      },
      (_) {
        emit(AuthUnauthenticated());
      },
    );
  }
}
