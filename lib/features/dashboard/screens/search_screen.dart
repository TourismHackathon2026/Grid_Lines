import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/feature_page.dart';
import '../../../core/theme/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Search',
      icon: Icons.search,
      color: AppColors.primary,
      description: 'Search for tourist places, tracks, and more.',
      items: [
        FeatureItem(
          icon: Icons.place,
          title: 'Browse Places',
          subtitle: 'View all tourist destinations',
          color: AppColors.accent,
          onTap: () => context.pushNamed(AppRoutes.touristPlacesName),
        ),
        FeatureItem(
          icon: Icons.map,
          title: 'Open Map',
          subtitle: 'Explore locations on the map',
          color: AppColors.success,
          onTap: () => context.pushNamed(AppRoutes.mapName),
        ),
      ],
    );
  }
}
