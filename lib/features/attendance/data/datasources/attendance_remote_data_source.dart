import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';

abstract class AttendanceRemoteDataSource {
  /// Envía asistencia y devuelve la asistencia creada (dominio).
  Future<ClassAttendance> submitClassAttendance(int classSessionId, DateTime date, List<AttendanceRecord> records);

  /// Obtiene todas las asistencias desde el backend (dominio).
  Future<List<ClassAttendance>> getAllClassAttendances();
}