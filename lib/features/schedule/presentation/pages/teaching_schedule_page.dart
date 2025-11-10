import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_bloc.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_event.dart';
import 'package:demy_teachers/features/schedule/presentation/widgets/day_selection_bar.dart';
import 'package:demy_teachers/features/schedule/presentation/widgets/schedule_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TeachingSchedulePage extends StatelessWidget {
  const TeachingSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Inyecta el BLoC y lanza el evento inicial
    return BlocProvider(
      create: (_) => GetIt.I<ScheduleBloc>()..add(ScheduleWeeklyScheduleRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teaching Schedule'),
          centerTitle: true,
          // El icono de flecha atrás se hereda o lo maneja el GoRouter
        ),
        body: const Column(
          children: [
            DaySelectionBar(), // Usa el widget de barra de días
            Expanded(
              child: ScheduleBody(), // Usa el widget de cuerpo de horario
            ),
          ],
        ),
      ),
    );
  }
}