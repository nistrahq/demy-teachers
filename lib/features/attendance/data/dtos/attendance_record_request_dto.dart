class AttendanceRecordRequestDto {
  final String dni;
  final String status;

  const AttendanceRecordRequestDto({
    required this.dni,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'dni': dni,
        'status': status,
      };
}