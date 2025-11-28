import 'package:demy_teachers/core/network/api_client.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository_impl.dart';
import 'package:demy_teachers/features/attendance/domain/usecases/get_students_use_case.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AttendanceModule {
  @lazySingleton
  AttendanceRemoteDataSource attendanceRemoteDataSource(ApiClient client) => 
      AttendanceRemoteDataSourceImpl(client);

  @lazySingleton
  AttendanceRepository attendanceRepository(AttendanceRemoteDataSource remote) => 
      AttendanceRepositoryImpl(remote);

  @lazySingleton
  GetStudentsUseCase getStudentsUseCase(AttendanceRepository repo) => 
      GetStudentsUseCase(repo);

  @lazySingleton
  RegisterAttendanceUseCase registerAttendanceUseCase(AttendanceRepository repo) => 
      RegisterAttendanceUseCase(repo);

  // Bloc injection
  @injectable
  AttendanceBloc attendanceBloc(
      GetStudentsUseCase getStudents, 
      RegisterAttendanceUseCase register
  ) => AttendanceBloc(getStudents, register);
}