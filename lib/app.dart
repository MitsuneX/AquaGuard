import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_footer.dart';
import '../screens/home_screen.dart';
import '../screens/water_screen.dart';
import '../screens/sanitation_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/calculator_screen.dart';
import '../screens/action_screen.dart';
import '../screens/about_screen.dart';

class AquaGuardApp extends StatefulWidget {
  const AquaGuardApp({super.key});

  @override
  State<AquaGuardApp> createState() => _AquaGuardAppState();
}

class _AquaGuardAppState extends State<AquaGuardApp>
    with SingleTickerProviderStateMixin {
  NavPage _currentPage = NavPage.home;
  final ScrollController _scrollController = ScrollController();

  late AnimationController _transitionController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _transitionController,
      curve: Curves.easeInOut,
    );
    _transitionController.value = 1.0; // Start visible
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  Future<void> _navigateTo(NavPage page) async {
    if (_currentPage == page) {
      // Scroll to top if same page tapped
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      return;
    }

    // Fade out
    await _transitionController.reverse();

    // Scroll to top
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    setState(() => _currentPage = page);

    // Fade in
    await _transitionController.forward();
  }

  Widget _buildCurrentScreen() {
    switch (_currentPage) {
      case NavPage.home:
        return HomeScreen(onNavigate: _navigateTo);
      case NavPage.water:
        return const WaterScreen();
      case NavPage.sanitation:
        return const SanitationScreen();
      case NavPage.dashboard:
        return const DashboardScreen();
      case NavPage.calculator:
        return const CalculatorScreen();
      case NavPage.action:
        return const ActionScreen();
      case NavPage.about:
        return const AboutScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Sticky navbar
          AppNavbar(
            currentPage: _currentPage,
            onNavigate: _navigateTo,
          ),

          // Page content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    _buildCurrentScreen(),
                    const AppFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
