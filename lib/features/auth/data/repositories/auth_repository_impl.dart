import 'package:demy_teachers/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:demy_teachers/features/auth/domain/entities/user.dart';
import 'package:demy_teachers/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<User> signIn(String email, String password) async {
    final user = await remoteDataSource.signIn(email, password);
    await localDataSource.saveToken(user.token);
    return user;
  }

  @override
  Future<String?> getCachedToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<void> signOut() async {
    await localDataSource.clearToken();
  }
}