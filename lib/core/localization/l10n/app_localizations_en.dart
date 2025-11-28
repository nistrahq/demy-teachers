// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Demy Teachers';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInSubtitle =>
      'Enter your credentials provided by your administrator to continue';

  @override
  String get signInButton => 'Sign in';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get homePageTitle => 'Welcome to Demy Teachers';

  @override
  String get homePagePlaceholder => 'Home content coming soon...';

  @override
  String get profilePageTitle => 'My Profile';

  @override
  String get profilePagePlaceholder => 'Profile information coming soon...';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsPagePlaceholder => 'Settings options coming soon...';

  @override
  String get registerAttendanceButtonLabel => 'Take Attendance';
}
