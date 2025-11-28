// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Demy Teachers';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get signInTitle => 'Iniciar sesión';

  @override
  String get signInSubtitle =>
      'Ingrese sus credenciales otorgadas por su administrador para continuar';

  @override
  String get signInButton => 'Iniciar sesión';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get emailRequired => 'El correo electrónico es obligatorio';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get home => 'Inicio';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get homePageTitle => 'Bienvenido a Demy Teachers';

  @override
  String get homePagePlaceholder =>
      'El contenido del inicio estará disponible pronto...';

  @override
  String get profilePageTitle => 'Mi Perfil';

  @override
  String get profilePagePlaceholder =>
      'La información del perfil estará disponible pronto...';

  @override
  String get settingsPageTitle => 'Configuración';

  @override
  String get settingsPagePlaceholder =>
      'Las opciones de configuración estarán disponibles pronto...';

  @override
  String get registerAttendanceButtonLabel => 'Registrar Asistencia';
}
