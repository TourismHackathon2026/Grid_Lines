import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page.dart';
import '../../../core/theme/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Reports',
      icon: Icons.show_chart,
      color: AppColors.chartPurple,
      description: 'Analytics for your Nepal travel activity.',
      items: const [
        FeatureItem(
          icon: Icons.trending_up,
          title: 'Weekly Summary',
          subtitle: '34.5 km across Kathmandu Valley',
          color: AppColors.success,
        ),
        FeatureItem(
          icon: Icons.calendar_month,
          title: 'Monthly Report',
          subtitle: '12 Nepali destinations visited',
          color: AppColors.accent,
        ),
        FeatureItem(
          icon: Icons.emoji_events,
          title: 'Achievements',
          subtitle: '5 badges earned exploring Nepal',
          color: AppColors.chartOrange,
        ),
      ],
    );
  }
}
