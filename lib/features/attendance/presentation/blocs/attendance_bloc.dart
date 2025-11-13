// ...existing code...
import 'package:bloc/bloc.dart';
import 'package:demy_teachers/core/errors/failure.dart';
import 'package:demy_teachers/features/attendance/domain/entities/attendance_record.dart';
import 'package:demy_teachers/features/attendance/domain/entities/class_attendance.dart';
import 'package:demy_teachers/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:demy_teachers/features/attendance/domain/usecases/submit_class_attendance_use_case.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final SubmitClassAttendaceUseCase submitUseCase;
  final AttendanceRepository repository;

  AttendanceBloc({
    required this.submitUseCase,
    required this.repository,
  }) : super(AttendanceState.initial()) {
    on<AttendanceInitRequested>(_onInit);
    on<AttendanceDateChanged>(_onDateChanged);
    on<AttendanceCourseChanged>(_onCourseChanged);
    on<AttendanceRecordStatusChanged>(_onRecordStatusChanged);
    on<AttendanceSubmitRequested>(_onSubmit);
  }

  Future<void> _onInit(AttendanceInitRequested _, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(loading: true, error: null, success: false));
    // hardcoded students (replace with real fetch later)
    final students = <StudentItem>[
      StudentItem(id: 1, name: 'Ana Pérez', dni: '12345678'),
      StudentItem(id: 2, name: 'Juan Gómez', dni: '87654321'),
      StudentItem(id: 3, name: 'María Ruiz', dni: '11223344'),
    ];
    // default statuses = PRESENT
    final statuses = List<String>.filled(students.length, 'PRESENT');
    emit(state.copyWith(loading: false, students: students, statuses: statuses));
  }

  void _onDateChanged(AttendanceDateChanged event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(date: event.date));
  }

  void _onCourseChanged(AttendanceCourseChanged event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(selectedClassSessionId: event.classSessionId));
  }

  void _onRecordStatusChanged(AttendanceRecordStatusChanged event, Emitter<AttendanceState> emit) {
    final newStatuses = List<String>.from(state.statuses);
    if (event.studentIndex >= 0 && event.studentIndex < newStatuses.length) {
      newStatuses[event.studentIndex] = event.status;
      emit(state.copyWith(statuses: newStatuses));
    }
  }

  Future<void> _onSubmit(AttendanceSubmitRequested _, Emitter<AttendanceState> emit) async {
    if (state.selectedClassSessionId == null) {
      emit(state.copyWith(error: 'Seleccione un curso antes de enviar'));
      return;
    }

    emit(state.copyWith(submitting: true, error: null, success: false));

    // construir lista de AttendanceRecord desde estado
    final records = <AttendanceRecord>[];
    for (var i = 0; i < state.students.length; i++) {
      final s = state.students[i];
      final status = state.statuses.length > i ? state.statuses[i] : 'PRESENT';
      records.add(AttendanceRecord(id: 0, dni: s.dni, status: status));
    }

    final result = await submitUseCase(SubmitClassAttendanceParams(
      classSessionId: state.selectedClassSessionId!,
      date: state.date,
      records: records,
    ));

    result.fold(
      (Failure f) => emit(state.copyWith(submitting: false, error: f.message, success: false)),
      (ClassAttendance created) => emit(state.copyWith(submitting: false, success: true, error: null)),
    );
  }
}