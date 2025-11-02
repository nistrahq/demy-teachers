import 'package:demy_teachers/core/errors/dio_exception_mapper.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/core/network/api_client.dart';
import 'package:demy_teachers/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:demy_teachers/features/auth/data/dtos/sign_in_request_dto.dart';
import 'package:demy_teachers/features/auth/data/dtos/sign_in_response_dto.dart';
import 'package:demy_teachers/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:demy_teachers/features/auth/data/mappers/user_mapper.dart';
import 'package:demy_teachers/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final request = SignInRequestDto(email: email, password: password);
      final response = await apiClient.post(AuthEndpoints.signIn, body: request.toJson());
      final dto = SignInResponseDto.fromJson(response.data);
      return UserMapper.fromDto(dto);
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    } catch (_) {
      throw const UnknownFailure('Unexpected error occurred');
    }
  }
}