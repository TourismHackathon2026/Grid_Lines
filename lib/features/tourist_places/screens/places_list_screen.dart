import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/place_card.dart';
import '../../dashboard/providers/dashboard_provider.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final places = state.recentPlaces;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourist Places'),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {}),
        ],
      ),
      body: Column(children: [
        AppSearchBar(hint: 'Search places...', onFilterTap: () {}),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            itemCount: places.length * 3,
            itemBuilder: (ctx, i) {
              final p = places[i % places.length];
              return PlaceCard(
                name: '${p.name} - ${i + 1}',
                location: p.location,
                rating: p.rating,
                reviewCount: p.reviewCount,
                categories: p.categories,
                onTap: () => context.pushNamed(
                    AppRoutes.placeDetailName,
                    pathParameters: {'id': '$i'}),
              );
            },
          ),
        ),
      ]),
    );
  }
}
