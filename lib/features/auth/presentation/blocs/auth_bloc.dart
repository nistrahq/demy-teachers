import 'package:demy_teachers/features/auth/domain/repositories/auth_repository.dart';
import 'package:demy_teachers/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:demy_teachers/features/auth/presentation/blocs/auth_event.dart';
import 'package:demy_teachers/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUser signInUser;
  final AuthRepository repository;

  AuthBloc({
    required this.signInUser,
    required this.repository,
  }) : super(AuthInitial()) {
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signInUser(
        SignInParams(email: event.email, password: event.password),
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure('Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.signOut();
    emit(AuthSignedOut());
  }
}