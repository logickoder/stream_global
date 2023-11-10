import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/routes.dart';
import 'app/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.current(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: theme.scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      title: 'Stream Global',
      theme: theme,
      routes: AppRoutes.current,
      debugShowCheckedModeBanner: false,
    );
  }
}
