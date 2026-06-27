import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/models/tourist_place_model.dart';

class DashboardPopular extends StatelessWidget {
  final List<TouristPlace> places;
  const DashboardPopular({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Popular Destinations',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () => context.pushNamed(
                      AppRoutes.touristPlacesName),
                  child: const Text('See All')),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: places.length,
            itemBuilder: (ctx, i) {
              final place = places[i];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: AppSpacing.md),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => context.pushNamed(
                        AppRoutes.placeDetailName,
                        pathParameters: {'id': place.id}),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          color: AppColors.primary.withAlpha(25),
                          child: Center(
                            child: Icon(Icons.place, size: 40,
                                color: AppColors.primary.withAlpha(150)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(place.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.location_on, size: 14,
                                    color: AppColors.textSecondary),
                                const SizedBox(width: 2),
                                Expanded(
                                    child: Text(place.location,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                              ]),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.star, size: 14,
                                    color: Colors.amber),
                                const SizedBox(width: 2),
                                Text('${place.rating}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(width: 4),
                                Text('(${place.reviewCount})',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary)),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
