import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/app_empty.dart';
import '../../dashboard/providers/dashboard_provider.dart';

class PlacesTab extends ConsumerWidget {
  const PlacesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final places = state.recentPlaces;

    return Column(
      children: [
        AppSearchBar(
          hint: 'Search destinations...',
          onFilterTap: () {},
        ),
        // Category chips
        if (places.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryChip(label: 'All', selected: true),
                  _CategoryChip(label: 'Beach'),
                  _CategoryChip(label: 'Mountain'),
                  _CategoryChip(label: 'Temple'),
                  _CategoryChip(label: 'City'),
                  _CategoryChip(label: 'Museum'),
                  _CategoryChip(label: 'Nature'),
                  _CategoryChip(label: 'Adventure'),
                ],
              ),
            ),
          ),
        Expanded(
          child: places.isEmpty
              ? const AppEmpty(
                  message: 'No places found',
                  icon: Icons.place_outlined,
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(dashboardProvider.notifier).refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: AppSpacing.lg),
                    itemCount: places.length * 3,
                    itemBuilder: (ctx, i) {
                      final p = places[i % places.length];
                      return PlaceCard(
                        name: _placeNames[i % _placeNames.length],
                        location: p.location,
                        imageUrl: p.imageUrl,
                        rating: [4.2, 4.7, 4.5, 3.9, 4.8, 4.3]
                            [i % 6],
                        reviewCount: [128, 256, 89, 342, 156, 78]
                            [i % 6],
                        categories: [
                          ['Beach', 'Nature'],
                          ['Mountain', 'Adventure'],
                          ['Temple', 'Culture'],
                          ['City', 'Shopping'],
                          ['Museum', 'History'],
                          ['Park', 'Relaxation'],
                        ][i % 6],
                        onTap: () => context.pushNamed(
                            AppRoutes.placeDetailName,
                            pathParameters: {'id': '${i + 1}'}),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

const _placeNames = [
  'Sunset Paradise Beach',
  'Alpine Peak Summit',
  'Golden Temple Sanctuary',
  'Metropolitan Art Gallery',
  'Blue Lagoon Resort',
  'Emerald Forest Retreat',
  'Crystal Waterfall Haven',
  'Ancient Ruins Valley',
  'Sakura Garden Park',
  'Desert Oasis Camp',
  'Northern Lights Point',
  'Tropical Island Escape',
];

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _CategoryChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.textSecondary,
          fontWeight:
              selected ? FontWeight.w600 : FontWeight.w400,
        ),
        onSelected: (_) {},
      ),
    );
  }
}
