class AttendanceRecordDto {
  final int id;
  final String dni;
  final String status;

  const AttendanceRecordDto({
    required this.id,
    required this.dni,
    required this.status,
  });

  factory AttendanceRecordDto.fromJson(Map<String, dynamic> json) => AttendanceRecordDto(
        id: json['id'] as int,
        dni: json['dni'] as String,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'dni': dni,
        'status': status,
      };
}