// ...existing code...
import 'package:flutter/widgets.dart';
import '../pages/attendance_page.dart';

class AttendanceRoutes {
  static const attendance = '/attendance';

  static Map<String, WidgetBuilder> routes() => {
        attendance: (_) => AttendancePage(),
      };
}