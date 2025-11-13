import 'package:demy_teachers/core/network/api_client.dart';
import 'package:demy_teachers/core/services/token_provider.dart';
import 'package:demy_teachers/core/storage/session_storage.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:demy_teachers/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:demy_teachers/features/auth/data/services/auth_token_provider.dart';
import 'package:demy_teachers/features/auth/domain/repositories/auth_repository.dart';
import 'package:demy_teachers/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:demy_teachers/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  @lazySingleton
  AuthLocalDataSource authLocalDataSource(SessionStorage storage) =>
      AuthLocalDataSourceImpl(storage);

  @lazySingleton
  TokenProvider tokenProvider(AuthLocalDataSource ds) =>
      AuthTokenProvider(ds);

  @lazySingleton
  AuthRemoteDataSource authRemoteDataSource(ApiClient apiClient) =>
      AuthRemoteDataSourceImpl(apiClient);

  @lazySingleton
  AuthRepository authRepository(AuthLocalDataSource local, AuthRemoteDataSource remote) =>
      AuthRepositoryImpl(local, remote);

  @lazySingleton
  SignInUser signInUser(AuthRepository repo) => SignInUser(repo);

  @injectable
  AuthBloc authBloc(SignInUser signInUser, AuthRepository repository) =>
      AuthBloc(signInUser: signInUser, repository: repository);
}