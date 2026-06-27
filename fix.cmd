@echo off
(
echo import 'package:flutter/material.dart';
echo import 'package:flutter_riverpod/flutter_riverpod.dart';
echo import 'core/theme/app_theme.dart';
echo import 'core/routes/app_router.dart';
echo.
echo void main() {
echo   WidgetsFlutterBinding.ensureInitialized();
echo   runApp(
echo     const ProviderScope(
echo       child: TourTrackApp(),
echo     ),
echo   );
echo }
echo.
echo class TourTrackApp extends ConsumerWidget {
echo   const TourTrackApp({super.key});
echo.
echo   @override
echo   Widget build(BuildContext context, WidgetRef ref) {
echo     return MaterialApp.router(
echo       title: 'TourTrack',
echo       debugShowCheckedModeBanner: false,
echo       theme: AppTheme.lightTheme,
echo       darkTheme: AppTheme.darkTheme,
echo       themeMode: ThemeMode.system,
echo       routerConfig: AppRouter.router,
echo     );
echo   }
echo }
) > d:\hackathon\lib\main.dart
