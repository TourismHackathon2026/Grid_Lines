import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Base unit: 4dp
  static const double unit = 4.0;

  static const double xs = unit; // 4
  static const double sm = unit * 2; // 8
  static const double md = unit * 4; // 16
  static const double lg = unit * 6; // 24
  static const double xl = unit * 8; // 32
  static const double xxl = unit * 12; // 48
  static const double xxxl = unit * 16; // 64

  // Horizontal padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(
    horizontal: md,
  );

  // Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(lg);

  // List item padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // Section spacing
  static const SizedBox sectionSpacing = SizedBox(height: lg);
  static const SizedBox sectionSpacingSmall = SizedBox(height: md);
  static const SizedBox sectionSpacingLarge = SizedBox(height: xl);

  // Common spacers
  static const SizedBox spacerXs = SizedBox(height: xs, width: xs);
  static const SizedBox spacerSm = SizedBox(height: sm, width: sm);
  static const SizedBox spacerMd = SizedBox(height: md, width: md);
  static const SizedBox spacerLg = SizedBox(height: lg, width: lg);
  static const SizedBox spacerXl = SizedBox(height: xl, width: xl);

  static SizedBox vertical(double height) => SizedBox(height: height);
  static SizedBox horizontal(double width) => SizedBox(width: width);

  // Border radii
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusRound = 50.0;

  // Icon sizes
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // Button heights
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightLarge = 56.0;

  // Input heights
  static const double inputHeight = 48.0;
  static const double inputHeightLarge = 56.0;

  // App bar
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 64.0;

  // Card dimensions
  static const double cardElevation = 2.0;
  static const double cardElevationHover = 4.0;
}
