import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/assets.dart';
import '../app/dimens.dart';

class AuthAccountVerifiedDialog extends StatelessWidget {
  const AuthAccountVerifiedDialog({super.key});

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
                  widthFactor: 0.44,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: SvgPicture.asset(
                      AppAssets.verified,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.padding),
                Text(
                  'Verified',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Yay! you have successfully verified your account',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppDimens.padding),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    textStyle: theme.textTheme.bodySmall,
                  ),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
