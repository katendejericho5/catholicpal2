import 'package:catholicpal/models/prayer_model.dart';

class Devotion {
  final String name;
  final String description;
  final String imageUrl;
  final String history;
  final List<Prayer> prayers;

  Devotion({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.history,
    required this.prayers,
  });

  factory Devotion.fromJson(Map<String, dynamic> json) {
    return Devotion(
      name: json['name'] as String? ?? 'Unknown Name', // Handle null
      description: json['description'] as String? ??
          'No description provided', // Handle null
      imageUrl:
          json['imageUrl'] as String? ?? 'default_image_url', // Handle null
      history:
          json['history'] as String? ?? 'No history provided', // Handle null
      prayers: (json['prayers'] as List<dynamic>? ?? [])
          .map((prayerJson) => Prayer.fromJson(prayerJson))
          .toList(),
    );
  }
}
