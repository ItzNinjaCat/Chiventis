import 'package:chiventis/ui/screens/create_wallet_pin.dart';
import 'package:chiventis/ui/screens/e_wallet_otp.dart';
import 'package:flutter/material.dart';
import 'package:chiventis/ui/screens/forgotten_password.dart';
import 'package:chiventis/ui/screens/bottomNav.dart';
import 'package:chiventis/ui/screens/login.dart';
import 'package:chiventis/ui/screens/settings.dart';
import 'package:chiventis/ui/screens/sign_up.dart';
import 'package:chiventis/ui/screens/sign_up_success.dart';
import 'package:chiventis/ui/screens/reset_otp.dart';
import 'package:chiventis/ui/screens/change_password.dart';

class Routes {
  static const String signUp = '/sign_up';
  static const String signUpSuccess = '/sign_up_success';
  static const String verifyWallet = '/verify_wallet';
  static const String createEWalletPin = '/create_e_wallet_pin';
  static const String login = '/login';
  static const String home = '/home';
  static const String forgotPassword = '/forgot_password';
  static const String resetOTP = '/reset_otp';
  static const String changePassword = '/reset_password';
  static const String settingsPage = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case home:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case signUpSuccess:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SignUpSuccessPage(email: args),
          );
        }
        return _errorRoute();
      case verifyWallet:
        final args = settings.arguments;
        print('args');
        print(args);
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) =>
                EWalletOtpPage(name: args['name'], email: args['email']),
          );
        } else {
          return _errorRoute();
        }
      case createEWalletPin:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => CreateEWalletPinPage(name: args),
          );
        } else {
          return _errorRoute();
        }
      case resetOTP:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ResetOtpPage(email: args),
          );
        }
        return _errorRoute();
      case changePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const SingleChildScrollView(
            child: Center(
          child: Text('Error: Page not found'),
        )),
      );
    });
  }
}
