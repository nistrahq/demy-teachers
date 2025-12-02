class Student {
  final String dni;
  final String fullName;
  final String photoUrl;

  const Student({
    required this.dni, 
    required this.fullName,
    this.photoUrl = '', 
  });
}

enum AttendanceStatus { present, absent, excused, none }

class StudentAttendance {
  final Student student;
  AttendanceStatus status;

  StudentAttendance({required this.student, this.status = AttendanceStatus.none});
}