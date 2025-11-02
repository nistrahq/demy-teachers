// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:demy_teachers/config/app_config.dart' as _i0;
import 'package:demy_teachers/core/di/network_module.dart' as _i870;
import 'package:demy_teachers/core/network/api_client.dart' as _i552;
import 'package:demy_teachers/core/network/interceptors/auth_interceptors.dart'
    as _i99;
import 'package:demy_teachers/core/network/network_info.dart' as _i316;
import 'package:demy_teachers/core/services/token_provider.dart' as _i963;
import 'package:demy_teachers/core/storage/secure_storage.dart' as _i703;
import 'package:demy_teachers/core/storage/session_storage.dart' as _i586;
import 'package:demy_teachers/features/auth/data/datasources/auth_local_data_source.dart'
    as _i883;
import 'package:demy_teachers/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i85;
import 'package:demy_teachers/features/auth/data/di/auth_module.dart' as _i75;
import 'package:demy_teachers/features/auth/domain/repositories/auth_repository.dart'
    as _i604;
import 'package:demy_teachers/features/auth/domain/usecases/sign_in_user.dart'
    as _i859;
import 'package:demy_teachers/features/auth/presentation/blocs/auth_bloc.dart'
    as _i536;
import 'package:demy_teachers/features/splash/presentation/blocs/splash_bloc.dart'
    as _i871;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final authModule = _$AuthModule();
    gh.lazySingleton<_i0.AppConfig>(() => networkModule.appConfig());
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity());
    gh.lazySingleton<_i316.NetworkInfo>(
      () => networkModule.networkInfo(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio(gh<_i0.AppConfig>()));
    gh.lazySingleton<_i586.SessionStorage>(() => _i703.SecureStorage());
    gh.lazySingleton<_i552.ApiClient>(
      () => networkModule.apiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i85.AuthRemoteDataSource>(
      () => authModule.authRemoteDataSource(gh<_i552.ApiClient>()),
    );
    gh.lazySingleton<_i883.AuthLocalDataSource>(
      () => authModule.authLocalDataSource(gh<_i586.SessionStorage>()),
    );
    gh.lazySingleton<_i963.TokenProvider>(
      () => authModule.tokenProvider(gh<_i883.AuthLocalDataSource>()),
    );
    gh.lazySingleton<_i604.AuthRepository>(
      () => authModule.authRepository(
        gh<_i883.AuthLocalDataSource>(),
        gh<_i85.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i859.SignInUser>(
      () => authModule.signInUser(gh<_i604.AuthRepository>()),
    );
    gh.factory<_i871.SplashBloc>(
      () => _i871.SplashBloc(gh<_i604.AuthRepository>()),
    );
    gh.factory<_i536.AuthBloc>(
      () => authModule.authBloc(
        gh<_i859.SignInUser>(),
        gh<_i604.AuthRepository>(),
      ),
    );
    gh.factory<_i99.AuthInterceptor>(
      () => _i99.AuthInterceptor(gh<_i963.TokenProvider>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i870.NetworkModule {}

class _$AuthModule extends _i75.AuthModule {}
