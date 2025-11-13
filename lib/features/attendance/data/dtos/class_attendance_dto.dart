import 'attendance_record_dto.dart';

class ClassAttendanceDto {
  final int id;
  final int classSessionId;
  final String date;
  final List<AttendanceRecordDto> records;

  const ClassAttendanceDto({
    required this.id,
    required this.classSessionId,
    required this.date,
    required this.records,
  });

  factory ClassAttendanceDto.fromJson(Map<String, dynamic> json) => ClassAttendanceDto(
        id: json['id'] as int,
        classSessionId: json['classSessionId'] as int,
        date: json['date'] as String,
        records: (json['records'] as List<dynamic>?)
                ?.map((e) => AttendanceRecordDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'classSessionId': classSessionId,
        'date': date,
        'records': records.map((r) => r.toJson()).toList(),
      };
}