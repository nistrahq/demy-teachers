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

  @override
  String get phoneNumberLabel => 'Número de teléfono';

  @override
  String get resetPasswordButton => 'Restablecer Contraseña';

  @override
  String get verifyResetCodeTitle => 'Ingresa tu Código de Verificación';

  @override
  String get verifyResetCodeDescription =>
      'Enviamos un código a tu correo electrónico, ingrésalo para restablecer tu contraseña';

  @override
  String get verificationCodeLabel => 'Código de Verificación';

  @override
  String get verificationCodeHint => 'Ingresa el código';

  @override
  String get verificationCodeRequired =>
      'El código de verificación es obligatorio';

  @override
  String get verifyCodeButton => 'Verificar Código';

  @override
  String get resetPasswordTitle => 'Restablecer Contraseña';

  @override
  String get resetPasswordDescription =>
      'Ingresa tu nueva contraseña y confírmala';

  @override
  String get oldPasswordLabel => 'Contraseña Actual';

  @override
  String get oldPasswordHint => 'Ingresa tu contraseña actual';

  @override
  String get oldPasswordRequired => 'La contraseña actual es obligatoria';

  @override
  String get newPasswordLabel => 'Nueva Contraseña';

  @override
  String get newPasswordHint => 'Ingresa tu nueva contraseña';

  @override
  String get newPasswordRequired => 'La nueva contraseña es obligatoria';

  @override
  String get newPasswordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get confirmPasswordLabel => 'Confirmar Contraseña';

  @override
  String get confirmPasswordHint => 'Confirma tu nueva contraseña';

  @override
  String get confirmPasswordRequired => 'Por favor confirma tu contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get submitButton => 'Enviar';

  @override
  String get resetPasswordSuccessTitle =>
      '¡Contraseña Restablecida Exitosamente!';

  @override
  String get resetPasswordSuccessMessage =>
      'Tu contraseña ha sido restablecida exitosamente. Ahora puedes iniciar sesión con tu nueva contraseña.';

  @override
  String get goToHomeButton => 'Ir al Inicio';
}
