import 'package:demy_teachers/core/usecases/usecase.dart';
import 'package:demy_teachers/features/auth/domain/entities/user.dart';
import 'package:demy_teachers/features/auth/domain/repositories/auth_repository.dart';

class SignInParams {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });
}

class SignInUser implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignInUser(this.repository);

  @override
  Future<User> call(SignInParams params) async {
    return await repository.signIn(params.email, params.password);
  }
}