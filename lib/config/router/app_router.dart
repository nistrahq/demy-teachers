import 'package:demy_teachers/features/auth/presentation/navigation/auth_routes.dart';
import 'package:demy_teachers/features/home/presentation/pages/home_page.dart';
import 'package:demy_teachers/features/profile/presentation/pages/profile_page.dart';
import 'package:demy_teachers/features/settings/presentation/pages/settings_page.dart';
import 'package:demy_teachers/features/splash/presentation/navigation/splash_routes.dart';
import 'package:demy_teachers/shared/widgets/bottom_navigation_bar_widget.dart';
import 'package:demy_teachers/features/schedule/presentation/navigation/schedule_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    ...splashRoutes,
    ...authRoutes,
    ...scheduleRoutes,
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
            ),
          ],
        ),
      ],
    ),
  ],
);