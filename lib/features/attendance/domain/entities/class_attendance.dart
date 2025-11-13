import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';

class ClassAttendance {
  final int id;
  final int classSessionId;
  final DateTime date;
  final List<AttendanceRecord> records;

  const ClassAttendance({
    required this.id,
    required this.classSessionId,
    required this.date,
    required this.records,
  });

}