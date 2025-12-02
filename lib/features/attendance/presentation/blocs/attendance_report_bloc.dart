import 'package:demy_teachers/core/usecases/usecase.dart';
import 'package:demy_teachers/features/attendance/domain/entities/attendance_history.dart';
import 'package:demy_teachers/features/attendance/domain/entities/student.dart';
import 'package:demy_teachers/features/attendance/domain/entities/student_statistics.dart';
import 'package:demy_teachers/features/attendance/domain/usecases/get_attendance_history_use_case.dart';
import 'package:demy_teachers/features/attendance/domain/usecases/get_students_use_case.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_report_event.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceReportBloc extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  
  final GetStudentsUseCase getStudentsUseCase;
  final GetAttendanceHistoryUseCase getAttendanceHistoryUseCase; 

  List<AttendanceHistory> _allHistory = [];
  List<Student> _allStudents = [];

  AttendanceReportBloc({
    required this.getStudentsUseCase,
    required this.getAttendanceHistoryUseCase,
  }) : super(ReportInitial()) {
    on<LoadReportEvent>(_onLoadReport);
    on<FilterReportEvent>(_onFilterReport);
  }

  Future<void> _onLoadReport(LoadReportEvent event, Emitter<AttendanceReportState> emit) async {
    emit(ReportLoading());


    final studentsResult = await getStudentsUseCase(0); 
    final historyResult = await getAttendanceHistoryUseCase(NoParams()); // <--- USANDO USECASE

    if (studentsResult.isLeft() || historyResult.isLeft()) {
      emit(ReportFailure("Error al cargar reporte"));
      return;
    }

    _allStudents = studentsResult.getOrElse(() => []);
    _allHistory = historyResult.getOrElse(() => []);

 
    final now = DateTime.now();
    final startDate = now.subtract(const Duration(days: 30));
    final endDate = now;
    final stats = _calculateStats(startDate, endDate);

    emit(ReportLoaded(stats: stats, startDate: startDate, endDate: endDate));
  }
  

  void _onFilterReport(FilterReportEvent event, Emitter<AttendanceReportState> emit) {
    
    if (state is ReportLoaded) {
      final stats = _calculateStats(event.startDate, event.endDate);
      
      emit(ReportLoaded(
        stats: stats,
        startDate: event.startDate,
        endDate: event.endDate,
      ));
    }
  }

  List<StudentStatistics> _calculateStats(DateTime start, DateTime end) {
    
    final Map<String, Map<String, int>> counters = {};

   
    for (var s in _allStudents) {
      counters[s.dni] = {'total': 0, 'present': 0, 'absent': 0, 'excused': 0};
    }

    
    for (var record in _allHistory) {
      final recordDate = DateTime.parse(record.date);

      
      if (recordDate.isAfter(start.subtract(const Duration(days: 1))) &&
          recordDate.isBefore(end.add(const Duration(days: 1)))) {
        
        for (var item in record.attendance) {
          if (counters.containsKey(item.dni)) {
            
            counters[item.dni]!['total'] = (counters[item.dni]!['total'] ?? 0) + 1;

            
            if (item.status == 'PRESENT') {
              counters[item.dni]!['present'] = (counters[item.dni]!['present'] ?? 0) + 1;
            } else if (item.status == 'ABSENT') {
              counters[item.dni]!['absent'] = (counters[item.dni]!['absent'] ?? 0) + 1;
            } else if (item.status == 'EXCUSED' || item.status == 'LATE') {
              counters[item.dni]!['excused'] = (counters[item.dni]!['excused'] ?? 0) + 1;
            }
          }
        }
      }
    }

    
    return _allStudents.map((student) {
      final c = counters[student.dni]!;
      return StudentStatistics(
        student: student,
        totalSessions: c['total']!,
        presentCount: c['present']!,
        absentCount: c['absent']!,
        excusedCount: c['excused']!,
      );
    }).toList();
  }
}