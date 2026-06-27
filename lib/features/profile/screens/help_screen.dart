import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page.dart';
import '../../../core/theme/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Help & Support',
      icon: Icons.help_outlined,
      color: AppColors.info,
      description: 'We are here to help you.',
      items: const [
        FeatureItem(
          icon: Icons.mail_outline,
          title: 'Contact Us',
          subtitle: 'support@tourtrack.com',
          color: AppColors.primary,
        ),
        FeatureItem(
          icon: Icons.description,
          title: 'FAQs',
          subtitle: 'Frequently asked questions',
          color: AppColors.success,
        ),
        FeatureItem(
          icon: Icons.privacy_tip,
          title: 'Privacy Policy',
          subtitle: 'How we handle your data',
          color: AppColors.chartPurple,
        ),
      ],
    );
  }
}
