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
      description: 'Your bookmarked destinations.',
      items: const [
        FeatureItem(
          icon: Icons.place,
          title: 'Taj Mahal',
          subtitle: 'Agra, Uttar Pradesh',
          color: AppColors.accent,
        ),
        FeatureItem(
          icon: Icons.place,
          title: 'Jaipur Palace',
          subtitle: 'Jaipur, Rajasthan',
          color: AppColors.chartOrange,
        ),
      ],
    );
  }
}
