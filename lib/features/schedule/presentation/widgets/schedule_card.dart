import 'package:demy_teachers/features/schedule/domain/entities/class_session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleCard extends StatelessWidget {
  final ClassSession item;

  const ScheduleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color primaryColor = colorScheme.primary; 
    final Color accentColor = colorScheme.onSurface.withOpacity(0.4);
    final IconData checkIcon = Icons.check_circle_outline_rounded; 
    final Color rescheduleIconColor = colorScheme.error.withOpacity(0.6); 
    
    final Color cardBackgroundColor = Colors.white;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ==================================================
          // COLUMNA 1 (IZQUIERDA): ICONO Y HORA (FUERA DE LA CARD)
          // ==================================================
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                checkIcon,
                color: accentColor,
                size: 28, 
              ),
              const SizedBox(height: 8),
              Text(
                item.startTime,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                      height: 1.2, 
                    ),
              ),
              Text(
                item.endTime,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                      height: 1.2, 
                    ),
              ),
            ],
          ),
          
          const SizedBox(width: 16), // Espacio entre las columnas
          
          // ==================================================
          // COLUMNA 2 (DERECHA): CONTENIDO DE LA CLASE (ES LA CARD)
          // ==================================================
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: cardBackgroundColor, 
                borderRadius: BorderRadius.circular(16) 
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de la Clase 
                        Text(
                          item.course.name, 
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryColor, // Título en color azul
                              ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Salón de Clase
                        Row(
                          children: [
                            Icon(Icons.meeting_room_sharp, size: 16, color: colorScheme.onSurface), 
                            const SizedBox(width: 6),
                            Text(
                              item.classroom.code, 
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        
                        // Ubicación
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: colorScheme.onSurface), 
                            const SizedBox(width: 6),
                            Text(
                              item.classroom.campus, 
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Icono de reprogramación
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: IconButton(
                      icon: const Icon(Icons.edit_calendar_outlined),
                      color: rescheduleIconColor,
                      onPressed: () {
                            // 2. Navegación pasando el ID del item actual
                          context.pushNamed(
                            'reschedule',
                            pathParameters: {
                              'sessionId': item.id.toString(),
                            },
                            extra: item, // <--- AQUÍ PASAMOS EL OBJETO COMPLETO
                          );
                        },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}