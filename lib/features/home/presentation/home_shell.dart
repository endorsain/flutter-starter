import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/application/auth_controller.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/navigation_icon.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final destinations = <_NavigationDestinationData>[
      _NavigationDestinationData(
        label: localizations.mapTab,
        icon: Icons.map_outlined,
      ),
      _NavigationDestinationData(
        label: localizations.profileTab,
        icon: Icons.person_outline,
      ),
      _NavigationDestinationData(
        label: localizations.settingsTab,
        icon: Icons.settings_outlined,
      ),
      _NavigationDestinationData(
        label: localizations.cameraTab,
        icon: Icons.camera_alt_outlined,
      ),
      _NavigationDestinationData(
        label: localizations.playgroundTab,
        icon: Icons.science_outlined,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(destinations[navigationShell.currentIndex].label),
        actions: [
          IconButton(
            tooltip: localizations.logoutAction,
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          for (var index = 0; index < destinations.length; index++)
            NavigationDestination(
              icon: NavigationIcon(
                icon: destinations[index].icon,
                selected: false,
              ),
              selectedIcon: NavigationIcon(
                icon: destinations[index].icon,
                selected: true,
              ),
              label: destinations[index].label,
            ),
        ],
      ),
    );
  }
}

class _NavigationDestinationData {
  const _NavigationDestinationData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
