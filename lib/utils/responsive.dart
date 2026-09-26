import 'package:flutter/material.dart';

/// Responsive breakpoints
class Responsive {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1280;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1440) return 1280;
    if (width >= 1280) return 1140;
    if (width >= tabletBreakpoint) return 960;
    return double.infinity;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20);
    }
    if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40);
    }
    return const EdgeInsets.symmetric(horizontal: 60);
  }

  static double sectionSpacing(BuildContext context) {
    if (isMobile(context)) return 60;
    if (isTablet(context)) return 80;
    return 100;
  }
}
