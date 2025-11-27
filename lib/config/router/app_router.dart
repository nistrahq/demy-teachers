import 'package:demy_teachers/core/di/injection.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_bloc.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_event.dart';
import 'package:demy_teachers/features/attendance/presentation/pages/take_attendance_page.dart'; // Asegúrate de importar esto
import 'package:demy_teachers/features/auth/presentation/navigation/auth_routes.dart';
import 'package:demy_teachers/features/home/presentation/pages/home_page.dart';
import 'package:demy_teachers/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:demy_teachers/features/profile/presentation/blocs/profile_event.dart';
import 'package:demy_teachers/features/profile/presentation/pages/profile_page.dart';
import 'package:demy_teachers/features/settings/presentation/pages/settings_page.dart';
import 'package:demy_teachers/features/splash/presentation/navigation/splash_routes.dart';
import 'package:demy_teachers/shared/widgets/bottom_navigation_bar_widget.dart';
import 'package:demy_teachers/features/schedule/presentation/navigation/schedule_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    ...splashRoutes,
    ...authRoutes,
    ...scheduleRoutes,

    GoRoute(
      path: '/take-attendance',
      name: 'take_attendance',
      builder: (context, state) {
        // Recibimos los argumentos enviados desde el botón
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return TakeAttendancePage(
          classSessionId: args['sessionId'] as int,
          courseName: args['courseName'] as String,
        );
      },
    ),

    // --- Aquí empieza el Menú con BottomNavigationBar ---
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocProvider(
          create: (_) =>
              GetIt.instance<ProfileBloc>()..add(const LoadProfileRequested()),
          child: Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavigationBarWidget(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
            ),
          ),
        );
      },

      branches: [
        // Rama Perfil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        // Rama Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        // Rama Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsPage(),

              routes: [], 
            ),
          ],
        ),
      ],
    ),
  ],
);