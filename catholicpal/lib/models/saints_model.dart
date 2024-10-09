import 'package:catholicpal/models/prayer_model.dart';

class Saint {
  final String name; // Title or name of the saint
  final String imageUrl; // URL for the saint's image
  final String lifeSummary; // A short summary of the saint's life
  final String feastDay; // Feast day of the saint
  final String patronage; // Areas of patronage (e.g., patron of certain causes)
  final List<String> majorLifeEvents; // Key events in the saint's life
  final List<String> quotes; // Famous quotes or writings of the saint
  final List<Prayer> prayers; // List of prayers associated with the saint

  // Constructor
  Saint({
    required this.name,
    required this.imageUrl,
    required this.lifeSummary,
    required this.feastDay,
    required this.patronage,
    required this.majorLifeEvents,
    required this.quotes,
    required this.prayers,
  });

  factory Saint.fromJson(Map<String, dynamic> json) {
    return Saint(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      lifeSummary: json['lifeSummary'] as String,
      feastDay: json['feastDay'] as String,
      patronage: json['patronage'] as String,
      majorLifeEvents: List<String>.from(json['majorLifeEvents']),
      quotes: List<String>.from(json['quotes']),
      prayers: (json['prayers'] as List)
          .map((prayerJson) => Prayer.fromJson(prayerJson))
          .toList(),
    );
  }
}
