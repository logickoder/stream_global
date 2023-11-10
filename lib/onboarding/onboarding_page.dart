import 'package:flutter/material.dart';

import '../app/dimens.dart';
import 'pager_indicator.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String trailing;
  final int index;
  final int length;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onSkipPressed;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.trailing,
    required this.index,
    required this.length,
    this.buttonText = 'Next',
    this.onButtonPressed,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: onSkipPressed,
            child: const Text('Skip'),
          ),
        ),
        const Spacer(flex: 1),
        FractionallySizedBox(
          widthFactor: 0.77,
          child: Image.asset(image),
        ),
        const SizedBox(height: AppDimens.padding),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.secondaryPadding),
        FractionallySizedBox(
          widthFactor: 0.74,
          child: Text(
            trailing,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppDimens.padding),
        PagerIndicator(
          currentPage: index,
          pageCount: length,
        ),
        const Spacer(flex: 2),
        FractionallySizedBox(
          widthFactor: 0.558,
          child: FilledButton(
            onPressed: onButtonPressed,
            child: Text(buttonText),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
