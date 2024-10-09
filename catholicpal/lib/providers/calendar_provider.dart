import 'package:catholicpal/models/liturgical_day_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarProvider with ChangeNotifier {
  LiturgicalDay? _liturgicalDay;
  bool _isLoading = false;
  bool _hasError = false;

  LiturgicalDay? get liturgicalDay => _liturgicalDay;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchLiturgicalDay(DateTime selectedDate) async {
    final year = selectedDate.year;
    final month = selectedDate.month.toString().padLeft(2, '0'); // Ensure two digits
    final day = selectedDate.day.toString().padLeft(2, '0');     // Ensure two digits

    final url = 'http://calapi.inadiutorium.cz/api/v0/en/calendars/default/$year/$month/$day';
    _isLoading = true;
    _hasError = false;
    print('Fetching data from: $url');
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));  // Added timeout
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Check if data is not null and contains expected fields
        if (data != null && data.isNotEmpty) {
          _liturgicalDay = LiturgicalDay.fromJson(data);
          print('Liturgical day data: $_liturgicalDay');
        } else {
          print('No data found for the selected date.');
          _liturgicalDay = null;
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        _hasError = true;
      }
    } catch (e) {
      print('Error: $e');
      _hasError = true;
    } finally {
      print('Liturgical day after fetch: $_liturgicalDay');
      _isLoading = false;
      notifyListeners();
    }
  }
}
