import 'package:demy_teachers/core/di/injection.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_bloc.dart';
import 'package:demy_teachers/features/attendance/presentation/blocs/attendance_event.dart';
import 'package:demy_teachers/features/attendance/presentation/pages/attendance_page.dart';
import 'package:demy_teachers/features/auth/presentation/navigation/auth_routes.dart';
import 'package:demy_teachers/features/home/presentation/pages/home_page.dart';
import 'package:demy_teachers/features/profile/presentation/pages/profile_page.dart';
import 'package:demy_teachers/features/settings/presentation/pages/settings_page.dart';
import 'package:demy_teachers/features/splash/presentation/navigation/splash_routes.dart';
import 'package:demy_teachers/shared/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    ...splashRoutes,
    ...authRoutes,
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBarWidget(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsPage(),
              routes: [
                GoRoute(
                  path: 'attendance',
                  name: 'attendance',
                  builder: (context, state) {
                    
                    final bloc = getIt<AttendanceBloc>()
                      ..add(const AttendanceInitRequested());
                    return BlocProvider.value(
                      value: bloc,
                      child: const AttendancePage(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);