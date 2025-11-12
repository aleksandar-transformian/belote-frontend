import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static EdgeInsets safeAreaPadding(BuildContext context) =>
      MediaQuery.of(context).padding;

  static double cardWidth(BuildContext context) {
    if (isMobile(context)) {
      return 60;
    } else if (isTablet(context)) {
      return 80;
    } else {
      return 100;
    }
  }

  static double cardHeight(BuildContext context) {
    return cardWidth(context) * 1.4; // Maintain aspect ratio
  }

  static double spacing(BuildContext context, {double mobile = 8, double tablet = 12, double desktop = 16}) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  static double fontSize(BuildContext context, {double mobile = 14, double tablet = 16, double desktop = 18}) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
}

// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context) && desktop != null) {
      return desktop!(context);
    } else if (Responsive.isTablet(context) && tablet != null) {
      return tablet!(context);
    } else {
      return mobile(context);
    }
  }
}
