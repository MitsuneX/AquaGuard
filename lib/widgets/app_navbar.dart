import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

enum NavPage {
  home,
  water,
  sanitation,
  dashboard,
  calculator,
  action,
  about,
}

class AppNavbar extends StatefulWidget {
  final NavPage currentPage;
  final Function(NavPage) onNavigate;

  const AppNavbar({
    super.key,
    required this.currentPage,
    required this.onNavigate,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  bool _mobileMenuOpen = false;

  static const List<_NavItem> _navItems = [
    _NavItem(page: NavPage.home, label: 'Home', icon: Icons.home_outlined),
    _NavItem(page: NavPage.water, label: 'Water', icon: Icons.water_drop_outlined),
    _NavItem(page: NavPage.sanitation, label: 'Sanitation', icon: Icons.clean_hands_outlined),
    _NavItem(page: NavPage.dashboard, label: 'Dashboard', icon: Icons.bar_chart_outlined),
    _NavItem(page: NavPage.calculator, label: 'Calculator', icon: Icons.calculate_outlined),
    _NavItem(page: NavPage.action, label: 'Take Action', icon: Icons.eco_outlined),
    _NavItem(page: NavPage.about, label: 'About', icon: Icons.info_outline),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.deepOcean.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: 0,
              ),
              child: SizedBox(
                height: 64,
                child: Row(
                  children: [
                    // Logo
                    GestureDetector(
                      onTap: () => widget.onNavigate(NavPage.home),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: AppColors.cardGradient,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('💧', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'AquaGuard',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepOcean,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Desktop nav items
                    if (!isMobile)
                      Row(
                        children: _navItems.map((item) {
                          final isActive = widget.currentPage == item.page;
                          return _DesktopNavItem(
                            item: item,
                            isActive: isActive,
                            onTap: () => widget.onNavigate(item.page),
                          );
                        }).toList(),
                      ),

                    // Mobile menu button
                    if (isMobile)
                      IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            _mobileMenuOpen ? Icons.close : Icons.menu,
                            key: ValueKey(_mobileMenuOpen),
                            color: AppColors.deepOcean,
                          ),
                        ),
                        onPressed: () {
                          setState(() => _mobileMenuOpen = !_mobileMenuOpen);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Mobile drawer
          if (isMobile && _mobileMenuOpen)
            _MobileMenu(
              items: _navItems,
              currentPage: widget.currentPage,
              onNavigate: (page) {
                setState(() => _mobileMenuOpen = false);
                widget.onNavigate(page);
              },
            ),
        ],
      ),
    );
  }
}

class _NavItem {
  final NavPage page;
  final String label;
  final IconData icon;

  const _NavItem({
    required this.page,
    required this.label,
    required this.icon,
  });
}

class _DesktopNavItem extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _DesktopNavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primaryBlue.withOpacity(0.1)
                : _hovered
                    ? AppColors.veryLightBlue
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.item.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
              color: widget.isActive
                  ? AppColors.primaryBlue
                  : _hovered
                      ? AppColors.primaryBlue
                      : AppColors.darkText,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final List<_NavItem> items;
  final NavPage currentPage;
  final Function(NavPage) onNavigate;

  const _MobileMenu({
    required this.items,
    required this.currentPage,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.cardBorder),
        ),
      ),
      child: Column(
        children: items.map((item) {
          final isActive = currentPage == item.page;
          return ListTile(
            leading: Icon(
              item.icon,
              color: isActive ? AppColors.primaryBlue : AppColors.mediumGrey,
            ),
            title: Text(
              item.label,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primaryBlue : AppColors.darkText,
              ),
            ),
            trailing: isActive
                ? Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
            onTap: () => onNavigate(item.page),
          );
        }).toList(),
      ),
    );
  }
}
