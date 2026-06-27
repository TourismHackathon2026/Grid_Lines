import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class FeaturePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<FeatureItem>? items;

  const FeaturePage({
    super.key,
    required this.title,
    required this.icon,
    this.color = AppColors.primary,
    this.description = '',
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              ),
              child: Icon(icon, size: 48, color: color),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title,
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            if (description.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary)),
            ],
            if (items != null) ...[
              const SizedBox(height: AppSpacing.xl),
              ...items!.map((item) => ListTile(
                    leading: Icon(item.icon, color: item.color ?? color),
                    title: Text(item.title),
                    subtitle: item.subtitle != null
                        ? Text(item.subtitle!)
                        : null,
                    trailing: item.onTap != null
                        ? const Icon(Icons.chevron_right)
                        : null,
                    onTap: item.onTap,
                  )),
            ],
          ],
        ),
      ),
    );
  }
}

class FeatureItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback? onTap;

  const FeatureItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.color,
    this.onTap,
  });
}
