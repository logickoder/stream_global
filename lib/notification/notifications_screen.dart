import 'package:flutter/material.dart';

import '../app/dimens.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: AppDimens.secondaryPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Today',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF37313A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SliverList.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'You bookmarked Pastor Bankole’s sermon',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF222741),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    '28.10.2022 04:58',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.inversePrimary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.circle,
                    color: theme.colorScheme.inversePrimary,
                    size: AppDimens.padding / 2,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
