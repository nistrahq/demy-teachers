

import 'package:dartz/dartz.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/core/usecases/usecase.dart';
import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository.dart';

class SubmitClassAttendanceParams {
  final int classSessionId;
  final DateTime date;
  final List<AttendanceRecord> records;

  SubmitClassAttendanceParams({
    required this.classSessionId,
    required this.date,
    required this.records,
  });

}

class SubmitClassAttendaceUseCase implements UseCase<Either<Failure,ClassAttendance>,SubmitClassAttendanceParams>{ 
  final AttendanceRepository repository;
  
  SubmitClassAttendaceUseCase(this.repository);

  @override
  Future<Either<Failure, ClassAttendance>> call (SubmitClassAttendanceParams params) {
    return repository.submitClassAttendance(params.classSessionId, params.date, params.records);
  }


}