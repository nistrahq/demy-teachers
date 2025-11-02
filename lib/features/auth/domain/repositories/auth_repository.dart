import 'package:demy_teachers/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String email, String password);

  Future<String?> getCachedToken();

  Future<void> signOut();
}