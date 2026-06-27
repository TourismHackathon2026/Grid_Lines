import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/chart_card.dart';
import '../providers/dashboard_provider.dart';

class DashboardChart extends ConsumerWidget {
  const DashboardChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final trends = state.stats.visitTrends;
    if (trends.isEmpty) return const SizedBox.shrink();

    return ChartCard(
      title: 'Weekly Visits',
      subtitle: 'Tourist activity this week',
      height: 200,
      legends: const [
        LegendItem(label: 'Visits', color: AppColors.primary)
      ],
      chart: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 40,
          barGroups: trends.asMap().entries.map((e) {
            return BarChartGroupData(x: e.key, barRods: [
              BarChartRodData(
                toY: e.value.value,
                color: AppColors.primary,
                width: 20,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6)),
              ),
            ]);
          }).toList(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(labels[v.toInt()],
                        style: const TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
