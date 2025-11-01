import 'package:demy_teachers/config/environment.dart';

class AppConfig {
  final Environment environment;
  final String baseUrl;
  final bool enableLogging;

  const AppConfig({
    required this.environment,
    required this.baseUrl,
    this.enableLogging = false,
  });

  static AppConfig forEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        return const AppConfig(
          environment: Environment.dev,
          baseUrl: 'https://dev.api.demy.app',
          enableLogging: true,
        );
      case Environment.prod:
        return const AppConfig(
          environment: Environment.prod,
          baseUrl: 'https://api.demy.app',
          enableLogging: false,
        );
    }
  }
  
  String get label => environment.name.toUpperCase();

  @override
  String toString() {
    return 'AppConfig(environment: $environment, baseUrl: $baseUrl, enableLogging: $enableLogging)';
  }
}
