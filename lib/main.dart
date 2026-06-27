import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/routes/app_routes.dart'; // Ensure this matches your project path layout
import 'features/dashboard/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // 🔐 CRITICAL HACKATHON RENDER FIX: Wrap the application inside a ProviderScope
    // This allows Riverpod consumer widgets (like your HomeScreen) to bind state safely.
    const ProviderScope(
      child: TourTrackApp(),
    ),
  );
}

class TourTrackApp extends StatelessWidget {
  const TourTrackApp({Key? key}) : super(key: key);

  // Define a localized, error-resistant GoRouter configuration directly inside the main tree
  static final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // Fallback placeholder route to satisfy the context settings actuator callbacks
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text("Settings Console")),
          body: const Center(child: Text("System Settings Framework Online")),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text("Routing Navigation Error: ${state.error}"),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TourTrack',
      debugShowCheckedModeBanner: false,
      
      // Applying a dark, high-contrast palette theme for tactical visibility
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardColor: const Color(0xFF1E293B),
        primaryColor: const Color(0xFF14B8A6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF14B8A6),
          secondary: Color(0xFF0D9488),
          surface: Color(0xFF1E293B),
        ),
        useMaterial3: true,
      ),
      
      // Bind router configuration matrices
      routerConfig: _router,
    );
  }
}