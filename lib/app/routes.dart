import 'package:flutter/material.dart';

import '../splash/splash_screen.dart';

class AppRoutes {
  static const splash = '/';

  static Map<String, Widget Function(BuildContext)> get current => {
        splash: (context) => const SplashScreen(),
      };
}
