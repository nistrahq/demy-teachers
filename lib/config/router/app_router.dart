import 'package:demy_teachers/features/auth/presentation/navigation/auth_routes.dart';
import 'package:demy_teachers/features/splash/presentation/navigation/splash_routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    ...splashRoutes,
    ...authRoutes,
  ],
);