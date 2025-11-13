import 'package:dartz/dartz.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';

abstract class AttendanceRepository {
  Future<Either<Failure,ClassAttendance>> submitClassAttendance(int classSessionId,  DateTime date , List<AttendanceRecord> records);
  
   Future<Either<Failure, List<ClassAttendance>>> getAllClassAttendances();
}
