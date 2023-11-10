import 'package:flutter/material.dart';

import '../auth/chooser/auth_chooser_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../splash/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const authChooser = '/auth';

  static Map<String, Widget Function(BuildContext)> get current => {
        splash: (context) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        authChooser: (_) => const AuthChooserScreen(),
      };
}
