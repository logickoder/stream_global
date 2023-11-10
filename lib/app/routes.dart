import 'package:flutter/material.dart';

import '../auth/auth_chooser_screen.dart';
import '../auth/auth_otp_screen.dart';
import '../auth/auth_screen.dart';
import '../auth/auth_type.dart';
import '../onboarding/onboarding_screen.dart';
import '../splash/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const authChooser = '/auth';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const otp = '/auth/otp';

  static Map<String, Widget Function(BuildContext)> get current => {
        splash: (context) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        authChooser: (_) => const AuthChooserScreen(),
        login: (_) => const AuthScreen(),
        register: (_) => const AuthScreen(type: AuthScreenType.register),
        otp: (_) => const AuthOtpScreen(),
      };
}
