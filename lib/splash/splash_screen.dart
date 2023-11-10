import 'package:flutter/material.dart';

import '../app/assets.dart';
import '../app/data/services/onboarding_service.dart';
import '../app/dimens.dart';
import '../app/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // navigate to onboarding screen after 1000ms
    Future.delayed(const Duration(milliseconds: 1000), () async {
      Navigator.pushReplacementNamed(context, await _getStartRoute());
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.465,
              child: Image.asset(
                AppAssets.logo,
                color: theme.colorScheme.onPrimary,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: AppDimens.padding / 2),
            Text(
              'Streamglobe',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'The app for spiritual growth and connection',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getStartRoute() async {
    if (!(await OnboardingService.hasUserOnboarded())) {
      return AppRoutes.onboarding;
    } else {
      return AppRoutes.login;
    }
  }
}
