import 'package:flutter/material.dart';

class NestedNavigationDestination {
  const NestedNavigationDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
}

extension ListNestedNavigationDestinationX on List<NestedNavigationDestination> {
  List<BottomNavigationBarItem> get asNavigationBarItems {
    return map(
      (e) => BottomNavigationBarItem(
        icon: e.icon,
        activeIcon: e.selectedIcon,
        label: e.label,
      ),
    ).toList();
  }

  List<NavigationRailDestination> get asNavigationRailDestinationItems {
    return map(
      (e) => NavigationRailDestination(
        icon: e.icon,
        selectedIcon: e.selectedIcon,
        label: Text(e.label),
      ),
    ).toList();
  }
}
