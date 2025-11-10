import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_bloc.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_event.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_state.dart';
import 'package:demy_teachers/features/schedule/domain/entities/class_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

// Helper Widget para la tarjeta de horario
class _SimpleHomeScheduleCard extends StatelessWidget {
  final ClassSession session;
  final Color cardColor;

  const _SimpleHomeScheduleCard({
    required this.session,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Usamos el día y mes actual para simular la fecha del mockup
    // Nota: Esto es solo para el diseño; la sesión real viene del BLoC.
    final now = DateTime.now();
    final date = now.day.toString();
    final month = DateFormat('MMM', Localizations.localeOf(context).languageCode).format(now);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Diseño de la Tarjeta de Fecha (similar a image_fd093a.png)
          Container(
            width: 50,
            height: 70, 
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(date, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                // Mes actual (Ej: Nov)
                Text(month, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white)),],
            ),
          ),
          const SizedBox(width: 12),
          // Detalles de la Clase
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título del Curso (más grande, color primario)
                Text(
                  session.course.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, 
                    color: colorScheme.primary
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text('${session.startTime} – ${session.endTime}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: colorScheme.outline),
                    const SizedBox(width: 4),
                    Text(session.classroom.campus, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.outline)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodayScheduleHome extends StatelessWidget {
  const TodayScheduleHome({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Instanciar el BLoC y pedir los datos.
    return BlocProvider(
      // Se instancia aquí para que sea independiente de la pantalla de horarios.
      create: (_) => GetIt.I<ScheduleBloc>()..add(ScheduleWeeklyScheduleRequested()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading || state is ScheduleInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ScheduleFailure) {
              return Center(child: Text('Error al cargar el horario: ${state.message}'));
            }
            if (state is ScheduleLoaded) {
              
              // 🎯 CLAVE: Se usa SOLAMENTE la lista filtrada para hoy.
              final sessionsToShow = state.dailySessions; 

              if (sessionsToShow.isEmpty) {
                return Center(child: Text('No hay clases programadas para hoy.'));
              }
              
              // 2. Muestra la lista de sesiones del día
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sessionsToShow.map((session) {
                  // Alternamos colores para el diseño del mockup
                  final index = sessionsToShow.indexOf(session);
                  final color = index.isEven 
                      ? Theme.of(context).colorScheme.primary 
                      : Theme.of(context).colorScheme.secondaryFixed; 
                  
                  return _SimpleHomeScheduleCard(
                    session: session,
                    cardColor: color, 
                  );
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}