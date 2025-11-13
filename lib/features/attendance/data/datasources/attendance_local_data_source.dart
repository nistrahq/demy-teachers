import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';

abstract class AttendanceLocalDataSource {

  Future<void> cacheClassAttendances(List<ClassAttendance> attendances);


  Future<List<ClassAttendance>?> getCachedClassAttendances();
}