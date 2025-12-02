import 'package:equatable/equatable.dart';

abstract class AttendanceReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadReportEvent extends AttendanceReportEvent {}


class FilterReportEvent extends AttendanceReportEvent {
  final DateTime startDate;
  final DateTime endDate;

  FilterReportEvent({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}