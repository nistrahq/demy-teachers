import 'package:demy_teachers/features/home/presentation/widgets/quick_access_card.dart';
import 'package:demy_teachers/features/home/presentation/widgets/today_schedule_home.dart'; // 🎯 Importar el nuevo componente
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const teacherName = 'Paul Salim Crispin Vilca'; 

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- 1. Header Fijo (Fondo azul/morado) ---
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 20.0),
              color: colorScheme.primaryContainer, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bloque de Perfil (Paul Salim Crispin Vilca)
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'), 
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        teacherName,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  
                  
                ],
              ),
            ),
          ),
          
          // 🎯 2. SLIVER DE TARJETAS DE ACCESO RÁPIDO (DEBAJO DEL ÁREA AZUL)
          SliverToBoxAdapter(
            child: Padding(
              // Padding superior normal (20.0) para un margen de separación del header azul.
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0), 
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo de la tarjeta blanca
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(0.2), 
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                // ❌ Ya no necesitamos IntrinsicHeight ni Transform.translate.
                child: Row( 
                  children: [
                    Expanded(
                      child: QuickAccessCard(
                        icon: Icons.calendar_today,
                        title: 'Attendance Report', 
                        onTap: () {},
                      ),
                    ),
                    
                    // DIVISOR GRIS SUAVE 1
                    Container(width: 1, height: 90, color: colorScheme.outlineVariant.withOpacity(0.3)),

                    Expanded(
                      child: QuickAccessCard(
                        icon: Icons.access_time,
                        title: 'Teaching Schedule', 
                        onTap: () => context.go('/teaching-schedule'),
                      ),
                    ),

                    // DIVISOR GRIS SUAVE 2
                    Container(width: 1, height: 90, color: colorScheme.outlineVariant.withOpacity(0.3)),
                    
                    Expanded(
                      child: QuickAccessCard(
                        icon: Icons.notifications,
                        title: 'View Notifications',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          // --- 3. Agenda del Día (Today Schedule Header) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Schedule', 
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.go('/teaching-schedule'),
                    child: Text('View all >', style: TextStyle(color: colorScheme.primary)),
                  ),
                ],
              ),
            ),
          ),
          
          // 🎯 4. LISTA DE HORARIOS DEL DÍA (TodayScheduleHome)
          SliverToBoxAdapter(
            child: TodayScheduleHome(), 
          ),
          
        ],
      ),
    );
  }
}