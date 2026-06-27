import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/map_card.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String id;
  const PlaceDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: AppColors.primary.withAlpha(25),
              child: const Center(
                child: Icon(Icons.place, size: 80,
                    color: AppColors.primary),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Destination #$id',
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: AppSpacing.sm),
                Row(children: [
                  const Icon(Icons.location_on, size: 18,
                      color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  const Text('Tourist Destination',
                      style: TextStyle(
                          color: AppColors.textSecondary)),
                  const SizedBox(width: AppSpacing.md),
                  ...List.generate(5, (i) =>
                      Icon(Icons.star, size: 18,
                          color: i < 4
                              ? Colors.amber
                              : AppColors.divider)),
                  const SizedBox(width: 4),
                  const Text('4.0',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: ['Beach', 'Nature', 'Scenic', 'Popular']
                      .map((c) => Chip(label: Text(c))).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Description',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                    'This is a beautiful tourist destination offering amazing '
                    'views and experiences. Perfect for travelers seeking '
                    'adventure and cultural immersion. The area features '
                    'various attractions, local cuisine, and guided tours.'),
                const SizedBox(height: AppSpacing.lg),
                MapCard(
                  title: 'Location',
                  height: 200,
                  child: Container(
                    color: AppColors.primary.withAlpha(15),
                    child: const Center(
                      child: Icon(Icons.map, size: 48,
                          color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Get Directions',
                      icon: Icons.directions,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Container(
                    width: AppSpacing.buttonHeight,
                    height: AppSpacing.buttonHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSm),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: AppColors.primary,
                      onPressed: () {},
                    ),
                  ),
                ]),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
