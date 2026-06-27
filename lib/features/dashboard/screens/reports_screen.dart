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
      description: 'Analytics and insights about your travel activity.',
      items: const [
        FeatureItem(
          icon: Icons.trending_up,
          title: 'Weekly Summary',
          subtitle: '12.4 km traveled this week',
          color: AppColors.success,
        ),
        FeatureItem(
          icon: Icons.calendar_month,
          title: 'Monthly Report',
          subtitle: '48 places visited this month',
          color: AppColors.accent,
        ),
        FeatureItem(
          icon: Icons.emoji_events,
          title: 'Achievements',
          subtitle: '5 badges earned',
          color: AppColors.chartOrange,
        ),
      ],
    );
  }
}
