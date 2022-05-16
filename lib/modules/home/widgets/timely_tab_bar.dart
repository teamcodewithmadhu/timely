import 'package:flutter/material.dart';
import 'package:timely/shared/extensions.dart';

class TabItem {
  final IconData icon;
  final IconData selectedIcon;

  TabItem({
    required this.icon,
    required this.selectedIcon,
  });
}

class TimelyTabBar extends StatefulWidget {
  final TabController tabController;

  const TimelyTabBar({Key? key, required this.tabController}) : super(key: key);

  @override
  State<TimelyTabBar> createState() => _TimelyTabBarState();
}

class _TimelyTabBarState extends State<TimelyTabBar> {
  int _currentIndex = 0;

  final List<TabItem> _tabList = [
    TabItem(icon: Icons.alarm, selectedIcon: Icons.alarm),
    TabItem(icon: Icons.watch_later, selectedIcon: Icons.watch_later_outlined),
    TabItem(icon: Icons.timer, selectedIcon: Icons.timer_outlined),
    TabItem(icon: Icons.hourglass_full, selectedIcon: Icons.hourglass_empty_outlined),
  ];

  _handleChange() {
    final value = widget.tabController.animation?.value.round();

    if (value != null && value != _currentIndex) {
      setState(() {
        _currentIndex = value;
      });
    }
  }

  @override
  void initState() {
    widget.tabController.animation?.addListener(_handleChange);

    super.initState();
  }

  @override
  void dispose() {
    widget.tabController.animation?.removeListener(_handleChange);

    super.dispose();
  }

  _onTabPressed(int index) {
    widget.tabController.animateTo(
      index,
      duration: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _tabList
          .asMap()
          .entries
          .map(
            (entry) => TabBarItem(
              tabItem: entry.value,
              onPressed: () {
                _onTabPressed(entry.key);
              },
              selected: entry.key == _currentIndex,
              selectedColor: Colors.blue,
              color: context.textTheme.caption!.color!,
            ),
          )
          .toList(),
    );
  }
}

class TabBarItem extends StatelessWidget {
  final TabItem tabItem;
  final Color color;
  final Color selectedColor;
  final bool selected;
  final Function() onPressed;

  const TabBarItem({
    Key? key,
    required this.onPressed,
    required this.selected,
    required this.tabItem,
    this.color = Colors.black,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onPressed,
      icon: Icon(selected ? tabItem.icon : tabItem.selectedIcon),
      color: selected ? selectedColor : color,
    );
  }
}
