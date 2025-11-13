// ...existing code...
import 'package:dartz/dartz.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/core/utils/safe_call.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_local_data_source.dart';
import 'package:demy_teachers/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';
import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceLocalDataSource localDataSource;
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ClassAttendance>> submitClassAttendance(
      int classSessionId, DateTime date, List<AttendanceRecord> records) {
    return safeCall(() async {
      final created = await remoteDataSource.submitClassAttendance(classSessionId, date, records);
      // opcional: actualizar cache local
      final cached = await localDataSource.getCachedClassAttendances() ?? [];
      await localDataSource.cacheClassAttendances([created, ...cached]);
      return created;
    });
  }
  @override
  Future<Either<Failure, List<ClassAttendance>>> getAllClassAttendances() {
    return safeCall(() async {
      final remoteList = await remoteDataSource.getAllClassAttendances();
      await localDataSource.cacheClassAttendances(remoteList);
      return remoteList;
    });
  }
  }

// ...existing code...