import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class DashboardWelcome extends StatelessWidget {
  const DashboardWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Card(
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back! 👋',
                        style: AppTextStyles.headline5
                            .copyWith(color: Colors.white)),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Ready to explore new destinations today?',
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: Colors.white70)),
                  ],
                ),
              ),
              const Icon(Icons.travel_explore, size: 48, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
