// ...existing code...
import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class AttendanceInitRequested extends AttendanceEvent {
  const AttendanceInitRequested();
}

class AttendanceDateChanged extends AttendanceEvent {
  final DateTime date;
  const AttendanceDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class AttendanceCourseChanged extends AttendanceEvent {
  final int classSessionId;
  const AttendanceCourseChanged(this.classSessionId);

  @override
  List<Object?> get props => [classSessionId];
}

class AttendanceRecordStatusChanged extends AttendanceEvent {
  final int studentIndex;
  final String status; // 'PRESENT','ABSENT','AUSENT'
  const AttendanceRecordStatusChanged(this.studentIndex, this.status);

  @override
  List<Object?> get props => [studentIndex, status];
}

class AttendanceSubmitRequested extends AttendanceEvent {
  const AttendanceSubmitRequested();
}