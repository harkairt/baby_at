import 'package:app/presentation/responsive/nested_navigation_destination.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:v_flutter_core/v_flutter_core.dart';

final destinations = [
  const NestedNavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
  const NestedNavigationDestination(icon: Icon(Icons.portrait), label: 'Profile'),
];

class NestedNavigation extends StatelessWidget {
  const NestedNavigation({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => ScreenTypeLayout.builder(
        mobile: (context) => ApplyThemeExtension(
          theme: ScaffoldBehavior(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              items: destinations.asNavigationBarItems,
              onTap: (value) => navigationShell.goBranch(value),
            ),
          ),
          child: navigationShell,
        ),
        tablet: (context) => ApplyThemeExtension(
          theme: ScaffoldBehavior(
            body: (context, child) {
              return Row(
                children: [
                  NavigationRail(
                    extended: false,
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: (value) => navigationShell.goBranch(value),
                    destinations: destinations.asNavigationRailDestinationItems,
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(child: Container(child: child)),
                ],
              );
            },
          ),
          child: navigationShell,
        ),
        desktop: (context) => ApplyThemeExtension(
          theme: ScaffoldBehavior(
            body: (context, child) => Row(
              children: [
                NavigationRail(
                  extended: true,
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (value) => navigationShell.goBranch(value),
                  destinations: destinations.asNavigationRailDestinationItems,
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: Container(child: child)),
              ],
            ),
          ),
          child: navigationShell,
        ),
      );
}
