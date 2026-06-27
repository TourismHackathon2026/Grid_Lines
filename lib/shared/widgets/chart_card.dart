import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'dashboard_card.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget chart;
  final double height;
  final List<LegendItem>? legends;

  const ChartCard({
    super.key,
    required this.title,
    required this.chart,
    this.subtitle,
    this.height = 220,
    this.legends,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: title,
      subtitle: subtitle,
      child: Column(
        children: [
          SizedBox(height: height, child: chart),
          if (legends != null && legends!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.xs,
              children: legends!.map((legend) => _LegendItemWidget(
                color: legend.color,
                label: legend.label,
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class LegendItem {
  final String label;
  final Color color;

  const LegendItem({required this.label, required this.color});
}

class _LegendItemWidget extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItemWidget({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
