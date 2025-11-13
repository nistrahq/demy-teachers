import 'dart:convert';

import 'package:demy_teachers/features/attendance/data/dtos/class_attendance_dto.dart';
import 'package:demy_teachers/features/attendance/data/mappers/class_attendance_mapper.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';
import 'attendance_local_data_source.dart';

/// Implementación simple en memoria + JSON (puedes reemplazar por SessionStorage/secure storage).
class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  static const _cacheKey = 'ATTENDANCE_CACHE';
  List<ClassAttendance>? _memoryCache;

  @override
  Future<void> cacheClassAttendances(List<ClassAttendance> attendances) async {
    _memoryCache = attendances;
    
    return;
  }

  @override
  Future<List<ClassAttendance>?> getCachedClassAttendances() async {
    return _memoryCache;
  }
}