import 'package:demy_teachers/features/schedule/domain/entities/class_session.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/reschedule_bloc.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/reschedule_event.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/reschedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class TeachingReschedulePage extends StatefulWidget {
  final ClassSession session; // Recibimos el objeto completo

  const TeachingReschedulePage({super.key, required this.session});
  
  @override
  State<TeachingReschedulePage> createState() => _TeachingReschedulePageState();
}

class _TeachingReschedulePageState extends State<TeachingReschedulePage> {
  
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late String selectedDay;
  
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    // 1. Inicializamos los valores con los datos que vienen del item (ClassSession)
    startTime = _parseTimeString(widget.session.startTime);
    endTime = _parseTimeString(widget.session.endTime);
    selectedDay = widget.session.dayOfWeek;
    // Nota: Asegúrate que dayOfWeek venga en formato "Monday", "Tuesday", etc.
    // O ten una función que lo capitalice correctamente.
  }

  // Helper para convertir "18:00:00" -> TimeOfDay(18, 0)
  TimeOfDay _parseTimeString(String timeString) {
    try {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0); // Fallback por seguridad
    }
  }

  // Lógica para saber si el usuario modificó algo
  bool get _hasChanges {
    final originalStart = _parseTimeString(widget.session.startTime);
    final originalEnd = _parseTimeString(widget.session.endTime);
    
    return startTime != originalStart ||
           endTime != originalEnd ||
           selectedDay != widget.session.dayOfWeek;
  }

  // --- LÓGICA DEL TIME PICKER (Dial) ---
  Future<void> _pickTime({required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
      builder: (context, child) {
        // Opcional: Esto fuerza el tema claro si tu app es oscura, o viceversa
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  // --- LÓGICA DEL DAY PICKER (SimpleDialog) ---
  Future<void> _pickDay() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Day'),
          children: daysOfWeek.map((day) {
            return SimpleDialogOption(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              onPressed: () {
                setState(() {
                  selectedDay = day;
                });
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(day, style: const TextStyle(fontSize: 16)),
                  if (selectedDay == day)
                    Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 20),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // Helper para formatear TimeOfDay a String 24h para la API (ej: "18:30:00")
  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<RescheduleBloc>(),
      child: BlocConsumer<RescheduleBloc, RescheduleState>(
        listener: (context, state) {
          if (state is RescheduleSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rescheduled successfully!')));
            context.pop(); // Volver atrás
          }
          if (state is RescheduleFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Teaching Reschedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Grupo de campos blancos redondeados
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildSelectionTile(
                              icon: Icons.calendar_today,
                              title: "Day of Week",
                              value: selectedDay,
                              onTap: _pickDay,
                            ),
                            const Divider(height: 1, indent: 50),
                            _buildSelectionTile(
                              icon: Icons.access_time,
                              title: "Start Time",
                              value: startTime.format(context),
                              onTap: () => _pickTime(isStartTime: true),
                            ),
                            const Divider(height: 1, indent: 50),
                            _buildSelectionTile(
                              icon: Icons.access_time_filled,
                              title: "End Time",
                              value: endTime.format(context),
                              onTap: () => _pickTime(isStartTime: false), 
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Campos grises (solo lectura o secundarios)
                      _buildReadOnlyField("Course: ${widget.session.course.name} - ${widget.session.course.code}"),
                      const SizedBox(height: 12),
                      _buildReadOnlyField("Campus: ${widget.session.classroom.campus} - Classroom: ${widget.session.classroom.code}"),
                    ],
                  ),
                ),

                // Botones inferiores
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: (_hasChanges && state is! RescheduleLoading)
                            ? () {
                                context.read<RescheduleBloc>().add(SubmitReschedule(
                                  sessionId: widget.session.id,
                                  classroomId: widget.session.classroom.id,
                                  startTime: _formatTimeForApi(startTime), 
                                  endTime: _formatTimeForApi(endTime),
                                  dayOfWeek: selectedDay.toUpperCase(),
                                ));
                              }
                              : null,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.grey[300], // Color desactivado visualmente en la imagen, ajusta según tema
                            foregroundColor: Colors.black54,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: state is RescheduleLoading 
                            ? const CircularProgressIndicator.adaptive() 
                            : const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

Widget _buildSelectionTile({required IconData icon, required String title, required String value, required VoidCallback onTap}) {
    return Material( // Añadido Material para el efecto Ripple al tocar
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Para que el ripple respete bordes si es el primero/último
        child: Padding( // Moví el padding dentro del InkWell para mejor área de toque
          padding: const EdgeInsets.symmetric(vertical: 4.0), 
          child: ListTile(
            leading: Icon(icon, color: Colors.grey[700]),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E9F0), // Gris claro estilo input disabled
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(text.contains("Course") ? Icons.book : Icons.location_on, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Text(text, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}