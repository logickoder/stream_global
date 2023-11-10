import 'package:flutter/material.dart';

import '../app/assets.dart';
import '../app/data/services/onboarding_service.dart';
import '../app/routes.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          OnboardingPage(
            image: AppAssets.onboarding1,
            title: 'Welcome to Streamglobe',
            trailing:
                'Streamglobe helps you stay connected to God and grow in your faith. Whether you like reading, listening or watching, we have the right content for you.',
            index: 0,
            length: 3,
            onSkip: _finishOnboarding,
            onPressed: _nextPage,
          ),
          OnboardingPage(
            image: AppAssets.onboarding2,
            title: 'Explore our features',
            trailing:
                'Streamglobe helps you grow in God with diverse features. Enjoy sermons, radio, bible studies, picture messages, and comics.',
            index: 1,
            length: 3,
            onSkip: _finishOnboarding,
            onPressed: _nextPage,
          ),
          OnboardingPage(
            image: AppAssets.onboarding3,
            title: 'Join our family',
            trailing:
                'Access Streamglobe’s features and connect with other believers. Join us today and get stronger on your Christian journey.',
            index: 2,
            length: 3,
            buttonText: 'Get Started',
            onSkip: _finishOnboarding,
            onPressed: _finishOnboarding,
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    OnboardingService.setUserOnboarded().then((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.authChooser);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
