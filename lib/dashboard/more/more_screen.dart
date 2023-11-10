import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_global/app/dimens.dart';

import '../../app/assets.dart';
import '../../app/routes.dart';
import '../../app/widgets/profile_avatar.dart';

typedef _MoreItem = (String, String, bool);

const List<_MoreItem> _items = [
  ('Notifications', AppAssets.notificationIcon, false),
  ('Bookmarks', AppAssets.bookmarkIcon, false),
  ('Downloads', AppAssets.downloadIcon, false),
  ('History / Recent Activity', AppAssets.historyIcon, false),
  ('Settings', AppAssets.settingIcon, true),
  ('About Us', AppAssets.infoIcon, false),
  ('Help & Support', AppAssets.helpIcon, false),
  ('Donate', AppAssets.donateIcon, true),
  ('Logout', AppAssets.logoutIcon, false),
];

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.secondaryPadding),
          children: [
            const _MoreHeader(),
            const SizedBox(height: AppDimens.padding),
            for (final item in _items) ...{
              ListTile(
                leading: SvgPicture.asset(item.$2),
                title: Text(item.$1),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppDimens.secondaryPadding,
                ),
                onTap: () => _handleClick(context, item),
              ),
              if (item.$3) ...{
                const Divider(),
              }
            },
          ],
        ),
      ),
    );
  }

  void _handleClick(BuildContext context, _MoreItem item) {
    final route = switch (item.$2) {
      AppAssets.notificationIcon => AppRoutes.notifications,
      AppAssets.settingIcon => AppRoutes.settings,
      _ => null,
    };
    if (route != null) {
      Navigator.pushNamed(context, route);
    }
  }
}

class _MoreHeader extends StatelessWidget {
  const _MoreHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.padding,
        horizontal: AppDimens.secondaryPadding,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
      ),
      child: Row(
        children: [
          const Expanded(flex: 18, child: ProfileAvatar()),
          const Spacer(flex: 2),
          Expanded(
            flex: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fola Aina',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.surface,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  'jackson@gmail.com',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.surface,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 35,
            child: FittedBox(
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.editProfile,
                ),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onPrimary,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                icon: SvgPicture.asset(AppAssets.editIcon),
                label: const Text('Edit Profile'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
