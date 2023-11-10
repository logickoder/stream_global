import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/assets.dart';
import '../app/dimens.dart';

typedef _AboutItemData = (String, String, String);

const List<_AboutItemData> _items = [
  (
    AppAssets.churchIcon,
    'Nondenominational',
    'We are a nondenominational ministry with the vision of Streaming the world with the knowledge of God'
  ),
  (
    AppAssets.prayerIcon,
    'We Love the Lord',
    'Overwhelmed by the gift of salvation we have found in Jesus, we are committed to the joy of the Lord by fulfilling God’s purpose'
  ),
];

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: AppDimens.secondaryPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.aboutUsImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppDimens.secondaryPadding / 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppDimens.secondaryPadding),
                    Text(
                      'About Us',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.surface,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.66,
                      child: Text(
                        'We Are a nondenominational ministry',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.surface,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppDimens.secondaryPadding),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Contact Us'),
                    ),
                    const SizedBox(height: AppDimens.secondaryPadding),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.padding,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Our Ministry',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                final item = _items[index];
                return _AboutItem(
                  icon: item.$1,
                  title: item.$2,
                  description: item.$3,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: AppDimens.secondaryPadding,
              ),
              itemCount: _items.length,
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutItem extends StatelessWidget {
  const _AboutItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimens.secondaryPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: 0.178,
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: AppDimens.secondaryPadding),
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.secondaryPadding),
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
