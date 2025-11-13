import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import '../dtos/attendance_record_dto.dart';
import '../dtos/attendance_record_request_dto.dart';

class AttendanceRecordMapper {
  static AttendanceRecord fromDto(AttendanceRecordDto dto) {
    return AttendanceRecord(id: dto.id, dni: dto.dni, status: dto.status);
  }

  static AttendanceRecordDto toDto(AttendanceRecord entity) {
    return AttendanceRecordDto(id: entity.id, dni: entity.dni, status: entity.status);
  }

  // para construir el payload de envío (sin id)
  static AttendanceRecordRequestDto toRequestDto(AttendanceRecord entity) {
    return AttendanceRecordRequestDto(dni: entity.dni, status: entity.status);
  }
}