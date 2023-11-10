import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/assets.dart';
import '../app/dimens.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
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
                aspectRatio: 391 / 360,
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.helpImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppDimens.secondaryPadding / 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.45,
                        child: Text(
                          'How can we help you today?',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.71,
                        child: Text(
                          'Our team is always available to help out. Feel free to reach out with any inquiries, and we’ll respond promptly',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppDimens.padding),
            ),
            SliverList.separated(
              itemBuilder: (_, index) {
                final item = _items[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimens.secondaryPadding / 2,
                    ),
                    side: const BorderSide(
                      color: Color(0xFFC1BFC2),
                      width: 1,
                    ),
                  ),
                  leading: SvgPicture.asset(item.$1),
                  title: Text(
                    item.$2,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    item.$3,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFA3A0A4),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
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

typedef _HelpItemData = (String, String, String);

const List<_HelpItemData> _items = [
  (AppAssets.chatIcon, 'Chat Support', 'Start a conversation'),
  (AppAssets.faqIcon, 'FAQs', 'Find quick answers to your questions'),
  (AppAssets.mailIcon, 'Email Support', 'Get solutions shared to your email'),
];
