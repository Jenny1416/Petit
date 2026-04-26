import 'package:flutter/material.dart';

import 'package:petit/features/auth/presentation/pages/splash_page.dart';
import 'package:petit/features/auth/presentation/pages/onboarding_page.dart';
import 'package:petit/features/auth/presentation/pages/login_page.dart';
import 'package:petit/features/auth/presentation/pages/create_account_page.dart';
import 'package:petit/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:petit/features/auth/presentation/pages/new_password_page.dart';
import 'package:petit/features/home/presentation/pages/home_page.dart';
import 'package:petit/features/auth/presentation/pages/forgot_password_sent_page.dart';
import 'package:petit/features/auth/presentation/pages/password_updated_page.dart';
import 'package:petit/features/auth/presentation/pages/onboarding_page_01.dart';
import 'package:petit/features/auth/presentation/pages/onboarding_page_02.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String newPassword = '/new-password';
  static const String home = '/home';
  static const String forgotPasswordSent = '/forgot-password-sent';
  static const String passwordUpdated = '/password-updated';
  static const String onboardingPage01 = '/onboarding-page-01';
  static const String onboardingPage02 = '/onboarding-page-02';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case register:
        return MaterialPageRoute(builder: (_) => const CreateAccountPage());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordPage());

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case onboardingPage01:
        return MaterialPageRoute(builder: (_) => const OnboardingPage01());

      case onboardingPage02:
        return MaterialPageRoute(builder: (_) => const OnboardingPage02());

      case forgotPasswordSent:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordSentPage(),
        );

      case passwordUpdated:
        return MaterialPageRoute(builder: (_) => const PasswordUpdatedPage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
        );
    }
  }
}
