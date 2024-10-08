import 'dart:convert';
import 'package:catholicpal/models/categories_model.dart';
import 'package:catholicpal/models/prayer_model.dart';
import 'package:flutter/services.dart';

class DataService {
  Future<List<Category>> loadCategories() async {
    try {
      final String response =
          await rootBundle.loadString('assets/categories.json');
      final data = json.decode(response);

      List<Category> categories = (data['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();
      print('Categories loaded: $categories');

      return categories;
    } catch (e) {
      print('Error loading categories: $e');
      return [];
    }
  }

  Future<List<Prayer>> loadPrayers() async {
    try {
      final String response =
          await rootBundle.loadString('assets/prayers.json');
      final data = json.decode(response);

      List<Prayer> prayers = (data['prayers'] as List)
          .map((prayerJson) => Prayer.fromJson(prayerJson))
          .toList();
      print('Prayers loaded: $prayers');

      return prayers;
    } catch (e) {
      print('Error loading prayers: $e');
      return [];
    }
  }
}
