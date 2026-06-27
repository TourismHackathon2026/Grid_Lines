import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page.dart';
import '../../../core/theme/app_colors.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'My Badges',
      icon: Icons.badge_outlined,
      color: AppColors.chartOrange,
      description: 'Achievements you have earned.',
      items: const [
        FeatureItem(
          icon: Icons.explore,
          title: 'Explorer',
          subtitle: 'Visit 10 different places',
          color: AppColors.success,
        ),
        FeatureItem(
          icon: Icons.directions_walk,
          title: 'Walker',
          subtitle: 'Walk 50 km total',
          color: AppColors.primary,
        ),
        FeatureItem(
          icon: Icons.star,
          title: 'Reviewer',
          subtitle: 'Write 5 reviews',
          color: AppColors.accent,
        ),
      ],
    );
  }
}
