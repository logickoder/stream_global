import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/assets.dart';
import '../app/dimens.dart';
import '../app/routes.dart';

class AuthLogoutDialog extends StatelessWidget {
  const AuthLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.padding / 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: AspectRatio(
                    aspectRatio: 140 / 170,
                    child: Image.asset(
                      AppAssets.logoutImage,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.padding),
                Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'You can always log back in any time. If you just want to switch accounts, you can add another account.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppDimens.padding),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          textStyle: theme.textTheme.bodySmall,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: AppDimens.secondaryPadding),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          (route) => false,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFDE5753),
                          textStyle: theme.textTheme.bodySmall,
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
