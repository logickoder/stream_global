import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/assets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          Center(child: Text('Home')),
          Center(child: Text('Radio')),
          Center(child: Text('Sermons')),
          Center(child: Text('Explore')),
          Center(child: Text('More')),
        ],
      ),
      bottomSheet: _BottomBar(
        selectedIndex: _index,
        onIndexSelected: (index) => setState(() => _index = index),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.selectedIndex,
    required this.onIndexSelected,
  });

  final int selectedIndex;
  final void Function(int) onIndexSelected;

  static const routes = {
    'Home': AppAssets.homeIcon,
    'Radio': AppAssets.radioIcon,
    'Sermons': AppAssets.sermonsIcon,
    'Explore': AppAssets.exploreIcon,
    'More': AppAssets.moreIcon,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedItemColor = theme.colorScheme.inversePrimary;
    final unselectedItemColor = theme.colorScheme.onBackground.withOpacity(.33);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: routes.entries
          .mapIndexed(
            (index, route) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                route.value,
                colorFilter: ColorFilter.mode(
                  index == selectedIndex
                      ? selectedItemColor
                      : unselectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
              label: route.key,
            ),
          )
          .toList(),
      currentIndex: selectedIndex,
      onTap: onIndexSelected,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
    );
  }
}
