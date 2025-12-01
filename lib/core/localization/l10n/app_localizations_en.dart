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

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get resetPasswordButton => 'Reset Password';

  @override
  String get verifyResetCodeTitle => 'Enter Verification Code';

  @override
  String get verifyResetCodeDescription =>
      'We sent a code to your email address, enter it to reset your password';

  @override
  String get verificationCodeLabel => 'Verification Code';

  @override
  String get verificationCodeHint => 'Enter code';

  @override
  String get verificationCodeRequired => 'Verification code is required';

  @override
  String get verifyCodeButton => 'Verify Code';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordDescription =>
      'Enter your new password and confirm it';

  @override
  String get oldPasswordLabel => 'Current Password';

  @override
  String get oldPasswordHint => 'Enter your current password';

  @override
  String get oldPasswordRequired => 'Current password is required';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get newPasswordHint => 'Enter your new password';

  @override
  String get newPasswordRequired => 'New password is required';

  @override
  String get newPasswordTooShort => 'Password must be at least 6 characters';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Confirm your new password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get submitButton => 'Submit';

  @override
  String get resetPasswordSuccessTitle => 'Password Reset Successful!';

  @override
  String get resetPasswordSuccessMessage =>
      'Your password has been reset successfully. You can now sign in with your new password.';

  @override
  String get goToHomeButton => 'Go to Home';
}
