import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/dashboard/screens/home_screen.dart';
import '../../features/dashboard/screens/search_screen.dart';
import '../../features/dashboard/screens/reports_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/tourist_places/screens/places_list_screen.dart';
import '../../features/tourist_places/screens/place_detail_screen.dart';
import '../../features/tracking/screens/map_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/badges_screen.dart';
import '../../features/profile/screens/saved_places_screen.dart';
import '../../features/profile/screens/help_screen.dart';
import '../../features/profile/screens/about_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRoutes.onboardingName,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerName,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: AppRoutes.dashboardName,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.touristPlaces,
        name: AppRoutes.touristPlacesName,
        builder: (_, __) => const PlacesListScreen(),
      ),
      GoRoute(
        path: AppRoutes.placeDetail,
        name: AppRoutes.placeDetailName,
        builder: (_, state) => PlaceDetailScreen(
            id: state.pathParameters['id'] ?? '0'),
      ),
      GoRoute(
        path: AppRoutes.map,
        name: AppRoutes.mapName,
        builder: (_, __) => const MapScreen(),
      ),
      GoRoute(
        path: AppRoutes.search,
        name: AppRoutes.searchName,
        builder: (_, __) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.reports,
        name: AppRoutes.reportsName,
        builder: (_, __) => const ReportsScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: AppRoutes.editProfileName,
        builder: (_, __) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.badges,
        name: AppRoutes.badgesName,
        builder: (_, __) => const BadgesScreen(),
      ),
      GoRoute(
        path: AppRoutes.savedPlaces,
        name: AppRoutes.savedPlacesName,
        builder: (_, __) => const SavedPlacesScreen(),
      ),
      GoRoute(
        path: AppRoutes.help,
        name: AppRoutes.helpName,
        builder: (_, __) => const HelpScreen(),
      ),
      GoRoute(
        path: AppRoutes.about,
        name: AppRoutes.aboutName,
        builder: (_, __) => const AboutScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}
