// ...existing code...
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/attendance_bloc.dart';
import '../blocs/attendance_event.dart';
import '../blocs/attendance_state.dart';
import '../widgets/student_row.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  static const courses = <Map<String, dynamic>>[
    {'id': 101, 'name': 'Matemáticas - 8A'},
    {'id': 102, 'name': 'Historia - 8A'},
    {'id': 201, 'name': 'Física - 9B'},
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AttendanceBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar asistencia')),
      body: SafeArea(
        child: BlocConsumer<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
            }
            if (state.success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Asistencia registrada')));
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state.loading) return const Center(child: CircularProgressIndicator());

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Course selector
                  Row(
                    children: [
                      const Text('Curso:'),
                      const SizedBox(width: 12),
                      DropdownButton<int>(
                        value: state.selectedClassSessionId,
                        hint: const Text('Seleccione curso'),
                        items: courses
                            .map((c) => DropdownMenuItem<int>(
                                  value: c['id'] as int,
                                  child: Text(c['name'] as String),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) bloc.add(AttendanceCourseChanged(value));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Date picker
                  Row(
                    children: [
                      const Text('Fecha:'),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: state.date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) bloc.add(AttendanceDateChanged(picked));
                        },
                        child: Text('${state.date.year}-${state.date.month.toString().padLeft(2, '0')}-${state.date.day.toString().padLeft(2, '0')}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Students list
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.students.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final s = state.students[index];
                        final status = state.statuses.length > index ? state.statuses[index] : 'PRESENT';
                        return StudentRow(
                          name: s.name,
                          dni: s.dni,
                          status: status,
                          onStatusChanged: (newStatus) => bloc.add(AttendanceRecordStatusChanged(index, newStatus)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: state.submitting
                        ? null
                        : () {
                            bloc.add(const AttendanceSubmitRequested());
                          },
                    child: state.submitting ? const CircularProgressIndicator() : const Text('Registrar asistencia'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}