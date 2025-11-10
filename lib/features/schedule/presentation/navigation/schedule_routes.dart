import 'package:demy_teachers/features/schedule/presentation/pages/teaching_schedule_page.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> scheduleRoutes = [
  GoRoute(
    path: '/teaching-schedule',
    name: 'teaching_schedule', 
    builder: (context, state) => const TeachingSchedulePage(),
  ),
];