import 'package:dartz/dartz.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn(String email, String password);

  Future<String?> getCachedToken();

  Future<Map<String, String?>> getCachedUser();

  Future<User?> getCachedUserEntity();

  Future<void> signOut();
}