import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/app_loading.dart';
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
        Expanded(
          child: places.isEmpty
              ? const Center(child: AppLoading())
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
                        name: p.name,
                        location: p.location,
                        imageUrl: p.imageUrl,
                        rating: p.rating,
                        reviewCount: p.reviewCount,
                        categories: p.categories,
                        onTap: () => context.pushNamed(
                            AppRoutes.placeDetailName,
                            pathParameters: {'id': p.id}),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
