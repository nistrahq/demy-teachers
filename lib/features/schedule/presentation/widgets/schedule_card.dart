import 'package:demy_teachers/features/schedule/domain/entities/class_session.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final ClassSession item;

  const ScheduleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox/Icono de estado
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 4.0),
              child: Icon(
                Icons.check_circle, 
                color: colorScheme.primary, 
                size: 24,
              ), 
            ),
            
            // Contenido de la clase
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.startTime} - ${item.endTime}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.course.name, 
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.school, size: 16, color: colorScheme.secondary),
                      const SizedBox(width: 4),
                      Text(
                        item.course.description, 
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: colorScheme.outline),
                      const SizedBox(width: 4),
                      Text(
                        item.classroom.campus, 
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Icono de reprogramación
            IconButton(
              icon: const Icon(Icons.edit_calendar),
              color: colorScheme.error,
              onPressed: () {
                // Aquí se implementaría la navegación a la pantalla de Reschedule
                // Por ejemplo: context.go('/reschedule/${item.id}');
              },
            ),
          ],
        ),
      ),
    );
  }
}