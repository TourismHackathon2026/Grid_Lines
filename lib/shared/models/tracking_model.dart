import 'package:equatable/equatable.dart';

class TrackingSession extends Equatable {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<LocationPoint> route;
  final double totalDistance;
  final double avgSpeed;
  final String status;

  const TrackingSession({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    this.route = const [],
    this.totalDistance = 0.0,
    this.avgSpeed = 0.0,
    this.status = 'active',
  });

  @override
  List<Object?> get props =>
      [id, userId, startTime, endTime, status, totalDistance];
}

class LocationPoint extends Equatable {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double? speed;
  final double? altitude;

  const LocationPoint({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.speed,
    this.altitude,
  });

  @override
  List<Object?> get props => [latitude, longitude, timestamp];
}

class DashboardStats extends Equatable {
  final int totalPlaces;
  final int totalVisits;
  final double totalDistance;
  final int activeSessions;
  final List<TouristDataPoint> visitTrends;
  final List<TouristDataPoint> popularCategories;

  const DashboardStats({
    this.totalPlaces = 0,
    this.totalVisits = 0,
    this.totalDistance = 0.0,
    this.activeSessions = 0,
    this.visitTrends = const [],
    this.popularCategories = const [],
  });

  @override
  List<Object?> get props =>
      [totalPlaces, totalVisits, totalDistance, activeSessions];
}

class TouristDataPoint extends Equatable {
  final String label;
  final double value;
  final String? color;

  const TouristDataPoint({
    required this.label,
    required this.value,
    this.color,
  });

  @override
  List<Object?> get props => [label, value];
}
