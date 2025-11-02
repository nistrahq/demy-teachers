import 'package:demy_teachers/core/storage/session_storage.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SessionStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  static const _tokenKey = 'auth_token';

  @override
  Future<void> saveToken(String token) async =>
      await storage.save(_tokenKey, token);

  @override
  Future<String?> getToken() async =>
      await storage.read(_tokenKey);

  @override
  Future<void> clearToken() async =>
      await storage.delete(_tokenKey);
}