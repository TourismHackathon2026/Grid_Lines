import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/map_card.dart';

class TrackingTab extends ConsumerWidget {
  const TrackingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        MapCard(
          title: 'Live Tracking',
          subtitle: 'Your current location',
          height: 300,
          onExpand: () => context.pushNamed(AppRoutes.mapName),
          child: Container(
            color: AppColors.primary.withAlpha(15),
            child: const Center(
              child: Icon(Icons.map, size: 64,
                  color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildTrackingInfo(context),
        const SizedBox(height: AppSpacing.md),
        _buildRecentSessions(context),
      ],
    );
  }

  Widget _buildTrackingInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tracking Statistics',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TrackingStat(
                    icon: Icons.speed, label: 'Avg Speed',
                    value: '12.5 km/h', color: AppColors.primary),
                _TrackingStat(
                    icon: Icons.timer, label: 'Duration',
                    value: '2h 15m', color: AppColors.success),
                _TrackingStat(
                    icon: Icons.straighten, label: 'Distance',
                    value: '28.4 km', color: AppColors.accent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSessions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Sessions',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(3, (i) => ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.success.withAlpha(25),
            child: const Icon(Icons.route, color: AppColors.success),
          ),
          title: Text(['Phewa Lake Walk', 'Swayambhunath Trek', 'Bhaktapur Tour'][i]),
          subtitle: Text(['${5 + i * 3}.${i * 2} km • ${30 + i * 15} min'][0]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.pushNamed(AppRoutes.trackingName),
        )),
      ],
    );
  }
}

class _TrackingStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _TrackingStat({
    required this.icon, required this.label,
    required this.value, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 56, height: 56,
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(value, style: const TextStyle(
          fontWeight: FontWeight.w700, fontSize: 16)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(
          fontSize: 12, color: AppColors.textSecondary)),
    ]);
  }
}
