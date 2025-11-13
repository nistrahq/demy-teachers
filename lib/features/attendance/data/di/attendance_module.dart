import 'package:injectable/injectable.dart';
import 'package:demy_teachers/core/network/api_client.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_local_data_source_impl.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_local_data_source.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_remote_data_source_impl.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:demy_teachers/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:demy_teachers/features/attendance/domain/usecases/submit_class_attendance_use_case.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_bloc.dart';
@module
abstract class AttendanceModule {
  @lazySingleton
  AttendanceLocalDataSource attendanceLocalDataSource() =>
      AttendanceLocalDataSourceImpl();

  @lazySingleton
  AttendanceRemoteDataSource attendanceRemoteDataSource(ApiClient apiClient) =>
      AttendanceRemoteDataSourceImpl(apiClient: apiClient);

  @lazySingleton
  AttendanceRepository attendanceRepository(
          AttendanceLocalDataSource local, AttendanceRemoteDataSource remote) =>
      AttendanceRepositoryImpl(localDataSource: local, remoteDataSource: remote);

  // Si tienes un AttendanceBloc, regístralo aquí igual que en AuthModule:
  // @injectable
  // AttendanceBloc attendanceBloc(AttendanceRepository repo) => AttendanceBloc(repo);

    // UseCase provider
  @lazySingleton
  
SubmitClassAttendaceUseCase submitClassAttendanceUseCase(AttendanceRepository repo) =>
    SubmitClassAttendaceUseCase(repo);  

  // Bloc provider (factory - nueva instancia cuando sea requerida)
  @factoryMethod
  AttendanceBloc attendanceBloc(SubmitClassAttendaceUseCase useCase, AttendanceRepository repo) =>
      AttendanceBloc(submitUseCase: useCase, repository: repo);
}