
import 'package:demy_teachers/core/constants/api_constants.dart';

class AttendanceEndpoints {
  static const String _authBase =  ApiConstants.attendanceEndpointPath;

  static const  String create = _authBase;
  static const  String getAll = '$_authBase/all';
}
