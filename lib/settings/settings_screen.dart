import 'package:flutter/material.dart';

import '../app/dimens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(AppDimens.secondaryPadding),
        child: Column(
          children: [
            const _SettingItem(
              title: 'Account Settings',
              fontWeight: FontWeight.w600,
            ),
            const _SettingItem(
              title: 'Edit Profile',
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
            const _SettingItem(
              title: 'Preferred language',
              trailing: Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ),
            _SettingItem(
              title: 'Turn on notifications',
              trailing: Switch(value: true, onChanged: (val) {}),
            ),
            const Divider(),
            const _SettingItem(
              title: 'Privacy policy',
              trailing: Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ),
            _SettingItem(
              title: 'Rate our app',
              trailing: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_outline_rounded,
                    color: index < 2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withOpacity(0.44),
                    size: AppDimens.padding,
                  ),
                ),
              ),
            ),
            const Divider(),
            const _SettingItem(
              title: 'Delete Account',
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    required this.title,
    this.fontWeight = FontWeight.w500,
    this.trailing,
  });

  final String title;
  final FontWeight fontWeight;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.padding / 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: fontWeight,
                ),
          ),
          const Spacer(),
          if (trailing != null) ...{
            trailing!,
          }
        ],
      ),
    );
  }
}
