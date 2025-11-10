import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_bloc.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_event.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Constante de días compartida
const List<String> weekDaysShort = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

class DaySelectionBar extends StatelessWidget {
  const DaySelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (previous, current) => current is ScheduleLoaded,
      builder: (context, state) {
        String selectedDay = (state is ScheduleLoaded) ? state.selectedDay : weekDaysShort.first;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: weekDaysShort.map((day) {
              final isSelected = day.toLowerCase() == selectedDay.toLowerCase();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(day),
                  selected: isSelected,
                  selectedColor: colorScheme.primaryContainer,
                  onSelected: (_) {
                    context.read<ScheduleBloc>().add(ScheduleDayChanged(day));
                  },
                  labelStyle: TextStyle(
                    color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}