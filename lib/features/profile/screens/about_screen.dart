import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page.dart';
import '../../../core/theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'About',
      icon: Icons.info_outlined,
      color: AppColors.info,
      description: 'TourTrack v1.0.0\nNepal Tourism Tracking App',
      items: const [
        FeatureItem(
          icon: Icons.code,
          title: 'Version',
          subtitle: '1.0.0+1',
          color: AppColors.primary,
        ),
        FeatureItem(
          icon: Icons.gavel,
          title: 'License',
          subtitle: 'MIT License',
          color: AppColors.success,
        ),
      ],
    );
  }
}
