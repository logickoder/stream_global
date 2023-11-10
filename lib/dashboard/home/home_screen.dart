import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/assets.dart';
import '../../app/dimens.dart';
import '../../app/widgets/profile_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(AppDimens.secondaryPadding),
        child: CustomScrollView(
          slivers: [
            const _HomeAppBar(),
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimens.padding),
                  _DailyDevotional(),
                  SizedBox(height: AppDimens.padding),
                  _LiveRadio(),
                  SizedBox(height: AppDimens.padding)
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Audio and Video Sermons',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppDimens.secondaryPadding / 2),
                ],
              ),
            ),
            const _Sermons(),
          ],
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Row(
          children: [
            Expanded(
              flex: 86,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Mercy',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'What do you want to do today?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        .6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 14,
              child: ProfileAvatar(
                borderColor: theme.colorScheme.inversePrimary,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DailyDevotional extends StatelessWidget {
  const _DailyDevotional();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Devotional',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimens.secondaryPadding / 2),
        Text(
          'Today . 26-09-2023',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(.6),
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'How to live in Victory',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            children: [
              const TextSpan(text: '\n'),
              const TextSpan(
                text:
                    'God wants you to live in victory everyday of your life. But can you do that? Here are three steps to help you walk in victory',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(text: '...'),
              TextSpan(
                text: 'Read More',
                style: const TextStyle(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LiveRadio extends StatelessWidget {
  const _LiveRadio();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimens.secondaryPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(AppDimens.secondaryPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Radio',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Listen to Streamglobe Live, the online radio for Christian music and teachings. Chat with hosts and guests. ',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppDimens.secondaryPadding),
          FilledButton.icon(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssets.playIcon),
            label: const Text('Play'),
          ),
        ],
      ),
    );
  }
}

class _Sermons extends StatelessWidget {
  const _Sermons();

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppDimens.secondaryPadding / 2,
        crossAxisSpacing: AppDimens.secondaryPadding / 2,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (c, index) => _Sermon(
          index % 2 == 0 ? AppAssets.playIcon : AppAssets.musicIcon,
        ),
        childCount: 30,
      ),
    );
  }
}

class _Sermon extends StatelessWidget {
  const _Sermon(this.icon);

  final String icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppAssets.sermonImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
      ),
      padding: const EdgeInsets.all(AppDimens.secondaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            icon,
            width: AppDimens.padding,
            height: AppDimens.padding,
          ),
          const SizedBox(height: AppDimens.padding / 2),
          Text(
            'Salvation',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.surface,
            ),
          ),
          Text(
            'Pst. Akanni',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
