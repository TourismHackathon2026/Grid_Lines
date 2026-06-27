import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page.dart';
import '../../../core/theme/app_colors.dart';

class SavedPlacesScreen extends StatelessWidget {
  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Saved Places',
      icon: Icons.favorite_border,
      color: AppColors.error,
      description: 'Your bookmarked destinations in Nepal.',
      items: const [
        FeatureItem(
          icon: Icons.place,
          title: 'Pashupatinath Temple',
          subtitle: 'Kathmandu, Nepal',
          color: AppColors.accent,
        ),
        FeatureItem(
          icon: Icons.place,
          title: 'Phewa Lake',
          subtitle: 'Pokhara, Nepal',
          color: AppColors.chartOrange,
        ),
        FeatureItem(
          icon: Icons.place,
          title: 'Lumbini',
          subtitle: 'Rupandehi, Nepal',
          color: AppColors.success,
        ),
      ],
    );
  }
}
