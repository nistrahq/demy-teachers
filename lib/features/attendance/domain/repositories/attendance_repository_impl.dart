import 'package:dartz/dartz.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/core/utils/safe_call.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:demy_teachers/features/attendance/data/dtos/create_attendance_request_dto.dart';
import 'package:demy_teachers/features/attendance/domain/entities/student.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Student>>> getStudents() async {
    return safeCall(() async {
      final dtos = await remoteDataSource.getStudents();
      return dtos.map((dto) => Student(
        dni: dto.dni,
        fullName: '${dto.firstName} ${dto.lastName}',
        // photoUrl: dto.photoUrl,
      )).toList();
    });
  }

  @override
  Future<Either<Failure, void>> registerAttendance(
      int sessionId, String date, List<StudentAttendance> attendanceList) async {
    return safeCall(() async {
      final requestDto = CreateAttendanceRequestDto(
        classSessionId: sessionId,
        date: date,
        attendance: attendanceList.map((item) {
          // Mapea tu Enum al string que espera el backend
          String statusString;
          switch (item.status) {
            case AttendanceStatus.present: statusString = "PRESENT"; break;
            case AttendanceStatus.late: statusString = "LATE"; break;
            case AttendanceStatus.absent: statusString = "ABSENT"; break;
            default: statusString = "PRESENT"; // Default
          }
          return AttendanceItemDto(dni: item.student.dni, status: statusString);
        }).toList(),
      );
      
      await remoteDataSource.registerAttendance(requestDto);
    });
  }
}