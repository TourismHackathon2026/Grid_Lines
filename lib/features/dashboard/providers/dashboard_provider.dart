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
          TouristDataPoint(label: 'Temple', value: 35),
          TouristDataPoint(label: 'Mountain', value: 28),
          TouristDataPoint(label: 'Lake', value: 22),
          TouristDataPoint(label: 'Heritage', value: 18),
          TouristDataPoint(label: 'Wildlife', value: 12),
        ],
      ),
      recentPlaces: _mockPlaces(),
      popularPlaces: _mockPlaces().reversed.toList(),
    );
  }

  List<TouristPlace> _mockPlaces() => [
        TouristPlace(
          id: '1',
          name: 'Pashupatinath Temple',
          location: 'Kathmandu, Nepal',
          description:
              'Sacred Hindu temple on the Bagmati River, a UNESCO World Heritage Site.',
          imageUrl: 'assets/images/Pashupati.jpg',
          rating: 4.9,
          reviewCount: 452,
          latitude: 27.7105,
          longitude: 85.3488,
          categories: ['Temple', 'Heritage'],
        ),
        TouristPlace(
          id: '2',
          name: 'Phewa Lake',
          location: 'Pokhara, Nepal',
          description:
              'Serene freshwater lake with stunning Annapurna range reflections.',
          imageUrl: 'assets/images/fewa_tal.jpg',
          rating: 4.7,
          reviewCount: 389,
          latitude: 28.2096,
          longitude: 83.9596,
          categories: ['Lake', 'Nature'],
        ),
        TouristPlace(
          id: '3',
          name: 'Swayambhunath Stupa',
          location: 'Kathmandu, Nepal',
          description:
              'Ancient Buddhist stupa atop a hill, known as the Monkey Temple.',
          imageUrl: 'assets/images/swyambu.jpg',
          rating: 4.8,
          reviewCount: 523,
          latitude: 27.7148,
          longitude: 85.2907,
          categories: ['Temple', 'Heritage'],
        ),
        TouristPlace(
          id: '4',
          name: 'Lumbini',
          location: 'Rupandehi, Nepal',
          description:
              'Birthplace of Lord Buddha, a UNESCO World Heritage pilgrimage site.',
          imageUrl: 'assets/images/lumbbini.jpg',
          rating: 4.9,
          reviewCount: 678,
          latitude: 27.4833,
          longitude: 83.2757,
          categories: ['Heritage', 'Culture'],
        ),
        TouristPlace(
          id: '5',
          name: 'Chitwan National Park',
          location: 'Chitwan, Nepal',
          description:
              'Jungle safari with rhinos, tigers, and rich wildlife.',
          imageUrl: 'assets/images/images.jpg',
          rating: 4.6,
          reviewCount: 312,
          latitude: 27.5291,
          longitude: 84.3542,
          categories: ['Wildlife', 'Adventure'],
        ),
        TouristPlace(
          id: '6',
          name: 'Bhaktapur Durbar Square',
          location: 'Bhaktapur, Nepal',
          description:
              'Medieval city square with ancient palaces, temples, and pottery.',
          imageUrl: 'assets/images/bkt durabr sqr.jpg',
          rating: 4.8,
          reviewCount: 445,
          latitude: 27.6722,
          longitude: 85.4285,
          categories: ['Heritage', 'Culture'],
        ),
        TouristPlace(
          id: '7',
          name: 'Everest Base Camp',
          location: 'Solukhumbu, Nepal',
          description:
              'Iconic trekking destination at the foot of the world\'s highest peak.',
          imageUrl: 'assets/images/everest_base camp.jpg',
          rating: 4.9,
          reviewCount: 891,
          latitude: 27.9881,
          longitude: 86.9250,
          categories: ['Mountain', 'Adventure'],
        ),
        TouristPlace(
          id: '8',
          name: 'Annapurna Circuit',
          location: 'Gandaki, Nepal',
          description:
              'World-famous trekking trail crossing Thorong La Pass at 5,416m.',
          imageUrl: 'assets/images/anapurna circut.jpg',
          rating: 4.8,
          reviewCount: 734,
          latitude: 28.5961,
          longitude: 83.8203,
          categories: ['Mountain', 'Adventure'],
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
