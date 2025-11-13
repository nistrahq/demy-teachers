// ...existing code...
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';
import '../dtos/class_attendance_dto.dart';
import '../dtos/submit_class_attendance_request_dto.dart';
import 'attendance_record_mapper.dart';

class ClassAttendanceMapper {
  static ClassAttendance fromDto(ClassAttendanceDto dto) {
    return ClassAttendance(
      id: dto.id,
      classSessionId: dto.classSessionId,
      date: DateTime.parse(dto.date),
      records: dto.records.map((r) => AttendanceRecordMapper.fromDto(r)).toList(),
    );
  }

  // crea el DTO de request (formatea fecha a yyyy-MM-dd)
  static SubmitClassAttendanceRequestDto toSubmitRequest(ClassAttendance entity) {
    final d = DateTime(entity.date.year, entity.date.month, entity.date.day);
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final dateStr = '$y-$m-$day';

    return SubmitClassAttendanceRequestDto(
      classSessionId: entity.classSessionId,
      date: dateStr,
      attendance: entity.records.map((r) => AttendanceRecordMapper.toRequestDto(r)).toList(),
    );
  }
}
