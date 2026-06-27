import 'package:flutter/material.dart';
import 'theme_light.dart';
import 'theme_dark.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get lightTheme => AppLightTheme.theme;
  static ThemeData get darkTheme => AppDarkTheme.theme;
}
