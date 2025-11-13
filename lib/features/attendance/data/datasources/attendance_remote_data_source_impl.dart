import 'package:demy_teachers/core/network/api_client.dart';
import 'package:demy_teachers/features/attendance/data/dtos/class_attendance_dto.dart';
import 'package:demy_teachers/features/attendance/data/dtos/submit_class_attendance_request_dto.dart';
import 'package:demy_teachers/features/attendance/data/endpoints/attendance_endpoints.dart';
import 'package:demy_teachers/features/attendance/data/mappers/class_attendance_mapper.dart';
import 'package:demy_teachers/features/attendance/data/mappers/attendance_record_mapper.dart';
import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';
import 'attendance_remote_data_source.dart';

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient apiClient;

  AttendanceRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ClassAttendance> submitClassAttendance(int classSessionId, DateTime date, List<AttendanceRecord> records) async {
    // formatea fecha a 'yyyy-MM-dd'
    final d = DateTime(date.year, date.month, date.day);
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final dateStr = '$y-$m-$day';

    final req = SubmitClassAttendanceRequestDto(
      classSessionId: classSessionId,
      date: dateStr,
      attendance: records.map((r) => AttendanceRecordMapper.toRequestDto(r)).toList(),
    );

    final response = await apiClient.post(AttendanceEndpoints.create, body: req.toJson());

    final raw = response.data;
    final body = (raw is Map<String, dynamic> && raw.containsKey('data')) ? raw['data'] : raw;

    if (body is Map<String, dynamic>) {
      final dto = ClassAttendanceDto.fromJson(body);
      return ClassAttendanceMapper.fromDto(dto);
    }

    throw Exception('Invalid response format from submitClassAttendance');
  }

  @override
  Future<List<ClassAttendance>> getAllClassAttendances() async {
    final response = await apiClient.get(AttendanceEndpoints.getAll);

    final raw = response.data;
    final body = (raw is Map<String, dynamic> && raw.containsKey('data')) ? raw['data'] : raw;

    if (body is List) {
      return body
          .cast<Map<String, dynamic>>()
          .map((e) => ClassAttendanceMapper.fromDto(ClassAttendanceDto.fromJson(e)))
          .toList();
    }

    throw Exception('Invalid response format from getAllClassAttendances');
  }
}