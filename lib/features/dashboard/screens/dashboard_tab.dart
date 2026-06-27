import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/stat_card.dart';
import '../../../shared/widgets/app_loading.dart';
import '../../../shared/widgets/app_error.dart';
import '../providers/dashboard_provider.dart';
import 'dashboard_welcome.dart';
import 'dashboard_chart.dart';
import 'dashboard_popular.dart';
import 'dashboard_quick_actions.dart';

class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    if (state.isLoading) {
      return const AppLoading(message: 'Loading dashboard...');
    }
    if (state.error != null) {
      return AppError(
        message: state.error!,
        onRetry: () => ref.read(dashboardProvider.notifier).refresh(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
      child: CustomScrollView(slivers: [
        const SliverToBoxAdapter(child: DashboardWelcome()),
        SliverToBoxAdapter(child: _buildStats(context, state)),
        const SliverToBoxAdapter(child: DashboardQuickActions()),
        const SliverToBoxAdapter(child: DashboardChart()),
        SliverToBoxAdapter(
            child: DashboardPopular(places: state.popularPlaces)),
        const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.lg)),
      ]),
    );
  }

  Widget _buildStats(BuildContext context, dynamic state) {
    final stats = state.stats;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Wrap(children: [
        SizedBox(width: MediaQuery.of(context).size.width / 2 - 12,
            child: StatCard(title: 'Total Places', value: '${stats.totalPlaces}',
                icon: Icons.place, color: AppColors.chartBlue)),
        SizedBox(width: MediaQuery.of(context).size.width / 2 - 12,
            child: StatCard(title: 'Total Visits', value: '${stats.totalVisits}',
                icon: Icons.directions_walk, color: AppColors.chartGreen)),
        SizedBox(width: MediaQuery.of(context).size.width / 2 - 12,
            child: StatCard(title: 'Distance', value: '${stats.totalDistance} km',
                icon: Icons.route, color: AppColors.chartOrange)),
        SizedBox(width: MediaQuery.of(context).size.width / 2 - 12,
            child: StatCard(title: 'Active', value: '${stats.activeSessions}',
                icon: Icons.monitor_heart, color: AppColors.chartPurple)),
      ]),
    );
  }
}
