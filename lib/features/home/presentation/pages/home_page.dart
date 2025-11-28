import 'package:demy_teachers/features/home/presentation/widgets/quick_access_card.dart';
import 'package:demy_teachers/features/home/presentation/widgets/today_schedule_home.dart';
import 'package:demy_teachers/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:demy_teachers/features/profile/presentation/blocs/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- 1. Header Fijo (Fondo azul/morado) ---
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: colorScheme.primaryContainer, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'), 
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          String displayName = 'Usuario';
                          if (state is ProfileLoading) displayName = 'Loading...';
                          if (state is ProfileLoaded) displayName = state.teacher.fullName;

                          return Text(
                            displayName,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
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
                child: Row( 
                  children: [
                    Expanded(
                      child: QuickAccessCard(
                        icon: Icons.calendar_today,
                        title: 'Attendance Report', 
                        onTap: () {
                          context.pushNamed(
                            'take_attendance',
                            extra: {
                              'sessionId': 4, // ID de prueba (debe existir en tu BD)
                              'courseName': 'Chemistry - I239',
                            },
                          );
                        },
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
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Schedule', 
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.go('/teaching-schedule'),
                    child: Text('View all >', 
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.primary)),
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