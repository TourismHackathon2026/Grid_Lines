import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/tracking_model.dart';
import '../../../shared/models/tourist_place_model.dart';

class DashboardState {
  final DashboardStats stats;
  final List<TouristPlace> recentPlaces;
  final List<TouristPlace> popularPlaces;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.stats = const DashboardStats(),
    this.recentPlaces = const [],
    this.popularPlaces = const [],
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardStats? stats,
    List<TouristPlace>? recentPlaces,
    List<TouristPlace>? popularPlaces,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      stats: stats ?? this.stats,
      recentPlaces: recentPlaces ?? this.recentPlaces,
      popularPlaces: popularPlaces ?? this.popularPlaces,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(const DashboardState()) {
    _loadData();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 800));
    state = DashboardState(
      isLoading: false,
      stats: const DashboardStats(
        totalPlaces: 48,
        totalVisits: 156,
        totalDistance: 234.5,
        activeSessions: 12,
        visitTrends: [
          TouristDataPoint(label: 'Mon', value: 12),
          TouristDataPoint(label: 'Tue', value: 18),
          TouristDataPoint(label: 'Wed', value: 15),
          TouristDataPoint(label: 'Thu', value: 22),
          TouristDataPoint(label: 'Fri', value: 28),
          TouristDataPoint(label: 'Sat', value: 35),
          TouristDataPoint(label: 'Sun', value: 26),
        ],
        popularCategories: [
          TouristDataPoint(label: 'Beach', value: 35),
          TouristDataPoint(label: 'Mountain', value: 28),
          TouristDataPoint(label: 'City', value: 22),
          TouristDataPoint(label: 'Temple', value: 18),
          TouristDataPoint(label: 'Museum', value: 12),
        ],
      ),
      recentPlaces: _mockPlaces(),
      popularPlaces: _mockPlaces().reversed.toList(),
    );
  }

  List<TouristPlace> _mockPlaces() => [
        TouristPlace(
          id: '1', name: 'Sunset Beach', location: 'Bali, Indonesia',
          description: 'Beautiful beach', rating: 4.8, reviewCount: 234,
          latitude: -8.3405, longitude: 115.092,
          categories: ['Beach', 'Nature'],
        ),
        TouristPlace(
          id: '2', name: 'Mountain Peak', location: 'Alps, Switzerland',
          description: 'Scenic mountain', rating: 4.6, reviewCount: 189,
          latitude: 46.8182, longitude: 8.2275,
          categories: ['Mountain', 'Adventure'],
        ),
        TouristPlace(
          id: '3', name: 'Historic Temple', location: 'Kyoto, Japan',
          description: 'Ancient temple', rating: 4.9, reviewCount: 567,
          latitude: 35.0116, longitude: 135.7681,
          categories: ['Temple', 'Culture'],
        ),
      ];

  Future<void> refresh() async {
    await _loadData();
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier();
});
