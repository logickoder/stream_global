import 'package:flutter/material.dart';

import '../about/about_screen.dart';
import '../auth/auth_chooser_screen.dart';
import '../auth/auth_otp_screen.dart';
import '../auth/auth_screen.dart';
import '../auth/auth_type.dart';
import '../dashboard/dashboard_screen.dart';
import '../donate/donate_screen.dart';
import '../help/help_screen.dart';
import '../notification/notifications_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../profile/edit/edit_profile_screen.dart';
import '../settings/settings_screen.dart';
import '../splash/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const authChooser = '/auth';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const otp = '/auth/otp';
  static const dashboard = '/dashboard';
  static const editProfile = '/profile/edit';
  static const notifications = '/notifications';
  static const settings = '/settings';
  static const about = '/about';
  static const help = '/help';
  static const donate = '/donate';

  static Map<String, Widget Function(BuildContext)> get current => {
        splash: (context) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        authChooser: (_) => const AuthChooserScreen(),
        login: (_) => const AuthScreen(),
        register: (_) => const AuthScreen(type: AuthScreenType.register),
        otp: (_) => const AuthOtpScreen(),
        dashboard: (_) => const DashboardScreen(),
        editProfile: (_) => const EditProfileScreen(),
        notifications: (_) => const NotificationsScreen(),
        settings: (_) => const SettingsScreen(),
        about: (_) => const AboutScreen(),
        help: (_) => const HelpScreen(),
        donate: (_) => const DonateScreen(),
      };
}
