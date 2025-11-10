import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_bloc.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_state.dart';
import 'package:demy_teachers/features/schedule/presentation/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleBody extends StatelessWidget {
  const ScheduleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoading || state is ScheduleInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ScheduleFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error al cargar el horario: ${state.message}'),
            ),
          );
        }
        if (state is ScheduleLoaded) {
          if (state.dailySessions.isEmpty) {
            return Center(child: Text('No hay clases programadas para ${state.selectedDay}.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.dailySessions.length,
            itemBuilder: (context, index) {
              return ScheduleCard(item: state.dailySessions[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}