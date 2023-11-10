import 'package:flutter/material.dart';

import '../app/assets.dart';
import '../app/dimens.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partner with us'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: AppDimens.secondaryPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 364 / 295,
                child: Image.asset(
                  AppAssets.donateImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppDimens.padding),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    AppDimens.padding / 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.padding,
                  horizontal: AppDimens.secondaryPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Get Involved',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimens.padding / 2),
                    FractionallySizedBox(
                      widthFactor: 0.81,
                      child: Text(
                        'Let’s Change the World Together! Has God placed it in your heart to support this ministry via voluntary support? See someone’s life changed today.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppDimens.padding),
                    FractionallySizedBox(
                      widthFactor: 0.81,
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    theme.colorScheme.inversePrimary,
                              ),
                              child: const Text('Donate'),
                            ),
                          ),
                          const SizedBox(width: AppDimens.padding),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: theme.colorScheme.onPrimary,
                                side: BorderSide(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                              child: const Text('Give Online'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
