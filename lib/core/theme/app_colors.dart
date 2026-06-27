import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryVariant = Color(0xFF0D47A1);

  // Secondary / Accent
  static const Color accent = Color(0xFFFF5722);
  static const Color accentLight = Color(0xFFFF7043);
  static const Color accentDark = Color(0xFFE64A19);

  // Backgrounds
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  static const Color scaffoldBackground = Color(0xFFF0F2F5);

  // Dark mode backgrounds
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFF9E9E9E);

  // Status colors
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color success = Color(0xFF388E3C);
  static const Color successLight = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFF57C00);
  static const Color warningLight = Color(0xFFFF9800);
  static const Color info = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFF2196F3);

  // Chart colors
  static const Color chartBlue = Color(0xFF1976D2);
  static const Color chartGreen = Color(0xFF4CAF50);
  static const Color chartOrange = Color(0xFFFF9800);
  static const Color chartRed = Color(0xFFF44336);
  static const Color chartPurple = Color(0xFF9C27B0);
  static const Color chartTeal = Color(0xFF009688);
  static const Color chartPink = Color(0xFFE91E63);
  static const Color chartYellow = Color(0xFFFFEB3B);

  // Divider and borders
  static const Color divider = Color(0xFFBDBDBD);
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFF9E9E9E);
  static const Color disabledBackground = Color(0xFFE0E0E0);

  // Gradients
  static const List<Color> gradientPrimary = [
    Color(0xFF1565C0),
    Color(0xFF1976D2),
    Color(0xFF42A5F5),
  ];

  static const List<Color> gradientAccent = [
    Color(0xFFE64A19),
    Color(0xFFFF5722),
    Color(0xFFFF7043),
  ];

  static const List<Color> gradientSuccess = [
    Color(0xFF2E7D32),
    Color(0xFF388E3C),
    Color(0xFF4CAF50),
  ];

  // Shadows
  static Color shadowColor = const Color(0xFF000000).withAlpha(26);
  static Color shadowColorDark = const Color(0xFF000000).withAlpha(51);

  // Transparent colors
  static Color primaryWithOpacity(double opacity) =>
      primary.withAlpha((255 * opacity).round());
}
