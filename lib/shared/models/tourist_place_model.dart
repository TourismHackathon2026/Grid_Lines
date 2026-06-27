import 'package:equatable/equatable.dart';

class TouristPlace extends Equatable {
  final String id;
  final String name;
  final String description;
  final String location;
  final String? imageUrl;
  final double rating;
  final int reviewCount;
  final List<String> categories;
  final double latitude;
  final double longitude;
  final bool isFavorite;
  final DateTime? createdAt;

  const TouristPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.categories = const [],
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
    this.createdAt,
  });

  TouristPlace copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    List<String>? categories,
    double? latitude,
    double? longitude,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return TouristPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      categories: categories ?? this.categories,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'location': location,
        'image_url': imageUrl,
        'rating': rating,
        'review_count': reviewCount,
        'categories': categories,
        'latitude': latitude,
        'longitude': longitude,
        'is_favorite': isFavorite,
        'created_at': createdAt?.toIso8601String(),
      };

  factory TouristPlace.fromJson(Map<String, dynamic> json) => TouristPlace(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        location: json['location'] as String,
        imageUrl: json['image_url'] as String?,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
        categories: (json['categories'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        isFavorite: json['is_favorite'] as bool? ?? false,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String)
            : null,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        rating,
        latitude,
        longitude,
        isFavorite,
      ];
}
