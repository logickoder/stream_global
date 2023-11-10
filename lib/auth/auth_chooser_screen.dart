import 'package:flutter/material.dart';

import '../app/assets.dart';
import '../app/dimens.dart';
import '../app/routes.dart';

class AuthChooserScreen extends StatelessWidget {
  const AuthChooserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.authChooserImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: double.infinity,
              color: theme.colorScheme.onSurface.withOpacity(0.72),
              padding: const EdgeInsets.symmetric(
                vertical: AppDimens.secondaryPadding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.surface,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.65,
                    child: Text(
                      'Contrary to popular belief, Lorem Ipsum is not simply.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.surface,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppDimens.secondaryPadding * 2),
                  FractionallySizedBox(
                    widthFactor: 0.74,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.surface,
                        foregroundColor: theme.colorScheme.onSurface,
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.register,
                      ),
                      child: const Text('Sign me up'),
                    ),
                  ),
                  const SizedBox(height: AppDimens.secondaryPadding / 2),
                  FractionallySizedBox(
                    widthFactor: 0.74,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.surface,
                        side: BorderSide(color: theme.colorScheme.surface),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.login,
                      ),
                      child: const Text('Already have an account'),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.74,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.surface,
                      ),
                      onPressed: () {},
                      child: const Text('Continue as a guest'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
