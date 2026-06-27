import 'package:flutter/material.dart';
import '../constants/app_routes.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/details/details_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.splash:
        return _materialRoute(const SplashScreen());
      case AppRoutes.login:
        return _materialRoute(const LoginScreen());
      case AppRoutes.register:
        return _materialRoute(const RegisterScreen());
      case AppRoutes.home:
        return _materialRoute(const HomeScreen());
      case AppRoutes.profile:
        return _materialRoute(const ProfileScreen());
      case AppRoutes.settings:
        return _materialRoute(const SettingsScreen());
      case AppRoutes.dashboard:
        return _materialRoute(const DashboardScreen());
      case AppRoutes.details:
        final args = routeSettings.arguments;
        return _materialRoute(DetailsScreen(data: args));
      case AppRoutes.onboarding:
        return _materialRoute(const OnboardingScreen());
      default:
        return _materialRoute(
          const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }

  static MaterialPageRoute _materialRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}