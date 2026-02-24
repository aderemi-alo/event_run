import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers_di.dart';

class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  static const _mainPaths = {
    RoutePaths.dashboard,
    RoutePaths.events,
    RoutePaths.clients,
    RoutePaths.invoices,
    RoutePaths.inventory,
  };

  bool _isMainScreen(String location) {
    return _mainPaths.contains(location);
  }

  static const _navItems = [
    _NavItem(
      label: 'Home',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      path: RoutePaths.dashboard,
    ),
    _NavItem(
      label: 'Events',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month,
      path: RoutePaths.events,
    ),
    _NavItem(
      label: 'Clients',
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      path: RoutePaths.clients,
    ),
    _NavItem(
      label: 'Invoices',
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      path: RoutePaths.invoices,
    ),
    _NavItem(
      label: 'Inventory',
      icon: Icons.inventory_2_outlined,
      activeIcon: Icons.inventory_2,
      path: RoutePaths.inventory,
    ),
  ];

  int _currentIndex(String location) {
    for (int i = 0; i < _navItems.length; i++) {
      if (location == _navItems[i].path ||
          location.startsWith('${_navItems[i].path}/')) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _currentIndex(location);
    final isDesktop = MediaQuery.sizeOf(context).width >= 768;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            _DesktopSidebar(
              navItems: _navItems,
              selectedIndex: selectedIndex,
              onItemTap: (item) => context.go(item.path),
              onSettingsTap: () => context.go(RoutePaths.profile),
            ),
            Expanded(
              child: Column(
                children: [
                  _DesktopHeader(
                    title: _navItems[selectedIndex].label,
                    onProfileTap: () => context.go(RoutePaths.profile),
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _MobileHeader(onProfileTap: () => context.go(RoutePaths.profile)),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: _isMainScreen(location)
          ? _MobileBottomNav(
              navItems: _navItems,
              selectedIndex: selectedIndex,
              onItemTap: (index) => context.go(_navItems[index].path),
            )
          : null,
    );
  }
}

// ──────────────────────────────────────────────
// NAV ITEM MODEL
// ──────────────────────────────────────────────

class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String path;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.path,
  });
}

// ──────────────────────────────────────────────
// MOBILE HEADER
// ──────────────────────────────────────────────

class _MobileHeader extends StatelessWidget {
  final VoidCallback onProfileTap;

  const _MobileHeader({required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top + 56,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EventRun',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: onProfileTap,
              icon: Icon(Icons.settings_outlined, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// DESKTOP HEADER
// ──────────────────────────────────────────────

class _DesktopHeader extends ConsumerWidget {
  final String title;
  final VoidCallback onProfileTap;

  const _DesktopHeader({required this.title, required this.onProfileTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendor = ref.watch(vendorProvider).currentVendor;
    final displayName = vendor?.businessName ?? '';
    final initials = displayName.isNotEmpty
        ? displayName
              .split(' ')
              .take(2)
              .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
              .join()
        : '?';

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// DESKTOP SIDEBAR
// ──────────────────────────────────────────────

class _DesktopSidebar extends StatelessWidget {
  final List<_NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<_NavItem> onItemTap;
  final VoidCallback onSettingsTap;

  const _DesktopSidebar({
    required this.navItems,
    required this.selectedIndex,
    required this.onItemTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      width: 256,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            height: 64,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Text(
              'EventRun',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          ),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  ...List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    final isActive = index == selectedIndex;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Material(
                        color: isActive
                            ? primary.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => onItemTap(item),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isActive ? item.activeIcon : item.icon,
                                  size: 20,
                                  color: isActive
                                      ? primary
                                      : Colors.grey.shade600,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isActive
                                        ? primary
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Settings
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: onSettingsTap,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// MOBILE BOTTOM NAV
// ──────────────────────────────────────────────

class _MobileBottomNav extends StatelessWidget {
  final List<_NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<int> onItemTap;

  const _MobileBottomNav({
    required this.navItems,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isActive = index == selectedIndex;
              final primary = Theme.of(context).colorScheme.primary;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onItemTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isActive ? item.activeIcon : item.icon,
                        size: 24,
                        color: isActive ? primary : Colors.grey.shade500,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: isActive ? primary : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
