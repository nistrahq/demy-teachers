// ...existing code...
import 'package:equatable/equatable.dart';

class StudentItem {
  final int id;
  final String name;
  final String dni;
  StudentItem({required this.id, required this.name, required this.dni});
}

class AttendanceState extends Equatable {
  final bool loading;
  final DateTime date;
  final int? selectedClassSessionId;
  final List<StudentItem> students;
  final List<String> statuses; // parallel list of statuses per student
  final bool submitting;
  final String? error;
  final bool success;

  const AttendanceState({
    required this.loading,
    required this.date,
    required this.selectedClassSessionId,
    required this.students,
    required this.statuses,
    required this.submitting,
    this.error,
    required this.success,
  });

  factory AttendanceState.initial() => AttendanceState(
        loading: false,
        date: DateTime.now(),
        selectedClassSessionId: null,
        students: const [],
        statuses: const [],
        submitting: false,
        error: null,
        success: false,
      );

  AttendanceState copyWith({
    bool? loading,
    DateTime? date,
    int? selectedClassSessionId,
    List<StudentItem>? students,
    List<String>? statuses,
    bool? submitting,
    String? error,
    bool? success,
  }) {
    return AttendanceState(
      loading: loading ?? this.loading,
      date: date ?? this.date,
      selectedClassSessionId: selectedClassSessionId ?? this.selectedClassSessionId,
      students: students ?? this.students,
      statuses: statuses ?? this.statuses,
      submitting: submitting ?? this.submitting,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props =>
      [loading, date, selectedClassSessionId, students, statuses, submitting, error, success];
}