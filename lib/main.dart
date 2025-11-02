import 'package:demy_teachers/config/app_config.dart';
import 'package:demy_teachers/config/logger/logger_config.dart';
import 'package:demy_teachers/core/di/injection.dart';
import 'package:demy_teachers/demy_teachers_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  final config = getIt<AppConfig>();

  LoggerConfig.init(enableLogging: config.enableLogging);
  LoggerConfig.log('Running Demy Teachers on environment: ${config.label}');
  LoggerConfig.log('Base URL: ${config.baseUrl}');

  runApp(DemyTeachersApp(config: config));
}