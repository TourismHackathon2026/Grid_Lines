import os
content = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: TourTrackApp(),
    ),
  );
}

class TourTrackApp extends ConsumerWidget {
  const TourTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'TourTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
"""
path = 'd:/hackathon/lib/main.dart'
if os.path.exists(path):
    os.remove(path)
with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('File written successfully')
