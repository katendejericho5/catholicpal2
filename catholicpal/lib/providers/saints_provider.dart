import 'dart:convert';
import 'package:catholicpal/models/saints_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SaintsProvider with ChangeNotifier {
  List<Saint> _saints = [];

  List<Saint> get saints => _saints;

  // Method to load saints from a local JSON file
  Future<void> loadSaints() async {
    try {
      final String response = await rootBundle.loadString('assets/saints.json');
      final List<dynamic> data = json.decode(response);

      _saints = data.map((json) => Saint.fromJson(json)).toList();

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print("Error loading saints data: $error");
      }
    }
  }
}
