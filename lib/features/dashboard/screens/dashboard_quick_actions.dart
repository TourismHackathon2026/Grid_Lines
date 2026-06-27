import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _QuickAction(
              icon: Icons.search, label: 'Search',
              color: AppColors.primary,
              onTap: () => context.pushNamed(AppRoutes.searchName)),
          _QuickAction(
              icon: Icons.map_outlined, label: 'Map',
              color: AppColors.success,
              onTap: () => context.pushNamed(AppRoutes.mapName)),
          _QuickAction(
              icon: Icons.place_outlined, label: 'Places',
              color: AppColors.accent,
              onTap: () => context.pushNamed(AppRoutes.touristPlacesName)),
          _QuickAction(
              icon: Icons.show_chart, label: 'Reports',
              color: AppColors.chartPurple,
              onTap: () => context.pushNamed(AppRoutes.reportsName)),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon, required this.label,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}
