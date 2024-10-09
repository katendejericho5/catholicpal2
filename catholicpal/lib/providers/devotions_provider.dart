// Updated DevotionProvider class

import 'dart:convert';
import 'package:catholicpal/models/devotion_model.dart';
import 'package:catholicpal/models/prayer_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DevotionProvider with ChangeNotifier {
  List<Devotion> _devotions = [];

  List<Devotion> get devotions => _devotions;

  // Function to load devotions from the assets (JSON file)
  Future<void> loadDevotions() async {
    try {
      final String response =
          await rootBundle.loadString('assets/devotions.json');
      print('JSON Response: $response'); // Print the raw JSON response
      final List<dynamic> data = jsonDecode(response);
      print('Decoded JSON: $data'); // Print the decoded JSON
      _devotions =
          data.map((devotionData) => Devotion.fromJson(devotionData)).toList();
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print("Error loading devotions: $error");
      }
    }
  }

  // Updated function to fetch devotion by name
  Devotion? getDevotionByName(String name) {
    try {
      return _devotions.firstWhere((devotion) => devotion.name == name);
    } catch (e) {
      return null; // Return null if no match is found
    }
  }

  // Function to fetch associated prayers by devotion name
  List<Prayer> getPrayersByDevotion(String devotionName) {
    final devotion = getDevotionByName(devotionName);
    if (devotion != null) {
      return devotion.prayers;
    } else {
      return []; // Return empty list if devotion is not found
    }
  }
}
