import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/map_card.dart';
import '../../../shared/models/tourist_place_model.dart';
import '../../dashboard/providers/dashboard_provider.dart';

class PlaceDetailScreen extends ConsumerWidget {
  final String id;
  const PlaceDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final allPlaces = [...state.recentPlaces, ...state.popularPlaces];
    final place = allPlaces.cast<TouristPlace?>().firstWhere(
          (p) => p!.id == id,
          orElse: () => null,
        );

    if (place == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Place')),
        body: const Center(child: Text('Place not found')),
      );
    }

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(place.name),
            background: place.imageUrl != null
                ? (place.imageUrl!.startsWith('http')
                    ? Image.network(place.imageUrl!, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _buildPlaceholder(place.name))
                    : Image.asset(place.imageUrl!, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _buildPlaceholder(place.name)))
                : _buildPlaceholder(place.name),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: AppSpacing.sm),
                Row(children: [
                  const Icon(Icons.location_on, size: 18,
                      color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(place.location,
                        style: const TextStyle(
                            color: AppColors.textSecondary)),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  ...List.generate(
                      5,
                      (i) => Icon(Icons.star,
                          size: 18,
                          color: i < place.rating.round()
                              ? Colors.amber
                              : AppColors.divider)),
                  const SizedBox(width: 4),
                  Text(place.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 4),
                  Text('(${place.reviewCount})',
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13)),
                ]),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: place.categories
                      .map((c) => Chip(label: Text(c)))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Description',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.sm),
                Text(place.description),
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

  Widget _buildPlaceholder(String name) {
    return Container(
      color: AppColors.primary.withAlpha(25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.place, size: 80, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(name[0].toUpperCase(),
                style: const TextStyle(
                    fontSize: 32,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
