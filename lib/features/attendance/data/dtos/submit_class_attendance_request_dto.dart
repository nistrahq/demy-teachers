import 'attendance_record_request_dto.dart';

class SubmitClassAttendanceRequestDto {
  final int classSessionId;
  final String date; // transporte como 'yyyy-MM-dd' o ISO según API
  final List<AttendanceRecordRequestDto> attendance;

  const SubmitClassAttendanceRequestDto({
    required this.classSessionId,
    required this.date,
    required this.attendance,
  });

  Map<String, dynamic> toJson() => {
        'classSessionId': classSessionId,
        'date': date,
        'attendance': attendance.map((r) => r.toJson()).toList(),
      };
}