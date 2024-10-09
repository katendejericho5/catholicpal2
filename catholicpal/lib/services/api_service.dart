import 'dart:convert'; // For json decoding
import 'package:catholicpal/models/liturgical_day_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String _baseUrl = "http://calapi.inadiutorium.cz/api/v0/en/calendars/default";

  // Fetch data for today
  Future<LiturgicalDay> fetchToday() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/today'));

      if (response.statusCode == 200) {
        // Parse JSON data into LiturgicalDay model
        final jsonData = jsonDecode(response.body);
        return LiturgicalDay.fromJson(jsonData);
      } else {
        throw Exception('Failed to load today\'s data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch data for a specific date (year, month, day)
  Future<LiturgicalDay> fetchDate(int year, int month, int day) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$year/$month/$day'));

      if (response.statusCode == 200) {
        // Parse JSON data into LiturgicalDay model
        final jsonData = jsonDecode(response.body);
        return LiturgicalDay.fromJson(jsonData);
      } else {
        throw Exception('Failed to load data for the selected date');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
