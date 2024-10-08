import 'package:catholicpal/models/prayer_model.dart';
import 'package:catholicpal/models/saints_model.dart';

class Devotion {
  final String name;
  final String imageUrl;
  final String description;
  final String history;
  final List<Prayer> prayers;
  final List<Saint> associatedSaintsOrPersons;

  Devotion({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.history,
    required this.prayers,
    required this.associatedSaintsOrPersons,
  });

  // Factory method to create a Devotion from a JSON map
  factory Devotion.fromJson(Map<String, dynamic> json) {
    return Devotion(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      history: json['history'] as String,
      prayers: (json['prayers'] as List)
          .map(
            (prayerJson) => Prayer.fromJson(prayerJson),
          )
          .toList(),
      associatedSaintsOrPersons: (json['associatedSaintsOrPersons'] as List)
          .map(
            (saintJson) => Saint.fromJson(saintJson),
          )
          .toList(),
    );
  }
}
